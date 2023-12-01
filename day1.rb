# line: 51591twosix4dhsxvgghxq

def find_code(line)
  max_size = numbers.keys.map(&:size).max
  nums = []
  i = 0
  line.each_char.with_index do |char, i|
    char = line[i]
    
    if is_num?(char)
      nums.append(char)
      i += 1
      next
    end
    
    chunk = line.slice(i, max_size)
    number_string = numbers.keys.find { |number| chunk.start_with?(number) }

    if number_string
      nums.append(numbers[number_string]) 
      i += number_string.size
      next
    end

    i += 1
  end

  (nums.first + nums.last).to_i
end

def numbers
  @numbers ||= {
    'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine'  => '9'
  }
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
