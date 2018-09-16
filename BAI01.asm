.model small
.stack  100h
.Data   

File_Loca db "*.*",0 ;thu muc hien tai
DT 	 db 128 dup(?) ;phan bo 128 byte chua khoi tao cho bo nho

.code
main proc
    mov ax,@Data  
    mov ds,ax 
    mov es,ax 

    mov dx,OFFSET DT 	
    mov ah,1Ah 		; dat dia chi cua DT
    int 21h 		

    mov cx,3Fh 		; doc tu file
    mov dx,OFFSET File_loca 
    mov ah,4Eh 		; tim kiem file dau tien 
    int 21h 		

    Lap:

         mov dx,OFFSET File_loca 	
        mov ah,4Fh 		;tiep
        int 21h 		
        ; neu CF = 1 thi thoat ra
        jc thoat 	

        mov cx,13 		; chieu dai file location
        mov si,OFFSET DT+30 	
        xor bh,bh 		
        mov ah,0Eh 		

    Tiep:

        lodsb 		; AL = ki tu tiep theo
        int 10h 	

        loop Tiep

        mov di,OFFSET DT+30 	
        mov cx,13 		; chieu dai file location
        xor al,al 		
        rep stosb 		; Xoa Data

        jmp Lap 	


    Thoat:

           mov ax,4Ch 	; thoat
           int 21h
main endp
    end main