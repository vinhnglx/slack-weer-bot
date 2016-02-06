require 'sinatra/base'

module Weer
  class Web < Sinatra::Base
    get '/' do
      'Hello World'
    end
  end
end
