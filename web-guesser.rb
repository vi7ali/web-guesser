require 'sinatra'
require 'sinatra/reloader' if development?

num = rand(100)+1
COLORS = {too_low: '#B754FF', low:'#7C4DE8', high: '#4D70E8', too_high: '#54A9FF'}

get '/' do    
  guess = params[:guess].to_i unless params[:guess].nil?  
  message = get_message(guess, num)
  color = get_color(message)
  erb :index, :locals => {num: num, message: message, guess: guess, color: color}
end

def get_message(guess, num)
  message = ""
  unless guess.nil?
    case
    when guess > num && guess - num > 5
      message = "Way too high"
    when guess > num && guess - num <= 5
      message = "Too high"      
    when guess < num && num - guess > 5
      message = "Way too low"      
    when guess < num && num - guess <= 5
      message = "Too low"      
    else
      message = "Hooray you guessed it, the number was #{num}"
    end
  end
  message
end

def get_color(msg)
  
  unless msg.empty?
    case msg
    when "Way too high"
      color = COLORS[:too_high]
    when "Too high"
      color = COLORS[:high]
    when "Too low"
      color = COLORS[:low]
    when "Way too low"
      color = COLORS[:too_low]
    else
      color = '#6661FF'
    end
  end
  color
end