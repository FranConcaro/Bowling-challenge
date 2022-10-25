require_relative 'helpers/reader-printer/file_reader'
require_relative 'helpers/reader-printer/score_printer'
require_relative 'helpers/game/player'
require_relative 'helpers/game/score'
require_relative 'helpers/frames/frame'
require_relative 'helpers/frames/last_frame'

class Bowling
  def initialize(file)
    @games = FileReader.new.read(file)
    ScorePrinter.new.print(players_results)
  end

  private

  def players_results
    results = []
    @games.each do |game|
      results << Player.new(game[:player_name], game[:shots])
    end

    results
  end
end
