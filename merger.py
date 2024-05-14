from datetime import datetime
import re
import os

# Define the paths to your markdown files
links_file_path = os.path.expanduser("~/path/to/your/links.md")  # Update this path
youtube_file_path = os.path.expanduser("~/path/to/your/youtube_references.md")  # Update this path
combined_file_path = os.path.expanduser("~/path/to/your/combined_references.md")  # Update this path

def get_current_iso_timestamp():
    """Generate the current timestamp in ISO 8601 format."""
    return datetime.now().isoformat(timespec='seconds')

def read_links():
    """Read and process the general links markdown file."""
    with open(links_file_path, "r") as file:
        links = file.readlines()
    processed_links = []
    for link in links:
        # Ensure the regex is within a single line to avoid syntax errors
        match = re.match(r'^- 
\[(.*)\]
\((.*)\)', link)
        if match:
            title, url = match.groups()
            timestamp = get_current_iso_timestamp()  # Use current timestamp for each link
            processed_links.append(f"- [{title}]({url}) ({timestamp} | Type: General)\n")
    return processed_links

def read_youtube():
    """Read and process the YouTube references markdown file."""
    with open(youtube_file_path, "r") as file:
        youtube_links = file.readlines()
    processed_youtube_links = []
    for link in youtube_links:
        # Adjusted regex pattern to fit on one line
        match = re.match(r'^- 
\[(.*?)\]
\((.*?)\) \((.*?) \| Type: YouTube\)', link)
        if match:
            title, url, additional_info = match.groups()
            processed_youtube_links.append(f"- [{title}]({url}) ({additional_info} | Type: YouTube)\n")
        else:
            # If the line doesn't match, include it as is
            processed_youtube_links.append(link)
    return processed_youtube_links

def combine_and_write(processed_links, processed_youtube_links):
    """Combine processed links and write them to a new markdown file."""
    with open(combined_file_path, "w") as combined_file:
        combined_file.writelines(processed_links + processed_youtube_links)

def main():
    """Main function to orchestrate the merging process."""
    processed_links = read_links()
    processed_youtube_links = read_youtube()
    combine_and_write(processed_links, processed_youtube_links)
    print(f"Combined markdown file created at {combined_file_path}")

if __name__ == "__main__":
    main()

