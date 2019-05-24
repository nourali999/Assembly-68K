*----------------------------------------------------------------------
* Programmer: Nour Ali
* Class Account: cssc1535
* Assignment or Title: Birthdate Assignment
* Filename: prog1.s
* Date completed: 02/28/2019
*----------------------------------------------------------------------
* Problem statement: lookup the name of the month given index
* Input: birthdate	
* Output: month
* Error conditions tested: none
* Included files: macros
* Method and/or pseudocode: array lookup
* References: none
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
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	

	lineout    title
	lineout    skipln
	lineout    prompt
	linein     buffer
	cvta2      buffer,#2
	subq.l     #1,D0             * month -> the array index
	mulu       #12,D0            * offset from array beginning
	lea        months,A0	     * ptr to array of months
	adda.l     D0,A0             * ptr to birth month
	move.l     (A0)+,month	     * first four chars
	move.l     (A0)+,month+4     * second four chars
	move.l     (A0),month+8      * last four chars
        lineout    answer
	


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
months:  dc.b     'January.   ',0
	 dc.b     'February.  ',0
	 dc.b     'March.     ',0
	 dc.b     'April.     ',0
	 dc.b     'May.       ',0
	 dc.b     'June.      ',0
	 dc.b     'July.      ',0
	 dc.b     'August.    ',0
	 dc.b     'September  ',0
	 dc.b     'October    ',0
	 dc.b     'November   ',0
	 dc.b     'December   ',0
	 
	 
	 
	 
title:   dc.b     'Nour Ali, Program #1, cssc1535',0
prompt:  dc.b     'Please enter your birthdate (MM/DD/YYYY)',0
buffer:  ds.b      82          *atleast 80
answer:  dc.b     'You were born in the month of '
month:   ds.b      12
skipln:  dc.b      0
	
	
	end
