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

# Function to expand the ~ in paths
expand_path() {
    local path="$1"
    echo "$path" | sed "s|^~|$HOME|"
}

# Function to remove double slashes from a path
remove_double_slashes() {
    local path="$1"
    echo "$path" | sed 's|//|/|g'
}

# Function to read directories from config.yaml
read_directories_from_config() {
    local config_file="$1"
    references_dir=$(grep '^references:' "$config_file" | awk '{print $2}')
    transcripts_dir=$(grep '^transcripts:' "$config_file" | awk '{print $2}')
    references_dir=$(expand_path "$references_dir")
    transcripts_dir=$(expand_path "$transcripts_dir")
    references_dir=$(remove_double_slashes "$references_dir")
    transcripts_dir=$(remove_double_slashes "$transcripts_dir")
}

# Check if URL is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <youtube_url_or_code>"
    exit 1
fi

# Main script execution
ref_url="$1"

# Read directories from config.yaml
config_file="$HOME/.config/ref/config.yaml"
if [ ! -f "$config_file" ]; then
    echo "Config file not found: $config_file"
    exit 1
fi

read_directories_from_config "$config_file"

# Check if the argument is a full URL or a video code
if [[ "$ref_url" != https://* ]]; then
    ref_url="https://www.youtube.com/watch?v=$ref_url"
fi

ref_output=$(ref "$ref_url")

if [ $? -ne 0 ]; then
    echo "Failed to run ref command"
    exit 1
fi

transcript_file="$transcripts_dir/$(echo "$ref_output" | awk -F'|' '{print $NF}' | sed 's:/*$::')"
transcript_file=$(remove_double_slashes "$transcript_file")
key=$(get_key "$ref_output")

if [ -z "$key" ]; then
    echo "Failed to extract key from ref output"
    exit 1
fi

output_file="${transcript_file%.*}-extract_wisdom-openai.md"
output_file=$(remove_double_slashes "$output_file")

echo "Running the command:"
extract_wisdom_from_transcript "$transcript_file" "$output_file"

if [ $? -eq 0 ]; then
    echo "Successfully created $output_file"
else
    echo "Failed to extract wisdom"
    exit 1
fi

