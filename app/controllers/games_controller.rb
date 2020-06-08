require 'json'
require 'open-uri'

class GamesController < ApplicationController


  def new
    alphabet = ("a".."z").to_a
    @letters = []
    10.times do
      rank = rand() * 25
      @letters << alphabet[rank]
    end
  end

  def score
    @attempt = params[:attempt]
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    opening = open(url).read
    data = JSON.parse(opening)
    @exist = data["found"]
    @length = data["length"]
    @contain = true
    my_letters_array = @attempt.split("")
    all_letters_array = params[:letters].split(" ")
    while my_letters_array.length > 0
      if all_letters_array.include?(my_letters_array[0])
        index = all_letters_array.find_index(my_letters_array[0])
        all_letters_array.delete_at(index)
        my_letters_array.delete_at(0)
      else
        @contain = false
        break
      end
    end
    if @contain
      @score = @length
      if session[:totalscore]
        @totalScore = session[:totalscore] + @score
      else
        @totalScore = @score
      end
      session[:totalscore] = @totalScore
    end
  end
end
