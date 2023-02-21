AZ_PRIORITY = ("a".."z").to_a.each_with_index.inject({}) do |hash, (letter, i)|
  i+=1
  hash[letter] = i
  hash
end.freeze

ELVES_GROUP_COUNT = 3


def get_priority_from_item_type(item)
  if item.match?(/[a-z]/)
    priority = AZ_PRIORITY[item]
  else
    priority = AZ_PRIORITY[item.downcase] + AZ_PRIORITY.size
  end
end

# Maps the contents of the file (strings) into an array of arrays of 3 strings each
def separate_in_arrays(file)
  groups_of_elves = []
  group_of_elves = []
  file.each_line.with_index do |line, index|
    if ((index+1) % ELVES_GROUP_COUNT) == 0
      group_of_elves << line
      groups_of_elves << group_of_elves
      group_of_elves = []
      next
    end
    group_of_elves << line
  end
  groups_of_elves
end

# Receives an array with array objects. Each array has a group of strings. Calculates the priority of the repeated item in each group and accumulates it
def get_priorities_from_groups(array)
  groups_priorities = 0
  array.each_with_object([]) do |group|
    items = get_repeated_items_from_strings(group)
    # Remove 'jumpline' from repeated items
    items.delete("\n")
    # Get the priority of the repeated item
    group_priority = items.map { |item| get_priority_from_item_type(item) }.reduce(&:+)
    # accumulate the priority from each group
    groups_priorities += group_priority
  end
  groups_priorities
end

# Receives an array of strings and gets the repeated elements in all the arrays
def get_repeated_items_from_strings(strings)
  array_of_arrays = strings.inject([]) do |arr, string|
    arr << string.split("")
    arr
  end
  intersection = array_of_arrays.inject(:&)
end

file = File.open("day_3_data.txt").read
array_of_arrays =  separate_in_arrays(file)
priority = get_priorities_from_groups(array_of_arrays)

puts priority.inspect