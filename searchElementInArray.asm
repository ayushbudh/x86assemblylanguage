COMMENT !

Author: Ayush Budhwani
Description: This program searches for the given element in the array.If a value is found in the array then it is stored in the eax register, else -1 is stored in eax register.

!


.386															; Indicates that this is a 32-bit program
.model flat,stdcall												; Flat memory model is used by this program to store program memory and standard calling convention is used
.stack 4096														; Reserves 4096 Bytes of program memory for this program

ExitProcess PROTO, dwExitCode: dword							; ExitProcess prototype is used to exit the program. A prototype consist of the proto keyword, a comma and an input parameter
																; in this case the input parameter is dwExitCode.
.data															; Data Segment- used for assiging memory to variables 
	array DWORD 10h,20h,30h,40h,50h	
	sample DWORD 50h
.code															; Code Segment - is used for writing instruction 

;  ----------------------Procedure Main--------------------------------
main PROC														; Main Procedure - the entry point of the program
	
	mov ebx,sample												; storing parameters that will be passed to the procedure Search
	mov ecx, LENGTHOF array
	mov esi, OFFSET array
	mov edx, TYPE array

	call Search													; calling procedure Search

	INVOKE ExitProcess,0										; Invoking Exiprocess function to call the it and exit the process 
main ENDP														; Ending the main procedure which was started above at the start of the program														


;  ----------------------Procedure Search-------------------------------

Search PROC

push esi														; pushing value of esi to the stack so that it can be retrieved at the end of the current procedure which keeps the execution of the main procedure unaffected
push ecx														; pushing value of ecx to the stack so that it can be retrieved at the end of the current procedure which keeps the execution of the main procedure unaffected
	
L1:
	cmp ebx, [esi]												; Checking if value accessed from the array is equal to the sample given that is stored in ebx register in the main procedure
	JNE l2														; if the current value accessed is not equal to the sample value that we are checking for then we move to the next value in the array
	mov ebx,[esi]												; if we found the element in the array the program control flow jumps to the ItemFound label to store the value of the ebx to eax register 
	JMP ItemFound													

l2:
	add esi,edx													; used for indexing to each element in the array

loop L1															; Loop until the length of the array is completed traversing

ItemNotFound:													; if the loop completes without jumping to the ItemFound code label then the item is not found and we store -1 t eax register 
																; to indicate item is not found
	mov eax,-1
	JMP gotoend													; Jumps to the gotoend label so that it doesn't stores value of ebx into eax register

ItemFound: 
	mov eax,ebx													; moving value of ebx to eax if item is found	

gotoend:

pop ecx															; popping the value of ecx from the stack to ensure normal execution of the program as the control will be returned back to the main procedure
pop esi															; popping the value of esi from the stack to ensure normal execution of the program as the control will be returned back to the main procedure
ret																; ret - return instruction to return the control to the main procedure of the program

Search ENDP														; End of the Search procedure

End main														; ENd of the main program