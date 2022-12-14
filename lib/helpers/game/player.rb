class Player
  attr_accessor :shot, :name, :score_card, :shots

  def initialize(name, shots)
    @name = name
    @shots = shots
    @score_card = Score.new
    @current_frame = Frame.new(0)
    player_game
  end

  def player_game
    @shots.each { |shot| roll(shot) }
  end

  def roll(number_of_pins)
    number_of_pins = 0 if number_of_pins == 'F'
    validate_game_not_finished
    @current_frame.add(number_of_pins)

    if @current_frame.complete?
      @score_card.add(@current_frame)
      @current_frame = new_frame
    end
  end

  def score
    validate_game_finished
    @score_card.points
  end

  def new_frame
    frame_count == 9 ? LastFrame.new(9) : Frame.new(frame_count)
  end

  def frame_count
    @score_card.frames.count
  end

  def validate_game_not_finished
    raise 'Should not be able to roll after game is over (You may entered more than 10 throws)' if game_over?
  end

  def validate_game_finished
    unless game_over?
      raise 'Score cannot be taken until the end of the game (Check if you enter the correct number of throws for each player)'
    end
  end

  def game_over?
    frame_count == 10
  end
end
