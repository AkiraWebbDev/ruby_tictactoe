# frozen_string_literal: true

require 'board'

describe Board do # rubocop:disable Metrics/BlockLength
  describe '#display_board' do
    # No test required since only accesses and prints stuff
  end

  describe '#take_turn' do
    subject(:board_turn) { described_class.new }
    context 'when a player passes valid input' do
      it 'puts the symbol in the correct place' do
        player_symbol = 'X'
        place = 1
        expect { board_turn.take_turn(player_symbol, place) }.to \
          change { board_turn.instance_variable_get(:@board) }.to \
            eq([['X', 2, 3], [4, 5, 6], [7, 8, 9]])
      end

      it 'increments the turn counter' do
        player_symbol = 'X'
        place = 1
        expect { board_turn.take_turn(player_symbol, place) }.to \
          change { board_turn.instance_variable_get(:@turns) }.by 1
      end

      it 'returns "DRAW" if the board is full' do
        player_symbol = 'X'
        place = 1
        board_turn.instance_variable_set(:@turns, 8)
        expect(board_turn.take_turn(player_symbol, place)).to be 'DRAW'
      end

      it 'calls check_winner once' do
        player_symbol = 'X'
        place = 1
        expect(board_turn).to receive(:check_winner).exactly(1).times
        board_turn.take_turn(player_symbol, place)
      end
    end

    context 'when a player passes invalid input' do
      it 'does not accept letters as places' do
        player_symbol = 'X'
        invalid_place = 'G'
        expect(board_turn.take_turn(player_symbol, invalid_place)).to eql(-1)
      end

      it 'does not accept out-of-range numbers as places' do
        player_symbol = 'X'
        invalid_place = 24
        expect(board_turn.take_turn(player_symbol, invalid_place)).to eql(-1)
      end

      it 'does not accept places that are already taken' do
        player_symbol = 'O'
        invalid_place = 1
        board_turn.instance_variable_set(:@board, [['X', 2, 3], [4, 5, 6], [7, 8, 9]])
        expect(board_turn.take_turn(player_symbol, invalid_place)).to eql(-1)
      end
    end
  end

  describe '#check_winner' do # rubocop:disable Metrics/BlockLength
    subject(:board_check) { described_class.new }
    context 'when there is no winner' do
      it 'calls check_row_win once' do
        expect(board_check).to receive(:check_row_win).once
        board_check.check_winner
      end

      it 'calls check_col_win once' do
        expect(board_check).to receive(:check_col_win).once
        board_check.check_winner
      end

      it 'calls check_diag_left_win once' do
        expect(board_check).to receive(:check_diag_left_win).once
        board_check.check_winner
      end

      it 'calls check_diag_right_win once' do
        expect(board_check).to receive(:check_diag_right_win).once
        board_check.check_winner
      end

      it 'returns false' do
        expect(board_check.check_winner).to be false
      end
    end

    context 'when there is a winner' do
      it 'identifies a row win and returns true' do
        board_check.instance_variable_set(:@board, [%w[X X X], [4, 5, 6], [7, 8, 9]])
        expect(board_check.check_winner).to be true
      end

      it 'identifies a column win and returns true' do
        board_check.instance_variable_set(:@board, [['X', 2, 3], ['X', 5, 6], ['X', 8, 9]])
        expect(board_check.check_winner).to be true
      end

      it 'identifies a diagonal win and returns true' do
        board_check.instance_variable_set(:@board, [['X', 2, 3], [4, 'X', 6], [7, 8, 'X']])
        expect(board_check.check_winner).to be true
      end

      it 'identifies the other diagonal win and returns true' do
        board_check.instance_variable_set(:@board, [[1, 2, 'X'], [4, 'X', 6], ['X', 8, 9]])
        expect(board_check.check_winner).to be true
      end
    end
  end
end
