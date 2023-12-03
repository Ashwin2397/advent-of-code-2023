lines = []
# [number, index_range, row]
part_numbers = []
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

        
        part_numbers.append([part_number.to_i, ([0, start_index - 1].max..[line.size, i].min), row])
        # puts part_numbers.last.to_s
      else
        i += 1
      end
    end
  end
end


def integer?(char)
  # return false unless char
  char.match?(/[0-9]/)
end


def valid_part_number?(lines, part_number)
  number, index_range, row = part_number

  # Directly adjacent
  return true if (
    (lines[row][index_range.first] && lines[row][index_range.first] != '.' && !integer?(lines[row][index_range.first])) ||
    (lines[row][index_range.last] && lines[row][index_range.last] != '.' && !integer?(lines[row][index_range.last]))
  )
  
  # puts part_number.first
  # puts lines[row][index_range.first]
  
  index_range.each do |index|

    # puts "Row index: #{row - 1}"
    # puts "Row -1 #{lines[row - 1][index]}"
    return true if (
      ((row - 1) >= 0 &&  lines[row - 1][index] && lines[row - 1][index] != '.' && !integer?(lines[row - 1][index])) || 
      ((row + 1) < lines.size && lines[row + 1][index] && lines[row + 1][index] != '.' && !integer?(lines[row + 1][index]))
    )
  end

  return false
end

sum_of_part_numbers = 0
part_numbers.each do |part_number|
  sum_of_part_numbers += part_number.first if valid_part_number?(lines, part_number)
end

puts sum_of_part_numbers
