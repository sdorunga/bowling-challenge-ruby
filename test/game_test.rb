require "minitest/autorun"
require "./lib/game"

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_score_with_gutter_balls
    assert_equal(0, @game.score)
    roll(9, [0, 0], @game)
    @game.add_frame([0, 0, 0])
    assert_equal(0, @game.score)
    assert_raises(Game::GameFinished) { @game.add_frame([0, 0]) }
  end

  def test_score_with_simple_rolls
    roll(9, [1,2], @game)
    @game.add_frame([1, 2, 0])
    assert_equal(30, @game.score)
  end

  def test_score_with_spares
    roll(9, [9,1], @game)
    @game.add_frame([9, 1, 9])
    assert_equal(190, @game.score)
  end

  def test_score_with_strikes
    roll(9, [10,0], @game)
    @game.add_frame([10,10,10])
    assert_equal(300, @game.score)
  end

  def test_score_with_mix
    #@game.add_frame([10,10,10])
  end

  def test_adding_too_many_rolls
    assert_raises(Frame::TooManyRolls) { @game.add_frame([1,1,1])}
  end

  private

  def roll(number, frame, game)
    number.times do
      game.add_frame(frame)
    end
  end
end
