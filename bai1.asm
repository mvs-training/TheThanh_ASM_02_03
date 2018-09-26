.model small
.stack 100h 
.data
msg db 'cac file va thu muc hien hanh',10,13,'$'
dta db 69h dup(?)
filename dw ?
err db 'error$'
.code
main proc
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    ;xor cx,cx
    mov dx,offset dta
    mov ah,1ah
    int 21h 
    
    mov dx,offset filename
    mov cx,0fh
    mov ah,4eh   ; file dau tien
    int 21h
    
    jc error 
    
    mov ah,9
    lea dx,msg
    int 21h
    
    print:
    
    mov dx,offset [dta+30] ; tro den vung ten file
    mov si,dx
    mov byte ptr [si+14],'$'
    mov ah,9
    int 21h 
    
    mov ah,4fh    ; file tiep theo
    int 21h
    
    jc end
    jmp print 
    
    error:
    mov ah,9
    lea dx,err
    int 21h
    
    end:
    mov ah,4ch
    int 21h
    main endp
end main
    
    
    
    
    