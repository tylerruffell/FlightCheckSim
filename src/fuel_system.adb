with controls; use controls;
with Ada.Numerics.Float_Random;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

package body Fuel_System is

   function Consume_Fuel(Current : Fuel_Percent; 
                         Speed   : Speed_Knots; 
                         Alt     : Altitude_Meters) return Fuel_Percent is
      Fuel_Loss : Float;
   begin
      -- Example formula: faster speed and higher altitude consume more fuel
      Fuel_Loss := Float(Speed) / 10.0 + Float(Alt) / 1000.0;

      -- Subtract fuel loss safely and clamp to 0..100
      if Float(Current) - Fuel_Loss < 0.0 then
         return Fuel_Percent(0);
      else
         return Fuel_Percent(Float(Current) - Fuel_Loss);
      end if;
   end Consume_Fuel;

end Fuel_System;
