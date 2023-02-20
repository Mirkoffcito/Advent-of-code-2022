AZ_PRIORITY = ("a".."z").to_a.each_with_index.inject({}) do |hash, (letter, i)|
  i+=1
  hash[letter] = i
  hash
end.freeze


def get_priority_from_item_type(item)
  if item.match?(/[a-z]/)
    priority = AZ_PRIORITY[item]
  else
    priority = AZ_PRIORITY[item.downcase] + AZ_PRIORITY.size
  end
end

def separate_string_in_half(string)
  string_size = string.size
  first_half = string[0..(string_size/2)-1]
  second_half = string[(string_size/2)..(string.size)]
  [first_half, second_half]
end

def get_repeated_items_from_strings(string_1, string_2)
  string_1_arr = string_1.split("")
  string_2_arr = string_2.split("")
  string_1_arr.intersection(string_2_arr)
end

def get_sum_of_repeated_items_priorities_from_file(file)
  total = 0
  file.each_line do |line|
    first_half, second_half = separate_string_in_half(line)
    repeated_items = get_repeated_items_from_strings(first_half, second_half)
    repeated_items.each do |item|
      total += get_priority_from_item_type(item)
    end
  end
  total
end

file = File.open("day_3_data.txt").read
puts get_sum_of_repeated_items_priorities_from_file(file).inspect