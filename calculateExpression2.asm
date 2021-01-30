COMMENT !
         Author: Ayush Budhwani
       	 Description: This program first creates a list named z uninitilaized then in the code segment instructions are used to 
                      calculate the expressions that needs to be stored in the memory locations.
         
         z_0 = x + 13 
         z_1 = y - x 
         z_2 = r+ z_1 - 13 
!

.386                                    ; this lines indicates as a 32-Bit program
.model flat, stdcall                    ; this program uses flat model and standard calling function to call the functions in the program
.stack 4096                             ; Reserves 4096 Bytes of memory for the program
ExitProcess PROTO, dwExitCode: dword    ; ExitProcess prototype consist of PROTO Keyword a comma and input parameter which is dword in this case

.data                                   ; Data Segment is used to assign memory to the variables and the list with the name z in this case
    count=3                             ; Symbolic constant that is used for the size of the array created by the DUP operator
    z WORD count DUP(?)                 ; List named z that creates untialized 48 Bit of array each  
    X WORD 7                            ; Variable X of 16 Bit initialized with the value 7
    Y WORD 20                           ; Variable Y of 16 Bit initialized with the value 20
    R WORD 4                            ; Variable Y of 16 Bit initialized with the value 4

.code                                   ; Code segment of the program
main PROC                               ; Main Procedure that is the entry point of the program

     mov dx,X                           ; Copies data of the data label X to the Data register which can be used while calculating the second expression for Z1 
     
     ; Calcuating and storing the result of the expression z_0 = X + 13 to the z_0 memory location in the array
     Add X,13                           ; X= X+13
     Mov ax,X                           ; AX = 0014h
     Mov [z+0],ax                       ; z_0 = 0014h

     ; Calcuating and storing the result of the expression  z_1 = Y - X  to the z_1 memory location in the array
     Sub Y,dx                           ; Y= Y- dx    dx - has the intial value of the X (i.e. 7)
     mov bx,Y                           ; BX = 000Dh
     mov [z+2],bx                       ; z_1 = 000Dh

     ; Calcuating and storing the result of the expression  z_2 = r+ z_1 - 13   to the z_2 memory location in the array
     add bx,r                           ; BX = BX + r
     sub bx,13                          ; BX = BX + 13
     mov [z+4],bx                       ; z_2 = 0004h

	INVOKE ExitProcess,0                ; Invoking the ExiProcess function to mark the end of program
main ENDP                               ; Ending the Process that has started at line 26
END main                                ; Ending the main program

