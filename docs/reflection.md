# Reflektionsdokument – obligatorisk leverabel

Svara kort men motiverat på samtliga frågor. Knyt svaren till vad du implementerade och observerade i laborationen; enstaka ja/nej-svar är inte tillräckliga. Ersätt instruktionstexten med dina svar före inlämning.

1. Varför ska sensorerna kommunicera med ett API i stället för direkt med PostgreSQL?
API skapar ett skydd mellan sensorer och databasen, och det skulle vara en säkerhetsrisk om man skulle använda direkt med PostgreSQL eftersom varje sensor information och kunskap om tabellstrukturen. 
Det lager av skydd som API skapar validera datan också (validate_mesurment) och utan det skulle felaktiga och skadliga data kunna hamna i databasen.
Och med hjälp av API det är lättare att kunna byta databas i framtiden utan att påverka sensorer.

2. Varför ska felaktig sensordata stoppas innan den sparas?
Eftersom det felaktiga sensordata påverkar analyser och det gör att det går inte längre lita på själva analys och detta leder till statistik blir felaktig eller krascha.

3. Varför passar PostgreSQL för historiska mätvärden?
Eftersom historiska mätvärde ska vara kompletta och varje mätning ska finnsa krav för alltid eller ett längdre period så PostgreSQL passar bäst för det. PostgreSQL är en relationsdatabas som är byggd för struktur och hållbar lagring. Och i detta project ligger datan i en docker-volym(postgre_data).

4. Vad händer med lösningen om Redis försvinner?
Inget data kommer försvinna men däremot det tillfälliga cache kommer försvinna. I labben så testade jag med redis-cli FLUSHUB och API fortsatte att fungera eftersom endpoint faller tillbaka på PostgreSQL.

5. Vad händer med lösningen om PostgreSQL försvinner?
PostgreSQL är en viktig del för labben och om det försvinner så kan nya mättningar inte sparas och det historiska datan kan inte hämtas, dvs att hela API slutar fungerar. Eftersom båda POST/measurement och GET/devices/id/latest anropar devixe_exists som frågar Postgres, så en nedkoppling databas gör att båda enpoint kraschar.

6. Varför används Docker Compose lokalt?
Med hjälp av docker compose kan man starta hela systemet och kopplar ihåp API, PostgreSQL och Redis, iställer för att starata manuel och koppla alla tillsamans. Detta leder att alla tjänster kör i samma nätverk och hitta varandra.

7. Vad automatiserar din CI-pipeline?
CI-pipeline som ligger i .guthub/workflows kör atoumatisk vid varje push och pull request. Det bygger docker-images och säkertställer att trasiga kod upptäcks direkt. Pipeline hämtar kod och kör alla valideringstester. 

8. Vad observerade du när du tog bort en Kubernetes Pod?
Efte att jag tog bort poden så ändrades status till TEmination och inom några sekunder så skapades helt ny pod. Det visar att deployments övervakar antal poddat och automatiskt återsäller det om det ske ändring. 

9. Varför kan flera repliker ge högre tillgänglighet?
En replik är en kopia av appen som körs, om en finns bara en kopia och det kraschar så ligger allt nere tills det startar om. Med flera kapior som är igång samtidigt, så spelar inget roll om en kraschar, eftersom de andra förtsätter att svara. När jag tog bort en replik så de andra två tog över direkt och det ledde att sidan slutade aldrig fungera.

10. När hade Kubernetes varit overkill för en lösning?
Kubernetes kan vara en överkil för mindre projekt med en låg trafik och få användare och tjänster. för mindre projekt eller applikatoin en enklare molntjänst hade varit bättre alternativ.

Spara svaren i denna fil. Arkitekturdiagrammet lämnas separat enligt `docs/architecture.md`.
