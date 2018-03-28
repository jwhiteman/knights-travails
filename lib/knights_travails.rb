require "knights_travails/version"

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
end
