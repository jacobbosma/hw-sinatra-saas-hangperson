class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = '' 
    @wrong_guesses = ''
    @word_with_guesses=String.new('')
    @word.length.times {@word_with_guesses = @word_with_guesses + '-'}
    @word_array = @word.chars
    @check_win_or_lose = :play
end

  def guess(guess)
    if guess.nil? || guess.length == 0
      raise ArgumentError.new("guess cannot be empty")
    end
    if guess !~ /[a-zA-Z]/
       raise ArgumentError.new("That is not a letter")
    end
    @guess=guess.downcase
    if @guesses.include?(@guess) || @wrong_guesses.include?(@guess)
       return false
    end
    if @word.include?(@guess)
       @guesses << @guess unless @guesses.include?(@guess)
    else
       @wrong_guesses << @guess unless @wrong_guesses.include?(@guess)
    end
    @word_array.each_with_index{|value,index|@word_with_guesses[index] = value if value == @guess}
    @check_win_or_lose = :win  if @word == @word_with_guesses
    @check_win_or_lose = :lose if @wrong_guesses.length == 7
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_reader   :word_with_guesses
  attr_reader   :check_win_or_lose

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
end
