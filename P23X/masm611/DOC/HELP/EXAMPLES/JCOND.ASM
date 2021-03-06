;* JCOND.ASM (conditional jump) shows how to transfer execution
;* conditionally with jump instructions. The code is arranged as
;* a program so that you can trace through it and change registers
;* to test alternate results. Many of the conditional jump instructions
;* are illustrated.
;*
;* See IFS.ASM for an example of how to do similar jumps using .IF and
;* related directives. See JUMP.ASM for an example of the related JMP
;* instruction. See
;*
;*
;* Shows:   cmp        test
;*          jb/jnae    jae/jnb    jbe/jna    ja/jnbe    (unsigned)
;*          jl/jnge    jge/jnl    jle/jng    jg/jnle    (signed)
;*          je/jz      js         jns                   (equality and sign)
;*          jc         jnc        jo         jno        (carry and overflow)
;*          jp/jpe     jnp/jpo                          (parity)

        .MODEL small, c, os_dos

showcx  MACRO
        push    ax
        push    dx
        mov     number, cl
        add     number, '0'
        mov     dx, OFFSET msg
        mov     ah, 09h
        int     21h
        pop     dx
        pop     ax
ENDM

        .STACK
        .DATA
msg     BYTE    "CX is: "
number  BYTE    0, 13, 10, "$"
        .CODE
        .STARTUP

        mov     ax, 1   ; Initialize arbitrary registers for comparisons
        mov     bx, 2
        mov     cx, 1

        cmp     ax, bx  ; Compare unsigned relative values
        jb      below   ; Jump if unsigned AX is below unsigned BX
        je      equal
above:
        inc     cx      ; If not below and not equal, must be above
equal:
        inc     cx      ; Jump to here if equal
below:
        inc     cx      ; Jump here if below
        showcx

        cmp     ax, bx  ; Compare signed relative values
        jl      less    ; Jump if signed AX is less than signed BX
        jg      more
        inc     cx      ; If not less or more, must be equal
less:
        inc     cx      ; Jump here if less
more:
        inc     cx      ; Jump here if more
        showcx

        sub     ax, 2   ; Set flags for sign test
        js      sign    ; Jump if sign flag is set
nosign:
        add     cx, 1   ; Sign not set, so positive number
sign:
        add     cx, -1  ; Sign set for negative.

        sub     bx, 3   ; Set flags for carry test (make BX = -1)
        jc      yescarry; Jump if carry flag is set
nocarry:
        inc     cx      ; Subtraction causes carry
yescarry:
        dec     cx      ; Subtraction doesn't cause carry
        showcx

        mov     al, 254 ; Prepare for multiply
        mul     bl      ; Set flags with multiply of AL x BL
        jo      overflow; Jump if overflow flag is set
nooverflow:
        inc     cx      ; No overflow
overflow:
        inc     cx      ; Jump not taken, so this line is executed
        showcx

        test    bx, 010y; Test bit 1
        jnz     on      ; Jump it bit 1 is set
off:
        inc     cx
on:
        cmp     ax, bx  ; Set flags for parity check
        jp      peven   ; Jump if parity flag is set (parity even)
podd:
        inc     cx      ; Odd number of set bits in low byte of result
peven:
        inc     cx      ; Even number of set bits in low byte of result
        showcx

        .EXIT           ; Terminate program

        END
