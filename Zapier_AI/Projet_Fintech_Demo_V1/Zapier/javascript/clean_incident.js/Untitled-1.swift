// this is wrapped in an `async` function
// you can use await throughout the function

// Récupère la réponse de Claude
const responseText = inputData.claudeResponse;

// Nettoie le texte (enlève les backticks markdown)
let cleanText = responseText
  .replace(/```json\n?/g, '')
  .replace(/```\n?/g, '')
  .trim();

// Parse le JSON
let incidents;
try {
  incidents = JSON.parse(cleanText);
} catch (e) {
  // Si le parsing échoue, essaie de corriger les guillemets
  cleanText = cleanText
    .replace(/'/g, "\\'")  // Échappe les apostrophes
    .replace(/\n/g, ' ');   // Enlève les retours à la ligne
  
  try {
    incidents = JSON.parse(cleanText);
  } catch (e2) {
    // En dernier recours, retourne un tableau vide
    return [{
      objet: "Erreur de parsing",
      corps: "Le JSON n'a pas pu être parsé",
      severite: "haute",
      resume: cleanText.substring(0, 100),
      action: "Vérifier le format JSON",
      equipe: "Support"
    }];
  }
}

// Retourne les incidents
return incidents;