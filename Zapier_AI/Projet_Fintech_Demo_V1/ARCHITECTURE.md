# 🏗️ Architecture Technique

## Vue d'ensemble

Ce document décrit l'architecture complète du système d'automatisation d'incidents fintech.

## Flow de données

### 1️⃣ Déclenchement (Trigger)
- **Source** : Gmail
- **Fréquence** : Temps réel + vérification toutes les heures
- **Filtre** : Emails contenant "incident" ou "erreur"

### 2️⃣ Extraction des données (ChatGPT)
```javascript
Input: Email brut
Process: Parsing NLP via ChatGPT-4o-mini
Output: JSON structuré
```

**Champs extraits** :
- `timestamp`
- `type_incident`
- `sous_type`
- `criticite` (faible/moyenne/élevée)
- `resume`
- `action_recommandee`
- `equipe_assignee`
- `message_brut`
- `source`

### 3️⃣ Analyse et résumé (Claude)
```javascript
Input: JSON structuré
Process: Analyse contextuelle + génération résumé
Output: Résumé professionnel en français
```

### 4️⃣ Parsing JavaScript
```javascript
// Nettoyage et validation du JSON
const cleanIncidents = incidents
  .filter(i => i.criticite !== null)
  .map(i => ({
    ...i,
    timestamp: new Date(i.timestamp).toISOString()
  }));
```

### 5️⃣ Distribution

**Google Sheets** :
- Insertion ligne par ligne
- Historisation complète
- Colonnes : timestamp, type, criticité, résumé, action, équipe

**Slack** :
- Channel : `#all-fintechaiincidents`
- Format : Message formaté avec émojis selon criticité
- Mention : @équipe-assignée si criticité élevée

**Looker Studio** :
- Connexion directe à Google Sheets
- Mise à jour automatique toutes les 15 minutes
- Visualisations : tendances, types, criticité, géographie

## Gestion des erreurs

### Rate Limiting
- **ChatGPT** : Limite de 3 requêtes/min → Retry avec backoff
- **Claude** : Limite flexible

### Validation des données
```javascript
if (!incident.criticite || !incident.type_incident) {
  return { error: "Champs manquants", incident };
}
```

### Fallback
Si l'IA échoue → Enregistrement du message brut + alerte manuelle

## Performances

| Métrique | Valeur |
|----------|--------|
| Temps de traitement | 90-120 secondes |
| Incidents par heure | 10 max |
| Taux de succès | 95% |
| Disponibilité | 99.5% |

## Sécurité

- ✅ Authentification OAuth2 (Gmail, Google Sheets, Slack)
- ✅ API Keys stockées dans secrets Zapier
- ✅ Aucun credential dans le code
- ✅ Logs désactivés pour données sensibles

## Évolutions possibles

- [ ] Webhooks pour temps réel absolu
- [ ] Machine Learning pour prédiction de criticité
- [ ] Intégration Jira pour création automatique de tickets
- [ ] API REST pour intégration externe
