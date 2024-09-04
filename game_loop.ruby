# frozen_string_literal: true

# require_relative 'player.ruby'
# require_relative 'board.ruby'

# Main loop that runs the Tic-Tac-Toe game
class Gameloop
  # def initialize
  #   @board = Board.new
  # end

  def run
    puts "Welcome to Tic-Tac-Toe!\nEnter \"1\" to play"
    input = gets
    until input == 'QUIT'
      # Do lots of stuff
      puts "Type your option:\n\nor \'QUIT\' to end the game"
      input = gets.chomp
    end
  end
end

game = Gameloop.new

game.run
