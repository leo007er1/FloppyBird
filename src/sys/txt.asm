; =====================================
; PROTOTYPE	: void set_text_mode(void)
; INPUT		: n/a
; RETURN	: n/a
; =====================================
set_text_mode:
	push ax

	mov ax, 0x3		; 80x25 @ 16 color mode
	int 10h			; call BIOS interrupt

	pop ax
	ret	

; ==============================
; PROTOTYPE	: void reboot(void)
; INPUT		: n/a
; RETURN	: n/a
; ==============================
reboot:
	xor ax, ax
	int 19h
	ret

; ==================================
; PROTOTYPE	: short getch(void)
; INPUT		: n/a
; RETURN	: returns key hit in AX
; ==================================
getch:
	xor ah, ah		; get key hit function (will block)
	int 16h			; call BIOS interrupt

	mov word [.key], ax
	ret	

.key: dw 0

; ==================================
; PROTOTYPE	: short kbhit(void)
; INPUT		: n/a
; RETURN	: returns key hit in AX
; ==================================
kbhit:
	mov al, 0			; check for any keys hit
	mov ah, 1			; but do not block (async)
	int 16h				; call BIOS interrupt
	jz .end				; if no keys hit jump to end

	xor ax, ax			; get key hit function
	int 16h				; call BIOS interrupt

	mov word [.key], ax
	ret		

	.end:
		xor ax, ax			; set AX to 0 if no keys hit
		ret

.key: dw 0

; ===========================================
; PROTOTYPE	: void puts(char *s)
; INPUT		: offset/pointer to string in SI
; RETURN	: n/a
; ===========================================
puts:
	push ax
	mov ah, byte 0xe ; Teletype function

	.loop:
		lodsb		; move byte [DS:SI] into AL

		or al, al	; 0 == end of string ?
		jz .end

		int 10h		; call BIOS interrupt
		jmp .loop	; next character

	.end:
		pop ax
		ret

; =======================================
; PROTOTYPE	: void putc(char ch)
; INPUT		: character to display in AL
; RETURN	: n/a
; =======================================
putc:
	push ax

	mov ah, byte 0xe ; Teletype function
	int 10h		; call BIOS interrupt

	pop ax
	ret
