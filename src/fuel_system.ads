with controls; use controls;

package Fuel_System is

   type Fuel_Percent is range 0 .. 100;

   -- Consume fuel based on speed and altitude
   function Consume_Fuel(Current : Fuel_Percent; 
                         Speed   : Speed_Knots; 
                         Alt     : Altitude_Meters) return Fuel_Percent;

end Fuel_System;
