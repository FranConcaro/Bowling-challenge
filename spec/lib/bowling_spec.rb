require 'spec_helper'
require 'bowling'

RSpec.describe Bowling do
  let(:perfect) { file_fixture('perfect.txt') }
  let(:scores) { file_fixture('scores.txt') }
  let(:all_fouls) { file_fixture('all-fouls.txt') }
  let(:invalid_score) { file_fixture('invalid-score.txt') }
  let(:negative) { file_fixture('negative.txt') }
  let(:extra_score) { file_fixture('extra-score.txt') }
  let(:perfect_output) { file_fixture('perfect_output.txt').read }
  let(:scores_output) { file_fixture('scores_output.txt').read }
  let(:fouls_output) { file_fixture('fouls_output.txt').read }

  context 'when input file is valid' do
    context 'with more than two players' do
      it 'prints the game scoreboard to stdout' do
        expect { described_class.new(scores) }.to output(scores_output.gsub(/\\t/, "\t").gsub(/\\n/, "\n")).to_stdout
      end
    end

    context 'with strikes in all throwings' do
      it 'prints a perfect game scoreboard' do
        expect { described_class.new(perfect) }.to output(perfect_output.gsub(/\\t/, "\t").gsub(/\\n/, "\n")).to_stdout
      end
    end

    context 'with fouls in all throwings' do
      it 'prints the game scoreboard to stdout' do
        expect do
          described_class.new(all_fouls)
        end.to output(fouls_output.gsub(/\\t/, "\t").gsub(/\\n/, "\n")).to_stdout
      end
    end
  end

  context 'when input file is invalid' do
    context 'with invalid characters present' do
      it 'raises the corresponding error message' do
        expect { described_class.new(invalid_score) }.to raise_error(RuntimeError)
      end
    end

    context 'with invalid score' do
      it 'raises the corresponding error message' do
        expect { described_class.new(negative) }.to raise_error(RuntimeError)
      end
    end

    context 'with invalid number of throwings' do
      it 'raises the corresponding error message' do
        expect { described_class.new(extra_score) }.to raise_error(RuntimeError)
      end
    end
  end
end
