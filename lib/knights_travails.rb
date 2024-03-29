module KnightsTravails
  extend self

  attr_accessor :verbose

  def shortest_path(start:, destination:, forbidden:)
    seen = {}
    add_seen(start, :root, seen)

    return winner(start, seen) if start == destination

    queue = []

    for forbidden_square in forbidden do
      add_seen(forbidden_square, :forbidden, seen)
    end

    next_squares = calculate_next_squares(start, seen)
    add_queue(next_squares, start, queue)

    for parent, squares in queue do
      for square in squares do
        add_seen(square, parent, seen)

        if square == destination
          return winner(square, seen)
        else
          next_squares = calculate_next_squares(square, seen)
          add_queue(next_squares, square, queue)
        end
      end
    end

    puts "failed: #{seen}" if verbose
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
                     unpack("cc")

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
        pack("cc").
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
