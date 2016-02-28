require_relative './frame'

class FinalFrame < Frame
  def initialize(rolls)
    raise Frame::TooManyRolls if rolls.size > 3
    @first = rolls[0]
    @second = rolls[1]
    @third = rolls[2]
  end

  def score(next_frame, next_but_next_frame)
    roll_score
  end

  def bonus_for_strike(next_frame)
    @first + @second
  end

  def roll_score
    @first + @second + @third
  end
end

