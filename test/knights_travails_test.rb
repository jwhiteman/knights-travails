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

    assert_equal %i(a1 c1 h1), @subject.winner(:h1, seen)
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

  def test_calculate_next_squares_in_center
    seen = {}

    expected =
      [
        :c7, :e7,
        :b6, :f6,
        :b4, :f4,
        :c3, :e3
      ]

    assert_equal expected, @subject.calculate_next_squares(:d5, seen)
  end

  def test_calculate_next_squares_on_corner
    seen = {}

    assert_equal %i(b3 c2), @subject.calculate_next_squares(:a1, seen)
  end


  def test_calculate_next_squares_with_seen
    seen = { b6: :forbidden }

    assert_equal %i(c7), @subject.calculate_next_squares(:a8, seen)
  end

  def test_shortest_path_with_trivial_solution
    assert_equal [:a1],
                 @subject.shortest_path(start: :a1,
                                        destination: :a1,
                                        forbidden: %i())
  end

  def test_shortest_path_with_solution
    expected = %i(a8 c7 b5 d6 b7)

    assert_equal expected,
                 @subject.shortest_path(start: :a8,
                                        destination: :b7,
                                        forbidden: %i(b6))
  end

  def test_shortest_path_with_no_solution
    assert_nil @subject.shortest_path(start: :a8,
                                      destination: :g6,
                                      forbidden: %i(b6 c7))
  end
end
