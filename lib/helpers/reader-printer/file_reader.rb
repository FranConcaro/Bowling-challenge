class FileReader
  attr_reader :games

  def read(file)
    @games = parse_games(file) # [{:name, :shots}]
  end

  private

  def parse_games(file)
    games = []
    shots = File.read(file).split("\n")
    validate_input(shots)
    names, players_shots = players_names(shots)
    raise "\n******\nERROR: Please check file format and re-run.\n******\n" unless names

    names.each do |player|
      ps = players_shots.select { |p| p.first == player }.flatten!.reject { |p| p == player }
      games << { player_name: player, shots: ps }
    end
    games
  end

  def players_names(shots)
    players_shots = []
    names = []
    shots.each do |shot|
      names << shot.split.first
      players_shots << shot.split
    end

    [names.uniq!, players_shots]
  end

  def validate_input(shots)
    shots.each_with_index do |shot, i|
      shot.gsub!(/(?:\r|\n)/, '')
      if (shot =~ /\w+(?:\t+|\s+)(?:F|10|[0-9])$/).nil?
        raise "\n******\nInvalid input on line #{i + 1}. Please check file format and re-run.\n******\n"
      end
    end
  end
end
