/******************************************************************************
* file: arm_lab_cs18m524_assignment_5_b
* author: Ananya Barat
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/


@ BSS section
      .bss
@Iterate through the string and find out if every value is either 0 or 1
@Hex of the ascii value 0 is 0x30 and 1 is 0x31
@If all values are 0 or 1 consolidate and store all the numbers and display the final number and clear the error value.
@If any digit is not 0 or 1, print error. 
@Only first 8 values are checked. After that values are not considered.
  
	  
@ DATA SECTION
      .data


STRING:  .word 0x31, 0x31, 0x31, 0x30, 0x30, 0x30, 0x31, 0x30, 0x37; @8 bit string 
ERROR: 	 .word 0xFF; @location contains 0xFF if any digit in the string is not 0 or 1
NUMBER:  .word 0x00; @the number will be stored here

@ TEXT section
      .text

.globl _main
	LDR R1, =STRING @Load the string 
	LDR R4, [R1]
	MOV R2, #0x00
	LDR R8, =ERROR  @If a there is a bit that's not 0 or 1, 0xFF is stored here otherwise 0x00
	LDR R7, =NUMBER @The number is stored here if all digits are 0 or 1 , otherwise 0x00
	
LOOP: 
	LDR R5, [R1], #4 	@iterate through the string
	CMP R2, #0x08	 	@check only 8 digits 
	BGE CORRECT			@if this condition is true then there were no digits that weren't 0 or 1 in the first 8
	ADD R2, R2, #0x01	@loop variable
	CMP R5 , #0x30		@Check if bit is 0
	BEQ Valid			
	CMP R5, #0x31		@Check if bit is 1
	BNE Invalid			@Invalid if not 0 or 1
	B Valid
	B LOOP

Valid:
	SUB R3, R5 , #0x30  @On subtracting 0x30 from the hex of the ASCII of 0 (0x30) or 1 (0x31) we get the value 0 or 1
	MOV R6, R6, LSL#4	@Left shift this string by 4 positions ( one hex digits)
	ADD R6, R6, R3		@Add the digit 0 or 1 to the left shifted value to make the consolidated number
	B LOOP
	
Invalid: 
	MOV R6, #0xFF		@Make the error value 0xFF if a difit is not 0 or 1 
	STR R6, [R8]
	MOV R2, #0x00
    STR R2, [R7]		@Make the number 0x00 in this case
	B exit

CORRECT:
	MOV R2, #0x00		@If the first 8 digits are valid then clear the error 
    STR R2, [R8]
	STR R6, [R7]		@Store the consolidated number in NUMBER 
	B exit

exit:
	@end
	
