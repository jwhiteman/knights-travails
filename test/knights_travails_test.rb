require "test_helper"

class KnightsTravailsTest < Minitest::Test
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

    assert_equal %i(h1 c1 a1), KnightsTravails.winner(:h1, seen)
  end
end
