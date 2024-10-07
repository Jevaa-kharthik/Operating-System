org 0x7C00
bits 16


%define ENDL 0x0D, 0x0A

start:
    jmp main

;
; Prints the String to the String
; parameter : 
;           di:si points to Stirng
;

puts:
    ; save register to modify
    push si
    push ax

.loop:
    lodsb       ; loads next charater in al
    or al, al   ; verify if the next character in al in null
    jz .done

    mov ah, 0x0e    ; call bios interrupt
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret




main:


    ; setup data segments
    mov ax, 0       ; cant write to ds/es directly
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00      ; stack grows downwards where we are loaded the memory

    ;print message
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt 





msg_hello: db 'Hello World!!', ENDL, 0

times 510-($-$$) db 0
dw 0xAA55