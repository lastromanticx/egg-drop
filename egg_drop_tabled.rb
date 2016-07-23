TOP = 100
EGGS = 2
$it = 0
$m = Array.new(TOP + 1){Array.new(TOP + 1){Array.new(EGGS + 1){Array.new(TOP + 1)}}}

def f high, top, eggs, trials
  if $m[high][top][eggs][trials]
    return $m[high][top][eggs][trials]
  end

  $it += 1

  if $it > 10000000
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
      best = [best, f(i, top, eggs, trials + 1)].min
      next
    end

    best = [best,
      [
        if eggs > 0 then f(high, i, eggs - 1, trials + 1) else Float::INFINITY end,
        f(i, top, eggs, trials + 1)
      ].max
    ].min
  end

  return $m[high][top][eggs][trials] = best
end

puts f 0, TOP, EGGS, 0   # 14
puts $it                 # 4587828
