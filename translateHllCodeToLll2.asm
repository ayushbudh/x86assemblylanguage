COMMENT !
	Author: Ayush Budhwani
        Description: This  programs translates the statements from the High Level Language to Low level Assembly Language.

HLL code:
                          while X > 0
if  X != 3 AND (X > A OR X < B)
        X = X – 2
else
       X = X – 1
end while

		
!

.386								; Indicates that this is a 32-bit program
.model flat,stdcall					; Flat memory model is used by this program to store program memory and standard calling convention is used
.stack 4096							; Reserves 4096 Bytes of program memory for this program

ExitProcess PROTO, dwExitCode:dword ; ExitProcess prototype is used to exit the program. A prototype consist of the proto keyword, a comma and an input parameter
									; in this case the input parameter is dwExitCode.

.data								; Data Segment- used for assiging memory to variables 
	X SWORD 11
	A SWORD 9
	B SWORD 8
.code								; Code Segment - is used for writing instruction 
main PROC							; Main Procedure - the entry point of the program
	
	L1:
									; while(X>0)    
		mov ax,0
		cmp X,ax
		JLE L3						; Checking the while condition, if X<=0 is true, then X>0 is false. Hence the program jumps to L3 label to exit the loop as conition of while loop is false
							
		L2:							; if X> 0 is true then continue the loop
			cmp X,3			
			JE L4					; if (X==3) then if condition is false since any one of the condition
									; needs to be false for the entire if statement to be false, then jump to L4 which is else condition with expression X=X-1

									; any of one statement needs to be true for the second expression (X>A OR X<B) to be true 
									; AND 	
			mov ax, A	
			cmp X, ax
			JG L5					; if (X>A) is true then the program evalautes the X=X-2 expression

									;OR
			mov ax, B	
			cmp X,ax
			JL L5					; if (X<B) is true then the program evalautes the X=X-2 expression
														
									;else
		L4:
			dec X					; X = X-1
			JMP L6

		L5:
			sub X,2					; X = X-2
	
		L6:							; Do nothing

	Loop L1

	L3:								; Code label used to exit from the loop 

	INVOKE ExitProcess,0			; Invoking Exiprocess function to call the it and exit the process 
main ENDP							; Ending the main procedure which was started above at the start of the program
End main							; Ending the assembly program