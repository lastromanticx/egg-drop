TOP = 100
EGGS = 2
$iterations = 0

# a matrix to store values for the four-variable states in f
$m = Array.new(TOP + 1)

(0..TOP + 1).to_a.each do |high|
  $m[high] = Array.new(TOP + 1)
 
  (0..TOP + 1).to_a.each do |top|
    $m[high][top] = Array.new(EGGS + 1)
 
    (0..EGGS + 1).to_a.each do |eggs|
      $m[high][top][eggs] = Array.new(TOP + 1)
 
      (0..TOP + 1).to_a.each do |trials|
 
        # we cannot solve if we're out of eggs 
        # before knowing about all the floors
        $m[high][top][0][trials] = Float::INFINITY if high < top - 1
      end
    end
  end
end

# high: we have a determined answer for this and all floors below it
# top: we know the egg will break above this point
# eggs: how many of them we have left
# trials: how many we've executed so far

def f high, top, eggs, trials

  # if the value is already known, avoid recalculating it
  if $m[high][top][eggs][trials]
    return $m[high][top][eggs][trials]
  end

  $iterations += 1

  # we find a possible solution when we know about all the floors
  if high >= top - 1 && eggs >= 0
    return trials
  end

  # an accumulator to update as we try different possibilities
  best = Float::INFINITY

  # since we don't know where to try next, let's try them all
  (high + 1..top).to_a.each do |i|

    # special case: the highest known floor is directly below our
    # current floor. If the egg were to break here, we would have
    # our answer; therefore, we pick the longer possibility, with 
    # more trials, where the egg does not break and our new 'highest-
    # known floor' is set to i, and minimize on that.
    if high == i - 1
      best = [best, f(i, top, eggs, trials + 1)].min
      next
    end

    # if the highest known floor is not directly below i, breaking
    # the egg (assuming we have any to break) would determine the 
    # new higher-bound, meaning the lowest floor above which we have 
    # an answer for all floors; otherwise, if the egg does not break, we
    # update the low-bound, the 'highest known floor' again. We pick
    # the longer of these two possibilities to minimize on.
    best = [best,
      [
       if eggs > 0 
         then f(high, i, eggs - 1, trials + 1) 
         else Float::INFINITY end,
       f(i, top, eggs, trials + 1)
      ].max
    ].min
  end

  # return our accumulator as the best solution for this state of f
  # and add that value to the matrix
  return $m[high][top][eggs][trials] = best
end

puts f 0, TOP, EGGS, 0 # 14
puts $iterations # 499953
