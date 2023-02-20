SHAPES_POINTS = {
  "ROCK":1,
  "PAPER":2,
  "SCISSORS":3
}

OUTCOMES_POINTS = {
  "WIN":6,
  "LOSS":0,
  "DRAW":3
}

EACH_WINS = {
  "ROCK": "PAPER",
  "PAPER": "SCISSORS",
  "SCISSORS": "ROCK"
}

OUTCOMES_CODES = {
  "Y": "DRAW",
  "X": "LOSE",
  "Z": "WIN"
}

SHAPES_CODES = {
  "A": "ROCK",
  "B": "PAPER",
  "C": "SCISSORS"
}

def calculate_total_score_from_file(file_name)
  file = File.open(file_name).read
  # Split each round into a string and make it an array of string objects
  rounds = file.split("\n")
  # Map each string into an array of two objects (input and response)
  rounds.map! { |round| round.split(" ") }
  total_score = 0
  rounds.each do |round|
    # Get the input and the result
    input, result = get_shape_name_from_code(round[0]), get_result_name_from_code(round[1])
    # Get the response needed to get the expected result
    response = get_response_from_input_and_result(input, result)
    # Calculate the total score for the round and accumulate it
    total_score += calculate_score(input, response)
  end
  total_score
end

def get_response_from_input_and_result(input, result)
  if result == "DRAW"
    response = input
  elsif result == "WIN"
    # Get the value needed to win the round
    response = EACH_WINS[input.to_sym]
  else
    # Remove the value needed to win the round
    values = EACH_WINS.except(input.to_sym).values
    # Remove the value needed to "DRAW" the round
    values.delete(input)
    # Only value left is the lose value
    response = values.sample
  end
end

def get_shape_name_from_code(code)
  SHAPES_CODES[code.to_sym]
end

def get_result_name_from_code(code)
  OUTCOMES_CODES[code.to_sym]
end

# Calculate the total score of a round based on the outcome and my response
def calculate_score(input, response)
  outcome = get_outcome(input, response)
  shape_score = SHAPES_POINTS[response.to_sym]
  outcome_score = OUTCOMES_POINTS[outcome.to_sym]
  total_score = shape_score + outcome_score
end

# Method to get the outcome based on the input and my response
def get_outcome(input, response)
  return "DRAW" if input == response
  EACH_WINS[input.to_sym] == response ? "WIN" : "LOSS"
end

puts calculate_total_score_from_file("elves_rock_paper_scissors.txt")