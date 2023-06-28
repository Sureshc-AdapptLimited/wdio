#!/bin/bash
# directory="jsonReport"
# output_file="./cucumber_json_report.json"

# Directory path containing the JSON files
directory="./jsonReport"

# Output file name
merged_json_report="./merged_json_report.json"
cucumber_json_report="./cucumber_json_report.json"

# Create the file
touch "$merged_json_report"
touch "$cucumber_json_report"

echo "[" > "$merged_json_report"
for file in "$directory"/*.json; do
    if [ -d "$file" ]; then
        continue
    fi
    result=$(jq '.[]' "$file")  
    
    echo "$result," >> "$merged_json_report"
done
echo "]" >> "$merged_json_report"

# Remove commas from the end of array objects and store in a new file
awk -v RS= '{ gsub(/,[[:space:]]*]/, "\n]", $0) }1' "$merged_json_report" | jq '.' > "$cucumber_json_report"