COMMENT !
Author: Ayush Budhwani
Description: This program swaps the elements in the array after each iteration in the loop.
					 1) For even length of the array it swaps all the consecutive elements pairs in the array.
					 2) For odd length of the array it swaps all consecutive elements pairs except the last element in the array.
					 3) Program is flexible in terms of the datatype used,  only lines that needs to be changed are: 21 (to edit the data type), 37, 38 and 39 
						(where register needs to be changed to avoid "operands must have same size error")
!

.386																	; Indicates that this is a 32-bit program
.model flat,stdcall														; Flat memory model is used by this program to store program memory and standard calling convention is used
.stack 4096																; Reserves 4096 Bytes of program memory for this program

ExitProcess PROTO ,dwExitCode:dword										; ExitProcess prototype is used to exit the program. A prototype consist of the proto keyword, a comma and an input parameter
																		; in this case the input parameter is dwExitCode.

.data																	; Data Segment- used for assiging memory to variables 
	array WORD 'B', 'A', 'D', 'C', 'F', 'E', 'H', 'G'					; array with the length 8
	
.code																	; Code Segment - is used for writing instruction 
main PROC																; Main Procedure - the entry point of the program
	mov ecx, LENGTHOF array												; storing the length of thw array to the ecx loop counter 
	mov esi, OFFSET array												; storing the address of the first element of the array to the esi source index
    
	datatype = TYPE array												; assigning the value for the datatype of the array
    loopcounter = (LENGTHOF array)/2									; assigning the value for loop counter as half of the complete length because the program will swap single pairs
																		; of two elements in the array in one iteration 
	mov ecx, loopcounter
    counter = datatype*2												; counter symbolic constant that will used to increment the address of the array stored in esi register so that address value
																		; is incremented twice due to the swapping of two elements in the array in a single iteration
												

	L3:																	; swapping the consecutive elements in the array 
		mov ax, [esi]													; deferencing esi register to get the value stored at the respective address location
		xchg [esi+datatype],ax										    
		mov [esi], ax
		add esi,counter													; decreasing the esi by the value of the counter so that the esi is decremented such that it will point to alternate element in the array
	LOOP L3

INVOKE ExitProcess,0													; Invoking Exiprocess function to call the it and exit the process 
main ENDP																; Ending the main procedure which was started above at the start of the program
End main																; Ending the assembly program