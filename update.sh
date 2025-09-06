#!/bin/bash

# set -e: Przerywa wykonanie skryptu, jeśli którekolwiek polecenie zakończy się błędem.
# Jest to dobra praktyka, aby uniknąć nieoczekiwanych zachowań.
set -e

# --- Konfiguracja ---
LOG_FILE="/home/black/log/update.log"

# --- Funkcje ---

# Funkcja do logowania komunikatów z datą i godziną
# Używa `tee -a` do wyświetlania komunikatu na ekranie ORAZ dopisywania go do pliku logu.
log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

# --- Główna część skryptu ---

# Sprawdzenie, czy skrypt jest uruchomiony z uprawnieniami roota (administratora).
# Jeśli nie, skrypt zakończy działanie z komunikatem błędu.
if [[ "$EUID" -ne 0 ]]; then
  echo "BŁĄD: Ten skrypt musi być uruchomiony z uprawnieniami roota. Użyj 'sudo ./update.sh'" >&2
  exit 1
fi

# Upewnienie się, że katalog na plik logu istnieje.
# `mkdir -p` tworzy katalog (i nadrzędne katalogi), tylko jeśli nie istnieje.
mkdir -p "$(dirname "$LOG_FILE")"

log "--- Rozpoczęto proces aktualizacji systemu ---"

log "Krok 1/4: Aktualizacja listy pakietów (apt-get update)..."
apt-get update -y

log "Krok 2/4: Aktualizacja zainstalowanych pakietów (apt-get upgrade)..."
apt-get upgrade -y

log "Krok 3/4: Usuwanie niepotrzebnych pakietów (apt-get autoremove)..."
apt-get autoremove -y

log "Krok 4/4: Czyszczenie lokalnego repozytorium (apt-get clean)..."
apt-get clean

log "--- Proces aktualizacji zakończony pomyślnie ---"
echo "" >> "$LOG_FILE" # Dodanie pustej linii dla lepszej czytelności w logach