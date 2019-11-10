/******************************************************************************
* file: arm_lab_cs18m524_assignment_5_a.s
* author: Ananya Barat
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

@ BSS section
@Given is the hex value for an ASCII digit. 
@Numbers in hex are from 0 -9 and A-F/a-f.
@Anything that is in the ascii range for this is converted and displayed.
@For anything apart of this 0xFFFFFFFF is stored in the memory H_DIGIT
      .bss	  
@ DATA SECTION
      .data


A_DIGIT:  .word 0x30 @Hex of the ASCII number to be converted
H_DIGIT:  .word 0x00 @The resultant number is stored here

@ TEXT section
      .text

.globl _main
	LDR R1, = A_DIGIT
	LDR R4, [R1]
	CMP R4 ,#0x30		@range of hex for ASCII digits 0-9 is 0x31 to 0x39
	BLT OUT_OF_RANGE	@if the value is less than 0x30 it's out of range
	CMP R4 , #0x39
	BLE NUMBER			@Greater than 0x31 and less than 0x39 -> 0-9
	CMP R4 , #0x41
	BLT OUT_OF_RANGE
	CMP R4 , #0x46		@Digits A-F are in range 0x41- 0x46
	BLE CAPITAL
	CMP R4 , #0x61
	BLT OUT_OF_RANGE
	CMP R4 , #0x66		@Digits a-f are also acceptable in 0x61-0x66
	BGT OUT_OF_RANGE
	SUB R6 , R4 , #0x57	@if we subtract 0x57 from the hex of the ascii numbers a-f, we get the number 
	B exit
	
CAPITAL:                
	SUB R6, R4, #0x37   @if we subtract 0x37 from the hex of the ascii numbers A-F, we get the number 
	B exit

NUMBER:
	SUB R6, R4 , #0x30	@if we subtract 0x30 from the hex of the ascii numbers 0-9, we get the number 
	B exit

OUT_OF_RANGE:
	MOV R6, #0xFFFFFFFF	@for out of range values 0xFFFFFFFF is stored as the eroor value
	B exit
	
exit:
	LDR R2, =H_DIGIT	@store the value back in H_DIGIT
    STR R6, [R2]
	@end	
	
	
