with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Real_Time;          use Ada.Real_Time;
with Controls;               use Controls;
with Fuel_System;            use Fuel_System;

procedure Main is
   Alt  : Altitude_Meters := 0;
   Spd  : Speed_Knots     := 0;
   Choice : Integer;

   -----------------------------
   -- Protected object to manage fuel safely
   -----------------------------
   protected Fuel_Store is
      entry Consume(Spd : Speed_Knots; Alt : Altitude_Meters);
      function Get return Fuel_Percent;
   private
      Fuel : Fuel_Percent := 100;
   end Fuel_Store;

   protected body Fuel_Store is
      entry Consume(Spd : Speed_Knots; Alt : Altitude_Meters) when Fuel > Fuel_Percent'First is
      begin
         Fuel := Fuel_System.Consume_Fuel(Fuel, Spd, Alt);
      end Consume;

      function Get return Fuel_Percent is
      begin
         return Fuel;
      end Get;
   end Fuel_Store;

   -----------------------------
   -- Task decreases fuel automatically
   -----------------------------
   task Fuel_Task;
   task body Fuel_Task is
   begin
      loop
         delay 1.0;  -- every second
         Fuel_Store.Consume(Spd, Alt);
         if Fuel_Store.Get = Fuel_Percent'First then
            Put_Line("WARNING: Out of fuel! Engine shutting down...");
            exit;
         end if;
      end loop;
   end Fuel_Task;

   -----------------------------
   -- Clears terminal screen
   -----------------------------
   procedure Clear_Screen is
   begin
      Put(ASCII.ESC & "[2J" & ASCII.ESC & "[H");
   end Clear_Screen;

   -----------------------------
   -- Shared variable for signaling exit
   -----------------------------
   Done : Boolean := False;

   -----------------------------
   -- Task to update display
   -----------------------------
   task Display_Task;
   task body Display_Task is
   begin
      loop
         exit when Done;
         Clear_Screen;
         Put_Line("=== Jet Control Simulator ===");
         Put_Line("-------------------------------");
         Put_Line("Altitude: " & Integer'Image(Integer(Alt)) & " m");
         Put_Line("Speed:    " & Integer'Image(Integer(Spd)) & " knots");
         Put_Line("Fuel:     " & Integer'Image(Integer(Fuel_Store.Get)) & "%");
         New_Line;
         Put_Line("Controls:");
         Put_Line("1) Set Altitude");
         Put_Line("2) Set Speed");
         Put_Line("0) Quit");
         Put("Enter choice: ");
         New_Line;
         delay 10.0;
      end loop;
   end Display_Task;

begin
   loop
      Put("Enter choice: ");
      Get(Choice);

      case Choice is
         when 1 =>
            declare
               New_Alt : Integer;
            begin
               Put("Enter new altitude (m): "); Get(New_Alt);
               Alt := Set_Altitude(New_Alt);
            end;

         when 2 =>
            declare
               New_Spd : Integer;
            begin
               Put("Enter new speed (knots): "); Get(New_Spd);
               Spd := Set_Speed(New_Spd);
            end;

         when 0 =>
            Done := True;
            Put_Line("Exiting simulator...");
            exit;

         when others =>
            Put_Line("Invalid option.");
      end case;
   end loop;
end Main;