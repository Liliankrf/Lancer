#!/bin/bash

# ============================================
# LANCER IA - Main Deploy Script
# ============================================

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Functions
print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_header() { echo -e "${CYAN}$1${NC}"; }

# Banner
clear
echo ""
print_header "╔════════════════════════════════════════╗"
print_header "║     LANCER IA - Deployment Tool       ║"
print_header "║  Minimalist Tech + Cinematic Anime    ║"
print_header "╚════════════════════════════════════════╝"
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ] || [ ! -f "styles.css" ]; then
    print_error "Error: Not in the lancer-ia-website directory!"
    echo "Please run this script from the project root."
    exit 1
fi

print_success "Project detected: Lancer IA Website"
echo ""

# Menu
print_header "Choose deployment platform:"
echo ""
echo "  1) GitHub Pages (Free, Professional)"
echo "  2) Netlify (Easy, Fast, 1-Click)"
echo "  3) Hostinger (Your current hosting)"
echo "  4) Local Preview (Test before deploy)"
echo "  5) Create ZIP for manual upload"
echo "  6) Exit"
echo ""

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        print_info "Deploying to GitHub Pages..."
        echo ""
        chmod +x deploy-github.sh
        ./deploy-github.sh
        ;;
    2)
        print_info "Deploying to Netlify..."
        echo ""
        chmod +x deploy-netlify.sh
        ./deploy-netlify.sh
        ;;
    3)
        print_info "Hostinger deployment instructions:"
        echo ""
        echo "Option A - Via Hostinger Horizons:"
        echo "  1. Go to: https://horizons.hostinger.com/"
        echo "  2. Click 'Upload Files' or 'Import'"
        echo "  3. Select all files in this directory"
        echo "  4. Publish!"
        echo ""
        echo "Option B - Via cPanel/File Manager:"
        echo "  1. Login to Hostinger cPanel"
        echo "  2. Open File Manager"
        echo "  3. Navigate to public_html/"
        echo "  4. Upload all files from this directory"
        echo "  5. Done!"
        echo ""
        print_warning "Create a ZIP first? (Easier to upload)"
        read -p "Create ZIP now? (y/n): " create_zip
        if [[ $create_zip =~ ^[Yy]$ ]]; then
            ZIP_NAME="lancer-ia-$(date +%Y%m%d-%H%M%S).zip"
            zip -r "../$ZIP_NAME" . -x "*.git/*" "*.sh" "DEPLOY.md"
            print_success "ZIP created: ../$ZIP_NAME"
        fi
        ;;
    4)
        print_info "Starting local preview..."
        echo ""
        
        # Try different methods to open browser
        if command -v python3 &> /dev/null; then
            print_success "Starting Python HTTP server..."
            echo ""
            print_info "Open browser to: http://localhost:8000"
            echo ""
            print_warning "Press Ctrl+C to stop server"
            echo ""
            python3 -m http.server 8000
        elif command -v php &> /dev/null; then
            print_success "Starting PHP server..."
            echo ""
            print_info "Open browser to: http://localhost:8000"
            echo ""
            print_warning "Press Ctrl+C to stop server"
            echo ""
            php -S localhost:8000
        else
            print_warning "No web server available"
            echo ""
            echo "Install Python or PHP, or just open index.html in your browser"
            
            # Try to open file directly
            if command -v xdg-open &> /dev/null; then
                xdg-open index.html
            elif command -v open &> /dev/null; then
                open index.html
            else
                print_info "Open this file in your browser:"
                echo "  $(pwd)/index.html"
            fi
        fi
        ;;
    5)
        print_info "Creating deployment ZIP..."
        echo ""
        
        ZIP_NAME="lancer-ia-deploy-$(date +%Y%m%d-%H%M%S).zip"
        
        # Create clean ZIP without git and scripts
        zip -r "$ZIP_NAME" . \
            -x "*.git/*" \
            -x "*.sh" \
            -x "DEPLOY.md" \
            -x "*.zip"
        
        print_success "ZIP created: $ZIP_NAME"
        print_info "Size: $(du -h $ZIP_NAME | cut -f1)"
        echo ""
        print_info "Ready to upload to:"
        echo "  • Hostinger File Manager"
        echo "  • Any web hosting cPanel"
        echo "  • Netlify Drop (https://app.netlify.com/drop)"
        ;;
    6)
        print_info "Exiting..."
        exit 0
        ;;
    *)
        print_error "Invalid choice!"
        exit 1
        ;;
esac

echo ""
print_success "All done! 🎉"
echo ""
