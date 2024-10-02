#!/bin/bash
 
# Configuration

SOURCE_REPO_URL="https://github.com/Drincarlos/Repo_DC01.git"  # Replace with your source repo URL

DEST_REPO_URL="https://github.com/Drincarlos/Repo_DC02.git"  # Replace with your destination repo URL

WORK_DIR="C:\Users\aldrin.b.carlos"  # Temporary working directory

SOURCE_DIR="$WORK_DIR\repository01\Repo_DC01\ToSync"  # Directory for source repository

DEST_DIR="$WORK_DIR\repository02\Repo_DC02\syncdestination"  # Directory for destination repository

FILE_TO_SYNC="SyncFile01"

BRANCH="main"  # Branch to sync
 

# rsync -av "$FILE_TO_SYNC" "$DEST_DIR"
 
# Create the working directory

mkdir -p "$SOURCE_DIR"

mkdir -p "$DEST_DIR"
 
# Clone the source repository

echo "Cloning source repository..."

git clone --branch "$BRANCH" "$SOURCE_REPO_URL" "$SOURCE_DIR"
 
# Clone the destination repository

echo "Cloning destination repository..."

git clone --branch "$BRANCH" "$DEST_REPO_URL" "$DEST_DIR"

 
# Copy the file to the destination repository

echo "Copying file from source to destination..."

cp -R "$SOURCE_DIR/$FILE_TO_SYNC" "$DEST_DIR/$FILE_TO_SYNC"
 

# Commit and push changes to the destination repository

cd "$DEST_DIR" || exit

git add "$FILE_TO_SYNC"

if git diff --cached --quiet; then

    echo "No changes detected. Nothing to commit."

else

    echo "Committing and pushing changes to the destination repository..."

    git commit -m "Synced $FILE_TO_SYNC from source repo"    

    git push origin "$BRANCH"

    git diff last version:HEAD

    echo "Changes pushed successfully."

fi
 


# git diff --name-only -branch "$BRANCH" "$SOURCE_DIR" "$DEST_DIR"

echo "Sync complete."
