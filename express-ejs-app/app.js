const express = require('express');
const app = express();
const port = 3000;

// EJS motorra konfiguratu
app.set('view engine', 'ejs');

// Hasierako orria
app.get('/', (req, res) => {
  res.render('index', { title: 'Express eta EJS Aplikazioa' });
});

// Zerbitzaria abiarazi
app.listen(port, () => {
  console.log(`Aplikazioa martxan dago http://localhost:${port} helbidean`);
});
