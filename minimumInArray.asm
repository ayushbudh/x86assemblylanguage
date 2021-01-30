COMMENT !
Author: Ayush Budhwani
 Description: The program searches for the minimum element in the array and stores it in the MINIMUM memory variable.
!

.386								; Indicates that this is a 32-bit program
.model flat,stdcall					; Flat memory model is used by this program to store program memory and standard calling convention is used
.stack 4096							; Reserves 4096 Bytes of program memory for this program

ExitProcess PROTO, dwExitCode:dword ; ExitProcess prototype is used to exit the program. A prototype consist of the proto keyword, a comma and an input parameter
									; in this case the input parameter is dwExitCode.
.data								; Data Segment- used for assiging memory to variables 
	Array WORD 10, 2, 23, 45, 21, 11	; continguous allocation of memory used by the array to store the elements in consecutive order.
	MINIMUM WORD ?						; uninitialzed Minimum variable WORD to store the minimum element in the array

.code								; Code Segment - is used for writing instruction 
main PROC							; Main Procedure - the entry point of the program
	mov ax, [Array]					; Storing the first element of the Array into the ax register 
	mov edi, OFFSET Array			; Storing the address of the first element in the Array to the edi register 
	mov ecx, LENGTHOF Array			; Storing the loop counter for the array as the length of the Array

	L1:								; Label L1 Main Loop 
	;if
		cmp ax, [edi]				; compares the value of the ax with the consecutive array elements to find the minimum element in the array
		JG L2						; if the content of the edi is smaller then the content of the ax then it jumps to the L2 label to store the new minimum elmeent found in the array
	;else
		add edi, TYPE array			; adding the address of the edi register after each loop executes to move the pointer of edi to point to the next address in the array
	Loop L1

	L2:								; Label L2 used by the L1 label to Jump here so that a new minimum found in the array can be stored in the ax register to compare the remaining elements in the array after it
		JECXZ L3					; if the ecx (loop counter) is zero then it should jump to the L3 label to store the current minimum into the ax register as all the elements in the array are already traversed 
		Mov ax,[edi]				; storing the content of the from the current location to which edi is pointing so that in the next check the ax register is updated and it's value can be used to check if their 
									; is any other minimum element present in it.
		add edi, TYPE array			; adding the address of the edi register after each loop executes to move the pointer of edi to point to the next address in the array
	Loop L1							; after storing the new minimum continue with the loop l1 

	L3: Mov MINIMUM, ax				; Minimum value found and stored in the ax register which is copied to the variable MINIMUM 

	INVOKE ExitProcess,0			; Invoking Exiprocess function to call the it and exit the process 
main ENDP							; Ending the main procedure which was started above at the start of the program
End main							; Ending the assembly program
