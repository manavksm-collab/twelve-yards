# Twelve Yards

The daily penalty-shootout quiz. Each question has four answers, and each answer is a corner of the goal: answer right and you score, answer wrong and it's saved or it misses. 25 seconds a kick, harder every round, and you go in goal for the rival's kicks in between.

- `src/game.html` – the game (canvas animation, Web Audio sound, daily rotation)
- `src/questions.txt` – the question bank: `Category|Question|Correct|Wrong|Wrong|Wrong`, grouped under `#easy`, `#medium`, `#hard`, `#expert`
- `build.sh` – builds `dist/index.html`; GitHub Actions runs it and deploys to Pages on every push to `main`

New shootout every day at local midnight. Shootout #1 was 18 November 2026.
