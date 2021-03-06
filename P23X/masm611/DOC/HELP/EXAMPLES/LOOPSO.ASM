;* LOOPSO.ASM - Illustrates the old method of generating loops.
;* For an example of new method using high-level control directives,
;* See LOOPS.ASM.
;*
;* Shows:  Instructions - LOOP      LOOPNE

        .MODEL  small, c, os_dos        ; Small model (could be any model)
        .DOSSEG                         ; Force DOS segment order
        .STACK
        .DATA
msg1    BYTE    13, 10, "Iteration: "   ; Iteration message
num1    BYTE    0, "$"                  ; Place holder for iteration byte
msg2    BYTE    13, 10, "Alphabet: $"   ; Alphabet message
num2    BYTE    0, " $"                 ; Place holder
msg3    BYTE    13, 10, "Type digits, then press ENTER: $"

        .CODE
        .STARTUP                        ; Initialize

; A simple loop that repeats until CX is zero.

        mov     cx, 9
        sub     bl, bl
next1:
        mov     bl, 10                  ; Calculate iteration number
        sub     bl, cl
        mov     num1, bl                ; Copy number to memory
        add     num1, '0'               ; Convert to ASCII

        mov     ah, 09h                 ; Request DOS Function 9
        mov     dx, OFFSET msg1         ; Load offset of string
        int     21h                     ; Display string
        loop    next1

; This conditional loop does its test at the end. It will always execute
; at least once, regardless of entry conditions.

        mov     dx, OFFSET msg2         ; Load offset of string
        int     21h                     ; Display string
        mov     bl, 'a'
next2:                                  ; While lowercase letter:
        mov     num2, bl                ; Copy letter to memory
        inc     bl                      ; Next letter
        mov     dl, bl                  ; Load for display

        mov     ah, 09h                 ; Request DOS Function 9
        mov     dx, OFFSET num2         ; Load offset of string
        int     21h                     ; Display string
        cmp     bl, 'z' + 1             ; Conditional loop can only test
        loopne  next2                   ;  for equality

        mov     ah, 09h                 ; Request DOS Function 9
        mov     dx, OFFSET msg3         ; Load offset of string
        int     21h                     ; Display string

; A common loop in assembler is one with the conditional test in the
; middle. This loop has two tests--one that breaks and one that
; continues to the top of the loop.

next3:
        mov     ah, 07h                 ; Get key without echo
        int     21h

        cmp     al, 0Dh                 ; Terminate if ENTER
        je      next4
        cmp     al, '0'                 ; Skip if not digit
        jb      next3
        cmp     al, '9'
        ja      next3

        mov     dl, al                  ; Copy
        mov     ah, 02h                 ; Output character
        int     21h
        jmp     next3
next4:
        .EXIT   0                       ; Exit  with return code 0

        END
