##Hair Salon

This will create an app to add a list of customers to each stylist that works in the salon.

##Setup
Assuming you have ruby installed. In the terminal:

`gem install bundle`

`bundle`

`ruby app.rb`

In psql create databases titled "salon" and "salon_test"

The tables in each database are titled "stylists" and "customers"

The stylists table includes the following columns: name varchar, id serial PRIMARY KEY

The customers table includes the following columns: name varchar, phone varchar, stylist_id int, id serial PRIMARY KEY

Go to http://localhost:4567 in your browser

##Tests
Testing the ruby methods can be done via rspec.

`gem install rspec`

`rspec`

##Motivation

To practice working with databases in psql and connecting with ruby and sinatra.

##License

MIT License, copyright 2015. Created by Jackie Fletcher.
