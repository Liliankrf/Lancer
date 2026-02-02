#!/bin/bash

# ============================================
# LANCER IA - Full Workflow: GitHub + Hostinger
# ============================================

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_header() { echo -e "${CYAN}$1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

clear
echo ""
print_header "╔════════════════════════════════════════╗"
print_header "║   LANCER IA - Workflow Complet        ║"
print_header "║   GitHub (Code) → Hostinger (Site)    ║"
print_header "╚════════════════════════════════════════╝"
echo ""

print_info "Workflow de développement professionnel:"
echo ""
echo "  1. 📝 Code modifié localement"
echo "  2. 🔄 Commit + Push vers GitHub (backup/versioning)"
echo "  3. 🚀 Déploiement vers Hostinger (production)"
echo ""

# Step 1: Commit changes
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    print_warning "Changements non commités détectés"
    echo ""
    git status --short
    echo ""
    read -p "Commiter ces changements? (y/n) " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git add .
        echo ""
        print_info "Message de commit (ou Enter pour défaut):"
        read -r COMMIT_MSG
        
        if [ -z "$COMMIT_MSG" ]; then
            COMMIT_MSG="✨ Update Lancer IA website - $(date +%Y-%m-%d)"
        fi
        
        git commit -m "$COMMIT_MSG"
        print_success "Changements commités"
    else
        print_warning "Changements non commités - push annulé"
        exit 1
    fi
else
    print_success "Aucun changement à commiter"
fi

# Step 2: Push to GitHub
echo ""
print_info "Push vers GitHub..."

if git remote get-url origin > /dev/null 2>&1; then
    REMOTE_URL=$(git remote get-url origin)
    print_info "Remote: $REMOTE_URL"
    
    if git push; then
        print_success "✓ Code pushé sur GitHub"
    else
        print_warning "Push GitHub échoué"
        echo ""
        echo "Si le remote n'existe pas encore:"
        echo "  ./auto-deploy-github.sh"
        echo ""
        exit 1
    fi
else
    print_warning "Aucun remote GitHub configuré"
    echo ""
    print_info "Configure d'abord GitHub:"
    echo "  ./auto-deploy-github.sh"
    echo ""
    exit 1
fi

# Step 3: Deploy to Hostinger
echo ""
print_warning "Déployer sur Hostinger maintenant?"
read -p "Continuer? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    print_info "Lancement du déploiement Hostinger..."
    chmod +x deploy-hostinger.sh
    ./deploy-hostinger.sh
else
    echo ""
    print_info "Déploiement Hostinger annulé"
    echo ""
    print_info "Pour déployer plus tard:"
    echo "  ./deploy-hostinger.sh"
    echo ""
fi

echo ""
print_header "════════════════════════════════════════"
print_success "   Workflow terminé ! 🎉"
print_header "════════════════════════════════════════"
echo ""
print_info "Résumé:"
echo "  ✓ Code commité localement"
echo "  ✓ Pushé sur GitHub (backup)"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "  ✓ Déployé sur Hostinger (live)"
else
    echo "  ⊗ Déploiement Hostinger à faire"
fi
echo ""
