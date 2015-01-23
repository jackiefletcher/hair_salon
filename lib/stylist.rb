class Stylist
attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :id => id}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_stylist|
    self.name().==(another_stylist.name()).&(self.id().==(another_stylist.id()))
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id().==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:customers) do
    stylist_customers = []
    customers = DB.exec("SELECT * FROM customers WHERE stylist_id = #{self.id()} ORDER BY name;")
    customers.each() do |customer|
      name = customer.fetch("name")
      phone = customer.fetch("phone")
      stylist_id = customer.fetch("stylist_id")
      id = customer.fetch("id").to_i()
      stylist_customers.push(Customer.new({:name => name, :phone => phone, :stylist_id => stylist_id, :id => id}))
    end
    stylist_customers
  end


end
