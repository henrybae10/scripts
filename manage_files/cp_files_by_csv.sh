csv_file="./re.csv"

# Define the source directory where the files are located
source_directory="../Desktop/sync/"

# Define the destination directory where the files will be moved
destination_directory="../Desktop/imageResizing/"

# Read the CSV file line by line and move the corresponding files
while IFS=, read -r filename
do
    # Trim any leading/trailing whitespace from the filename
    filename=$(echo "$filename" | tr -d '[:space:]')

    # Check if the file exists in the source directory
    if [ -e "${source_directory}${filename}" ]; then
        # Move the file to the destination directory
        cp "${source_directory}${filename}" "${destination_directory}"
        echo "Moved ${filename} to ${destination_directory}"
    else
        echo "File ${filename} not found in ${source_directory}"
    fi

done < "$csv_file"
