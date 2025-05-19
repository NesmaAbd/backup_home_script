# Backup Home Script

Questo progetto contiene uno script bash per eseguire backup giornalieri della cartella home dell'utente.

---

## Come funziona

- Lo script crea un archivio compresso `.tar.gz` della cartella home (`/home/nesma`).
- Il backup viene salvato nella cartella `/opt/backup/` con un nome che cambia in base al giorno della settimana (es. backup-Monday.tar.gz).
- Si mantiene una rotazione settimanale con massimo 7 file (uno per ogni giorno).

---

## Comandi principali usati

- `day=$(date +%A)` : ottiene il nome del giorno della settimana.
- `tar -czf backup-file.tar.gz /home/nesma` : crea un archivio compresso della cartella home.
- `sudo mkdir -p /opt/backup` : crea la cartella di destinazione se non esiste.
- `sudo chown nesma:nesma` e `chmod 644` : assicurano i permessi corretti al file di backup.

---

## Come usare lo script

1. Copiare il seguente script e salvarlo in un file chiamato `backup_home.sh`:
```
#!/bin/bash

# Cartella Home
SOURCE_DIR="/home/nesma"

# Cartella dove salvare i backup
DEST_DIR="/opt/backup"

# Giorno della settimana in minuscolo (lunedi, martedi, ecc.)
DAY_NAME=$(date +%A | tr '[:upper:]' '[:lower:]')

# Nome del file di backup
BACKUP_FILE="$DEST_DIR/backup-$DAY_NAME.tar.gz"

# Crea la cartella di destinazione se non esiste
sudo mkdir -p "$DEST_DIR"

# Elimina i backup più vecchi di 7 giorni
sudo find "$DEST_DIR" -name "backup-*.tar.gz" -type f -mtime +7 -exec rm {} \;

# Esegui il backup
sudo tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

```

> N.B. : ricordati dove hai salvato `backup_home.sh`, ovvero il percorso dove si trova il file.

2. Rendere eseguibile il file:

   ```bash
   chmod +x il-tuo-percorso/backup_home.sh
   ```

3. Creare la cartella di backup (con permessi di root):

   ```bash
   sudo mkdir -p /opt/backup
   sudo chown nesma:nesma /opt/backup
   ```

4. Eseguire manualmente lo script per testarlo:

   ```bash
   il-tuo-percorso/backup_home.sh
   ```

5. Configurare cron come utente root per eseguire il backup automaticamente ogni giorno alle 3:00:

   ```bash
   sudo crontab -e
   ```

   una volta aperto l'editor aggiungere la seguente riga:
   ```
   0 3 * * * /home/nesma/scripts/backup_home.sh >> /home/nesma/scripts/backup.log 2>&1
   ```

---

## Problemi risolti

- Permessi di scrittura nella cartella `/opt/backup`: si è usato `sudo` per creare la cartella e assegnare i permessi.
- Eliminazione backup più vecchi di sette giorni.

---

## Autore

Nesma

---
