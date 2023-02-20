# Gets the info from the file and maps it into an array of arrays of integers
def normalize_group_lines_to_arrays(file_name)
  file = File.open(file_name).read
  # Remove whitespaces
  file.gsub!(/\n/, " ")
  # Now each number is separated by a blank space and each group of numbers is separated by two blank spaces.
  arr = file.split("  ")
  groups = arr.map { |obj| obj.split(" ") }
  groups.map! { |obj| obj.map!(&:to_i) }
end

# Normalize the data from array of arrays(of integers each) into an array of hash objects
def build_elves_data(file_name)
  data_array = normalize_group_lines_to_arrays(file_name)
  elves_data = []
  data_array.each_with_index do |arr, i|
    i+=1
    elve_data = {
      "elve_#{i}": {
        "total_calories": arr.reduce(:+)
      }
    }
    elves_data << elve_data
  end
  elves_data
end

# Get the top 3 elves carrying the most calories from an array of elves
def get_top_3_elves_by_calories(array)
  max_values = []
  3.times do |i|
    # Map all the values into an array
    values = array.map { |elve| elve.values[0][:total_calories] }
    # get the max value from the array
    max_value = values.max
    # get the elve whose calories matches the max value
    elve = array.find { |elve| elve.values[0][:total_calories] == max_value }
    # save the elve into the array
    max_values << elve
    # remove the elve from the main array
    array.delete(elve)
  end
  max_values
end

# Get the total calories from an array of elves
def total_calories(arr_of_elves)
  acc = 0
  arr_of_elves.each do |elve|
    acc += elve.values[0][:total_calories]
  end
  acc
end

elves_array = build_elves_data("elves_input.txt")

puts total_calories(get_top_3_elves_by_calories(elves_array))

__END__