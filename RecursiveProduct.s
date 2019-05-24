*----------------------------------------------------------------------
* Programmer: Nour Ali
* Class Account: cssc1535
* Assignment or Title: Assignment 4
* Filename: prog4.s 
* Date completed: 
*----------------------------------------------------------------------
* Problem statement: recursive product
* Input: 2 integers
* Output: product
* Error conditions tested: none
* Included files: macros
* Method and/or pseudocode: none
* References: Riggins Reader
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
product: EQU $6000 
 
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only
				* Your code goes HERE
	
	lineout title
	lineout fprompt
	linein  buffer
	cvta2   buffer,D0
	move.w  D0,D1
	lineout sprompt
	linein  buffer
	cvta2   buffer,D0
	move.w  D0,D2
	move.w  D2,-(SP)        * push b on to the stack
	move.w  D1,-(SP)	* push a on to the stack
	jsr     product 	* call the subroutine
	adda.l  #4,SP   	* add 4 bytes to the stack pointer

	cvt2a   number,#11      * Atleast 10 is required
	stripp  number,#11
	lea     number,A0
	adda.l  D0,A0
	clr.b   (A0)
	lineout answer
	

	
	



        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:    dc.b       'Nour Ali, Program #4, cssc1535',0
fprompt:  dc.b       'Enter the first integer',0
sprompt:  dc.b       'Enter the second integer',0
buffer:   ds.b        80
answer:   dc.b       'The product of the two numbers is '
number:   ds.b        12
			
        end
