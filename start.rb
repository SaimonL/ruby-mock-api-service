require 'sinatra'
require 'json'

require 'pry'

set :port, 8000

Dir.glob('apps/*').each do |app|
  next unless File.directory?(app)
  
  app_name = app.split('/').last
  routes = File.read("#{app}/routes.json")
  routes = JSON.parse(routes)
  
  routes.each do |route|
    method = route["method"].downcase
    path = route["path"]
    file = [app, route["file"]].join('/')
    
    case method
    when 'get'
      get path do
        File.read(file)
      end
    when 'post'
      post path do
        File.read(file)
      end
    when 'put'
      put path do
        File.read(file)
      end
    else
      puts "Unknown method: #{method}"
    end
  end
end
