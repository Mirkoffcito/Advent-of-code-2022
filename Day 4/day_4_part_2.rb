# Reads each line and accumulates 1 to the counter if one of the sets is a subset of the other
def get_overlapped_sets_count_from_file(file)
  overlapped_sets_count = 0
  file.each_line do |line|
    sets = line.split(',')
    set_1 = get_set_from_array(sets[0].split('-'))
    set_2 = get_set_from_array(sets[1].split('-'))
    
    intersection = set_1.intersection(set_2)
    # Each set includes itself and to count +1 it should also include the other set
    overlapped_sets_count += 1 if intersection.size > 0
  end
  overlapped_sets_count
end

def get_set_from_array(arr)
  (arr[0].to_i..arr[1].to_i).to_set
end

file = File.open("day_4_data.txt").read
overlapped_sets_count = get_overlapped_sets_count_from_file(file)

puts overlapped_sets_count.inspect