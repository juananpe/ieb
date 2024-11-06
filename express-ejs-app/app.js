const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// EJS motorra konfiguratu
app.set('view engine', 'ejs');

// Hasierako orria
app.get('/', (req, res) => {
  res.render('index', { title: 'Express eta EJS Aplikazioa' });
});

// Bidaiak kontsultatzeko orria
app.get('/bidaiak', (req, res) => {
  // Momentuz datu estatikoak erabiliko ditugu
  const hiriak = ['Bilbo', 'Donostia', 'Gasteiz', 'Iruñea'];
  
  res.render('bidaiak', { 
    hiriak: hiriak,
    bidaiak: [
      { jatorria: 'Bilbo', helmuga: 'Donostia', data: '2024/04/04', plazak: 3, prezioa: 15 },
      { jatorria: 'Gasteiz', helmuga: 'Iruñea', data: '2024/04/04', plazak: 2, prezioa: 12 },
      { jatorria: 'Bilbo', helmuga: 'Gasteiz', data: '2024/04/05', plazak: 4, prezioa: 8 }
    ]
  });
});

// Zerbitzaria abiarazi
app.listen(port, () => {
  console.log(`Aplikazioa martxan dago http://localhost:${port} helbidean`);
});

app.get('/kaixo', (req, res) => {
  const message = 'Kaixo mundua';
  console.log(message);
  res.send(message);
});

