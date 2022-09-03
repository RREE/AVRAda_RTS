------------------------------------------------------------------------------
--                                                                          --
--                 GNAT RUN-TIME LIBRARY (GNARL) COMPONENTS                 --
--                                                                          --
--                   A D A . C A L E N D A R . D E L A Y S                  --
--                                                                          --
--                                  S p e c                                 --
--                                                                          --
--          Copyright (C) 1992-2005, Free Software Foundation, Inc.         --
--                                                                          --
-- GNARL is free software; you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion. GNARL is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNARL; see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
-- GNARL was developed by the GNARL team at Florida State University.       --
-- Extensive contributions were provided by Ada Core Technologies, Inc.     --
--                                                                          --
------------------------------------------------------------------------------

--  This package implements Calendar.Time delays using AVR.Real_Time.Delays.

--  Note: the compiler generates direct calls to this interface, in the
--  processing of time types.
with Interfaces;
package Ada.Calendar.Delays is

   --  The type declarations here have to match the corresponding type
   --  declarations in AVR.Real_Time.

   subtype Day_Count is Interfaces.Integer_16;
   --     type Duration is delta 0.001 digits 9 range -24.0 * 3600.0
   --  .. 48.0 * 3600.0;
   --     for Duration'Size use 32;

   type Time is record
      Days : Day_Count;
      Secs : Duration;
   end record;

   procedure Delay_For (D : Duration);
   --  Delay until an interval of length (at least) D seconds has passed,

   procedure Delay_Until (T : Time);
   --  Delay until Clock has reached (at least) time T,

private
   pragma Import (Ada, Delay_For, "ada__calendar__delays__delay_for");
   pragma Import (Ada, Delay_Until, "ada__calendar__delays__delay_until");
end Ada.Calendar.Delays;
