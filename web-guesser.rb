require 'sinatra'
require 'sinatra/reloader' if development?

num = rand(100)+1

get '/' do
  erb :index, :locals => {:num => num}
end