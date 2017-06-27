require "rubygems"
require "sequel"
require 'net/http'
require 'json'

DB = Sequel.connect('sqlite://accounts.db')

class Accounts < Sequel::Model

  WEI_EHTER_RATIO = 1000000000000000000

  accounts = DB[:accounts]

  private

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
    def get_accounts_json
      account_mapping = Accounts.map {|r| {r[:address] =>
                                          {:eth_balance => wei_to_ether(r[:account_balance]),
                                          :wei_balance => r[:account_balance]}}}
      account_mapping = {:accounts => account_mapping}
      return account_mapping.to_json
    end
  end


  dataset_module do
    def wei_to_ether(balance)
      return (balance / WEI_EHTER_RATIO).round(3)
    end
  end
end
