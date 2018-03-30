module KnightsTravails
  extend self

  def winner(key, seen)
    _winner(key, seen, [])
  end

  def _winner(key, seen, acc)
    if seen[key].nil?
      acc
    else
      _winner(seen[key], seen, acc << key)
    end
  end

  def add_seen(key, parent, seen)
    seen[key] = parent
  end

  def add_queue(squares, parent, queue)
    if squares.any?
      queue << [parent, squares]
    else
      false
    end
  end

  def calculate_next_squares(square)
    alpha, numeric = square.
                     to_s.
                     unpack("c*")

    [
      [alpha - 1, numeric + 2],
      [alpha + 1, numeric + 2],
      [alpha - 2, numeric + 1],
      [alpha + 2, numeric + 1],
      [alpha - 2, numeric - 1],
      [alpha + 2, numeric - 1],
      [alpha - 1, numeric - 2],
      [alpha + 1, numeric - 2]
    ].
    reject do |alpha, numeric|
      alpha < 97 || alpha > 104 || numeric < 49 || numeric > 57
    end.
    map do |square|
      square.
        pack("c*").
        intern
    end
  end
end
