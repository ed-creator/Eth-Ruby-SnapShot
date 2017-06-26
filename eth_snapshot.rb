# cat config.ru
require "roda"
require "./accounts_model.rb"

class EthSnapshot < Roda
  route do |r|
    r.on "addresses" do
      r.is "submit" do
        r.post do
          @address = r.params['address']
          Accounts.add_address(@address)
          require 'pry'; binding.pry
        end
      end
      r.is "print" do
        puts Accounts.dataset.all()
      end
    end
  end
end
