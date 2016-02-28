class Frame
  class TooManyRolls < StandardError; end

  attr_reader :first, :roll_score
  protected :first, :roll_score

  def initialize(rolls)
    raise Frame::TooManyRolls if rolls.size > 2
    @first = rolls[0]
    @second = rolls[1]
  end

  def score(next_frame, next_but_next_frame)
    roll_score + bonus(next_frame, next_but_next_frame)
  end

  protected

  def bonus(next_frame, next_but_next_frame)
    return next_frame.bonus_for_spare if spare?
    return next_frame.bonus_for_strike(next_but_next_frame) if strike?
    0
  end

  def bonus_for_strike(next_frame)
    return roll_score + next_frame.first if strike?
    roll_score
  end

  def bonus_for_spare
    @first
  end

  def strike?
    @first == 10
  end

  def roll_score
    @first + @second
  end

  private

  def spare?
    roll_score == 10 && !!@second && !strike?
  end
end

