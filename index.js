const express = require('express');
const { Client } = require('pg');
const path = require('path');
const app = express();
const port = 3000;

// Configurarea conexiunii la baza de date
const client = new Client({
    database: "formula1",
    user: "alex",
    password: "alexu",
    host: "localhost",
    port: 5432
});

client.connect();

app.use(express.static(path.join(__dirname, 'resurse')));
app.use('/imagini', express.static(path.join(__dirname, 'imagini')));
app.use(express.json()); // Necesită pentru a interpreta JSON în request body

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname));

// Servește pagina principală și transmite datele despre piloți, curse și rezultate
app.get('/', async (req, res) => {
    try {
        const pilotsResult = await client.query(`
            SELECT id_pilot, nume, prenume, echipa, nationalitate, abilitate, poza_nationalitate, poza_echipa
            FROM piloti
        `);
        
        const racesResult = await client.query('SELECT * FROM curse ORDER BY id_cursa');
        
        const resultsResult = await client.query(`
            SELECT pc.id_cursa, c.nume_cursa, p.nume, p.prenume, p.poza_nationalitate, p.poza_echipa, pc.pozitie_finala, pc.calificari
            FROM pilot_cursa pc
            JOIN piloti p ON pc.id_pilot = p.id_pilot
            JOIN curse c ON pc.id_cursa = c.id_cursa
            ORDER BY pc.id_cursa, pc.pozitie_finala
        `);

        res.render('formula1', { 
            drivers: pilotsResult.rows,
            races: racesResult.rows || [],
            results: resultsResult.rows
        });
    } catch (err) {
        console.error(err);
        res.send('Eroare la extragerea datelor.');
    }
});

// Ruta pentru a salva rezultatele unei curse în tabelul intermediar pilot_cursa
app.post('/save-race', async (req, res) => {
    const { raceId, driverId, position, qualifyingPosition } = req.body;
    console.log(`Primim date pentru cursa ${raceId}, pilot ${driverId}: calificări ${qualifyingPosition}, poziția finală ${position}`);
    
    try {
        const pilotExists = await client.query('SELECT 1 FROM piloti WHERE id_pilot = $1', [driverId]);
        const raceExists = await client.query('SELECT 1 FROM curse WHERE id_cursa = $1', [raceId]);

        if (pilotExists.rowCount === 0) {
            return res.status(400).send(`Pilotul cu ID ${driverId} nu există.`);
        }
        if (raceExists.rowCount === 0) {
            return res.status(400).send(`Cursa cu ID ${raceId} nu există.`);
        }

        await client.query(
            'INSERT INTO pilot_cursa (id_pilot, id_cursa, pozitie_finala, calificari) VALUES ($1, $2, $3, $4)',
            [driverId, raceId, position, qualifyingPosition]
        );
        res.sendStatus(200); // Răspuns OK dacă operațiunea este reușită
        console.log(`Date salvate cu succes pentru cursa ${raceId}, pilot ${driverId}`);
    } catch (err) {
        console.error('Eroare la salvarea rezultatului cursei:', err.message);
        res.status(500).send(`Eroare la salvare: ${err.message}`);
    }
});

// Pornirea serverului pe portul specificat
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});

// Gestionarea închiderii serverului prin Ctrl+C
process.on('SIGINT', () => {
    client.end(() => {
        console.log('Client disconnected');
        process.exit();
    });
});

// Endpoint pentru resetarea jocului
app.delete('/reset-game', async (req, res) => {
    try {
        await client.query('DELETE FROM pilot_cursa');
        console.log('Toate datele din pilot_cursa au fost șterse.');
        res.sendStatus(200); // Returnează 200 OK dacă ștergerea a avut succes
    } catch (err) {
        console.error('Eroare la ștergerea datelor din pilot_cursa:', err.message);
        res.status(500).send('Eroare la resetarea jocului.');
    }
});
