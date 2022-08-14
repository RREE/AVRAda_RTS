#if !defined(__AVR_TINY__)

#include "asmdef.h" 
;#include "macros.inc"

    ASSEMBLY_CLIB_SECTION
    .global _U(ada_u32_img)
    .type   _U(ada_u32_img), @function

_U(ada_u32_img):


/* function Ada_U32_Img (val   : Unsigned_32;
                         s     : Chars_Ptr;
                         radix : Unsigned_8)
                         return Unsigned_8;
 */

#define val_lo	r22
#define val_hi	r23
#define val_hlo	r24
#define val_hhi	r25
#define str_lo	r20
#define radix	r18

#define counter	r19
#define digit	r26
#define strlen  r27
#define ltemp   r18
#define rtemp   r19

        /* X = (r26:27)
           Y = (r28:29)
           Z = (r30:31)

        Call-Used Registers

        The call-used or call-clobbered general purpose registers
	(GPRs) are registers that might be destroyed (clobbered) by a
	function call.

        R18-R27, R30, R31
        These GPRs are call clobbered. An ordinary function may use
	them without restoring the contents. Interrupt service
	routines (ISRs) must save and restore each register they use.

        R0, T-Flag
        The temporary register and the T-flag in SREG are also
	call-clobbered, but this knowledge is not exposed explicitly
	to the compiler (R0 is a fixed register).
        */

        ;; push    r28
        clr     strlen
	X_movw	ZL, str_lo

1:  ; Saves one iteration of the digit-loop:
    ; If val < radix we can use the low byte of val as digit
	mov	digit, val_lo
	cp	val_lo, radix
	cpc	val_hi, __zero_reg__
	cpc	val_hlo, __zero_reg__
	cpc	val_hhi, __zero_reg__
    ; now C is set, if val < radix
	sbc	counter, counter
	bst	counter, 0
	brts	4f
    ; counter == 0 here

    ; If val >= radix, then pop one digit from val
	clr	digit

2:  ; Vanilla 32:8 quotient and remainder to pop the digit
    ; digit <- val % radix
    ; val   <- val / radix
	lsl	val_lo
	rol	val_hi
	rol	val_hlo
	rol	val_hhi
	rol	digit
	cp	digit, radix
	brlo	3f
	sub	digit, radix
    ; val |= 1
	inc	val_lo
3:  ; Loop the 32 bits
	subi	counter, 8		; 256 / 8 == 32 loops
	brne	2b

4:  ; Convert the digit to ASCII...
	subi	digit, -'0'
	cpi	digit, '9'+1
	brlo	5f
	subi	digit, '0'-'A'+10
5:  ; ... and store it to the reversed string
	st	Z+, digit
        inc     strlen
        
    ; Popped all digits?
	brtc    1b

        ;; return the length of the string
	mov     r24, strlen

;ENTRY   __ada_strrev
    ; Reverse the string and return the length.
    ; Assumes Z pointing to the cell right after the last character in
    ; the string.
8:      X_movw	XL, str_lo	; X is start of string
                                ; Z is end of string
  ; swap bytes
9:      ld	ltemp, X
	ld	rtemp, -Z
	st	X+, rtemp
	st	Z, ltemp
10:	cp	XL, ZL
	cpc	XH, ZH
	brlo	9b
        ;; if the number of digits is odd (impair) the center digit is
	;; uselessly written twice.  We could save some cycles at the
	;; expense of additional code handling this case.
        

        ;; pop     r28
	ret

    .size _U(ada_u32_img), . - _U(ada_u32_img) 

#endif /* !defined(__AVR_TINY__) */

ENDFUNC
