# line: 51591twosix4dhsxvgghxq
def find_code(line)
  nums = line.each_char.filter { |c| is_num?(c) }
  (nums.first + nums.last).to_i
end

def is_num?(char)
  ('0'.ord..'9'.ord).include?(char.ord) 
end

total = 0
File.open('day1.txt') do |file|
  file.each_line do |line|
    total += find_code(line)
  end
end

puts total
