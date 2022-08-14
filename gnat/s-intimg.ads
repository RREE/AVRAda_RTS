------------------------------------------------------------------------------
--                                                                          --
--                       S Y S T E M . I N T _ I M G                        --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 2013, Rolf Ebert                                  --
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
------------------------------------------------------------------------------

with Interfaces;

package System.Int_Img is
   pragma Pure;
   --  The function U32_Img converts an unsigned value into a text
   --  representation.
   --
   --  Value ist the value to be converted.
   --
   --  Buf points to a string buffer.  The actual strings starts at
   --  Buf+1, leaving space for a sign.
   --
   --  Radix is the number base in the range of 2 .. 36.
   --
   --  The return value is length+1 of the generated string

   type Radix_Range is range 2 .. 36;
   for Radix_Range'Size use 8;

   function U32_Img (Value : Interfaces.Unsigned_32; -- value to be converted
                     Buf   : not null access Character;  --  to buffer
                     Radix : Radix_Range := 10)      -- range 2 .. 36
                    return Interfaces.Unsigned_8;   -- (length+1) of the string
   pragma Import (C, U32_Img, "ada_u32_img");
   pragma Pure_Function (U32_Img);

end System.Int_Img;
