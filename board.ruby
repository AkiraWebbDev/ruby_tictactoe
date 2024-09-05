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

  def take_turn(value, player)
    @board.each do |row|
      row[row.index(value)] = player if row.include?(value)
    end
  end
end
