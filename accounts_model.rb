require "rubygems"
require "sequel"
require 'net/http'
require 'json'

# connect to an in-memory database
DB = Sequel.sqlite

DB = Sequel.connect('sqlite://accounts.db')

class EthAccounts < Sequel::Model

# create an items table
DB.create_table :accounts do
  primary_key :id
  String :address
  Float :account_balance
end

# create a dataset from the items table
accounts = DB[:accounts]

# populate the table
accounts.insert(:address => 'abc', :account_balance => rand * 100)
accounts.insert(:address => 'def', :account_balance => rand * 100)
accounts.insert(:address => 'ghi', :account_balance => rand * 100)

def add_address(address)
  url = 'https://etherchain.org/api/account/'
  uri = URI(url + address)
  response = Net::HTTP.get(uri)
  account_json = JSON.parse(response)
  account_json['data'][0]['address']
  accounts.insert(:address => account_json['data'][0]['address'],
                  :account_balance =>   account_json['data'][0]['balance'])
end

# print out the number of records
def print
  puts "Item count: #{accounts.count}"
end

# print out the average price
puts "The average price is: #{accounts.avg(:account_balance)}"

puts accounts

end
