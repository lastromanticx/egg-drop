TOP = 100
EGGS = 2
$iterations = 0

$m = Array.new(TOP + 1)

(0..TOP + 1).to_a.each do |range|
  $m[range] = Array.new(EGGS + 1)

  (0..EGGS + 1).to_a.each do |eggs|
    $m[range][0] = Float::INFINITY if 1 < range
  end
end

def f range, eggs

  if $m[range][eggs]
    return $m[range][eggs]
  end

  $iterations += 1

  if 2 >= range && eggs >= 0
    return 1
  end

  best = Float::INFINITY
 
  (1..range).to_a.each do |i|

    best = [best, 1 +
      [
       f(i, eggs - 1), 
       f(range - i, eggs)
      ].max
    ].min
  end

  return $m[range][eggs] = best
end

puts f TOP, EGGS  # 14
puts $iterations  # 1078
