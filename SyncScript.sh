#!/bin/bash

# Variables
SOURCE_REPO="/c/Users/aldrin.b.carlos/repository01/Repo_DC01/ToSync/"   # Local path to the source repository
DEST_REPO="/c/Users/aldrin.b.carlos/repository02/Repo_DC02/syncdestination/" # Local path to the destination repository
#EXCLUDE_PATTERN="*.git"              # Exclude patterns, adjust as needed

# Ensure both repositories exist
if [ ! -d "$SOURCE_REPO" ]; then
  echo "Source repository does not exist: $SOURCE_REPO"
  exit 1
fi

if [ ! -d "$DEST_REPO" ]; then
  echo "Destination repository does not exist: $DEST_REPO"
  exit 1
fi

# Use rsync to sync files from source to destination
rsync -av "$SOURCE_REPO/" "$DEST_REPO/"

# Navigate to the destination repository and commit changes
cd "$DEST_REPO" || exit
git add .
git commit -m "Sync files from $SOURCE_REPO to $DEST_REPO"
git push origin main  # Change 'main' to your target branch if necessary

echo "Files synchronized from $SOURCE_REPO to $DEST_REPO and committed."

