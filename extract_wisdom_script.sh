#!/bin/bash

# Function to get the key from the ref command output
get_key() {
    local ref_output="$1"
    echo "$ref_output" | awk -F'|' '{print $NF}' | awk -F'/' '{print $NF}' | awk -F'.' '{print $1}'
}

# Function to extract wisdom from the transcript
extract_wisdom_from_transcript() {
    local transcript_file="$1"
    local output_file="$2"
    echo "cat \"$transcript_file\" | fabric --pattern extract_wisdom > \"$output_file\""
    cat "$transcript_file" | fabric --pattern extract_wisdom > "$output_file"
}

# Check if URL is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <youtube_url>"
    exit 1
fi

# Main script execution
ref_url="$1"
ref_output=$(ref "$ref_url")

if [ $? -ne 0 ]; then
    echo "Failed to run ref command"
    exit 1
fi

transcript_file=$(echo "$ref_output" | awk -F'|' '{print $NF}')
key=$(get_key "$ref_output")

if [ -z "$key" ]; then
    echo "Failed to extract key from ref output"
    exit 1
fi

output_file="${key}-extract_wisdom-openai.md"

echo "Running the command:"
extract_wisdom_from_transcript "$transcript_file" "$output_file"

if [ $? -eq 0 ]; then
    echo "Successfully created $output_file"
else
    echo "Failed to extract wisdom"
    exit 1
fi

