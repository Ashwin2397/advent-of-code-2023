def parse_seeds!(lines)
  seeds_line = lines.shift
  seeds = seeds_line.split('seeds:')[1].split.map(&:to_i)

  [seeds, lines]
end

def get_ranges(lines)
  _, *ranges = lines.split("\n")

  ranges.map { |range| parse_range(range) }
end

def parse_range(range)
  dest_range_start, src_range_start, range_length = range.split.map(&:to_i)

  [dest_range_start...(dest_range_start + range_length),
  src_range_start...(src_range_start + range_length)]
end

def get_mapped_value_from_range(value, range)
  dest_range, src_range = range

  return value unless src_range.include?(value)

  diff = value - src_range.first

  return value unless dest_range.include?(dest_range.first + diff)

  dest_range.first + diff
end

def get_mapped_value_for_range_set(value, ranges)
  mapped_value = nil
  ranges.each do |range|
    mapped_value = get_mapped_value_from_range(value, range)

    break if mapped_value != value
  end

  mapped_value
end

def get_mapped_value_for_seed(seed, set_of_ranges)
  value = seed
  set_of_ranges.each do |ranges|
    value = get_mapped_value_for_range_set(value, ranges)
  end

  value
end

lines = File.read('./day5.txt').split("\n\n")
seeds, lines = parse_seeds!(lines)
set_of_ranges = []

lines.each do |line|
  set_of_ranges.append(get_ranges(line))
end

mapped_values = seeds.map do |seed|
                  get_mapped_value_for_seed(seed, set_of_ranges)
                end


puts "Lowest location: #{mapped_values.min}"
