TOP = 100
EGGS = 2
$iterations = 0
$hash = {}

def f high, top, eggs, trials
  key = [high,top,eggs,trials].join(",")

  if $hash[key]
    return $hash[key]
  end

  $iterations += 1

  if $iterations > 10000000
    return Float::INFINITY
  end

  if high >= top - 1 && eggs >= 0
    return trials

  elsif eggs == 0
    return Float::INFINITY
  end

  best = Float::INFINITY

  (high + 1..top).to_a.each do |i|
    if high == i - 1
      best = [best, f(i,top,eggs,trials + 1)].min
      next
    end

    best = [best,
      [
        f(high, i, eggs - 1, trials + 1),
        f(i, top, eggs, trials + 1)
      ].max
    ].min
  end

  return $hash[key] = best
end

puts f 0, TOP, EGGS, 0   # 14
puts $iterations         # 4587828
