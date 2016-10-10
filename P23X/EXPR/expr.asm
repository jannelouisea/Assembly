;-----------------------------------------------------------------
;   program:    EXPR *MASM* version
;
;   function:   The program dtermines the validity of a simple expression.
;
;   input:	The program is initialized by typing in 'EXPR' into the commaned line.
;		ASCII text files are inputs for the program and all output for the
;		program will be directed to a text file.
;
;   owner:      Janne Louise Ave (jfave)
;
;   date:       10/01/2016
;
;   10/01/16    First lines written
;   10/02/16	Translate table works!
;----------------------------------------------------------------
	.model	small						; 64k code and 64k data
      	.8086							; only allow 8086 instructions
      	.stack	256						; reserve 256 bytes for the stack
;----------------------------------------------------------------
      	.data							; start the data segment
;----------------------------------------------------------------
; Initializes variables used in the program
;----------------------------------------------------------------
end_file	db	1Ah					; If program raches EOF exit out of program
validmsg	db	'LINE IS VALID',13,10,13,10,'$'		; message for valid expression
infmt		db	'INVALID FORMAT',13,10,13,10,'$'	; message for exxpression with invalid format
invar		db	'INVALID VARIABLE',13,10,13,10,'$'	; message for expression with invlalid variable
;----------------------------------------------------------------
; Translate-table
; tran is a table with 256 entries (0 - 255)
; ASCII Characters from 0h to 1Fh will be translated
; into an '*' char, EXCLUDING CR & LF (0Ah 0Dh)
; Characters through 20h through 7F will be assigned 
; a number value based on what input they count as:
; Valid Operand (A - Z) -> 1
; Space: ' ' -> 2 
; Valid Operator (+ - =) -> 3
; Carriage Return: 0Dh -> 4
; Other -> 5
; Values 128 - 166 will corresponding to values from
; a statetransiton table made from a Finite State Machine 
; for this program.
; There are 8 states that are translated froma FSm to the XLAT Table
; State 0: Start of Line 			-> Decimal Value 128
; State 1: Looking for Operand (Start of Line) 	-> Decimal Value 134
; State 2: Looking for Operand (Middle of Line)	-> Decimal Value 140
; State 3: Started an Operand			-> Decimal Value 146
; State 4: Looking for Operator			-> Decimal Value 152
; State 5: Started an Operator			-> Decimal Value 158
; State 6: Line is Valid			-> Decimal Value 164
; State 7: Invalid Format			-> Decimal Value 165
; State 8: Invaid Variable			-> Decimal Value 166
;----------------------------------------------------------------
tran	db	13	dup	('*')				; for ASCII chars (0-12) -> '*'
	db	(4)						; Carriage Return char (CR) -> Decimal value 4	
	db	18	dup	('*')				; for ASCII chars (14-31) -> '*'
	db	(2)						; Space char ( ) -> Decimal value 2
	db	10	dup	(5)				; ASCII chars (33-42) are invlaid inputs -> 
								; Decimal value 5
	db	(3)						; '+' is a Valid Operator -> Decimal value 3
	db	(5)						; ',' is an Invalid Input (Other) ->
								; Decimal value 5
	db	(3)						; '-' is a Valid Operator -> Decimal value 3
	db	15	dup	(5)				; ASCII chars (46-60) are invalid inputs ->
								; Decimal value 5
	db	(3)						; '=' is a Valid Operator -> Decimal value 3
	db 	3	dup	(5)				; ASCII chars (62-64) are invalid inputs ->
								; Decimal value 5 
	db	26	dup	(1)				; 'A'-'Z' are Valid Operands -> Decimal value 1
	db	37	dup	(5)				; ASCII chars (91-127) are invalid inputs ->
								; Decimal value 5
	db	(128)						; 128 -> State 0
	db	(146)						; 129 -> State 0 + Valid Operand 	= State 3
	db	(134)						; 130 -> State 0 + Space 		= State 1 
	db	(165)						; 131 -> State 0 + Valid Operator	= State 7
	db	(164)						; 132 -> State 0 + CR			= State 6
	db	(165)						; 133 -> State 0 + Other		= State 7
								;
	db	(134) 						; 134 -> State 1
	db	(146)						; 135 -> State 1 + Valid Operand 	= State 3
	db	(134)						; 136 -> State 1 + Space 		= State 1 
	db	(165)						; 137 -> State 1 + Valid Operator	= State 7
	db	(164)						; 138 -> State 1 + CR			= State 6
	db	(165)						; 139 -> State 1 + Other		= State 7
		        					;
	db	(140)						; 140 -> State 2
	db	(146)						; 141 -> State 2 + Valid Operand 	= State 3
	db	(140)						; 142 -> State 2 + Space 		= State 2 
	db	(165)						; 143 -> State 2 + Valid Operator	= State 7
	db	(165)						; 144 -> State 2 + CR			= State 7
	db	(165)						; 145 -> State 2 + Other		= State 7
		        					;
	db	(146)						; 146 -> State 3
	db	(166)						; 147 -> State 3 + Valid Operand 	= State 8
	db	(152)						; 148 -> State 3 + Space 		= State 4 
	db	(166)						; 149 -> State 3 + Valid Operator	= State 8
	db	(164)						; 150 -> State 3 + CR			= State 6
	db	(166)						; 151 -> State 3 + Other		= State 8
		        					;
	db	(152)						; 152 -> State 4
	db	(165)						; 153 -> State 4 + Valid Operand 	= State 7
	db	(152)						; 154 -> State 4 + Space 		= State 4 
	db	(158)						; 155 -> State 4 + Valid Operator	= State 5
	db	(164)						; 156 -> State 4 + CR			= State 6
	db	(165)						; 157 -> State 4 + Other		= State 7

	db	(158)						; 158 -> State 5
	db	(165)						; 159 -> State 5 + Valid Operand 	= State 7
	db	(140)						; 160 -> State 5 + Space 		= State 2 
	db	(165)						; 161 -> State 5 + Valid Operator	= State 7
	db	(165)						; 162 -> State 5 + CR			= State 7
	db	(165)						; 163 -> State 5 + Other		= State 7
		        					;
	db	(164)						; 164 -> State 6
	db	(165)						; 165 -> State 7
	db	(166)						; 166 -> State 8
								;
	db	89	dup	('*')				; ASCII chars (161-255) -> '*'
