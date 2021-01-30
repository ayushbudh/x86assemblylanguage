COMMENT !
Author: Ayush Budhwani
 Description: This program calculates the expression 
              D = (B) + (A - C) + D + listsize.

The value in the 0-th index of array ?list? corresponds to A.
The value in the 1st index of array ?list? corresponds to B.
The value in the 2nd index of array ?list? corresponds to C. 
The value in the 3rd index of array ?list? corresponds to D. 
The end result is stored in the edx register.
!

.386                                             ; Directing the compiler by telling it that this is 32 bit program
.model flat,stdcall                              ; Using flat model with the standard call fuction
.stack 4096                                      ; Directing the compiler to reserve 4096 Bytes of storage
ExitProcess proto,dwExitCode:dword				 ; Prototype for ExitProcess 
.data											 ; Data Directive - used for memory allocation using Data labels

list DWORD 10,5,30,15						     ; Continuous allocation in memory using directive DWORD and Data Label list (Used DWORD as the directive because i will be storing the contents of the list into the 32-bit registers)
listsize = ($-list)/4							 ; Calculating the size of the Data Label list and dividing it to by 4 to get the size in bytes as one DWORD value corresponds to 4 Bytes.   

.code											 ; Code Directive - used for writing instructions
main PROC                                        ; Marks the start of the procedure block label called main.
	mov eax,[list+0]							 ; Moving the contents of first element in the list to eax register 
	mov ebx,[list+4]							 ; Moving the contents of Second element in the list to ebx register 
	mov ecx,[list+8]							 ; Moving the contents of Third element in the list to ecx register 
	mov edx,[list+12]							 ; Moving the contents of Fourth element in the list to edx register 
	sub eax,ecx									 ; Subtracting the contents of the eax regsiter from ecx or eax = eax- ecx  
	add ebx,edx									 ; Adding the contents of the regsiter edx to regsiter ebx and storing it into ebx regsiter
	add ebx,listsize							 ; Adding the contents of list size to the ebx register and storing it into the ebx regsiter	
	add ebx,eax									 ; Adding the contents of the eax register to the ebx register and storing it into the ebx register
	mov edx,ebx									 ; Moving the contents of the register ebx to edx	  

	INVOKE ExitProcess,0						 ;Calls the procedure at the address given by expression, passing the arguments onto the stack or in the registers according to the standards calling standards
main ENDP										 ; Marks the end of the procedure previously begun with PROC
END main										 ; end of the program