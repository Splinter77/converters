#!/bin/bash

# Run line before executing this script
# chmod +x GoProBatchConverts.sh

# Define input and output directories
input_folder="/path/to/DCIM/100GOPRO"
output_folder="/path/to/GoProConvertedVideos"

# Check if input directory exists
if [ ! -d "$input_folder" ]; then
    echo "Error: Input folder does not exist: $input_folder"
    exit 1
fi

# Create output directory if it doesn't exist
if [ ! -d "$output_folder" ]; then
    mkdir -p "$output_folder"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create output folder: $output_folder"
        exit 1
    fi
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install it first."
    exit 1
fi

# Process all MP4 files in the input folder
for input_file in "$input_folder"/*.mp4; do
    # Check if there are any matching files
    if [ ! -e "$input_file" ]; then
        echo "No MP4 files found in $input_folder"
        exit 0
    fi
    
    # Get the filename without path and extension
    filename=$(basename "$input_file" .mp4)
    
    # Convert the video
    echo "Converting: $input_file"
    ffmpeg -i "$input_file" \
           -c:v libx265 \
           -crf 28 \
           -preset medium \
           -c:a aac \
           -b:a 128k \
           "$output_folder/${filename}_converted.mp4"
    
    # Check if conversion was successful
    if [ $? -eq 0 ]; then
        echo "Successfully converted: ${filename}_converted.mp4"
    else
        echo "Error converting: $input_file"
    fi
done

echo "All conversions complete!"