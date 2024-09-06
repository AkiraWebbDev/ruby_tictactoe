# frozen_string_literal: true

# Represents a player
class Player
  attr_accessor :name, :symbol, :is_bot

  def initialize(name, is_bot = false) # rubocop:disable Style/OptionalBooleanParameter
    @name = name
    @is_bot = is_bot
    if is_bot
      @symbol = 'X'
    else
      puts "Enter the symbol for #{name}"
      @symbol = gets.chomp
    end
  end

  # Chooses a random number from the board in okay
  def random_turn
    [1..9].sample
  end

  def display
    puts "Player: #{@name},\nSymbol: #{@symbol},\nAI? #{@is_bot}}"
  end
end
