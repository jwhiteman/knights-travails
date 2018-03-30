module KnightsTravails
  extend self

  def shortest_path(start:, destination:, forbidden:)
    seen = {}
    add_seen(start, :root, seen)

    return winner(start, seen) if start == destination

    queue = []

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

    false
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

  def calculate_next_squares(current_square, seen)
    alpha, numeric = current_square.
                     to_s.
                     unpack("c*")

    all_possible_chars =
      [
        [alpha - 1, numeric + 2],
        [alpha + 1, numeric + 2],
        [alpha - 2, numeric + 1],
        [alpha + 2, numeric + 1],
        [alpha - 2, numeric - 1],
        [alpha + 2, numeric - 1],
        [alpha - 1, numeric - 2],
        [alpha + 1, numeric - 2]
      ]

    valid_possible_chars =
      all_possible_chars.
      select do |alpha, numeric|
        (alpha > 96 && alpha < 105) && (numeric > 48 && numeric < 57)
      end

    valid_possible_squares =
      valid_possible_chars.
      map do |square|
        square.
        pack("c*").
        intern
      end

    valid_squares =
      valid_possible_squares.
      reject do |square|
        seen[square]
      end

    valid_squares
  end
end
