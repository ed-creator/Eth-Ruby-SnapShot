# cat config.ru
require "roda"

class EthSnapshot < Roda
  route do |r|
    r.on "addresses" do
      r.is "submit" do
        "Hello World!"
      end
      r.is "print" do
        "Hello World!"
      end
    end
  end
end
