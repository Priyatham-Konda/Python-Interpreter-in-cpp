#!/bin/bash

# Build main
make build

# Define ANSI color codes
green="\e[32m"
red="\e[31m"
reset="\e[0m"

has_failed=false

# Strings to search for
error_strings=("Error: could not open file" "Runtime error:" "Exception:" "Unknown exception occurred" "Undeclared variable")

# Function to check if any error string is present in the output
check_error() {
  local output="$1"
  for error_string in "${error_strings[@]}"; do
    if grep -q "$error_string" <<< "$output"; then
      echo -e "${red}Error found: $error_string${reset}"
      exit 1
    fi
  done
}

# Traverse the tests/ folder and look for subfolders
for testfolder in tests/test_*; do

  # Extract the test name from the folder name
  testname=$(basename "$testfolder" | sed 's/^test_//')
  
  # Define the input and expected output filenames
  inputfile="${testfolder}/test.py"
  expectedfile="${testfolder}/expected.txt"
  
  # Run the test and capture the output
  output=$(./main.out "$inputfile")
  
  # Check for errors in the output
  check_error "$output"
  
  # Print the output line by line
  while IFS= read -r line; do
    echo "$line"
  done <<< "$output"

done
