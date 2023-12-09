def get_points(line)
  winning_numbers, my_numbers = line.split(':')[1].strip.split('|').map(&:strip).map(&:split)
  matches = my_numbers.select { |mn| winning_numbers.include?(mn) }.size
  matches > 0 ? 2 ** (matches - 1) : 0
end

File.open('day4.txt') do |file|
  sum = 0
  file.each_line do |line|
    sum += get_points(line)
  end

  puts sum
end
