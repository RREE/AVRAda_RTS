--  see http://gcc.gnu.org/onlinedocs/gcc/AVR-Built_002din-Functions.html

with Interfaces;

package System.GCC_Builtins is
   pragma Pure;

   subtype U8 is Interfaces.Unsigned_8;
   subtype I8 is Interfaces.Integer_8;
   subtype U16 is Interfaces.Unsigned_16;
   subtype I16 is Interfaces.Integer_16;
   subtype U32 is Interfaces.Unsigned_32;
   subtype U64 is Interfaces.Unsigned_64;

   procedure nop;
   procedure sei;
   procedure cli;
   procedure sleep;
   procedure wdr;
   function swap (B : U8) return U8;
   function fmul (Left, Right : U8) return U16;
   function fmuls (Left, Right : I8) return I16;
   function fmulsu (Left : I8; Right : U8) return I16;
   procedure delay_cycles (Ticks : U32);
   function map8 (map : U32; val : U8) return U8;
   function map16 (map : U64; val : U16) return U16;

private

   pragma Inline_Always (nop);
   pragma Inline_Always (sei);
   pragma Inline_Always (cli);
   pragma Inline_Always (sleep);
   pragma Inline_Always (wdr);
   pragma Inline_Always (swap);

   pragma Import (Intrinsic, nop, "__builtin_avr_nop");
   pragma Import (Intrinsic, sei, "__builtin_avr_sei");
   pragma Import (Intrinsic, cli, "__builtin_avr_cli");
   pragma Import (Intrinsic, sleep, "__builtin_avr_sleep");
   pragma Import (Intrinsic, wdr, "__builtin_avr_wdr");
   pragma Import (Intrinsic, swap, "__builtin_avr_swap");
   pragma Import (Intrinsic, fmul, "__builtin_avr_fmul");
   pragma Import (Intrinsic, fmuls, "__builtin_avr_fmuls");
   pragma Import (Intrinsic, fmulsu, "__builtin_avr_fmulsu");
   pragma Import (Intrinsic, delay_cycles, "__builtin_avr_delay_cycles");
   pragma Import (Intrinsic, map8, "__builtin_avr_map8");
   pragma Import (Intrinsic, map16, "__builtin_avr_map16");

end System.GCC_Builtins;
