------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                       A D A . E X C E P T I O N S                        --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1992-2011, Free Software Foundation, Inc.         --
--          Copyright (C) 2012, 2022 Rolf Ebert                             --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

package body Ada.Exceptions is

   procedure Reset;
   pragma Import (Ada, Reset);
   for Reset'Address use System.Null_Address;
   pragma No_Return (Reset);

   procedure Default_Handler (Msg : System.Address; Line : Integer);
   pragma Export (C, Default_Handler, "__gnat_last_chance_handler");
   pragma Weak_External (Default_Handler);
   pragma No_Return (Default_Handler);

   procedure Default_Handler (Msg : System.Address; Line : Integer) is
      pragma Unreferenced (Msg);
      pragma Unreferenced (Line);
   begin
      Reset;
   end Default_Handler;

   procedure Last_Chance_Handler (Msg : System.Address; Line : Integer);
   pragma Import (C, Last_Chance_Handler, "__gnat_last_chance_handler");
   pragma No_Return (Last_Chance_Handler);

   procedure Raise_Exception (E : Exception_Id; Message : String := "") is
      pragma Unreferenced (E);
   begin
      Last_Chance_Handler (Message'Address, 0);
   end Raise_Exception;

end Ada.Exceptions;
