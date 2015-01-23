require('spec_helper')

describe(Customer) do
  describe(".all") do
    it("starts off empty") do
      expect(Customer.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("tells you the customer's name") do
      customer = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      expect(customer.name()).to(eq("Sam Sparks"))
    end
  end

  describe('#id') do
    it('sets its ID when you save it') do
      customer = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      customer.save()
      expect(customer.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('saves the customer info to the database') do
      customer = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      customer.save()
      expect(Customer.all()).to(eq([customer]))
    end
  end

  describe('#==') do
    it("is the same customer if it has the same  name and id") do
      customer1 = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      customer2 = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      expect(customer1).to(eq(customer2))
    end
  end

  describe(".find") do
    it("returns a customer by its ID number") do
      customer1 = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      customer1.save()
      customer2 = Customer.new({:name => "Heather Hill", :phone => "555-55-6666", :stylist_id => 1, :id => nil})
      customer2.save()
      expect(Customer.find(customer2.id())).to(eq(customer2))
    end
  end

  describe("#update") do
    it("lets you update customers in the database") do
      customer1 = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      customer1.save()
      customer1.update({:name => "Tina"})
      expect(customer1.name()).to(eq("Tina"))
    end
  end

  describe("#delete") do
    it("lets you delete a customer from the database") do
      customer1 = Customer.new({:name => "Sam Sparks", :phone => "555-55-5555", :stylist_id => 1, :id => nil})
      customer1.save()
      customer2 = Customer.new({:name => "Heather Hill", :phone => "555-55-6666", :stylist_id => 1, :id => nil})
      customer2.save()
      customer1.delete()
      expect(Customer.all()).to(eq([customer2]))
    end
  end
end
