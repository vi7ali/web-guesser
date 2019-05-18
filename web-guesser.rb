require 'sinatra'
require 'sinatra/reloader' if development?

num = rand(100)+1

get '/' do  
  guess = params[:guess].to_i unless params[:guess].nil?
  message = get_message(guess, num)
  erb :index, :locals => {num: num, message: message, guess: guess}
end

def get_message(guess, num)
  message = ""
  unless guess.nil?
    if guess == num
      message = "Hooray"
    elsif guess > num
      message = "Too high!"
    elsif guess < num
      message = "Too low!"
    else
      message = "Not a num"
    end
  end
  message
end