#!/bin/bash

# ============================================
# LANCER IA - Netlify Deploy Script
# ============================================

set -e

echo "🚀 LANCER IA - Netlify Deployment"
echo "=================================="
echo ""

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if netlify-cli is installed
if ! command -v netlify &> /dev/null; then
    print_warning "Netlify CLI not found. Installing..."
    
    if command -v npm &> /dev/null; then
        npm install -g netlify-cli
        print_success "Netlify CLI installed"
    else
        print_warning "npm not found. Installing Node.js required."
        echo "Install from: https://nodejs.org/"
        echo ""
        print_info "Alternative: Manual deployment"
        echo "  1. Go to https://app.netlify.com/drop"
        echo "  2. Drag and drop this folder"
        echo "  3. Done!"
        exit 1
    fi
fi

# Login to Netlify
print_info "Logging in to Netlify..."
netlify login

# Deploy
print_info "Deploying to Netlify..."
echo ""

# First deployment
if [ ! -f .netlify/state.json ]; then
    print_info "First deployment - creating new site..."
    netlify deploy --prod
else
    print_info "Updating existing site..."
    netlify deploy --prod
fi

print_success "Deployed to Netlify! 🎉"
echo ""
netlify open:site
