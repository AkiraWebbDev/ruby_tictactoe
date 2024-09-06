# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# Main loop that runs the Tic-Tac-Toe game
class Gameloop
  def initialize
    @game_board = Board.new
  end

  def start
    settings
  end

  def settings
    valid_input = false
    until valid_input
      puts "\n\n\n###### WELCOME TO TIC-TAC-TOE! ######\n\nEnter \"1\" to play against another player.
      \nEnter \"QUIT\" to exit the game.
      \n#####################################"
      option = gets.chomp
      return if option == 'QUIT'

      valid_options = %w[1 2]
      valid_input = true if valid_options.include?(option)
    end
    setup_game(option)
  end

  def setup_game(option)
    puts 'Enter your name (Player 1)'
    player1 = Player.new(gets.chomp)
    puts 'Enter your name (Player 2)'
    player2 = option == '1' ? Player.new(gets.chomp, false) : Player.new(gets.chomp, true)
    run([player1, player2])
  end

  def run(players)
    input = nil
    current_player = 1
    until input == 'QUIT'
      current_player = current_player.zero? ? 1 : 0
      player = players[current_player]
      @game_board.display_board
      puts "It's #{player.name}'s turn!!\nType your option:\n\n\nor \'QUIT\' to end the game."
      input = gets.chomp
      return if input == 'QUIT'

      win = player_turn(player, input)
      while win.instance_of?(Integer.class)
        puts "Invalid choice #{player.name}... \nPlease try again"
        input = gets.chomp
        win = player_turn(player, input)
      end
      next unless win == true

      input = 'QUIT'
    end
    game_over(players[current_player])
  end

  def game_over(player)
    @game_board.display_board
    puts "#{player.name} WINS!!! CONGRATULATIONS!"
  end

  def player_turn(player, input)
    @game_board.take_turn(player.symbol, input)
  end
end
