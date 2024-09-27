import os
import git
import shutil

# Configuration
source_repo_url = 'https://github.com/user/source-repo.git'  # Source repository URL
target_repo_url = 'https://github.com/user/target-repo.git'  # Target repository URL
local_source_repo_path = '/path/to/local/source/repo'         # Local path for source repo
local_target_repo_path = '/path/to/local/target/repo'         # Local path for target repo
file_to_copy = 'path/to/file/in/source.txt'                   # Path to the file in the source repo
target_file_path = 'path/to/file/in/target.txt'               # Path to save the file in the target repo

# Clone or pull source repository
if not os.path.exists(local_source_repo_path):
    print("Cloning source repository...")
    git.Repo.clone_from(source_repo_url, local_source_repo_path)
else:
    print("Pulling latest changes from source repository...")
    repo = git.Repo(local_source_repo_path)
    repo.remotes.origin.pull()

# Clone or pull target repository
if not os.path.exists(local_target_repo_path):
    print("Cloning target repository...")
    git.Repo.clone_from(target_repo_url, local_target_repo_path)
else:
    print("Pulling latest changes from target repository...")
    repo = git.Repo(local_target_repo_path)
    repo.remotes.origin.pull()

# Copy the file
source_file = os.path.join(local_source_repo_path, file_to_copy)
target_file = os.path.join(local_target_repo_path, target_file_path)

print(f"Copying file from {source_file} to {target_file}...")
shutil.copy(source_file, target_file)

# Commit and push changes to target repository
repo = git.Repo(local_target_repo_path)
repo.index.add([target_file])
repo.index.commit('Copy file from source repository')
repo.remotes.origin.push()

print('File copied successfully.')
