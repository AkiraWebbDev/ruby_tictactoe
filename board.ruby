# frozen_string_literal: true

# The actual tic-tac-toe board.
class Board
  def initialize(state = 'clean')
    return unless state == 'clean'

    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  # Displays the current board state
  def display_board
    @board.each_with_index do |row, index|
      row.each_with_index do |value, inner_index|
        print "  #{value}  \|" if inner_index != 2
        print "  #{value}  " if inner_index == 2
      end
      puts "\n----------------" if index != 2
    end
    print "\n\n\n"
  end

  def take_turn(player, value)
    @board.each do |row|
      row[row.index(value)] = player if row.include?(value)
    end
    check_winner(player)
  end

  # Checks each win condtion for the input player
  def check_winner(player)
    return true if check_row_win(player)

    return true if check_col_win(player)

    return true if check_diag_win(player)

    false
  end

  def check_row_win(player)
    puts "checking row win for #{player}"
    @board.each { |row| return true if row.uniq.size == 1 }
    false
  end

  def check_col_win(player)
    puts "checking column win for #{player}"
    board_transposed = @board.transpose
    board_transposed.each { |row| return true if row.uniq.size == 1 }
    false
  end

  def check_diag_win(player)
    puts "checking diagonal win for #{player}"
    diag1 = [@board[0][0], @board[1][1], @board[2][2]]
    return true if diag1.uniq.size == 1

    diag2 = [@board[0][2], @board[1][1], @board[2][0]]
    return true if diag2.uniq.size == 1

    false
  end
end
