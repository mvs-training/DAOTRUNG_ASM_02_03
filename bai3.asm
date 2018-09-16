.model small 
.data  
     
     buff dw 256 dup(?)  
     table db '0123456789abcdef'
     

.stack 
    dw   128  dup(0)


.code  

Main proc

        
MOV AX,@DATA
MOV DS,AX 
mov es, ax
xor ax, ax
    
mov cx, 1h    
mov dx, 00801h 
mov bx, offset buff 

mov ax, 0201h 
int 13h
 
lea si,buff
mov cx,128  
        
        
Bo1:   

lodsb 
mov dl,al  
push cx      ;dua cx vao trong stack
mov cl,4  
shr al,cl 

lea bx,table
xlat         ; doi kieu
mov ah,0eh
int 10h  

mov al,dl
and al,0fh
xlat        ; doi kieu
mov ah,0eh
int 10h
pop cx        ; lay ra khoi stack
loop Bo1 

mov ax, 4ch   ; ket thuc chuong trinh
int 21h  


Main endp
 end main