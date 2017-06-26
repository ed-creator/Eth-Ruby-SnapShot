require "rubygems"
require "sequel"
require 'net/http'
require 'json'

DB = Sequel.connect('sqlite://accounts.db')

class Accounts < Sequel::Model

  # # create an items table
  # DB.create_table :accounts do
  #   primary_key :id
  #   String :address
  #   Float :account_balance
  # end

  # create a dataset from the items table
  accounts = DB[:accounts]

  # populate the table
  accounts.insert(:address => 'abc', :account_balance => rand * 100)
  accounts.insert(:address => 'def', :account_balance => rand * 100)
  accounts.insert(:address => 'ghi', :account_balance => rand * 100)
  dataset_module do

    def add_address(address)
      url = 'https://etherchain.org/api/account/'
      uri = URI(url + address)
      response = Net::HTTP.get(uri)
      account_json = JSON.parse(response)
      account_json['data'][0]['address']
      Accounts.create(:address => account_json['data'][0]['address'],
                      :account_balance =>   account_json['data'][0]['balance'])
    end
  end

    # print out the number of records
    dataset_module do

    def printf
      puts "Item count: #{accounts.count}"
    end
  end

  # print out the average price
  puts "The average price is: #{accounts.avg(:account_balance)}"

  puts accounts

end
