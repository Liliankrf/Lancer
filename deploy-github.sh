#!/bin/bash

# ============================================
# LANCER IA - GitHub Deploy Script
# ============================================

set -e  # Exit on error

echo "🚀 LANCER IA - GitHub Deployment"
echo "================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_NAME="Lancer"
DEFAULT_BRANCH="main"

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if Git is configured
if ! git config user.name > /dev/null 2>&1; then
    print_warning "Git user not configured. Setting default..."
    git config user.name "Lancer IA"
    git config user.email "lilian@lancer-ia.fr"
    print_success "Git configured"
fi

# Check if we're in a git repo
if [ ! -d .git ]; then
    print_error "Not a git repository. Initializing..."
    git init
    git add .
    git commit -m "🚀 Initial commit - Lancer IA website"
    print_success "Git repository initialized"
fi

# Get GitHub username
echo ""
print_info "Enter your GitHub username:"
read -r GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    print_error "GitHub username is required!"
    exit 1
fi

# Check if remote already exists
if git remote get-url origin > /dev/null 2>&1; then
    print_warning "Remote 'origin' already exists. Removing..."
    git remote remove origin
fi

# Add remote
REPO_URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
print_info "Adding remote: $REPO_URL"
git remote add origin "$REPO_URL"
print_success "Remote added"

# Rename branch to main if needed
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$DEFAULT_BRANCH" ]; then
    print_info "Renaming branch to $DEFAULT_BRANCH..."
    git branch -M "$DEFAULT_BRANCH"
    print_success "Branch renamed"
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    print_info "Uncommitted changes detected. Committing..."
    git add .
    echo ""
    print_info "Enter commit message (or press Enter for default):"
    read -r COMMIT_MSG
    
    if [ -z "$COMMIT_MSG" ]; then
        COMMIT_MSG="✨ Update Lancer IA website"
    fi
    
    git commit -m "$COMMIT_MSG"
    print_success "Changes committed"
fi

# Push to GitHub
echo ""
print_info "Pushing to GitHub..."
print_warning "You may need to enter your GitHub credentials or token"
echo ""

if git push -u origin "$DEFAULT_BRANCH"; then
    print_success "Successfully pushed to GitHub!"
    echo ""
    print_success "Repository: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
    print_success "View site: https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
    echo ""
    print_info "Next steps:"
    echo "  1. Enable GitHub Pages in repo Settings > Pages"
    echo "  2. Source: Deploy from branch 'main'"
    echo "  3. Wait 2-3 minutes for deployment"
    echo ""
else
    print_error "Push failed!"
    echo ""
    print_warning "If this is a new repository:"
    echo "  1. Create repo on GitHub: https://github.com/new"
    echo "  2. Name it: $REPO_NAME"
    echo "  3. Don't initialize with README"
    echo "  4. Run this script again"
    echo ""
    print_warning "If authentication failed:"
    echo "  1. Generate a Personal Access Token:"
    echo "     https://github.com/settings/tokens"
    echo "  2. Use token as password when prompted"
    echo ""
    exit 1
fi

# Optional: Open browser to repo
read -p "Open repository in browser? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v xdg-open > /dev/null; then
        xdg-open "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
    elif command -v open > /dev/null; then
        open "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
    else
        print_info "Please open: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}"
    fi
fi

print_success "Deployment complete! 🎉"
