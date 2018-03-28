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
end
