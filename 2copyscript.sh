#!/bin/bash

SOURCE_REPO_URL="https://github.com/Drincarlos/Repo_DC01.git"  # Replace with your source repo URL

DEST_REPO_URL="https://github.com/Drincarlos/Repo_DC02.git"  # Replace with your destination repo URL

WORK_DIR="C:\Users\aldrin.b.carlos"  # Temporary working directory

SOURCE_REPO="$WORK_DIR\repository01\Repo_DC01\ToSync"  # Directory for source repository

DEST_REPO="$WORK_DIR\repository02\Repo_DC02\syncdestination"  # Directory for destination repository

BRANCH="main"  # Branch to sync

# List of files to copy (relative to the source repository)
FILES_TO_COPY=(
    "SyncFile01"
    "SyncFile02"
    "SyncFile03"
)

# Copy specified files to the destination repository
for FILE in "${FILES_TO_COPY[@]}"; do
    if [ -e "$SOURCE_REPO$FILE" ]; then
        # Create the destination directory if it doesn't exist
        mkdir -p "$DESTINATION_REPO$(dirname "$FILE")"
        
        # Copy the file
        cp "$SOURCE_REPO$FILE" "$DESTINATION_REPO$FILE"
        echo "Copied: $FILE"
    else
        echo "File not found: $FILE"
    fi
done

# Navigate to the destination repository
cd "$DESTINATION_REPO" || exit

# Check for changes and commit
if ! git diff --quiet; then
    git add .
    git commit -m "Copied files from source repository"
    
    # Push changes to GitHub
    git push origin main  # Change 'main' if your branch is different
else
    echo "No changes to commit."
fi

