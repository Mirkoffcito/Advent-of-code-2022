# Reads each line and accumulates 1 to the counter if one of the sets is a subset of the other
def get_subsets_count_from_file(file)
  subsets_count = 0
  file.each_line do |line|
    sets = line.split(',')
    set_1 = get_set_from_array(sets[0].split('-'))
    set_2 = get_set_from_array(sets[1].split('-'))
    
    bigger_set = get_bigger_set(set_1, set_2)
    # Each set includes itself and to count +1 it should also include the other set
    subsets_count += 1 if set_1.subset?(bigger_set) && set_2.subset?(bigger_set)
  end
  subsets_count
end

def get_set_from_array(arr)
  (arr[0].to_i..arr[1].to_i).to_set
end

# returns the bigger set from two sets. If they have an equal quantity of elements, returns the second one as it doesn't matter
def get_bigger_set(set_1, set_2)
  (set_1.size > set_2.size) ? set_1 : set_2
end

file = File.open("day_4_data.txt").read
subsets_count = get_subsets_count_from_file(file)

puts subsets_count.inspect