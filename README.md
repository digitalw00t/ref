# URL Reference Tool

This is a command-line tool written in Python for adding URLs to markdown files. It allows you to easily record URLs along with their metadata, such as title and date, in separate Markdown files. The updated version of this tool includes improved error handling, cleaner and more concise code, better user interaction, and support for resolving URL redirects.

## Features

- Add URLs to markdown files for easy reference.
- Support for YouTube URLs, YouTube channel URLs, and general URLs.
- Fetches title information from the webpage for general URLs.
- Handles duplicate URL prevention based on existing records.
- Resolves URL redirects, including handling YouTube redirect URLs.
- Improved error handling and user experience.

## Requirements

- Python 3.x
- `argparse` library
- `requests` library
- `beautifulsoup4` library
- `google-api-python-client` library
- `python-dotenv` library

## Installation

1. Clone the repository:
   ```shell
   git clone <repository-url>
   cd ref-program
Install the required dependencies:

pip install -r requirements.txt
Set up the environment file:
Create a .env file in your home directory (~/.env) and add your YouTube API key:

YOUTUBE_API_KEY=your_youtube_api_key_here
Usage
To use the URL reference tool, run the following command:

python ref.py <url> [-f] [-e] [--version]
<url>: The URL to be added.
-f, --force: Force addition even if the URL already exists.
-e, --edit: Open the markdown file for editing.
--version: Display the version of the URL reference tool.

New in v1.4.1
The script now supports resolving URL redirects, including handling YouTube redirect URLs.
Examples:
ref.py https://www.youtube.com/watch?v=abcdefgh  # Add a YouTube video URL
ref.py https://www.example.com  # Add a general URL
ref.py -f https://www.example.com  # Force addition of a URL even if it already exists
ref.py -e https://www.youtube.com/@username  # Open the YouTube references file for editing
ref.py --version  # Display the version of the URL reference tool
ref.py "https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbF8xaGtKQl9jQVN1NlZINGxHcExuckg0eGd1QXxBQ3Jtc0tuQkhkWmFqaHlRLVBXWXFyMGF4MkhUNmQ2UTNLZHlrRTVfa210ZjNPRVhnZDZJTFdJRXdnSUdhb2xCNE5JUHN1M0FuSm1wMDNTWDk3Y2RENmx0akNKZkZzMzVVbXJnYXRJaWUwOUoxcWZkd2twdzNnVQ&q=https%3A%2F%2Fgithub.com%2Faaedmusa%2FCapstan-Drive&v=MwIBTbumd1Q"  # Handle YouTube redirect URL
File Structure
ref.py: The main Python script for the URL reference tool.
references/: Directory containing the markdown files.
references/youtube_references.md: Markdown file for recording YouTube-related URLs.
references/links.md: Markdown file for recording general URLs.
Contributing
Contributions to this URL reference tool are welcome! Feel free to open issues or submit pull requests for any enhancements, bug fixes, or additional features.

License
This project is licensed under the MIT License.
