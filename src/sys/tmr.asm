; ==================================================
; PROTOTYPE	: void ticks(void)
; INPUT		: n/a
; RETURN	: tick count in DX (resolution =~ 55ms)
; ==================================================
ticks:
	push ax

	xor ah, ah ; Get tick count function 
	int 0x1a
	mov word [.ticks], dx

	pop ax
	ret

	.ticks dw 0

; ============================================================
; PROTOTYPE	: void sleep(short ms)
; INPUT		: amount of ms to sleep in DX (resolution =~ 55ms)
; RETURN	: n/a
; ============================================================
sleep:
	push ax
	push cx
	push dx

	mov ah, byte 0x86
	mov cx, word 1
	int 0x15

	pop dx
	pop cx
	pop ax
	ret
