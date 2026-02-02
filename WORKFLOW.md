# 🎯 WORKFLOW LANCER IA - GitHub + Hostinger

## Architecture du Projet

```
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│   Local     │  push   │   GitHub    │  deploy │  Hostinger  │
│   (Code)    │ ──────> │  (Backup)   │ ──────> │   (Live)    │
└─────────────┘         └─────────────┘         └─────────────┘
     Edit                  Version                Production
                          Control               lancer-ia.fr
```

**GitHub** = Repo pour versionner, collaborer, sauvegarder
**Hostinger** = Hébergement production du site

---

## 📦 SETUP INITIAL (Une fois)

### 1. Push initial vers GitHub

```bash
# Crée d'abord le repo sur GitHub: https://github.com/new
# Nom: lancer
# Public ou Private

# Ensuite:
./auto-deploy-github.sh
```

**Résultat:**
- ✅ Code sur github.com/ton-username/Lancer
- ✅ Versioning activé
- ✅ Backup automatique

### 2. Configuration Hostinger (première fois)

```bash
./deploy-hostinger.sh
```

Le script va te demander:
- **FTP Host**: Trouve dans Hostinger hPanel > Files > FTP Accounts
- **Username**: Ton username FTP
- **Remote directory**: `public_html` ou `/`
- **Protocol**: SFTP (recommandé) ou FTP

**Ces infos seront sauvegardées** dans `.hostinger-deploy.conf`
(fichier ignoré par Git pour sécurité)

---

## 🔄 WORKFLOW QUOTIDIEN

### Méthode 1: Workflow automatique (Recommandé)

```bash
# Une seule commande fait tout:
./workflow.sh
```

**Ce script fait:**
1. ✅ Commit tes changements locaux
2. ✅ Push sur GitHub
3. ✅ Deploy sur Hostinger

**C'est tout ! 🚀**

### Méthode 2: Étape par étape

**A. Modifications locales**
```bash
# Édite tes fichiers (index.html, styles.css, etc.)
```

**B. Commit + Push GitHub**
```bash
git add .
git commit -m "✨ Description de tes changements"
git push
```

**C. Deploy Hostinger**
```bash
./deploy-hostinger.sh
```

---

## 🛠️ COMMANDES UTILES

### Voir les changements
```bash
git status
git diff
```

### Voir l'historique
```bash
git log --oneline --graph
```

### Annuler des modifications
```bash
git checkout .              # Annule tout
git checkout fichier.html   # Annule un fichier
```

### Créer une branche pour tester
```bash
git checkout -b feature/nouvelle-feature
# Fais tes modifs
git checkout main  # Retour à main
```

### Récupérer la dernière version
```bash
git pull
```

---

## 🚀 OPTIONS DE DÉPLOIEMENT HOSTINGER

### Option 1: LFTP (Automatique)

**Le plus rapide:**
```bash
./deploy-hostinger.sh
# Choisis option 1
# Entre ton password
# Upload automatique !
```

**Prérequis:**
- Mac: `brew install lftp`
- Linux: `sudo apt install lftp`
- Windows: Utilise WSL ou option 3

### Option 2: SFTP Manuel

```bash
sftp user@ftp.lancer-ia.fr
cd public_html
put index.html
put styles.css
put script.js
bye
```

### Option 3: ZIP Upload

```bash
./deploy-hostinger.sh
# Choisis option 3
# Upload le ZIP via Hostinger File Manager
```

### Option 4: File Manager Direct

1. Hostinger hPanel
2. Files > File Manager
3. Navigate to `public_html/`
4. Upload `index.html`, `styles.css`, `script.js`
5. Done !

---

## 📁 STRUCTURE FICHIERS

```
lancer/
├── index.html                 # 🌐 Page principale
├── styles.css                 # 🎨 Styles
├── script.js                  # ⚡ JavaScript
│
├── .git/                      # Git (auto)
├── .gitignore                 # Fichiers ignorés
│
├── workflow.sh                # 🔄 Workflow complet
├── auto-deploy-github.sh      # → GitHub
├── deploy-hostinger.sh        # → Hostinger
│
├── README.md                  # Documentation
├── QUICKSTART.md              # Démarrage rapide
└── WORKFLOW.md                # Ce fichier
```

---

## 🔒 SÉCURITÉ

### Credentials Hostinger

**JAMAIS commités sur GitHub !**

Le fichier `.hostinger-deploy.conf` est automatiquement ignoré.

Si tu veux partager l'accès:
- Partage les credentials de manière sécurisée (1Password, etc.)
- Ou crée des comptes FTP séparés sur Hostinger

### Permissions

```bash
# Les scripts doivent être exécutables
chmod +x *.sh
```

---

## 🐛 TROUBLESHOOTING

### "Permission denied" sur scripts
```bash
chmod +x workflow.sh deploy-hostinger.sh auto-deploy-github.sh
```

### Push GitHub échoué
```bash
git pull --rebase
git push
```

### Upload Hostinger échoué

**Vérifications:**
1. Credentials corrects?
2. FTP/SFTP activé sur Hostinger?
3. Répertoire remote correct? (public_html)
4. Connexion internet OK?

**Teste la connexion manuellement:**
```bash
sftp user@host
# Si ça marche pas: vérifie dans Hostinger hPanel
```

### Site pas à jour sur lancer-ia.fr

1. Vide le cache: `Ctrl + Shift + R`
2. Vérifie les fichiers sur Hostinger File Manager
3. Check les permissions (chmod 644)

---

## 📊 WORKFLOW AVANCÉ

### Avec branches Git

```bash
# Branche de dev
git checkout -b dev
# Fais tes modifs
git add .
git commit -m "✨ New feature"

# Merge dans main
git checkout main
git merge dev

# Push et deploy
./workflow.sh
```

### Avec tests locaux

```bash
# Test local
python3 -m http.server 8000
# Ouvre http://localhost:8000

# Si OK:
./workflow.sh
```

### Avec CI/CD (avancé)

Tu peux automatiser le déploiement avec:
- **GitHub Actions**: Deploy automatique sur push
- **Webhooks**: Hostinger appelle un script au push
- **Netlify/Vercel**: Alternative à Hostinger

(Setup avancé, on peut le faire plus tard si besoin)

---

## 🎉 RÉCAP

**Setup une fois:**
```bash
./auto-deploy-github.sh        # Configure GitHub
./deploy-hostinger.sh          # Configure Hostinger
```

**Workflow quotidien:**
```bash
# Édite ton code
./workflow.sh                  # Push GitHub + Deploy Hostinger
```

**C'est tout !**

---

## 💡 TIPS PRO

1. **Commit souvent** avec messages clairs
2. **Test local** avant de deploy
3. **Sauvegarde** `.hostinger-deploy.conf` ailleurs (notes perso)
4. **Vide le cache** après chaque deploy
5. **Branche de dev** pour les grosses modifs

---

## 📞 BESOIN D'AIDE ?

- **README.md** - Vue d'ensemble
- **QUICKSTART.md** - Démarrage rapide
- **Ce fichier** - Workflow détaillé

Questions ? admin@lancer-ia.fr

---

**Fait avec ❤️ et Claude**
