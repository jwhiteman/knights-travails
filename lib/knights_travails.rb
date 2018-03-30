module KnightsTravails
  extend self

  def shortest_path(start:, destination:, forbidden:)
    seen = Hash.new
    add_seen(start, :root, seen)

    if start == destination
      return winner(start, seen)
    else
      queue = Array.new

      forbidden.each do |forbidden_square|
        add_seen(forbidden_square, :forbidden, seen)
      end

      next_squares = calculate_next_squares(start, seen)
      add_queue(next_squares, start, queue)

      queue.each do |parent, squares|
        squares.each do |square|
          add_seen(square, parent, seen)

          if square == destination
            return winner(square, seen)
          else
            next_squares = calculate_next_squares(square, seen)
            add_queue(next_squares, square, queue)
          end
        end
      end

      return nil
    end
  end

  def winner(key, seen)
    if seen[key].nil?
      []
    else
      winner(seen[key], seen) << key
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

  def calculate_next_squares(square, seen)
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
    select do |alpha, numeric|
      alpha > 96 && alpha < 104 && numeric > 48 && numeric < 57
    end.
    map do |square|
      square.
        pack("c*").
        intern
    end.reject do |square|
      seen[square]
    end
  end
end
