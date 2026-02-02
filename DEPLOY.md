# 🚀 Instructions de Déploiement GitHub

## Étape 1: Créer le Repo sur GitHub

1. Va sur https://github.com/new
2. **Repository name**: `lancer-ia-website`
3. **Description**: `Site web Lancer IA - Agence IA-first pour PME françaises`
4. **Public** ou **Private**: à toi de choisir (Public pour GitHub Pages gratuit)
5. ⚠️ **NE COCHE PAS** "Initialize this repository with a README"
6. Clique sur **Create repository**

## Étape 2: Pusher le Code

GitHub va te donner des commandes. **Ignore-les** et utilise plutôt celles-ci:

```bash
# Va dans le dossier du projet
cd /path/to/lancer-ia-website

# Vérifie que Git est bien initialisé
git status

# Ajoute le remote GitHub (remplace TON-USERNAME par ton username GitHub)
git remote add origin https://github.com/TON-USERNAME/lancer-ia-website.git

# Renomme la branche en 'main' (convention moderne)
git branch -M main

# Push le code
git push -u origin main
```

### Si GitHub demande une authentification:

**Option A - Token (Recommandé):**
1. Va sur https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Nom: `Lancer IA Deploy`
4. Coche: `repo` (full control)
5. Génère et **copie le token**
6. Quand Git demande le password, **colle le token** (pas ton mot de passe GitHub)

**Option B - SSH:**
```bash
# Génère une clé SSH
ssh-keygen -t ed25519 -C "ton-email@gmail.com"

# Copie la clé publique
cat ~/.ssh/id_ed25519.pub

# Ajoute-la sur GitHub: Settings > SSH and GPG keys > New SSH key

# Change l'URL remote en SSH
git remote set-url origin git@github.com:TON-USERNAME/lancer-ia-website.git
```

## Étape 3: Activer GitHub Pages (Hébergement Gratuit)

1. Sur ton repo GitHub, va dans **Settings**
2. Dans le menu gauche, clique **Pages**
3. **Source**: Deploy from a branch
4. **Branch**: main / (root)
5. Click **Save**

⏱️ Attends 2-3 minutes, puis ton site sera live sur:
```
https://TON-USERNAME.github.io/lancer-ia-website/
```

## Domaine Custom (lancer-ia.fr)

### Si tu as déjà le domaine:

1. **GitHub Pages Settings**:
   - Custom domain: `lancer-ia.fr`
   - Coche "Enforce HTTPS"

2. **DNS chez OVH** (ton registrar):

Ajoute ces enregistrements DNS:

```
Type    Nom     Valeur
A       @       185.199.108.153
A       @       185.199.109.153
A       @       185.199.110.153
A       @       185.199.111.153
CNAME   www     TON-USERNAME.github.io
```

⏱️ Propagation DNS: 10min à 48h (généralement <1h)

### Si tu veux utiliser Hostinger:

Upload simplement les fichiers via:
1. **Hostinger Horizons**: Drag & drop les fichiers
2. **ou cPanel/File Manager**: Upload dans `public_html/`
3. Connecte ton domaine dans Hostinger

## Mises à Jour Futures

Quand tu modifies le code:

```bash
# Vérifie les changements
git status

# Ajoute tous les fichiers modifiés
git add .

# Commit avec message
git commit -m "✨ Description de tes changements"

# Push vers GitHub
git push
```

GitHub Pages se mettra à jour automatiquement en 1-2 minutes.

## Commandes Git Utiles

```bash
# Voir l'historique
git log --oneline --graph

# Annuler les modifications non commitées
git checkout .

# Créer une branche pour tester
git checkout -b feature/nouvelle-fonctionnalite

# Revenir à main
git checkout main

# Merger une branche
git merge feature/nouvelle-fonctionnalite
```

## Troubleshooting

**Push refusé (rejected):**
```bash
git pull origin main --rebase
git push origin main
```

**Mauvais remote:**
```bash
git remote -v  # Voir les remotes
git remote remove origin
git remote add origin https://github.com/TON-USERNAME/lancer-ia-website.git
```

**GitHub Pages ne s'affiche pas:**
- Attends 5 minutes après activation
- Vérifie que le repo est Public
- Vérifie Settings > Pages est bien configuré

---

## 🎉 Next Steps

Une fois déployé:

1. ✅ Teste sur mobile et desktop
2. ✅ Configure Google Analytics (voir README.md)
3. ✅ Connecte le formulaire à Make.com
4. ✅ Ajoute le chatbot Chatbase
5. ✅ Partage sur LinkedIn ! 🚀

**Besoin d'aide?** Check le README.md ou contacte-moi.
