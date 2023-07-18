# URL Reference Tool

This is a command-line tool written in Python for adding URLs to markdown files. It allows you to easily record URLs along with their metadata, such as title and date, in separate Markdown files.

## Features

- Add URLs to markdown files for easy reference.
- Support for YouTube URLs, YouTube channel URLs, and general URLs.
- Fetches title information from the webpage for general URLs.
- Handles duplicate URL prevention based on existing records.
- Markdown files are organized based on URL type: `youtube_references.md` for YouTube-related URLs and `links.md` for general URLs.

## Requirements

- Python 3.x
- `argparse` library
- `requests` library
- `beautifulsoup4` library

## Installation

1. Clone the repository:
   ```shell
   git clone <repository-url>
   cd ref-program

Install the required dependencies:
shell
Copy code
pip install -r requirements.txt
Usage
To use the URL reference tool, run the following command:

shell
Copy code
python ref.py <url> [-f] [-e]
<url>: The URL to be added.
-f, --force: Force addition even if the URL already exists.
-e, --edit: Open the markdown file for editing.
Examples:

shell
Copy code
python ref.py https://www.youtube.com/watch?v=abcdefgh  # Add a YouTube video URL
python ref.py https://www.example.com  # Add a general URL
python ref.py -f https://www.example.com  # Force addition of a URL even if it already exists
python ref.py -e https://www.youtube.com/@username  # Open the YouTube references file for editing
File Structure
ref.py: The main Python script for the URL reference tool.
references/: Directory containing the markdown files.
youtube_references.md: Markdown file for recording YouTube-related URLs.
links.md: Markdown file for recording general URLs.
Contributing
Contributions to this URL reference tool are welcome! Feel free to open issues or submit pull requests for any enhancements, bug fixes, or additional features.

License
This project is licensed under the MIT License.

css
Copy code

You can save the above content into a file named `README.md` in the root directory of your Git repository. Feel free to modify and customize the generated README to fit your specific needs.


