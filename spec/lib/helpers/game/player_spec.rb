require 'spec_helper'
require_relative '../../../../lib/helpers/game/player'
require_relative '../../../../lib/helpers/game/score'
require_relative '../../../../lib/helpers/frames/frame'
require_relative '../../../../lib/helpers/frames/last_frame'
RSpec.describe Player do
  describe 'while playing' do
    it 'scores a game with all zeros' do
      player = described_class.new('Frank', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
      expect(player.score).to be(0)
    end

    it 'scores a game with no strikes or spares' do
      player = described_class.new('Frank', [3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6])
      expect(player.score).to be(90)
    end

    it 'scores a game with 1 spare then 0s' do
      player = described_class.new('Frank', [6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
      expect(player.score).to be(10)
    end

    it 'doubles the next points after a spare' do
      player = described_class.new('Frank', [6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
      expect(player.score).to be(16)
    end

    it 'scores consecutive spares bonuses' do
      player = described_class.new('Frank', [5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
      expect(player.score).to be(31)
    end

    it 'scores when a spare in the last frame gets a one roll bonus that is counted once' do
      player = described_class.new('Frank', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7])
      expect(player.score).to be(17)
    end

    it 'scores a strike in a frame with a single roll which earns ten points' do
      player = described_class.new('Frank', [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
      expect(player.score).to be(10)
    end

    it 'scores points in the two rolls after a strike which are counted twice as a bonus' do
      player = described_class.new('Frank', [10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
      expect(player.score).to be(26)
    end

    it 'scores consecutive strikes which get the two roll bonus' do
      player = described_class.new('Frank', [10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
      expect(player.score).to be(81)
    end

    it 'scores a strike in the last frame which gets a two roll bonus that is counted once' do
      player = described_class.new('Frank', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1])
      expect(player.score).to be(18)
    end

    it 'scores a spare with the two roll bonus which does not get a bonus roll' do
      player = described_class.new('Frank', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3])
      expect(player.score).to be(20)
    end

    it 'scores strikes with the two roll bonus which do not get bonus rolls' do
      player = described_class.new('Frank', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10])
      expect(player.score).to be(30)
    end

    it 'scores a strike with the one roll bonus after a spare in the last frame which does not get a bonus' do
      player = described_class.new('Frank', [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10])
      expect(player.score).to be(20)
    end

    it 'scores a perfect game' do
      player = described_class.new('Frank', [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10])
      expect(player.score).to be(300)
    end

    it 'scores all fauls' do
      player = described_class.new('Frank',
                                   %w[F F F F F F F F F F F F F F F F F F F F])
      expect(player.score).to be(0)
    end
  end
end
