COMMENT  !
         Author: Ayush Budhwani
       	 Description: This program calculates the below arithmetic expression and stores the result in the BX 16- Bit register and
                      all the intermdeiate results are stored in the 16-Bit registers.
             
                             Expression: BX = –val2 + 7 - (- val3 + val1) * 2

Note: The upper values that is after the ax resgiter to the left side will be Garbage values, since question says to alter only BX part of the resgiter EBX
 
!

.386                                    ; this lines indicates as a 32-Bit program
.model flat, stdcall                    ; this program uses flat model and standard calling function to call the functions in the program
.stack 4096                             ; Reserves 4096 Bytes of memory for the program
ExitProcess PROTO, dwExitCode: dword    ; ExitProcess prototype consist of PROTO Keyword a comma and input parameter which is dword in this case

.data                                   ; data segment - all the variable declaration goes here 

    val1 SBYTE  12                      ; var1 assumed to be a signed integer 
    val2 SBYTE   9                      ; var2 assmed to be a signed integer as the var2 has a unary plus is in front of it in expression
    val3 SBYTE   2                      ; var3 assmed to be a signed integer as the var3 has a unary plus is in front of it in expression

.code                                   ; Code segment of the program - all instructions are used here
main PROC                               ; Main Procedure that is the entry point of the program

    NEG val2                            ; Negating the value of val2 as it has unary minus in front of it in the expression
    NEG val3                            ; Negating the value of val3 as it has unary minus in front of it in the expression

  ; -val2 + 7
    Add val2,7                          ; Adding the immediate value 7 to the val2 variable or Data label 

  ; -val3 + val1
    Movsx ax,val3                       ; Copying val3 to the ax register in it's al part and filling the remaining ah part with 1's since val3 is negative number
    Movzx bx, val1                      ; Copying val1 to the bx register in it's bl part and filling the remaining ah part with 0's since val1 is positive number
    Add ax,bx                           ; adding the values of val1 and val2

  ; (-val3 + val1)*2
    Add ax,ax                           ; Adding Value of ax to ax and storing it to the ax to perform multiplication 

  ; BX = -val2 + 7 - (-val3 + val1)*2
    Movsx bx,val2                       ; Since val2 here is negative(-2) so we use Movsx instruction for expression (-val2 + 7)
    Sub bx,ax                           ; Subtracting expression (-val2 + 7) from (-val3 + val1)*2 and storing the result to the BX register
                             

	INVOKE ExitProcess,0                ; Invoking the ExiProcess function to mark the end of program
main ENDP                               ; Ending the Process that has started at line 26
END main                                ; Ending the program