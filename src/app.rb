require 'sinatra'
require 'json'

require_relative 'isight'
require_relative 'uccp'

set :bind, '0.0.0.0'
set :port, 4567  
set :show_exceptions, :after_handler

puts "Initialized: App"
isight = Isight.new
uccp = Uccp.new

before do
  content_type 'application/json'
end

post '/person' do
  isight.getPerson_json(request)
end

get '/uccp/cs-healthcheck' do
  uccp.getCyberSourceHealthCheck_json(request)
end

get '/*' do
  getHelp
end

post '/*' do
  getHelp
end

error 500 do
  getHelp
end

def getHelp
  content_type 'text/html'
  erb :help
end



  






    