*Nour Ali, Program #4, cssc1535

	ORG $6000
	

product: link A6,#0             

	 movem.l D1-D2,-(SP)
	 move.w  8(A6),D1        	 * Add the first parameter a to D1
	 move.w  10(A6),D2		 * Add the second parameter b to D2
	 andi.l #$0000FFFF,D1	 
	 cmp.w   D2,D1                   * Set The CCR
	 BHS     skip         	         * If a>=b goto skip 
	 
       *if a<b return product(b,a).
	
        move.w  D1,-(SP)	         * push a on to the stack
	move.w  D2,-(SP)	         * push b on to the stack
	jsr     product 	         * call the subroutine
	adda.l  #4,SP   	         * add 2 words to the stack pointer
	bra     out
	 
       * if(b==1) return a   
  skip:  cmpi.w   #1,D2        		 * set the CCR
         beq     return         	 * if(b==1) goto return
	 
       * if(b==0) return 0
	 tst.w    D2		         * set the CCR
	 beq      done                   * if(b==0) goto done
      
       * if(b!=0) return a + product(a, b-1)
 
	 subi.w  #1,D2           	 * b-1
	 move.w  D2,-(SP)        	 * push b
	 move.w  D1,-(SP)       	 * push a
	 jsr     product
	 adda.l  #4,SP
	 add.l   D1,D0       
	 bra     out
	
return:  move.l   D1,D0                  * return a
  	 bra      out
 done:   moveq.l  #0,D0	                 * return 0
  out:   movem.l (SP)+,D1-D2     
 	 unlk     A6
	 rts 
	 end
 
 	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 