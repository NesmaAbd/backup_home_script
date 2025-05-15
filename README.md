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

1. Copiare lo script in `/home/nesma/scripts/backup_home.sh`
2. Rendersi eseguibile con:

   ```bash
   chmod +x /home/nesma/scripts/backup_home.sh
   ```

3. Creare la cartella di backup (con permessi di root):

   ```bash
   sudo mkdir -p /opt/backup
   sudo chown nesma:nesma /opt/backup
   ```

4. Eseguire manualmente lo script per testarlo:

   ```bash
   /home/nesma/scripts/backup_home.sh
   ```

5. Configurare cron per eseguire il backup automaticamente ogni giorno alle 3:00:

   ```bash
   crontab -e
   ```

   aggiungere questa riga:

   ```
   0 3 * * * /home/nesma/scripts/backup_home.sh >> /home/nesma/scripts/backup.log 2>&1
   ```

---

## Problemi risolti

- Permessi di scrittura nella cartella `/opt/backup`: si è usato `sudo` per creare la cartella e assegnare i permessi.
- File di log per monitorare l'esecuzione dello script da cron.
- Rotazione settimanale automatica del backup con nomi diversi in base al giorno.

---

## Come migliorare

- Aggiungere notifiche email in caso di errori.
- Aggiungere compressione più efficiente o backup incrementali.
- Backup remoto su server o cloud.

---

## Autore

Nesma

---
