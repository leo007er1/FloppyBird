draw_background:
	push ax
	push cx
	push di

	mov cx, VIDMEM
	mov es, cx
	xor di, di ; index 0
	
	mov al, byte [backgroundcolor]
	mov ah, al

	mov cx, (VIDMES / 4) + (VIDMEW * 2)	; 64000 / 4 + 2 rows
	rep stosw

	pop di
	pop cx
	pop ax
	ret


randomize_backgroundcolor:
	call random
	mov word [backgroundcolor], ax
	ret


backgroundcolor: dw 3