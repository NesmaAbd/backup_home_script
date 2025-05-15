#!/bin/bash

# Script di backup giornaliero della home directory
# Salva un archivio tar.gz in /opt/backup con rotazione settimanale (7 file)

# Variabile giorno della settimana (Monday, Tuesday, ...)
day=$(date +%A)

# Cartella home da salvare (modifica se serve)
home_dir="/home/nesma"

# Cartella di destinazione backup
backup_dir="/opt/backup"

# Nome file backup
backup_file="$backup_dir/backup-$day.tar.gz"

# Crea la cartella backup se non esiste (serve sudo)
if [ ! -d "$backup_dir" ]; then
  sudo mkdir -p "$backup_dir"
fi

# Crea il backup con tar
tar -czf "$backup_file" "$home_dir"

# Imposta permessi per permettere la lettura/scrittura
sudo chown nesma:nesma "$backup_file"
chmod 644 "$backup_file"
