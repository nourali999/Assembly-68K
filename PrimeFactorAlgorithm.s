*---------------------------------------------------------------------
* Programmer: Nour Ali
* Class Account: cssc 1535
* Assignment or Title: Prime Factor Algorithm 
* Filename: prog3.s
* Date completed:  
*----------------------------------------------------------------------
* Problem statement: 
* Input: integer between 2 and 65535
* Output: Prime Factors 
* Error conditions tested: 
* Included files: macros
* Method and/or pseudocode: yes
* References: Riggins Supplementary Material
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

  	lineout	 title          * Prints Title
  redo:	lineout  skipln		* skips line
	
  	lineout  prompt         * Asks User for input
	linein   buffer         * buffer useriput
	move.l   D0,D5		* copy string length to D5
	ext.l    D5		* Make string length long
	stripp   buffer,D5	* Eliminate leading 0
	move.l   D0,D6		* Copy new string length to D6
	move.l   D0,D7		* Make another copy for later
    
	
	
	cmpi.l   #5,D6           
	BHI       bad           * checks lengh
	cmpi.l   #0,D6
	BHI       next  
	
	
  bad:  lineout  error          *Outputs error
  	bra      redo 

  
  next: lea      buffer,A1
	subq.w   #1,D6
  loop:	cmpi.b   #$30,(A1)      *Checks 0-9
	BLO       bad
	cmpi.b   #$39,(A1)+
	BHI       bad
	dbra      D6,loop
	
	
	cvta2     buffer,D7      * content in D0
	move.w    D0,D4		 * copy number to D4
	cmpi.w    #2,D4         
	BLO       bad		 * if its less than 2 goto bad
	cmpi.w    #65535,D4
	BHI       bad		 * if its bigger than 65535
	
	move.b    #' ',(A1)+
	move.b    #'a',(A1)+
	move.b    #'r',(A1)+     * Adds are to the prompt dynamically
	move.b    #'e',(A1)+
	move.b    #':',(A1)+
	clr.b      (A1)
	

	lea       factors,A5
	move.l    #2,D2          * stores factor as 2
   for:	cmp.l     D4,D2          * if factor>2 goto done
	BHI       done
	move.l    D4,D3          * copy number to destroy
	divu      D2,D3          * divides number and factor
	swap      D3             * switches remaider and quotient
	tst.w     D3             * Sets CCR
	bne       do             * Checks if remainder is 0
	divu      D2,D4          * if the check passes, update number
	move.w    D2,D0          * moves number to D0
	ext.l     D0             * makes sure number is long
	cvt2a     (A5),#5        * Converts number to Ascii
	stripp    (A5),#5        * stores number to buffer with number being first
	adda.l    D0,A5          * Adds string length to address
	move.b    #'*',(A5)+     * Adds astreck next to factor
	subq.l    #1,D2          * Decrements one from factor

    do: addq.l    #1,D2          * Increments factor
    	bra       for
	

	
  done: subq      #1,A5         * Removes the last astrick
  	clr.b     (A5)          * Outputs answer
  	lineout   answer	
	lineout   factors
	
	
     yo: lineout   skipln
    	 lineout   ask
	 linein    buffer      * Asks user if they want to do it again
	 cmpi     #1,D0
	 bne       message
	 ori.b    #$20,buffer  * Makes user input lowercase
	 cmpi.b   #'n',buffer  
	 beq       finally     
	 cmpi.b   #'y',buffer
	 bne       message
	 bra       redo

message: lineout valid
	 bra     yo
	    
	
finally: lineout   terminate	
	
	
	
	
	
	
	

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:  dc.b       'Nour Ali, Program #3, cssc1535',0
prompt: dc.b	   'Enter an Integer to factor (2..65535):',0
error:  dc.b       'Sorry, your input is not a valid integer.',0
ask:    dc.b       'Do you want to factor another integer (Y/N)?',0
valid   dc.b       'Please enter a valid response',0
skipln: dc.b	   0
terminate dc.b      'Program terminated.',0
answer: dc.b       'The factors of '
buffer: ds.b        82  *Atleast 80 bytes must be allocated for buffer
factors: ds.b       50  *Minimum of 40 is recommended since 2^16 is 65535
				
        end
