# frozen_string_literal: true

# Represents a player
class Player
  attr_accessor :name, :symbol, :is_bot

  def initialize(name, is_bot = false) # rubocop:disable Style/OptionalBooleanParameter
    @name = name
    @is_bot = is_bot
    chosen_symbol = 'more than 1 character'
    while chosen_symbol.length > 1
      puts "Enter the symbol for #{name}\n(Must be 1 character)"
      chosen_symbol = gets.chomp
    end
    @symbol = chosen_symbol
  end

  # Chooses a random number from the board in okay
  def random_turn
    [1..9].sample
  end

  def display
    puts "Player: #{@name},\nSymbol: #{@symbol},\nAI? #{@is_bot}}"
  end
end
