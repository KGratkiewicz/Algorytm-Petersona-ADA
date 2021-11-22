# Algorytm Petersona ADA
Program pokazujący implementacje oraz działanie algorytmu Petersona przy użyciu języka [ADA](https://pl.wikipedia.org/wiki/Ada_(j%C4%99zyk_programowania)). 

Plik projektowy ze środowiska [GNAT Studio | Adacore](https://www.adacore.com/gnatpro/toolsuite/gnatstudio).

## Algorytm Petersona
Algortym Petersona rozwiązuje problem wzajemnego wykluczania, czyli zapewnia własność bezpieczeństwa [programu współbieżnego](https://pl.wikipedia.org/wiki/Przetwarzanie_wsp%C3%B3%C5%82bie%C5%BCne).

### Problem wzajemnego wykluczania
Problem wzajemnego wykluczania występuje wtedy kiedy conajmniej dwa procesy, chcą skorzystać z zasobu współdzielonego. Muszą one jednak skorzystać z niego jeden po drugim, aby nie "wtrącać się" jeden drugiemu. Dostęp do takiego zasobu współdzielonego nazywa się sekcją krytyczną procesu. W naszym przypadku zasobem współdzielonym jest specjalna zmienna, o nazwie `zasob_wspoldzieloy` co widać odrazu, oraz mniej oczywiste - ekran konsoli.

```
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with RandomPackage ; use RandomPackage;
with Ada.Text_IO ; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is
   zasob_wspoldzielony : Integer := 0;
   K1, K2 : Integer := 1;
   czyja_kolej : Integer := 1;
   
   task type P1;
   task type P2;
   
   task body P1 is
      licznik : Integer := 100;
      kolumna : Positive_Count := 1;
   begin
      for i in 1..licznik loop
         -- sekcja lokalna BEG
         delay(Standard.Duration(RandomInt(3)));
         -- sekcja lokalna END
         K1 := 0;
         czyja_kolej := 2;
         while K2 = 0 and czyja_kolej = 2 loop
            null;
         end loop;
         -- sekcja krytyczna BEG
         Set_Col(kolumna);
         Put("P1 nr ");
         Put(i,3);
         Put(", odczyt : ostatnio pisal -> P");
         Put(zasob_wspoldzielony, 1);         
         zasob_wspoldzielony := 1;
         New_Line;
         -- sekcja krytyczna END
         K1 := 1;         
      end loop;
   end P1;
   
   task body P2 is
      licznik : Integer := 100;
      kolumna : Positive_Count := 45;
   begin
      for i in 1..licznik loop
         -- sekcja lokalna BEG
         delay(Standard.Duration(RandomInt(3)));
         -- sekcja lokalna END
         K2 := 0;
         czyja_kolej := 1;
         while K1 = 0 and czyja_kolej = 1 loop
            null;
         end loop;
         -- sekcja krytyczna BEG
         Set_Col(kolumna);
         Put("P2 nr ");
         Put(i,3);
         Put(", odczyt : ostatnio pisal -> P");
         Put(zasob_wspoldzielony, 1);         
         zasob_wspoldzielony := 2;
         New_Line;
         -- sekcja krytyczna END
         K2 := 1;         
      end loop;      
   end P2;
   
   
   taks1 : P1;
   task2 : P2;
begin
   null;
end Main;

```
