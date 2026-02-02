# ⚠️ IMPORTANT : Nom du Repo GitHub

## Le repo s'appelle **"Lancer"** (avec majuscule)

**Correct :** `github.com/ton-username/Lancer`  
**Incorrect :** ~~github.com/ton-username/lancer~~

---

## 🚀 SETUP RAPIDE

### 1. Crée le repo sur GitHub

```
https://github.com/new

Repository name: Lancer  ← MAJUSCULE !
Description: Lancer IA - Agence IA-first pour PME
Public
Create repository
```

### 2. Push le code

```bash
cd lancer/  # ← le dossier local reste en minuscule
./auto-deploy-github.sh
```

**Le script push automatiquement vers:**
```
github.com/ton-username/Lancer
```

---

## 📁 Nomenclature

**Repo GitHub:** `Lancer` (majuscule)  
**Dossier local:** `lancer/` (minuscule, pas grave)  
**Domaine:** `lancer-ia.fr` (minuscule)

---

## ✅ C'est Déjà Configuré

Tous les scripts utilisent maintenant **"Lancer"** :

- ✅ `auto-deploy-github.sh` → pousse vers `Lancer`
- ✅ `deploy-github.sh` → pousse vers `Lancer`  
- ✅ `workflow.sh` → utilise `Lancer`
- ✅ Toute la documentation mise à jour

**Tu n'as rien à changer manuellement !**

---

## 🎯 Ready to Go

```bash
# Crée le repo "Lancer" sur GitHub
# Puis:
./auto-deploy-github.sh
```

Ça push sur `github.com/ton-username/Lancer` automatiquement 🚀

---

**Note:** Si tu veux renommer ton dossier local aussi :
```bash
mv lancer/ Lancer/
cd Lancer/
```

Mais c'est optionnel, le nom du dossier local n'a pas d'importance.
