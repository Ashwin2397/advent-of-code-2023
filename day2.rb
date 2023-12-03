# 12 red, 13 green, 14 blue

def max_or_min_value(line, color)
  line.scan(/([0-9][0-9]?) #{color}/).map(&:first).map(&:to_i).max
end

def is_valid?(line)
  max_or_min_value(line, 'red') <= 12 &&
  max_or_min_value(line, 'green') <= 13 &&
  max_or_min_value(line, 'blue') <= 14
end

def power(line)
  max_or_min_value(line, 'red') *
  max_or_min_value(line, 'green') *
  max_or_min_value(line, 'blue')
end

valid = 0
power_sum = 0
File.open('day2.txt') do |file|
  file.each_line do |line|
    # P1
    game_id = /Game (.*):/.match(line).to_a.last.to_i
    valid += game_id if is_valid?(line)

    # P2
    power_sum += power(line)
  end
end

puts valid
puts power_sum
