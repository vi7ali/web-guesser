# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
COLORS = { too_low: '#B754FF',
           low: '#7C4DE8',
           high: '#4D70E8',
           too_high: '#54A9FF',
           white: '#FFFFFF',
           red: '#FF0000' }.freeze
NUM = rand(1..100)
new_game = lambda do |x|
  { msg: "Let's Roll", color: COLORS[:white] } if x.nil? || x.zero?
end
way_too_high = lambda do |x|
  { msg: 'Way too high', color: COLORS[:too_high] } if (x > NUM) && (x - NUM > 5)
end
too_high = lambda do |x|
  { msg: 'Too high', color: COLORS[:high] } if (x > NUM) && (x - NUM <= 5)
end
way_too_low = lambda do |x|
  { msg: 'Way too low', color: COLORS[:too_low] } if (x < NUM) && (NUM - x > 5)
end
too_low = lambda do |x|
  { msg: 'Too low', color: COLORS[:low] } if (x < NUM) && (NUM - x <= 5)
end
winner = lambda do |x|
  { msg: "Congratulations, the number was #{NUM}", color: COLORS[:red] } if x == NUM
end
CHECKS = [new_game, way_too_high, way_too_low, too_high, too_low, winner].freeze

get '/' do
  guess = params[:guess].to_i
  check = perform_checks(guess)
  erb :index, locals: { message: check[:msg], color: check[:color] }
end

def perform_checks(guess)
  check = nil
  CHECKS.each do |operation|
    check = operation.call(guess)
    break unless check.nil?
  end
  check
end
