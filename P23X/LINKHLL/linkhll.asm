;-----------------------------------------------------------
; Program:   linkhll subroutine
;
; Function:  Determines the product of the two largest 
;	     unsigned word values out of the 4 passed into 
;	     the subroutine through the stack
;
; Input:     4 unsigned word value passed to the subroutine
;	     through the stack
;
; Output:    the product will be stored in the dx:ax registers
;
; Owner:     Janne Louise Ave (jfave)
;
; Date:      	Update Reason
; --------------------------
; 10/20/2016 	Original version
;----------------------------------------
	.model	small			; 64k code and 64k data
	.8086                         	; only allow 8086 instructions
	public	_linkhll            	; allow external programs to call subroutine
;----------------------------------------
	.data               	  	; start the data segment
;----------------------------------------
        .code               		; start the code segment
;----------------------------------------
_linkhll:				;
	push	bp			; save the caller's bp
	mov	bp,sp			; init bp to we have access to the parameters
					; passed through the subroutine through the stack
;----------------------------------------
; Overall logic:
;	ax -> contains the 1st largest value
;	dx -> contains the 2nd largest value
;
;	For each parameter, it will be compared
;	ax first. If a parameter is greater than
;	the value in ax it will also be greater than
;	the value in dx. Then the value will stored
;	in the ax register.
;
;	If the parameter, is not greater than the
;	value in ax, it must be compared against
;	the value in dx. If the parameter is greater
;	than the value in dx, then it is stored in dx.
;
;	** LUV -> Largest Unsigned Value **
;----------------------------------------
; First compare v1 ([bp + 4])and v2 ([bp + 6])
;----------------------------------------
	mov	ax,[bp + 4]		; v1 is 1st LUV
	mov	dx,[bp + 6]		; v2 is 2nd LUV
	cmp	ax,dx			; compare v1 and v2
	jb	setup2			; v2 > v1
	jmp	check_v3_ax		; check v3
;----------------------------------------
setup2:
	mov	ax,[bp + 6]		; v2 is 1st LUV
	mov	dx,[bp + 4]		; v1 is 2nd LUV
;----------------------------------------
check_v3_ax:
	cmp	word ptr [bp + 8],ax	; compare v3 and 1st LUV
	jb	check_v3_dx		; v3 < 1st LUV (ax) so check if v3 > 2nd LUV (dx) 
	mov	dx,ax			; last 1st LUV now is the 2nd LUV
	mov	ax,[bp + 8]		; v3 >= 1st LUV so v3 becomes 1st LUV 
	jmp	check_v4_ax		; check v4
;----------------------------------------
check_v3_dx:
	cmp	word ptr [bp + 8],dx	; compare v3 and 2nd LUV
	jb	check_v4_ax		; v3 < 2nd LUV (ax) so check v4 
	mov	dx,[bp + 8]		; v3 >= 1st LUV so v3 becomes 2nd LUV 
;----------------------------------------
check_v4_ax:
	cmp	word ptr [bp + 10],ax	; compare v4 and 1st LUV
	jb	check_v4_dx		; v4 < 1st LUV (ax) so check if v4 > 2nd LUV (dx) 
	mov	dx,ax			; last 1st LUV now is the 2nd LUV
	mov	ax,[bp + 10]		; v4 >= 1st LUV so v4 becomes 1st LUV 
	jmp	multiply		; finished comparing all values so find product
;----------------------------------------
check_v4_dx:
	cmp	word ptr [bp + 10],dx	; compare v4 and 2nd LUV
	jb	multiply		; finished comparing all values so find product
	mov	dx,[bp + 10]		; v4 >= 2nd LUV so v4 becomes 2nd LUV 
;----------------------------------------
multiply:
	mul	dx			; multiply the value in ax and dx
					; product will be stored in ax and dx registers
	pop	bp			; restore bp
        ret				; return
	end				; end of source code
;---------------------------------------

