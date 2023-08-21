; ==================================================
; PROTOTYPE	: void beep(short note, short delay)
; INPUT		: note in AX, delay in DX
; RETURN	: n/a
; ==================================================
beep:
	push bx
	mov bx, ax

	%ifdef COM
		xor ah, ah
		int 0x24
	
	%else
		push cx
		push dx

		; Reprogram PIT channel 2 to be a square wave generator 
		mov al, byte 0xb6
		out 0x43, al

		mov ax, bx
		out 0x42, al
		mov al, ah
		out 0x42, al

		; Get the position of speaker from bit 1 of port 0x61 of keyboard controller
		in al, 0x61
		or al, 3
		out 0x61, al

		; Waits 2 milliseconds
		xor cx, cx
		mov dx, 20000
		mov ah, 0x86
		int 0x15

		; Stop sound
		in al, 0x61
		and al, 11111100b
		out 0x61, al

		pop dx
		pop cx
	%endif

	pop bx
	ret
