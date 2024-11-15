# frozen_string_literal: true

# The actual tic-tac-toe board.
class Board
  def initialize(state = 'clean')
    return unless state == 'clean'

    @turns = 0
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

  def take_turn(player_symbol, value)
    row_found = nil
    @board.each_with_index do |row, index|
      row_found = index if row.include?(value)
    end
    return -1 if row_found.nil?

    @board[row_found][@board[row_found].index(value)] = player_symbol
    @turns += 1
    return 'DRAW' if @turns == 9

    check_winner
  end

  # Checks each win condition for the input player
  def check_winner
    return true if check_row_win

    return true if check_col_win

    return true if check_diag_left_win

    return true if check_diag_right_win

    false
  end

  private

  def check_row_win
    @board.each { |row| return true if row.uniq.size == 1 }
    false
  end

  def check_col_win
    board_transposed = @board.transpose
    board_transposed.each { |row| return true if row.uniq.size == 1 }
    false
  end

  def check_diag_left_win
    diag = [@board[0][0], @board[1][1], @board[2][2]]
    return true if diag.uniq.size == 1

    false
  end

  def check_diag_right_win
    diag = [@board[0][2], @board[1][1], @board[2][0]]
    return true if diag.uniq.size == 1

    false
  end
end