;----------------------------------------------------------------
	.code							; 
;----------------------------------------------------------------
; Initialize program execution
;----------------------------------------------------------------
start:								;
	mov		ax,@data				; establish addressability to the 
	mov		ds,ax					; data segment for this program
	mov 		bx,offset tran				; bx points to the table
;----------------------------------------------------------------
; Set state to start at 128 (Start of New Line)
;----------------------------------------------------------------
newexpr:							;
	mov		cl,128					; set the current state to start at State 0
;----------------------------------------------------------------
; Read/Echo/Process Line
;----------------------------------------------------------------
verify:								;
	mov		ah,8					; set ah=1 to request a character with out echo
	int		21h					; call DOS and the character will be returned in al
								; the character read and echoed is now in the al register
	mov		dl,al					; copy char recieved into dl
	mov		ah,2					; set ah=2 to request a character written
	int		21h					; call DOS and the character in dl will be written	
;----------------------------------------------------------------
	cmp		al,[end_file]				; Has EOF been 
	je		exit					; If so go to exit
	xlat							; translate input character
	add		al,cl					; add translated char to current state to get new state
	jc		error					; if an unsigned overflow occured then go to error
	xlat							; translate new state
	mov		cl,al					; set translated state (in al) to current state
	cmp		cl,163					; compare current state to 157 (number before end states)
	ja		endstate				; if state was greater than 157 go to end state
	jbe		verify					; if state was not one of the end states (158-160) read in next char
;----------------------------------------------------------------
; An End State has been reached
; First print out the rest of the character until
; LF has been reached
;----------------------------------------------------------------
endstate:							;
	mov		ah,8					; set ah=1 to request a character with out echo
	int		21h					; call DOS and the character will be returned in al
								; the character read and echoed is now in the al register
	mov		dl,al					; copy char recieved into dl
	mov		ah,2					; set ah=2 to request a character written
;----------------------------------------------------------------
	int		21h					; call DOS and the character in dl will be written	
	cmp		al,10					; Was the last character LF? 
	je		whichmessage				; If so go print out message
	jne		endstate				; If not keep on reading the rest of the input
;----------------------------------------------------------------
; Print a message
; If end state 164 -> Print 'LINE IS VALID'
; If end state 165 -> Print 'INVALID FORMAT'
; If end state 166 -> Print 'INVALID VARIABLE'
;----------------------------------------------------------------
whichmessage:							;		
	cmp		cl,164					; Was the end state -> State 5?
	je		validexpr				; if so go to valid exprssion
	cmp		cl,165					; Was the end state -> State 6?
	je		infmtexpr				; if so go to invalid format expression
	cmp 		cl,166					; Was the end state -> State 7?
	je		invarexpr				; if so go to invalid message expression
;----------------------------------------------------------------
; Expression was valid point dx to valid expression message
;----------------------------------------------------------------
validexpr:							;
	mov		dx, offset validmsg			; dx points to valid expression message
	mov		ah,9					; set ah=9 to request to write a string
	int 		21h					; call DOS and print message
	jmp		newexpr					; read in inputs for next line
;----------------------------------------------------------------
; Expression was invalid point dx to invalid format expression message
;----------------------------------------------------------------
infmtexpr:							;
	mov		dx, offset infmt			; dx points to valid expression message
	mov		ah,9					; set ah=9 to request to write a string
	int 		21h					; call DOS and print message
	jmp		newexpr					; read in inputs for next line
;----------------------------------------------------------------
; Expression was invalid point dx to invalid variable expression message
;----------------------------------------------------------------
invarexpr:							;
	mov		dx, offset invar			; dx points to valid expression message
	mov		ah,9					; set ah=9 to request to write a string
	int 		21h					; call DOS and print message
	jmp		newexpr					; read in inputs for next line
;----------------------------------------------------------------
; Unsigned overflow occured
;----------------------------------------------------------------
error:								;
	errormsg	db	'Overflow$'			; message for unsigned overflow
	mov		dx, offset errormsg			; dx points to error message
	mov		ah,9					; set ah=9 to request to write a string
	int 		21h					; call DOS and print message
	jmp		exit					; terminate program
;----------------------------------------------------------------
; Terminate program execution
;----------------------------------------------------------------
exit:								;
         mov		ax,4c00h				; set correct exit code in ax
         int       	21h					; int 21h will terminate program
         end       	start					; execution begins at the label start
;----------------------------------------------------------------
