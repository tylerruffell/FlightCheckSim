package Controls is
   type Altitude_Meters is new Integer;
   type Speed_Knots     is new Integer;

   function Set_Altitude(New_Alt : Integer) return Altitude_Meters;
   function Set_Speed(New_Spd : Integer) return Speed_Knots;
end Controls;
