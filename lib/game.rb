require_relative "./frame"
require_relative "./final_frame"

class Game
  class GameFinished < StandardError; end

  def initialize()
    @frames = []
  end

  def score
    @frames.each_with_index.reduce(0) do |prev, (frame, index)|
      prev + frame.score(@frames[index + 1], @frames[index + 2])
    end
  end

  def add_frame(rolls)
    raise GameFinished if @frames.length > 9
    frame = @frames.length < 9 ? Frame.new(rolls) : FinalFrame.new(rolls)

    @frames << frame
  end
end
