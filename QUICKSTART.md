# 🚀 QUICK START - Lancer IA

## Deploy en 30 secondes

```bash
# 1. Rends-toi dans le dossier
cd lancer-ia-website

# 2. Lance le script de déploiement
./deploy.sh

# 3. Choisis ta plateforme et suis les instructions
```

C'est tout ! 🎉

---

## Options de Déploiement

### 🔷 1. GitHub Pages (Recommandé)

**Pourquoi ?**
- Gratuit
- SSL automatique
- Professionnel
- Versionning inclus

**Comment ?**
```bash
./deploy.sh
# Choisis option 1
# Entre ton username GitHub
# C'est live sur: username.github.io/lancer
```

**Domaine custom (lancer-ia.fr) :**
- GitHub Settings > Pages > Custom domain
- DNS chez OVH : voir DEPLOY.md

---

### 🔷 2. Netlify (Le plus simple)

**Pourquoi ?**
- Déploiement en 1 clic
- SSL automatique
- CDN mondial
- Domaine gratuit

**Comment ?**
```bash
./deploy.sh
# Choisis option 2
# Ou va sur: https://app.netlify.com/drop
# Drag & drop le dossier
```

---

### 🔷 3. Hostinger (Ton hosting actuel)

**Comment ?**
```bash
./deploy.sh
# Choisis option 5 (Create ZIP)
# Upload le ZIP via Hostinger File Manager
```

**Ou via Horizons :**
- https://horizons.hostinger.com/
- Upload files
- Done !

---

## Test Local

```bash
./deploy.sh
# Choisis option 4 (Local Preview)
# Ouvre http://localhost:8000
```

---

## Commandes Git Utiles

**Voir les changements :**
```bash
git status
```

**Commiter des changements :**
```bash
git add .
git commit -m "✨ Mon changement"
git push
```

**Voir l'historique :**
```bash
git log --oneline --graph
```

---

## Personnalisation Rapide

### Changer les couleurs
Fichier: `styles.css` ligne 13-16
```css
--bio-blue: #4A9EFF;      /* Bleu principal */
--golden: #FFB84D;         /* Accents dorés */
```

### Modifier le contenu
Fichier: `index.html`
- Hero: ligne 23
- Services: ligne 53
- Contact: ligne 168

### Ajouter Make.com webhook
Fichier: `script.js` ligne 98
```javascript
const response = await fetch('TON_WEBHOOK_MAKE', {
    method: 'POST',
    body: JSON.stringify(data)
});
```

---

## Troubleshooting

**Script ne se lance pas :**
```bash
chmod +x deploy.sh
./deploy.sh
```

**Git push refusé :**
```bash
git pull --rebase
git push
```

**Site pas à jour sur GitHub Pages :**
- Attends 2-3 minutes
- Vide le cache (Ctrl+Shift+R)

---

## Support

Questions ? Vérifie :
- **README.md** - Documentation complète
- **DEPLOY.md** - Guide détaillé GitHub

Besoin d'aide ? admin@lancer-ia.fr

---

**Fait avec ❤️ et Claude**
