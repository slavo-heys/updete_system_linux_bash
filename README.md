# Skrypt Aktualizacyjny dla Systemów Debian/Ubuntu

Prosty, ale solidny skrypt Bash do automatyzacji procesu aktualizacji i czyszczenia systemu na dystrybucjach opartych na Debianie (takich jak Ubuntu, Linux Mint itp.). Idealny do uruchamiania ręcznego lub jako zadanie cron.

## Opis

Skrypt wykonuje pełen cykl konserwacji systemu za pomocą menedżera pakietów apt-get, wykonując po kolei następujące kroki:

1.  **`apt-get update`**: Odświeża listę dostępnych pakietów.
2.  **`apt-get upgrade`**: Aktualizuje wszystkie zainstalowane pakiety do najnowszych wersji.
3.  **`apt-get autoremove`**: Usuwa pakiety, które zostały zainstalowane jako zależności, ale nie są już potrzebne.
4.  **`apt-get clean`**: Czyści lokalne repozytorium z pobranych plików pakietów (`.deb`), zwalniając miejsce na dysku.

## Kluczowe Funkcjonalności

*   **Bezpieczeństwo i Niezawodność**: Dzięki `set -e` skrypt natychmiast przerywa działanie, jeśli którekolwiek z poleceń zakończy się błędem. Zapobiega to kontynuacji procesu w nieprzewidywalnym stanie.
*   **Szczegółowe Logowanie**: Każda operacja jest zapisywana wraz ze znacznikiem czasu do pliku logu (domyślnie `/home/black/log/update.log`). Ułatwia to śledzenie historii aktualizacji i diagnozowanie ewentualnych problemów.
*   **Sprawdzanie Uprawnień**: Skrypt automatycznie weryfikuje, czy jest uruchomiony z uprawnieniami administratora (`root`). Jeśli nie, wyświetla stosowny komunikat i kończy działanie.
*   **Automatyczne Tworzenie Katalogu**: Skrypt sam tworzy katalog na plik logu, jeśli ten nie istnieje, co zapobiega błędom przy pierwszym uruchomieniu.
*   **Czytelność**: Kod jest dobrze zorganizowany, wykorzystuje funkcje i zawiera komentarze, co ułatwia jego zrozumienie i ewentualne modyfikacje.

## Konfiguracja

Możesz łatwo zmienić ścieżkę do pliku logu, modyfikując zmienną `LOG_FILE` na początku skryptu:

```bash
LOG_FILE="/twoja/wlasna/sciezka/do/update.log"
```

---

## Jak uruchomić skrypt?

Aby uruchomić skrypt, wykonaj poniższe kroki w terminalu:

1.  **Nadaj plikowi uprawnienia do wykonania:**
    ```bash
    chmod +x update.sh
    ```
2.  **Uruchom skrypt z uprawnieniami administratora (`sudo`):**
    ```bash
    sudo ./update.sh
    ```


Skrypt rozpocznie proces aktualizacji, wyświetlając postęp na ekranie i jednocześnie zapisując go do pliku logu.
