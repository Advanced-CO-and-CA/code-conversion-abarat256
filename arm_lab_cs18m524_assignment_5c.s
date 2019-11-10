/******************************************************************************
* file: arm_lab_cs18m524_assignment_5_c.s
* author: Ananya Barat
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

@ BSS section
      .bss	  
@ DATA SECTION
      .data


BCDNUM:  .word 92529679 @BCD value
NUMBER:  .word 0		@Hex value will be stored here

@ TEXT section
      .text

.globl _main
	LDR R1, =BCDNUM   @load the BCD Number
	LDR R4, [R1]	  @The Arm simulator auto converts it into hex, since the BCD to Decimal conversion 
					  @is direct
	LDR R2, =NUMBER	  @Store the number in the asked memory location
	STR R4 ,[R2]

exit:
	@end