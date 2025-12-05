# 📚 Dictionnaire des Données

## Structure des incidents

### Champs principaux

| Champ | Type | Description | Exemple |
|-------|------|-------------|---------|
| `timestamp` | DateTime | Date et heure de l'incident | `2025-11-30T12:26:00Z` |
| `type_incident` | String | Type principal d'incident | `"Erreur API"` |
| `sous_type` | String | Sous-catégorie | `"Erreur 429"` |
| `criticite` | Enum | Niveau de gravité | `"Élevée"` |
| `resume` | String | Résumé de l'incident | `"Les clients ne peuvent plus finaliser de paiement..."` |
| `action_recommandee` | String | Action à entreprendre | `"Investiguer l'erreur et rétablir le service"` |
| `equipe_assignee` | String | Équipe responsable | `"Équipe technique"` |
| `message_brut` | Text | Email original complet | `"Bonjour équipe, Depuis 14h32 UTC..."` |
| `source` | String | Origine de l'incident | `"Email"` |

### Valeurs possibles

**criticite** :
- `"faible"` : Impact mineur, < 5% des clients
- `"moyenne"` : Impact modéré, 5-20% des clients
- `"élevée"` : Impact majeur, > 20% des clients

**type_incident** :
- `"Erreur API"`
- `"Problème de paiement"`
- `"Connexion / authentification"`
- `"Base de données"`
- `"Problème de base de données"`
- `"Suspension de fraude"`

**equipe_assignee** :
- `"Équipe technique"`
- `"Support"`
- `"Fraude"`
- `"Intégration"`

## Format d'échange

### JSON structuré (sortie ChatGPT)
```json
{
  "timestamp": "2025-11-30T12:26:00Z",
  "type_incident": "Erreur API",
  "sous_type": "Erreur 429",
  "criticite": "Élevée",
  "resume": "Les clients ne peuvent plus finaliser de paiement en raison d'une erreur 429 sur l'endpoint /v1/charge.",
  "action_recommandee": "Investiguer l'erreur et rétablir le service",
  "equipe_assignee": "Équipe technique",
  "message_brut": "Bonjour équipe...",
  "source": "Email"
}
```

### Google Sheets (colonnes)
```
| timestamp | type_incident | sous_type | criticite | resume | action_recommandee | equipe_assignee |
```

### Slack (message formaté)
```
🚨 **Incident Élevée**
Type: Erreur API
Résumé: Les clients ne peuvent plus...
Action: Investiguer l'erreur
Équipe: @équipe-technique
```

## Sources de données

### Email brut (/email_raw)
Emails Gmail non structurés contenant les rapports d'incidents.

### Structured output (/structured_output)
JSON généré par ChatGPT après parsing.

### Sheet output (/sheet_output_example)
Données telles qu'insérées dans Google Sheets.

## Qualité des données

- **Complétude** : 95% des champs remplis
- **Précision** : 93% de classification correcte
- **Fraîcheur** : < 2 minutes de latence
