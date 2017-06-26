# cat config.ru
require "roda"

class EthSnapshot < Roda
  route do |r|
    "Hello World!"
  end
end
