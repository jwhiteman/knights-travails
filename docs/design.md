- instantiate $seen
- instantiate $queue

- establish current-square
- is current-square the destination?
  - return current-square
- else
  - for f in forbidden
    - add-seen(f, :forbidden, $seen)
  - next-squares = calculate-next-squares(current-square, $seen)
  - add-queue(next-squares, current-square, $queue)
  - while (parent, squares) in $queue
    - for s in squares
      - add-seen(s, parent, $seen)
      - is s the destination?
        - return winner(destination, $seen)
      - else
        - next-squares = calculate-next-squares(s, $seen)
        - add-queue(next-squares, s, $queue)
  - return nil // failure

- add-queue(squares, parent, $queue)
  - $queue << [parent, squares] if squares present

- add-seen(square, parent, $seen)
  - $seen[square] = parent

- calculate-next-squares(square, $seen)
  - TBD
  - filter $seen // 8x operations in the worst case...
