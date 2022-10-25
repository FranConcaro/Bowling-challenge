require_relative 'bowling'
class Main
  def initialize
    Bowling.new(ARGV[0])
  end
end
Main.new
