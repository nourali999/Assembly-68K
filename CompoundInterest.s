*----------------------------------------------------------------------
* Programmer: Nour Ali
* Class Account: cssc1535
* Assignment or Title: Compound Interest
* Filename: prog2.s
* Date completed:  3/24/2019
*----------------------------------------------------------------------
* Problem statement: Determine the future value of an investment
* Input: Principle, Monthly, Interest, year
* Output: future value of the investment
* Error conditions tested: none
* Included files: float macros
* Method and/or pseudocode: none
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
	initF			* For floating point macros only	
	
	
	
        lineout     title       
	lineout     bigP        	 * Asks user to input P (i.e. principle).
	floatin     buffer		 * Stores P as ASCII to buffer.
	cvtaf       buffer,D1   	 * Stores P to D1 as float.
	lineout     littlep     	 * Asks user to input little p (i.e. monthly).
	floatin     buffer		 * stores little p as ASCII to buffer.
	cvtaf       buffer,D7   	 * Stores little p as float to D7.
	lineout     r           	 * Asks user for Interest rate.
	floatin     buffer       	 * Stores r as ASCII to buffer.
	cvtaf       buffer,D2    	 * Stores r as float to D2.
	lineout     t            	 * Asks user for the user for number of years
	floatin     buffer       	 * Stores t to buffer as ASCII
	cvtaf       buffer,D3    	 * Stores t as float to D3
	itof        #1,D4                * Stores 1 to D4 as float
	itof        #12,D5       	 * Stores 12 to D5 as float
	fmul        D5,D3       	 * stores 12*t to D3
	fdiv        D5,D2        	 * stores r/12 to D2
	fadd        D2,D4        	 * stores (1+r/12) to D4
	itof        #1,D6                * stores 1 to D6 as float
	
	
	fpow        D4,D3       	 * stores (1+r/12)^(12*t) to D0
	move.l      D0,D3        	 * copies content in line above to D3
	fmul        D0,D1                * stores P*(1+r/12)^(12*t) to D1
	fsub        D6,D3                * stores ((1+r/12)^(12*t))-1 to D3
	fdiv        D2,D3                * stores ((1+r/12)^(12*t))-1)) / (r/12) to D3
        fmul        D7,D3                * stores p*(((1+r/12)^(12*t))-1)/ (r/12) to D3
	fmul        D4,D3                * p*(((1+r/12)^(12*t)-1)) / ((r/12))*(1+r/12).
	
	
	fadd       D3,D1    * Adds P*(1+r/12)^(12*t) and p*(((1+r/12)^(12*t)-1)) / ((r/12))*(1+r/12).
	cvtfa      calc,#2  * stores ACSII answer to calc
	lineout    answer   * Outputs prompt in answer and null terminates with calc
	
	


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations


title:      dc.b     'Nour Ali, Program #1, cssc1535',$0A,0 *$0A is for skipln
bigP:       dc.b     'Please enter the initial investment',0
littlep:    dc.b     'Please enter the monthly deposit amount',0
r:          dc.b     'Please enter the anual interest rate in decimal (i.e. .06 not 6%)',0
t:          dc.b     'Please enter the number of years',0   

buffer:     ds.b     82    *floatin supports up to 80 characters

answer:     dc.b     $0A,'At the end of the given period your investment will be worth $' 
calc:       ds.b     8     *8 bytes for 32 bit floating IEEE formated to store answer

        end
