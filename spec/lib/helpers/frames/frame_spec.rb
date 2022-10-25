require 'spec_helper'
require_relative '../../../../lib/helpers/frames/frame'
require_relative '../../../../lib/helpers/frames/last_frame'
RSpec.describe Frame do
  let(:frames) { (0..8).map { |i| Frame.new(i) } }

  describe 'when parsing rolls' do
    it 'is an empty roll' do
      frame = frames[0]
      expect(frame.first_roll).to be_nil
    end

    it 'is a valid roll' do
      frame = frames[0]
      frame.add(5)
      expect(frame.first_roll).to be(5)
    end

    it 'is not a valid first roll' do
      frame = frames[0]
      expect { frame.add(11) }.to raise_error(RuntimeError)
    end

    it 'is a valid second roll' do
      frame = frames[0]
      frame.add(1)
      frame.add(8)
      expect(frame.second_roll).to be(8)
    end

    it 'is a complete frame' do
      frame = frames[0]
      frame.add(1)
      frame.add(8)
      expect(frame.complete?).to be true
    end

    it 'is a strike' do
      frame = frames[0]
      frame.add(10)
      expect(frame.strike?).to be true
    end

    it 'is a complete frame when strike' do
      frame = frames[0]
      frame.add(10)
      expect(frame.complete?).to be true
    end

    it 'is a spare frame' do
      frame = frames[0]
      frame.add(1)
      frame.add(9)
      expect(frame.spare?).to be true
    end

    it 'is an invalid frame for more than 10 pins in two throws' do
      frame = frames[0]
      frame.add(3)
      expect { frame.add(8) }.to raise_error(RuntimeError)
    end

    it 'gives 10 points for a spare' do
      frame = frames[0]
      frame.add(1)
      frame.add(9)
      expect(frame.points).to be(10)
    end

    it 'is a spare frame plus bonus' do
      frame = frames[0]
      frame.add(1)
      frame.add(9)
      frame.bonus = 5
      expect(frame.points).to be(15)
    end

    it 'is an incomplete last frame, when spare' do
      frames << LastFrame.new(9)
      frame = frames[9]
      frame.add(1)
      frame.add(9)
      expect(frame.complete?).to be false
    end

    it 'is an incomplete last frame, when 2 strikes' do
      frames << LastFrame.new(9)
      frame = frames[9]
      frame.add(10)
      frame.add(10)
      expect(frame.complete?).to be false
    end

    it 'is an complete last frame, when spare' do
      frames << LastFrame.new(9)
      frame = frames[9]
      frame.add(1)
      frame.add(9)
      frame.add(5)
      expect(frame.complete?).to be true
    end

    it 'is an complete last frame, when 2 strikes' do
      frames << LastFrame.new(9)
      frame = frames[9]
      frame.add(10)
      frame.add(10)
      frame.add(9)
      expect(frame.complete?).to be true
    end

    it 'cannot roll 3 times if there was no strike or spare' do
      frames << LastFrame.new(9)
      frame = frames[9]
      frame.add(1)
      frame.add(2)
      expect { frame.add(8) }.to raise_error(RuntimeError)
    end
  end
end
