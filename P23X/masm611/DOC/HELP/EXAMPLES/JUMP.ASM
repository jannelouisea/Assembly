;* JUMP.ASM (unconditional jump) - The following code illustrates how to
;* transfer execution to another statement with the JMP instruction. The
;* code is arranged as a program so that you can trace through it with a
;* debugger. See JCOND.ASM for examples of conditional jump instructions.
;*
;* Shows:   jmp

        .MODEL small, c, os_dos
        .STACK
        .CODE
        .STARTUP

; Jump to a destination (LBL2) within 128 bytes.
	mov     ax, 1           ; Make AX = 1
        jmp     lbl2            ; Skip short
lbl1:
        mov     ax, 2           ; Never executed
lbl2:                           ; SHORT destination

; Jump to a "near" destination (between 128 and 32,767 bytes away)
        mov     bx, 2
        jmp     label3          ; Jump near over the next section
;       .                       ; Represents more than
;       .                       ;   128 bytes
;       .                       ;   of code
        mov     bx, 5           ; Never executed
label3:                         ; Near destination

; A dispatch table (jump table in this case). See the MISCDEMO.ASM example
; program for a similar call table. Dispatch tables are arrays of addresses.
; An input value (such as a keystroke) is used to calculate the index of
; the destination address.

        .DATA
table   WORD    dst4            ; Offset for dst4 (index 0)
        WORD    dst5            ; Offset for dst5 (index 2)
        WORD    dst6            ; Offset for dst6 (index 4)
prompt  BYTE    13, 10, 'Type a number between 4 and 6 . . .  $'
disp    BYTE    13, 10, 13, 10, 'You chose '
num     BYTE    ?, 13, 10, '$'

        .CODE
        mov     ah, 9           ; Request string display
        mov     dx, OFFSET prompt
        int     21h             ; Display String
cons:
        mov     ah, 7           ; Request console input without echo
        int     21h             ; Get Console Input
        cmp     al, '4'         ; Make sure it's between 4 and 6
        jb      cons
        cmp     al, '6'
        ja      cons
        sub     al, '4'         ; Convert to binary number
        shl     al, 1           ; Convert byte index to word index
        sub     ah, ah          ; Clear AX high byte
        mov     bx, ax          ; Copy to BX for index

        jmp     table[bx]       ; Jump to table address with correct label

dst4:
        mov     num, '4'        ; Copy 4 to string
        jmp     SHORT done
dst5:
        mov     num, '5'        ; Copy 5 to string
        jmp     SHORT done
dst6:
        mov     num, '6'        ; Copy 6 to string
done:
        mov     ah, 9           ; Request $-terminated string display
        mov     dx, OFFSET disp
        int     21h             ; Display String

        .EXIT   num             ; Terminate program with num as return code

        END
