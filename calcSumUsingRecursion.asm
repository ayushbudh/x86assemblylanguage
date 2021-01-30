COMMENT !
 Author: Ayush Budhwani
 Description: This program calculates the sum of the series with common difference between the consecutive terms as 1 using recursion.
			  The first term of the series starts from the 1.
			  if N=3
			  Sum = 1+2+3+4 =10
!

.386															; Indicates that this is a 32-bit program
.model flat,stdcall												; Flat memory model is used by this program to store program memory and standard calling convention is used
.stack 4096														; Reserves 4096 Bytes of program memory for this program

ExitProcess PROTO, dwExitCode: dword							; ExitProcess prototype is used to exit the program. A prototype consist of the proto keyword, a comma and an input parameter
																; in this case the input parameter is dwExitCode.
.data															; Data Segment- used for assiging memory to variables 
Sum DWORD 0														; Variable Sum with value 0
Input DWORD 4													; Input parameter - Input

.code															; Code Segment - is used for writing instruction 
;  ----------------------Procedure Main--------------------------------

main PROC														; Main Procedure - entry point of the program
	mov edx,Input												; moving the value of the Input to the edx register 	
	mov eax,0													; eax will hold the sum of the series of Input value 4		
	mov ecx,1													; moving the value of ecx as 1 which will be used in the CalcSum procedure 
	call CalcSum												; calling the CalcSum Procedure
	
  INVOKE ExitProcess,0
main ENDP

;  ----------------------Procedure Proc-------------------------------

CalcSum PROC													

	cmp edx,ecx													; comparing the value of the edx with ecx register to check if while incrementing the value of the ecx register 
	jb exit														; after each recursive call is less than or equal to the Input value -> Base condition to terminate the recursive call
	add eax,ecx													; adding the value of the ecx with the eax and storing it in the eax (Eax = Eax + Ecx)
	inc ecx														; incrementing the ecx so that after each recursive call value of ecx is increased and sum is calculated as 1+2+3+4+....+N
	call CalcSum												; recursive call to the Procedue CalcSum

	exit:	mov Sum, eax										; exit label moves the value of the eax which consist of the Sum of the series till value of Input to the Sum data label
			ret													; when this ret is executed then the stack becomes empty by backtracking through it and finally returns to the main procedure

CalcSum ENDP													; end of the CalcSum procedure
End main														; end of the main program

