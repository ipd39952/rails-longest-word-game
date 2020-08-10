require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    12.times{@letters.push(('A'..'Z').to_a.sample)}
    @letters
  end

  def score
    # raise
    url = "https://wagon-dictionary.herokuapp.com/#{params["your_word"]}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    # user = {"found"=>true, "word"=>"apple", "length"=>5}
    if !params["your_word"].chars.all?{|item| params["letters"].include?(item.upcase)}
      @output = "Sorry but #{params["your_word"]} can't be build from the grid"
    elsif !user["found"]
      @output = "Sorry but #{params["your_word"]} doesn't seem to be a valid word"
    else
      @output = "Congratulations! #{params["your_word"]} is a valid English word!"
    end
  end
end
