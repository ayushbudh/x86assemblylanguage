COMMENT !
        Author: Ayush Budhwani
        Description: This  programs transaltes the statements from the High Level Language to Low level Assembly Language.

HLL code:

for (i = 5; i > 0; i--)
     {
    		      for(j = 3; j > 0; j--)  
                                        {
y = i + j ;
          }
      }
!

.386											; Indicates that this is a 32-bit program
.model flat,stdcall								; Flat memory model is used by this program to store program memory and standard calling convention is used
.stack 4096										; Reserves 4096 Bytes of program memory for this program

ExitProcess PROTO, dwExitCode:dword				; ExitProcess prototype is used to exit the program. A prototype consist of the proto keyword, a comma and an input parameter
												; in this case the input parameter is dwExitCode.
.data											; Data Segment- used for assiging memory to variables 

CountI=5										; Storing the count of the outer loop with counter i
CountJ=3										; Storing the count of the inner loop with counter J
CountY = CountI * CountJ;						; Calculating the CountY for the array Y which will hold the result of the expression i+j after each inner loop iteration

Y DWORD CountY DUP(?)							; Declaring an array Y using Duplicate operand in which each element is uninitialized
I DWORD CountI									; assigning value to the i counter 
J DWORD CountJ									; assigning value to the j counter 

.code											; Code Segment - is used for writing instruction 	
main PROC										; Main Procedure - the entry point of the program
	mov edi, OFFSET Y							; storing the starting address/Offset of the array Y
	mov ecx,CountI								; storing the value of the CountI to the ecx loop counter for the outer loop

L1:
	mov edx, ecx								; storing the outer loop counter to the edx register so that it's not lost after completing the inner loop
    mov ecx,CountJ								; storing the value of the CountJ symbolic constant to the ecx loop counter to iterate through the inner loop

	L2:

	mov eax,J									; storing the counter J to the eax register  	
	Add eax, I									; adding the value of counter I to the eax register so that the value obtained is I + J
	Mov [edi],eax								; moving the result obtained from I+J expression to the first position in the array and then incrementing the edi register by the datatype of the array
	add edi, TYPE Y								; to store the element successively.
	Dec J										; decrementing J for the next iteration

	Loop L2

	mov J,CountJ								; after the termination of the inner loop store the counter of J to 3 so that when the next outer loop executes J will be 3 again
	mov ecx,edx									; retrieving the value of the ecx that is lost due to the inner loop
	Dec I										; decrementing the value of the I so that in the next excution I will be one less than the prior loop and after executing 5 times loop will terminate 

LOOP L1

	
INVOKE ExitProcess,0							; Invoking Exiprocess function to call the it and exit the process 
main ENDP										; Ending the main procedure which was started above at the start of the program
End main										; Ending the assembly program