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
        
        #
        $m[high][top][0][trials] = Float::INFINITY if high < top - 1
      end
    end
  end
end

# high: we have a determined answer this and all floors below it
# top: we know the egg will break above this point
# eggs: how many of them we have left
# trials: how many we've executed so far
def f high, top, eggs, trials

  # if the value is already known, avoid recalculating it
  if $m[high][top][eggs][trials]
    return $m[high][top][eggs][trials]
  end

  $iterations += 1

  # avoid locking the browser in some online IDEs
  if $iterations > 10000000
    return Float::INFINITY
  end

  # we find a possible solution when the highest determined answer 
  # coincides with the lowest floor above which we know the egg will break
  if high >= top - 1 && eggs >= 0
    return trials
  end

  # accumulator to update as we try different possibilities
  best = Float::INFINITY

  # since we don't know where to try next, let's try them all
  (high + 1..top).to_a.each do |i|
    if high == i - 1
      best = [best, f(i, top, eggs, trials + 1)].min
      next
    end

    best = [best,
      [
        if eggs > 0 
           then f(high, i, eggs - 1, trials + 1) 
           else Float::INFINITY end,
        f(i, top, eggs, trials + 1)
      ].max
    ].min
  end

  return $m[high][top][eggs][trials] = best
end

puts f 0, TOP, EGGS, 0   # 14
puts $iterations         # 499953
