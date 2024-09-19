#!/bin/bash

# Configuration
REPO_URL="https://github.com/murnl/DeepPavlov-master.git"
LOCAL_REPO="DeepPavlov-master"
NUM_COMMITS=100
START_DATE=$(date -d "2 years ago" +"%Y-%m-%d")

# Clone the repository
if [ -d "$LOCAL_REPO" ]; then
    rm -rf "$LOCAL_REPO"  # Remove old clone if it exists
fi
git clone "$REPO_URL" "$LOCAL_REPO"
cd "$LOCAL_REPO" || exit

# Generate random commits
for i in $(seq 1 "$NUM_COMMITS"); do
    # Create a random file change
    FILE_NAME="random_file_$RANDOM.txt"
    echo "Random content: $RANDOM" > "$FILE_NAME"

    # Stage the file
    git add "$FILE_NAME"

    # Create a commit with a backdated timestamp
    COMMIT_DATE=$(date -d "$START_DATE + $((RANDOM % 480)) days" +"%Y-%m-%dT%H:%M:%S")
    COMMIT_MESSAGE="Random commit $RANDOM"

    GIT_AUTHOR_DATE="$COMMIT_DATE" git commit --date="$COMMIT_DATE" -m "$COMMIT_MESSAGE"

    # Clean up the file
    rm "$FILE_NAME"
done

# Push changes to the repository
git push origin main

echo "Completed backdating commits."
