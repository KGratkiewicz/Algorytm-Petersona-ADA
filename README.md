# Algorytm Petersona ADA
Program pokazujący implementacje oraz działanie algorytmu Petersona przy użyciu języka [ADA](https://pl.wikipedia.org/wiki/Ada_(j%C4%99zyk_programowania)). 

Plik projektowy ze środowiska [GNAT Studio | Adacore](https://www.adacore.com/gnatpro/toolsuite/gnatstudio).

## Algorytm Petersona
Algortym Petersona rozwiązuje problem wzajemnego wykluczania, czyli zapewnia własność bezpieczeństwa [programu współbieżnego](https://pl.wikipedia.org/wiki/Przetwarzanie_wsp%C3%B3%C5%82bie%C5%BCne).

### Problem wzajemnego wykluczania
Problem wzajemnego wykluczania występuje wtedy kiedy conajmniej dwa procesy, chcą skorzystać z zasobu współdzielonego. Muszą one jednak skorzystać z niego jeden po drugim, aby nie "wtrącać się" jeden drugiemu. Dostęp do takiego zasobu współdzielonego nazywa się sekcją krytyczną procesu. W naszym przypadku zasobem współdzielonym jest specjalna zmienna, o nazwie `zasob_wspoldzieloy` co widać odrazu, oraz mniej oczywiste - ekran konsoli.

## Działanie programu
Program ma stworzone dwa zadania (task), których zadaniem jest przeczytanie `zasob_wspoldzielony` oraz wypisanie komunikatu na ekranie w odpowiedniej kolumnie. Każde zadanie 100 razy wykonuje sekcję lokalną oraz sekcję krytyczną, oznaczoną w kodzie komentarzem. Do symulacji sekcji lokalnej użyta została funkcja opóźniająca `delay`, o losowym parametrze, alby zasymulować różnorodność trwania sekcji lokalnej w procesach.

### Output działąnia programu (fragment)
```
P1 nr  30, odczyt : ostatnio pisal -> P2
                                            P2 nr  28, odczyt : ostatnio pisal -> P1
P1 nr  31, odczyt : ostatnio pisal -> P2
                                            P2 nr  29, odczyt : ostatnio pisal -> P1
                                            P2 nr  30, odczyt : ostatnio pisal -> P2
                                            P2 nr  31, odczyt : ostatnio pisal -> P2
P1 nr  32, odczyt : ostatnio pisal -> P2
                                            P2 nr  32, odczyt : ostatnio pisal -> P1
P1 nr  33, odczyt : ostatnio pisal -> P2
P1 nr  34, odczyt : ostatnio pisal -> P1
                                            P2 nr  33, odczyt : ostatnio pisal -> P1
P1 nr  35, odczyt : ostatnio pisal -> P2
                                            P2 nr  34, odczyt : ostatnio pisal -> P1
P1 nr  36, odczyt : ostatnio pisal -> P2

```

### Kod żródłowy 

lokalizajca:

[src/main.adb](/src/main.adb) - plik główny main

[src/RandomPackage.ads](/src/RandomPackage.ads) - pakiet RandomPackage

[src/RandomPackage.adb](/src/RandomPackage.adb) - pakiet RandomPackage - ciało


---
&copy; Jakub Grątkiewicz
