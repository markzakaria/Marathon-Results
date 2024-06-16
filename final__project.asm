include 'emu8086.inc'

JMP START

DATA SEGMENT 
    	N     DW  1 DUP(?)                                                              
	NUMBERS   DB  100 DUP (?)
	TIME      DB  100 DUP (?)
	MSG0      DB 'Enter the total number of players maxmium 100 player : ',0    
	MSG1      DB 0DH,0AH,'Enter the numbers of players: ',0AH,0DH,0      ;0D FOR ENTER , OA FOR NEW LINE
	MSG2      DB 0DH,0AH,'Enter the time of players: ',,0AH,0DH,0 
	MSG3      DB 0DH,0AH,'Times after sorting: ',0AH,0DH,0
	                               
DATA ENDS  

CODE SEGMENT   
    
        	ASSUME DS:DATA CS:CODE     
START:	MOV AX, DATA
	    	MOV DS, AX                    
	   
	    	DEFINE_SCAN_NUM           
       	    DEFINE_PRINT_STRING 
        	DEFINE_PRINT_NUM
        	DEFINE_PRINT_NUM_UNS
        	
        	
        	 LEA  SI,MSG0
        	 CALL PRINT_STRING
        	 CALL SCAN_NUM       ; scan total number of playes
        	 MOV  BYTE PTR[N],CL
             PRINT 0AH      

	     
	    	LEA SI,MSG1
	       	CALL PRINT_STRING
	    	MOV SI, 0
	    	
	    	
	 
LOOP1:  	CALL SCAN_NUM       ;Scan the numbers of plyers one by one and store it in the memory
        	MOV NUMBERS[SI],CL
        	INC SI  
        	PRINT 0AH      
        	PRINT 0DH        
        	CMP SI,[N]    ; if SI reached to N ...scans all numbers of players and will exit from the loop
        	JNE LOOP1
       
        
        
	    	LEA SI,MSG2
	    	CALL PRINT_STRING         ; the same for scanning time
	    	MOV SI, 0
	   
LOOP2:  	CALL SCAN_NUM 
        	MOV TIME[SI],CL
        	INC SI  
        	PRINT 0AH       
        	PRINT 0DH         
        	CMP SI,[N] 
        	JNE LOOP2  
       
        
        
	    	;SORTING using bubble sort method we will put in cl number of players that i want to cmp between them and in
	    	; ch ..number of comparisons
	    	;which every loop we will cmp between the one ml and the ml after it and the biggest number will put in the last ML
	    	; we will repeat this numper of comparisons which stored in ch dep on the number of players that we cmp beteem them
	    	; so at the end whole 2 tables will be arranged       
	    	MOV CL,BYTE PTR[N]
	    	DEC CL                
OUTER:  
            LEA SI,TIME 
            LEA DI,NUMBERS
            MOV CH,BYTE PTR[N]
            DEC CH      
	    
	   
INNER:  	MOV  AL, [SI]
	    	MOV  DL, [DI]
	    	INC  SI 
	    	INC  DI
	    	CMP  [SI], AL
	    	JA   SKIP           ;if cf=0 num2>num1  num2 != num1 skip and dont exchange as the smallest number in the right place
	    	XCHG AL, [SI]
	    	MOV  [SI-1], AL
	    	XCHG DL, [DI]
        	MOV  [DI-1], DL  
        
SKIP:   
            DEC CH
            JNZ INNER   ;if not equal to zero continue comparison between the elements of the table if not dec the cl 
            DEC CL
            JNZ OUTER   
         	
	    
	    	

	    	LEA SI,MSG3
	    	CALL PRINT_STRING
	    	LEA SI,TIME 
	    	LEA DI,NUMBERS  
	    	MOV AH,0  
	    	MOV CL,BYTE PTR[N]
	        MOV CH,0    ; put in cx the number of players that will loop and print dep on it
	        
PRINT_TABLE:  	MOV AL,[DI]     
        	CALL PRINT_NUM_UNS    
        	PRINT 09H            
        	MOV AL,[SI]
        	CALL PRINT_NUM_UNS
        	PRINT 0AH             
        	PRINT 0DH   
        	INC SI 
        	INC DI
        	LOOP PRINT_TABLE    
        	

CODE ENDS
 
END START
  

ret








