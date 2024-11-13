# frozen_string_literal: true

require 'game_loop'

describe Gameloop do
  describe '#settings' do
    subject(:loop_settings) { described_class.new }
    context 'when the player passes single player input to continue' do
      before do
        valid_input = '1'
        allow(loop_settings).to receive(:gets).and_return(valid_input)
      end
      it 'calls setup_game once' do
        expect(loop_settings).to receive(:setup_game).exactly(1).times
        loop_settings.settings
      end
    end
  end
end
