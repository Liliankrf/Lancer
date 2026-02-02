#!/bin/bash

# ============================================
# LANCER IA - Hostinger Deploy Script
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
print_header "║   LANCER IA - Hostinger Deploy        ║"
print_header "╚════════════════════════════════════════╝"
echo ""

# Config file
CONFIG_FILE=".hostinger-deploy.conf"

# Function to save config
save_config() {
    cat > "$CONFIG_FILE" << EOF
# Hostinger FTP/SFTP Configuration
# NE COMMITE PAS CE FICHIER SUR GITHUB !

FTP_HOST="$1"
FTP_USER="$2"
FTP_REMOTE_DIR="$3"
FTP_PROTOCOL="$4"
EOF
    chmod 600 "$CONFIG_FILE"
    print_success "Configuration sauvegardée dans $CONFIG_FILE"
}

# Load existing config if available
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
    print_info "Configuration existante trouvée"
    echo ""
    echo "Host: $FTP_HOST"
    echo "User: $FTP_USER"
    echo "Remote dir: $FTP_REMOTE_DIR"
    echo "Protocol: $FTP_PROTOCOL"
    echo ""
    read -p "Utiliser cette config? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        rm "$CONFIG_FILE"
    fi
fi

# Get Hostinger credentials if not saved
if [ ! -f "$CONFIG_FILE" ]; then
    echo ""
    print_info "Configuration Hostinger FTP/SFTP"
    echo ""
    print_warning "Tu peux trouver ces infos dans ton Hostinger hPanel:"
    echo "  → Files > FTP Accounts"
    echo "  ou"
    echo "  → Advanced > SSH Access (pour SFTP)"
    echo ""
    
    read -p "FTP Host (ex: ftp.lancer-ia.fr ou IP): " FTP_HOST
    read -p "FTP Username: " FTP_USER
    read -p "Remote directory (ex: public_html ou /): " FTP_REMOTE_DIR
    
    echo ""
    echo "Protocole de transfert:"
    echo "  1) FTP (standard, moins sécurisé)"
    echo "  2) SFTP (sécurisé, recommandé)"
    read -p "Choix (1 ou 2): " proto_choice
    
    if [ "$proto_choice" = "2" ]; then
        FTP_PROTOCOL="sftp"
    else
        FTP_PROTOCOL="ftp"
    fi
    
    echo ""
    read -p "Sauvegarder cette config? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        save_config "$FTP_HOST" "$FTP_USER" "$FTP_REMOTE_DIR" "$FTP_PROTOCOL"
        
        # Add to .gitignore
        if ! grep -q "$CONFIG_FILE" .gitignore 2>/dev/null; then
            echo "" >> .gitignore
            echo "# Hostinger credentials - DO NOT COMMIT" >> .gitignore
            echo "$CONFIG_FILE" >> .gitignore
            print_success "Ajouté à .gitignore"
        fi
    fi
fi

# Files to deploy
FILES_TO_DEPLOY=(
    "index.html"
    "styles.css"
    "script.js"
)

echo ""
print_info "Fichiers à déployer:"
for file in "${FILES_TO_DEPLOY[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        print_warning "  ✗ $file (manquant)"
    fi
done
echo ""

# Choose deployment method
echo ""
print_header "Méthode de déploiement:"
echo ""
echo "  1) LFTP (Automatique, recommandé)"
echo "  2) SFTP manuel (commandes à copier)"
echo "  3) Créer un ZIP pour upload manuel"
echo "  4) Hostinger File Manager (instructions)"
echo ""
read -p "Choix (1-4): " deploy_method

case $deploy_method in
    1)
        # Check if lftp is installed
        if ! command -v lftp &> /dev/null; then
            print_warning "lftp n'est pas installé"
            echo ""
            echo "Installation:"
            echo "  Mac:    brew install lftp"
            echo "  Ubuntu: sudo apt-get install lftp"
            echo "  Windows: Utilise WSL ou option 3"
            echo ""
            exit 1
        fi
        
        print_info "Déploiement via LFTP..."
        echo ""
        
        read -s -p "Password FTP: " FTP_PASS
        echo ""
        echo ""
        
        # Create lftp script
        LFTP_SCRIPT=$(mktemp)
        cat > "$LFTP_SCRIPT" << EOF
set ssl:verify-certificate no
open -u $FTP_USER,$FTP_PASS $FTP_PROTOCOL://$FTP_HOST
cd $FTP_REMOTE_DIR
lcd .
mput index.html
mput styles.css
mput script.js
bye
EOF
        
        print_info "Upload en cours..."
        if lftp -f "$LFTP_SCRIPT"; then
            rm "$LFTP_SCRIPT"
            echo ""
            print_success "════════════════════════════════════════"
            print_success "   🎉 DÉPLOYÉ SUR HOSTINGER !"
            print_success "════════════════════════════════════════"
            echo ""
            print_info "Ton site est maintenant live sur lancer-ia.fr"
            echo ""
            print_warning "N'oublie pas de vider le cache (Ctrl+Shift+R)"
        else
            rm "$LFTP_SCRIPT"
            print_warning "Échec du déploiement"
            echo ""
            echo "Vérifie:"
            echo "  • Host, username, password corrects"
            echo "  • Répertoire remote correct"
            echo "  • Connexion FTP/SFTP activée sur Hostinger"
        fi
        ;;
        
    2)
        # SFTP manual commands
        print_info "Commandes SFTP manuelles:"
        echo ""
        echo "1. Connecte-toi:"
        echo "   sftp $FTP_USER@$FTP_HOST"
        echo ""
        echo "2. Va dans le bon répertoire:"
        echo "   cd $FTP_REMOTE_DIR"
        echo ""
        echo "3. Upload les fichiers:"
        echo "   put index.html"
        echo "   put styles.css"
        echo "   put script.js"
        echo ""
        echo "4. Quitte:"
        echo "   bye"
        echo ""
        ;;
        
    3)
        # Create deployment ZIP
        print_info "Création du ZIP de déploiement..."
        
        ZIP_NAME="lancer-deploy-$(date +%Y%m%d-%H%M%S).zip"
        zip "$ZIP_NAME" index.html styles.css script.js
        
        print_success "ZIP créé: $ZIP_NAME"
        echo ""
        print_info "Upload via Hostinger File Manager:"
        echo "  1. Connecte-toi à Hostinger hPanel"
        echo "  2. Files > File Manager"
        echo "  3. Navigate to public_html/"
        echo "  4. Upload $ZIP_NAME"
        echo "  5. Extract le ZIP"
        echo "  6. Supprime le ZIP"
        echo ""
        ;;
        
    4)
        # Hostinger File Manager instructions
        print_info "Déploiement via Hostinger File Manager:"
        echo ""
        echo "1. Connecte-toi à Hostinger hPanel"
        echo "   https://hpanel.hostinger.com/"
        echo ""
        echo "2. Va dans Files > File Manager"
        echo ""
        echo "3. Navigate vers public_html/"
        echo "   (ou le dossier de ton domaine lancer-ia.fr)"
        echo ""
        echo "4. Upload ces fichiers:"
        echo "   • index.html"
        echo "   • styles.css"
        echo "   • script.js"
        echo ""
        echo "5. Écrase les anciens fichiers si demandé"
        echo ""
        echo "6. C'est live !"
        echo ""
        print_warning "Alternative rapide: Crée un ZIP (option 3) puis upload"
        echo ""
        ;;
        
    *)
        print_warning "Choix invalide"
        exit 1
        ;;
esac

echo ""
print_success "Déploiement terminé ! 🚀"
