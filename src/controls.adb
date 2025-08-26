package body Controls is
   function Set_Altitude(New_Alt : Integer) return Altitude_Meters is
   begin
      return Altitude_Meters(New_Alt);
   end Set_Altitude;

   function Set_Speed(New_Spd : Integer) return Speed_Knots is
   begin
      return Speed_Knots(New_Spd);
   end Set_Speed;
end Controls;
