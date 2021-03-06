;Filename : disk.asm
;Author   : 0xC000005
;Website  : www.codeidea.cn
;Date     : 2016/06/29
;
;负责加载硬盘数据到内存，调用规则请参考0x13号中断。

disk_load:
    pusha

    push dx

    mov ah, 0x02
    mov al, dh
    mov cl, 0x02

    mov ch, 0x00
    mov dh, 0x00

    int 0x13
    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error
    popa
    ret


disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0
