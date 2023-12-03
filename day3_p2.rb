lines = []
# [row, column] => part_number
part_numbers = {}
gears = []
File.open('day3.txt') do |file|
  file.each_line.with_index do |line, row|
    # puts "Row: #{row}"
    line = line.chomp
    lines.append(line.chomp)


    i = 0
    while i < line.size
      if line[i].match?(/[0-9]/)
        start_index = i
        part_number = line[i]
        i += 1

        while i < line.size && line[i].match?(/[0-9]/)
          part_number += line[i]
          i += 1
        end

        (start_index..(i - 1)).each do |c|
          part_numbers[[row, c]] = part_number.to_i
        end
      elsif line[i] == '*'
        gears.append([row, i])
        i += 1
      else
        i += 1
      end
    end
  end
end

def integer?(char)
  char.match?(/[0-9]/)
end

def adjacent_numbers(lines, gear, part_numbers)
  row, column = gear
  adjacent_numbers = []

  [row - 1, row, row + 1].each do |r|
    numbers_on_row = []
    [column - 1, column, column + 1].each do |c|
      if lines[r] && lines[r][c] && integer?(lines[r][c])
        numbers_on_row.append(part_numbers[[r, c]])
      end
    end

    adjacent_numbers += numbers_on_row.uniq
  end

  adjacent_numbers
end

sum_of_gear_ratios = 0
gears.each do |gear|
  adjacent_numbers = adjacent_numbers(lines, gear, part_numbers)
  # puts "Gear: #{gear}"
  # puts adjacent_numbers.to_s
  sum_of_gear_ratios += adjacent_numbers.inject(:*) if adjacent_numbers.size == 2
end

puts sum_of_gear_ratios
