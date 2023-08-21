
%define MAX_SHORT 65535
; =================================
; PROTOTYPE	: void randomize(void)
; INPUT		: n/a
; RETURN	: n/a
; =================================
randomize:
	push dx

	call ticks
	mov word [seed], dx ; tickcount as seed

	pop dx
	ret

; ================================
; PROTOTYPE	: void random(void)
; INPUT		: n/a
; RETURN	: random number in AX
; ================================
random:
	push bx
	push dx
	
	mov ax, word [seed]
	mov dx, 33333
	mul dx				; multiply SEED with AX

	inc ax				; increment seed
	mov word [seed], ax		; use AX as new seed
	mov word [.rnd], dx		; save random value
	mov ax, dx

	pop dx
	pop bx

	ret

	.rnd dw 0

seed: dw 13666 ; default seed
