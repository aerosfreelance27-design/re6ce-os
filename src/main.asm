bits 16
org 0x7C00

start:
    jmp main

puts:
    push si
    push ax
    
.loop:
    lodsb               ; Loads [DS:SI] into AL and advances SI
    or al, al           ; Checks if AL (the character) is the null terminator
    jz .done            ; If zero (null terminator), exit
    
    mov ah, 0x0E        ; BIOS teletype function
    mov bh, 0           ; Page number
    int 0x10            ; Correct syntax for BIOS interrupt
    jmp .loop

.done:
    pop ax
    pop si
    ret

main:
    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00
    
    cld                 ; Clear direction flag so SI increments forward

    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt

msg_hello: db 'hai!! this is working!', 0 ; Replaced ENDL with 0 (null terminator)

times 510-($-$$) db 0
dw 0xAA55
