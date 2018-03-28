require "test_helper"

class KnightsTravailsTest < Minitest::Test
  def setup
    @subject = KnightsTravails
  end

  def test_winner
    seen =
      {
        a1: :root,
        b1: :a1,
        c1: :a1,
        d1: :a1,
        e1: :b1,
        f1: :b2,
        g1: :b2,
        h1: :c1, # winner
      }

    assert_equal %i(h1 c1 a1), @subject.winner(:h1, seen)
  end

  def test_add_seen_with_parent
    seen = {}

    @subject.add_seen(:b1, :a1, seen)

    assert_equal :a1, seen[:b1]
  end

  def test_add_queue
    queue = []

    @subject.add_queue(%i(b c d), :a, queue)

    assert_equal [[:a, %i(b c d)]], queue
  end

  def test_add_queue_with_empty_squares
    queue = []

    @subject.add_queue([], :a, queue)

    assert_equal [], queue
  end

  def test_calculate_next_squares
    assert false # complete me

    @subject.calculate_next_squares(:d5)

    [
      :c7,     :e7,
      :b6,     :f6,
      :b4,     :f4,
      :c3,     :e3
    ]

    @subject.calculate_next_squares(:a1)

    [
      :b3, :c2
    ]
  end
end
