#!/bin/bash

# ============================================
# LANCER IA - One-Liner GitHub Deploy
# ============================================
# Usage: curl -s URL_DE_CE_SCRIPT | bash
# Ou: ./auto-deploy-github.sh

set -e

# Colors
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
print_header "║   LANCER IA - Auto GitHub Deploy      ║"
print_header "╚════════════════════════════════════════╝"
echo ""

# Check we're in the right directory
if [ ! -f "index.html" ]; then
    print_warning "Télécharge et extrait lancer-website-full.zip d'abord"
    echo "Puis lance ce script depuis le dossier lancer/"
    exit 1
fi

print_success "Projet détecté !"
echo ""

# Get GitHub username
print_info "Entre ton username GitHub:"
read -r GH_USER

if [ -z "$GH_USER" ]; then
    echo "Username requis!"
    exit 1
fi

REPO_NAME="Lancer"
REPO_URL="https://github.com/${GH_USER}/${REPO_NAME}.git"

print_info "Repo: $REPO_URL"
echo ""

# Configure Git if needed
if ! git config user.name > /dev/null 2>&1; then
    print_info "Configuration Git..."
    git config user.name "Lancer IA"
    git config user.email "lilian@lancer-ia.fr"
    print_success "Git configuré"
fi

# Check if already initialized
if [ ! -d .git ]; then
    print_info "Initialisation Git..."
    git init
    git add .
    git commit -m "🚀 Initial commit - Lancer IA"
    print_success "Repo initialisé"
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    print_info "Changements détectés, commit..."
    git add .
    git commit -m "✨ Update Lancer IA website"
    print_success "Changements commités"
fi

# Remove old remote if exists
git remote remove origin 2>/dev/null || true

# Add remote and push
print_info "Ajout du remote GitHub..."
git remote add origin "$REPO_URL"

print_info "Renommage branche en main..."
git branch -M main

echo ""
print_warning "⚠️  IMPORTANT: GitHub va demander authentification"
echo ""
print_info "Si tu n'as pas de token:"
echo "  1. Va sur https://github.com/settings/tokens"
echo "  2. Generate new token (classic)"
echo "  3. Nom: Lancer Deploy"
echo "  4. Coche: repo (full control)"
echo "  5. Copie le token"
echo "  6. Utilise-le comme PASSWORD (pas ton mot de passe GitHub)"
echo ""
read -p "Prêt? (Appuie sur Enter pour continuer)" 

print_info "Push vers GitHub..."
echo ""

if git push -u origin main; then
    echo ""
    print_success "════════════════════════════════════════"
    print_success "   🎉 SUCCÈS ! Code pushé sur GitHub"
    print_success "════════════════════════════════════════"
    echo ""
    print_info "Ton repo: https://github.com/${GH_USER}/${REPO_NAME}"
    echo ""
    print_header "PROCHAINES ÉTAPES:"
    echo ""
    echo "1. Active GitHub Pages:"
    echo "   • Va sur: https://github.com/${GH_USER}/${REPO_NAME}/settings/pages"
    echo "   • Source: Deploy from branch 'main'"
    echo "   • Save"
    echo ""
    echo "2. Attends 2-3 minutes"
    echo ""
    echo "3. Ton site sera live sur:"
    print_success "   https://${GH_USER}.github.io/${REPO_NAME}/"
    echo ""
    echo "4. (Optionnel) Domaine custom:"
    echo "   • Custom domain: lancer-ia.fr"
    echo "   • Config DNS: voir GITHUB-PUSH.md"
    echo ""
    
    # Offer to open browser
    read -p "Ouvrir GitHub dans le navigateur? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if command -v xdg-open > /dev/null; then
            xdg-open "https://github.com/${GH_USER}/${REPO_NAME}"
        elif command -v open > /dev/null; then
            open "https://github.com/${GH_USER}/${REPO_NAME}"
        fi
    fi
    
else
    echo ""
    print_warning "Push échoué!"
    echo ""
    print_info "Vérifications:"
    echo ""
    echo "1. Le repo existe-t-il sur GitHub?"
    echo "   Crée-le: https://github.com/new"
    echo "   Nom: $REPO_NAME"
    echo "   ⚠️  Ne coche PAS 'Initialize with README'"
    echo ""
    echo "2. Token correct?"
    echo "   • Pas ton mot de passe GitHub"
    echo "   • Utilise un Personal Access Token"
    echo "   • Génère-le: https://github.com/settings/tokens"
    echo ""
    echo "3. Relance ce script:"
    echo "   ./auto-deploy-github.sh"
    echo ""
    exit 1
fi

print_success "Déploiement terminé ! 🚀"
