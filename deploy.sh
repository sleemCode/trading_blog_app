#!/bin/sh

# If a command fails, the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t PaperMod

# Go To Public folder
cd public

# Ensure the CNAME file is present, otherwise it will remove the custom domain from settings/pages
cp ../static/CNAME .  # Copy CNAME file to public directory

# Initialize a new git repository if it does not exist
if [ ! -d ".git" ]; then
  git init
  git remote add origin git@github.com-sleemCode:sleemCode/trading_blog_app.git 
fi

# Add changes to git.
git add -f .

# Commit changes.
msg="deploying site on - $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi
git commit -m "$msg"

# Push to the gh-pages branch
git push -f origin main:gh-pages

# Come Back up to the Project Root
cd ..
