require 'spec_helper'
require_relative '../../../../lib/helpers/game/score'
require_relative '../../../../lib/helpers/frames/frame'
require_relative '../../../../lib/helpers/frames/last_frame'
RSpec.describe Score do
  let(:score) { Score.new }
  let(:frames) { (0..8).map { |i| Frame.new(i) } }

  it 'adds a regular frame' do
    frames[0].add(3)
    frames[0].add(3)
    score.add(frames[0])
    expect(score.frames.size).to be(1)
  end

  it 'adds a regular frame and check points' do
    frames[0].add(3)
    frames[0].add(3)
    score.add(frames[0])
    expect(score.points).to be(6)
  end

  it 'adds 2 strikes and check points' do
    frames[0].add(10)
    frames[1].add(10)
    score.add(frames[0])
    score.add(frames[1])
    expect(score.points).to be(30)
  end

  it 'adds 1 spare and check points' do
    frames[0].add(9)
    frames[0].add(1)
    frames[1].add(5)
    score.add(frames[0])
    score.add(frames[1])
    expect(score.points).to be(20)
  end

  it 'adds 3 strikes and check points' do
    (0..2).each { |i| frames[i].add(10); score.add(frames[i]) }
    expect(score.points).to be(60)
  end

  it 'checks a perfect game' do
    frames << LastFrame.new(9)
    (0..8).each { |i| frames[i].add(10); score.add(frames[i]) }
    3.times { frames[9].add(10) }
    score.add(frames[9])
    expect(score.points).to be(300)
  end

  it 'checks a faulty game' do
    frames << LastFrame.new(9)
    (0..9).each { |i| frames[i].add(0); frames[i].add(0); score.add(frames[i]) }
    expect(score.points).to be(0)
  end
end
