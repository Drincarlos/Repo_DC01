#!/bin/bash
 
# Configuration

SOURCE_REPO_URL="https://github.com/Drincarlos/Repo_DC01.git"  # Replace with your source repo URL

DEST_REPO_URL="https://github.com/Drincarlos/Repo_DC02.git"  # Replace with your destination repo URL

WORK_DIR="C:\Users\aldrin.b.carlos"  # Temporary working directory

SOURCE_DIR="$WORK_DIR\repository01\Repo_DC01\ToSync"  # Directory for source repository

DEST_DIR="$WORK_DIR\repository02\Repo_DC02\syncdestination"  # Directory for destination repository

LOCAL_SOURCE="$WORK_DIR\repository01\Repo_DC01"

LOCAL_DEST="$WORK_DIR\repository02\Repo_DC02"

FILES_TO_SYNC=(
    "SyncFile01"
    "SyncFile02"
    "SyncFile03"
)

BRANCH="main"  # Branch to sync
 
mkdir -p "$SOURCE_DIR"

mkdir -p "$DEST_DIR"
 
# Clone the source repository

echo -e "\n#################################### Cloning of $SOURCE_REPO_URL. ####################################\n"
if [ -d "$SOURCE_DIR" ]; then
    echo "The repository already exists in $LOCAL_SOURCE."
else
  git clone --branch "$BRANCH" "$SOURCE_REPO_URL" "$SOURCE_DIR"
fi 

echo -e "\n[ Task Done ]\n"

# Clone the destination repository

echo -e "\n#################################### Cloning of $DEST_REPO_URL. ####################################\n"
if [ -d "$DEST_DIR" ]; then
    echo "The repository already exists in $LOCAL_DEST."
else
  git clone --branch "$BRANCH" "$DEST_REPO_URL" "$DEST_DIR"
fi

echo -e "\n[ Task Done ]\n"

#Sync from Remote to Local Repository

echo -e "\n#################################### Syncing Remote to Local Repository... ####################################\n"

git pull origin main

echo -e "\n[ Task Done ]\n"


# Copy the file to the destination repository

echo -e "\n#################################### Copying file from source to destination... ####################################\n"
 
for FILE in "${FILES_TO_SYNC[@]}"; do
    if [ -e "$SOURCE_DIR/$FILE" ]; then
        # Create the destination directory if it doesn't exist
        mkdir -p "$DEST_DIR$(dirname "$FILE")"
        
        # Copy the file
        cp "$SOURCE_DIR/$FILE" "$DEST_DIR/$FILE"
        echo -e "Copied: $FILE\n"
    else
        echo -e "File not found: $FILE\n"
    fi
done

echo -e "\n[ Task Done ]\n"

# Commit and push changes to the destination repository

echo -e "\n#################################### Push changes into Git... ####################################\n"

cd "$DEST_DIR" || exit

git add .

if git diff --cached --quiet; then

    echo -e "\nNo changes detected. Nothing to commit.\n"

else

    echo -e "\nCommitting and pushing changes to the destination repository...\n"

    git commit -m "Selected files are now synced from source repo"

    Git show

    git push origin "$BRANCH"

    echo -e "\nChanges pushed successfully...\n"

fi

echo -e "\n[ Task Done ]\n"
