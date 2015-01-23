require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/stylist.rb')
require('./lib/customer.rb')
require('pg')

DB = PG.connect({:dbname => "salon"})

get ("/") do
  @stylists = Stylist.all()
  erb(:index)
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end

get("/stylists/:id/edit") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist_edit)
end

patch("/stylists/:id") do
  name = params.fetch("name")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.update({:name => name})
  erb(:stylist)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:index)
end

post("/stylist") do
 name = params.fetch("name")
 stylist = Stylist.new({:name => name, :id => nil})
 stylist.save()
 @stylists = Stylist.all()
 erb(:index)
end

post("/customers") do
  name = params.fetch("customer")
  phone = params.fetch("phone")
  stylist_id = params.fetch("stylist_id").to_i()
  customer = Customer.new({:name => name, :phone => phone, :stylist_id => stylist_id, :id => nil})
  customer.save()
  @stylist = Stylist.find(stylist_id)
  erb(:stylist)
end

# could add customer updates/delete
#
# get("/customers/:id") do
#   @customer = Customer.find(params.fetch("id").to_i())
#   erb(:customer_edit)
# end
#
# get("/customers/:id/edit") do
#   @customer = Customer.find(params.fetch("id").to_i())
#   erb(:customer_edit)
# end
#
# patch("/customers/:id") do
#   name = params.fetch("name")
#   @customer = Customer.find(params.fetch("id").to_i())
#   @customer.update({:name => name})
#   erb(:index)
# end
#
# delete("/customers/:id") do
#   @customer = Customer.find(params.fetch("id").to_i())
#   @customer.delete()
#   @customers = Customer.all()
#   erb(:index)
# end
#
# post("/customer") do
#   name = params.fetch("customer")
#   phone = params.fetch("phone")
#   stylist_id = params.fetch("stylist_id").to_i()
#   customer = Customer.new({:name => name, :phone => phone, :stylist_id => stylist_id, :id => nil})
#   customer.save()
#   @customers = Customer.all()
#   erb(:index)
# end
