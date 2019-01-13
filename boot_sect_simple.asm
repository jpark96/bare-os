[org 0x7c00]
mov ah, 0x0e ; tty mode

; First attempt to find the_secret label
mov al, '1'
int 0x10
mov al, the_secret
int 0x10

; Second attempt to find the_secret label
; doesn't work because of the global offset 0x7c00
mov al, '2'
int 0x10
mov al, [the_secret] ; nasm brackets dereferences the argument
int 0x10

; Third attempt to find the_secret label
mov al, '3'
int 0x10
mov bx, the_secret
add bx, 0x7C00
mov al, [bx]
int 0x10

; Fourth attempt to find the_secret label
mov al, '4'
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $ ; jump to current address (infinite loop)

the_secret:
    db "X"

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55

