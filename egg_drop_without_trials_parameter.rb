TOP = 100
EGGS = 2
$iterations = 0

$m = Array.new(TOP + 1)

(0..TOP + 1).to_a.each do |high|
  $m[high] = Array.new(TOP + 1)
 
  (0..TOP + 1).to_a.each do |top|
    $m[high][top] = Array.new(EGGS + 1)
 
    (0..EGGS + 1).to_a.each do |eggs|
                                    # range = top - high                            
                                             # 1 < range 
      $m[high][top][0] = Float::INFINITY if high < top - 1
    end
  end
end

def f high, top, eggs

  if $m[high][top][eggs]
    return $m[high][top][eggs]
  end

  $iterations += 1

      # range = top - high
      # 2 >= range 
  if high >= top - 2 && eggs >= 0
    return 1
  end

  best = Float::INFINITY

  (high + 1..top).to_a.each do |i|
# range = top - high
# subtract high 
# (1..range)
    best = [best, 1 +
      [
       # f(0, range, eggs - 1)
         f(high, i, eggs - 1),
     # f(i, range, eggs)
       f(i, top, eggs)
      ].max
    ].min
  end

  return $m[high][top][eggs] = best
end

   # range = top - high
   # f RANGE, EGGS
puts f 0, TOP, EGGS  # 14
puts $iterations     # 24843
