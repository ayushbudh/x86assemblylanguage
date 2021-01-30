COMMENT !
Author: Ayush Budhwani
Description: The program converts pseudo code into assembly language.

Convert the following pseudo code into assembly code.
array1 13h, 14h, 15h, 16h // Each element is 1 Byte long
length1 = number of items in Array1. // length1 is a Symbolic constant
length 2 = number of items in Array2 // length2 is a Symbolic constant
array2 12h, 13h, 14h, 15h // Each element is 1 Byte long
sample1 = 30h // this variable is 1 byte long initialized with 30
sample2 = 5h. // this variable is 0 byte long
maxlength = max of length1 and length2. // maxlength is 1 byte long variable
index = 0. // this is a variable initialized with 0
While ( index < maxlength ){
 If (array1[index] > array2[index])
	exp1 = (array1[index] * sample1) / (array2[index] * Sample2) // only store the quotient of the division in exp1 and exp1 is //16 bit long variable
	else
exp1 = 0
	index = index + 1
}
!

.386															; Indicates that this is a 32-bit program
.model flat,stdcall												; Flat memory model is used by this program to store program memory and standard calling convention is used
.stack 4096														; Reserves 4096 Bytes of program memory for this program

ExitProcess PROTO, dwExitCode: dword							; ExitProcess prototype is used to exit the program. A prototype consist of the proto keyword, a comma and an input parameter
																; in this case the input parameter is dwExitCode.
											
.data															; Data Segment- used for assiging memory to variables 
			array1 BYTE 13h, 14h, 15h, 16h
			array2 BYTE 12h, 13h, 14h, 15h
			len1 = LENGTHOF array1
			len2 =  LENGTHOF array2

			sample1 BYTE 30h
			sample2 BYTE 5h

			index BYTE 0
			exp1 WORD ?

			maxLength BYTE ?
.code															; Code Segment - is used for writing instruction 

main PROC														; Main Procedure - the entry point of the program
	
			mov al, len1																				
			cmp al, len2										; comparing the length of the two arrays and storingthe maximum array length in maxLength data label
			JAE L1
		
			mov maxLength, len2
			JMP startwhile
		L1: 
			mov maxLength, al


	startwhile:	

			mov al, maxLength									; while(index<maxLength)
			movzx esi,index
			cmp index, al
			JAE endloop
		
			mov al, array1[esi]
			cmp al, array2[esi]									; If (array1[index] > array2[index])
			JBE L5 

			mul sample1											; (array1[index]*sample1) --> Storing the value of the expression in bx register so that it's not lost when the program will perform divison
			mov bx, ax	
																								
			mov al, array2[esi]																		
			mul sample2											; (array2[index]*sample2)
			mov dx, ax											; Storing the value of the expression for divison

			mov ax,bx											; restoring the value of the dividend ax from bx
																								
			cmp dx,0											; dx cannot be zero if dx is zero then exp1 data label is assigned 0
			JZ L5

			div dl												; since all of the numbers in the arrays are positive I am using div instruction
																; Not checking carry flag to determine whether the upper half of the dx register that is dh contains any value which remains empty for the given values in the array
		L8:
			movzx dx,al											; using zero extension since the values in the array are positive and their corresponding expression values are also positive
			mov exp1,dx															
			JMP L6	

		L5:															
			mov exp1,0											; else block executes when if block false

		L6:
			inc index											; incrementing the index to move th pointer to point to the next element in the array													
										
	LOOP startwhile												; execution continues until while condition evaluates to false

	endloop:													; code label to end the loop when the index points to the next index after the end index in the array 

	INVOKE ExitProcess,0										; Invoking Exiprocess function to call the it and exit the process 
main ENDP														; Ending the main procedure which was started above at the start of the program
End main														; Ending the assembly program