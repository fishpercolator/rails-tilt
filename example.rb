require 'sinatra'

set port: 8080

get '/' do
    'Hello from rails-tilt (actually Sinatra!)'
end
