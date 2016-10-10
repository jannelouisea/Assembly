;-----------------------------------------------------------------
;   program:    KEY *MASM* version
;
;   function:   Reads printable characters (20h-7Fh) from the Standard Input
;               (keyboard or a redirected ASCII text file) without echo 
;               (using ah=08h and int 21h). The characters are processed one
;               at a time, immediately, as the are read the program will
;               if the character is transformed and/or printed to standard
;               output. The program ends when the user enters a period.
;		The only characters that will be printed onto the screen are
;		alphabetical chars, a blank space, and a period. In addition to
; 		print nay uppercase letter, if a lowercase letter is inputed then
;		the character will be set to print out its uppercase.
;
;   input:	The program is initialized by typing in 'KEY' into the commaned line.
;		Fromt then the user enters data by preseeing any key on the keyboard.
;		As long as the user has not specified a period the program will keep
;		on running.
;
;   owner:      Janne Louise Ave (jfave)
;
;   date:       09/21/16
;
;   09/19/16    First lines written
;   09/21/16	Added more information to the header
;------------------------------------------------
	.model	small				; 64k code and 64k data
      	.8086					; only allow 8086 instructions
      	.stack	256				; reserve 256 bytes for the stack
;------------------------------------------------
      	.data					; start the data segment
;------------------------------------------------
; Translate-table
; tran is a table with 256 entries (0 - 255)
; Whatever ASCII char the user entered will be translated into a different char
; based on the table
; Any char translated to '*' will not be printed out by the program
;------------------------------------------------
tran	db	32	dup	('*')		; for ASCII chars (0 - 31) = '*'
	db	' '				; set 32 = ' '
	db	13	dup	('*')		; for ASCII chars (33 - 45) = '*'	
	db	'.'				; set 46 = '.'
	db      18	dup	('*')		; set ASCII chars (47 - 64) = '*'	
	db	'ABCDEFGHIJKLMNOPQRSTUVWXYZ'	; chars 65 - 90 = letters (A - Z)
	db	6	dup	('*')		; for ASCII chars (91 - 96) = '*'
	db	'ABCDEFGHIJKLMNOPQRSTUVWXYZ'	; chars 97 - 122 = letters (A - Z)
	db 	133	dup	('*')		; for ASCII chars (123 - 255) = '*'
;------------------------------------------------
	.code					; 
;-----------------------------------------------
; Initialize program execution
;----------------------------------------
start:					;
	mov	ax,@data		; establish addressability to the 
	mov	ds,ax			; data segment for this program
	mov 	bx,offset tran		; bx points to the table
;----------------------------------------
; Read in characters from the Standard Input
;----------------------------------------
getchars:				;
	mov		ah,8		; set ah = 8 to request a character
					; w/out echo
	int		21h		; call DOS and the character will be
					; returned in al
	xlat				; translate the char
	cmp 	al,'*'			; if the char is translated to a '*'
	je	getchars		; yes, char will not get printed out
;----------------------------------------
	mov		dl,al		; move char stored in al from input
					; call to the data register for printing
	mov		ah,2		; set ah=2 to request a character to
					; be written
	int		21h		; call DOS and the character will be
					; written
	cmp		al,'.'		; was the character a period
	jne		getchars	; if the character was not a period
					; get the next character and repeat the
					; process
;----------------------------------------
; terminate program execution
;----------------------------------------
exit:					;
         mov		ax,4c00h	; set correct exit code in ax
         int       	21h		; int 21h will terminate program
         end       	start		; execution begins at the label start
;----------------------------------------

