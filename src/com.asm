%define SECTORS 16							; keep it under 18
%define IMAGE_SIZE ((SECTORS + 1) * 512)	; SECTORS + 1 (~= 18) * 512 bytes

bits 16		; 16 bit mode
org 0x100	; MS DOS programs code starts at offset 0x100


_start:
	call main
	
	cli
	hlt

; mixin sys and main
%include 'sys/txt.asm'
%include 'sys/tmr.asm'
%include 'sys/rnd.asm'
%include 'sys/snd.asm'
%include 'sys/vga.asm'
%include 'main.asm'

times IMAGE_SIZE - ($ - $$) db 0	; pad to IMAGE_SIZE
