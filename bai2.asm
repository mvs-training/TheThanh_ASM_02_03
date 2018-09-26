.model small
.stack 100h
.data
buf2 DB 0dh,0ah,"Enter Substring to search :::: $"
buf3 DB 0dh,0ah," Found $",1
buf4 DB 0dh,0ah," not Found...$"
str DB 120,120 DUP(?)
str_len DW 0
substr DB 120,120 DUP (?)
substr_len DW 0
counter DW 0 
nd dw ? 
err db 'error$' 
buff dw 256 dup(0)
ndf dw ?,'$'
dta db 69h dup(?)
filename dw ?
.code 
main proc
mov ax,@DATA
mov DS,ax
mov es,ax

;=======Input Substring======
lea dx,buf2
call display
mov dx,offset substr
mov ah,0Ah
int 21h
;==========Input String===== 

mov dx,offset dta
mov ah,1ah
int 21h 
    
mov dx,offset filename
mov cx,0fh
mov ah,4eh   ; file dau tien
int 21h  
jc error 
    
print:
mov dx,offset [dta+30] ; tro den vung ten file
mov si,dx
mov byte ptr [si+14],'$'
mov ah,9
int 21h 
jc end 

mov ah,3dh
mov al,0
mov dx,offset [dta+30]
int 21h
jc error
mov bx, ax 
mov str_len,ax 

readf:
mov ah,3fh
mov dx,offset str
mov cx,ax
int 21h
    
jc error
mov si,ax
    
cmp si,1
je readf
jmp close
    
error: 
mov ah,9
lea dx,err
int 21h
close:
mov ah,3eh
int 21h 

;checking if substring is in string or not
mov SI,offset str[str_len] 
add SI,2
lea DI,substr
add DI,2
mov bx,substr_len
cmp str_len,bx
jg G 
mov cx,bx
G:
mov cx,str_len

L:
lodsb
cmp al,0Dh
je final
cmp al,' '
jne next
final:
cmp counter,0
je exit
mov counter,0
lea DI,substr
add DI,2
jmp next1
next:
dec SI
next1:
cmpsb
je h
inc counter
h:
LOOP L
exit:
cmp counter,0
je Found
jmp terminate
Found:
lea dx,buf3
call Display   
mov ah,4fh   
int 21h
jc end
jmp print 

terminate:
lea dx,buf4
call Display
mov ah,4fh  
int 21h
jc end
jmp print 
ret

end:
mov ah,4ch
int 21h 
main endp

Display PROC
mov ah,09h
int 21h
ret
Display ENDP 
end main
 


