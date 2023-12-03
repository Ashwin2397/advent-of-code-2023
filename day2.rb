# 12 red, 13 green, 14 blue

def max_value(line, color)
  line.scan(/([0-9][0-9]?) #{color}/).map(&:first).map(&:to_i).max
end

def is_valid?(line)
  max_value(line, 'red') <= 12 &&
  max_value(line, 'green') <= 13 &&
  max_value(line, 'blue') <= 14
end

valid = 0
File.open('day2.txt') do |file|
  file.each_line do |line|
    game_id = /Game (.*):/.match(line).to_a.last.to_i

    valid += game_id if is_valid?(line)
  end
end

puts valid
