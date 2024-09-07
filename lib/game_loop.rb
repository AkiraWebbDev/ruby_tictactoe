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
      next if win == false
      break if win == true

      if win == 'DRAW'
        draw_game
        return 0
      end

      while win == -1
        puts "Invalid choice #{player.name}... \nPlease try again:"
        input = gets.chomp
        win = player_turn(player, input)
      end
    end
    game_over(players[current_player])
  end

  def draw_game
    @game_board.display_board
    puts "\n#############################\nGame was a draw! Well played!\n#############################"
  end

  def game_over(player)
    @game_board.display_board
    puts "\n#############################\n#{player.name} WINS!!! CONGRATULATIONS!\n#############################"
  end

  def player_turn(player, input)
    return -1 unless Array(1..9).include?(input.to_i)
    return -1 if input.length > 1

    @game_board.take_turn(player.symbol, input.to_i)
  end
end
