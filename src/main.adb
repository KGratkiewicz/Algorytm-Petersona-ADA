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
         Put(i,1);
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
      kolumna : Positive_Count := 40;
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
         Put(i,1);
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
