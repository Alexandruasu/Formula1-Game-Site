let currentRaceIndex = 0;
const driverPoints = {}; // Obiect pentru a stoca punctele totale pentru fiecare pilot

document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("start-race").addEventListener("click", startRace);
    document.getElementById("reset-game").addEventListener("click", resetGame);

    // Inițializează punctele fiecărui pilot la 0
    document.querySelectorAll(".driver-card").forEach(card => {
        const driverId = card.querySelector("p[id^='position-']").id.split("-")[1];
        driverPoints[driverId] = 0;
    });
});

function startRace() {
    if (currentRaceIndex >= races.length) {
        if (confirm("Toate cursele s-au terminat! Vrei să începi un nou joc?")) {
            resetGame();
        }
        return;
    }

    const race = races[currentRaceIndex];
    document.getElementById("race-title").innerText = race.nume_cursa;

    // Creează o listă de piloți cu abilități randomizate pentru cursă
    const driverElements = document.querySelectorAll(".driver-card");
    const drivers = Array.from(driverElements).map(card => {
        const driverId = card.querySelector("p[id^='position-']").id.split("-")[1];
        const ability = parseInt(card.getAttribute('data-ability'));

        // Calculăm o valoare randomizată pe baza abilității pentru cursă
        const randomFactor = Math.random();
        const weightedScore = ability * (0.8 + 0.4 * randomFactor);

        return { id: driverId, weightedScore, ability };
    });

    // Calculează pozițiile de calificare ținând cont de abilitate
    const qualifyingResults = drivers.map(driver => {
        const qualifyingScore = driver.ability * (0.8 + 0.4 * Math.random());
        return { id: driver.id, qualifyingScore };
    });

    // Sortează piloții în funcție de calificare descrescător și atribuie pozițiile
    qualifyingResults.sort((a, b) => b.qualifyingScore - a.qualifyingScore);
    qualifyingResults.forEach((driver, index) => {
        driver.qualifyingPosition = index + 1;
    });

    // Sortează piloții în funcție de scorul ponderat pentru cursă descrescător (abilitate randomizată)
    drivers.sort((a, b) => b.weightedScore - a.weightedScore);

    // Punctajul pentru primele 10 poziții
    const pointsTable = [25, 18, 15, 12, 10, 8, 6, 4, 2, 1];

    drivers.forEach((driver, index) => {
        const driverId = driver.id;
        const position = index + 1;
        const qualifyingPosition = qualifyingResults.find(q => q.id === driverId).qualifyingPosition;
        const points = position <= 10 ? pointsTable[position - 1] : 0;

        // Verifică dacă pilotul primește puncte sau nu
        const pointsElement = document.getElementById(`points-${driverId}`);
        if (points > 0) {
            driverPoints[driverId] += points;
            pointsElement.innerText = `Puncte: ${driverPoints[driverId]}`;

            // Aplica animatia pentru schimbarea punctajului doar daca punctele au crescut
            pointsElement.classList.add('points-animation');

            pointsElement.addEventListener('animationend', () => {
                pointsElement.classList.remove('points-animation');
            }, { once: true });
        } else {
            // Dacă pilotul nu primește puncte, aplica animația roșie
            pointsElement.classList.add('no-points-animation');

            pointsElement.addEventListener('animationend', () => {
                pointsElement.classList.remove('no-points-animation');
            }, { once: true });
        }

        // Actualizează poziția în interfață
        document.getElementById(`position-${driverId}`).innerText = `Poziție: ${position}`;

        addRowToTable(race.nume_cursa, driverId, position, points);
        saveRaceResult(race.id_cursa, driverId, position, qualifyingPosition);
    });

    // Reordonare piloți în funcție de punctajul total
    sortDriversByPoints();
    currentRaceIndex++;
}



function sortDriversByPoints() {
    const container = document.getElementById("drivers-container");
    const cards = Array.from(container.querySelectorAll(".driver-card"));

    // Sortează cardurile în funcție de punctajul total al fiecărui pilot
    cards.sort((a, b) => {
        const aId = a.querySelector("p[id^='position-']").id.split("-")[1];
        const bId = b.querySelector("p[id^='position-']").id.split("-")[1];
        return driverPoints[bId] - driverPoints[aId];
    });

    // Rearanjează cardurile în DOM
    cards.forEach(card => container.appendChild(card));
}

function addRowToTable(raceName, driverId, position, points) {
    const row = document.createElement("tr");
    row.innerHTML = `<td>${raceName}</td><td>${driverId}</td><td>${position}</td><td>${points}</td>`;
    document.getElementById("score-table-body").appendChild(row);
}

function saveRaceResult(raceId, driverId, position, qualifyingPosition) {
    fetch('/save-race', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ raceId, driverId, position, qualifyingPosition })
    }).then(response => {
        if (!response.ok) {
            console.error('Eroare la salvarea rezultatului cursei:', response.statusText);
        }
    }).catch(error => {
        console.error('Eroare la comunicarea cu serverul:', error);
    });
}

function resetGame() {
    if (confirm("Ești sigur că vrei să începi un nou joc? Aceasta va șterge toate datele existente!")) {
        fetch('/reset-game', {
            method: 'DELETE',
        }).then(response => {
            if (response.ok) {
                alert("Jocul a fost resetat!");
                window.location.reload();
            } else {
                alert("Eroare la resetarea jocului.");
            }
        }).catch(error => {
            console.error("Eroare la comunicarea cu serverul:", error);
            alert("Eroare la resetarea jocului.");
        });
    }
}

function shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
}
