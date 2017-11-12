#PROGRAM: CONVERT HEXADECIMAL TO DECIMAL

.data
				 prompt: .asciiz "Enter a Hexadecimal Value: \n"
				 output1: .asciiz "The Decimal Value of " 
				 output2: .asciiz " is " 
				 invalid: .asciiz "Invalid Hexadecimal Number\n"
				 buffer: .space 4

.text
main:
				 #t0 - holds user input (hexadecimal)
				 #t2 - loop counter
				 #s0 - holds the decimal value
				 #s1 - holds length of string
				 $t3 - holds integer 9

				 #get hexadecimal value
				 la $a0, prompt               #address of string to print 
				 li $v0, 4                    #system call code for printing string = 4
				 syscall

				 li $v0, 8                    #system call code for reading string = 8
				 la $a0, buffer
				 la $a0, buffer               #load byte space into address
				 li $a1, 4                	  #allot the byte space for hexadecimal
				 move $t0, $a0					 		  #move hexadecimal into $t0 register
				 syscall
	
				 la $a0, $t0              		#load address of hexadecimal
				 jal STRLEN                   #call strlen procedure
				 addi $a1, $a0, 0        			#move address of hexadecimal into $a1
				 addi $s1, $t2, 0        			#move length of string into $s1
				 addi $t3, $zero, 8      			#initialize $t3 to 8
				 ble $s1, $t3, IF         		#if string length less than or equal to 8 branch to IF
				 bgt $s1, $t3, ELSE       		#if string length greater than 8 branch to ELSE
        
  IF:   
         sub $t5, $s2, 1
         addi $s1, $zero, 0						#initialize decimal value to 0
  			 li $s3, $t5              		#holds length of string - 1
  			 li $t2, 1										#loop counter
  			 li $s4 '0'              		  #holds character '0'
  			 li $s5, '9' 									#holds character '9'
  			 li $s6, 'a' 									#holds character 'a'
  			 li $s7, 'f'							    #holds character 'f'
  			 li $t4, 'A'						    	#holds character 'A'
  			 li $t5, 'F'						    	#holds character 'F'
  			 
  FORLOOP:
            beq $t2, $s3, PRINT       #if counter equals string length - 1 end loop
            lb $t3, 0($a1)            #load the next character into t3
            bge $t3, $s4, AND         #if the character is greater than 0
  AND:      ble $t3, $s5, THEN        # and less than 9 branch to LABEL1
  THEN:			jal LABEL1
            j JUMP
            bge $t3, $s6, AND2        #if the character is greater than 'a'
  AND2:			ble $t3, $s7, THEN2       #and less than 'f' 
  THEN2:		jal LABEL2                #jump to LABEL2
  					j JUMP                    
  					bge $t3, $t4, AND3        #if the character is greater than 'A'
  AND3:     ble $t3, $t5, THEN3       #and less than 'F' branch to LABEL3
  THEN3: 		jal LABEL3
  					j JUMP                    #skips else 
            j ELSE                    #jump to ELSE
  JUMP:     addi $a1, $a1, 1          #increment the string pointer
            addi $t2, $t2, 1          #increment counter
            j FORLOOP                 #jump to the beginning of the loop
  
  
  
  LABEL1:   
 						sub $t1, $t3, $s4          #get the int value of the character
 						addu $t6, $s3, $t2         #(userInput.length()- counter)
            li $t7, 1									 #loop counter 
 						li $t8, 16                 #base 16
 						li $v0, 16
 	LOOP:     beq $t7, $t6, DECIMAL      #if counter equals (userInput.length()- counter) end loop
 	          multu $v0, $t8             #16 *= 16
            mflo $v0 									 #store results in $v0 register
            addi $t7, $t7, 1           #increment counter
            j LOOP
 DECIMAL:   mult $t1, $v0
            mflo $v1
            addu $s1, $s1, $v1
            j EXIT
            
 
 LABEL2:   
 						sub $t1, $t3, $s6          #get the int value of the character
 						addi $t1, $t1, 10
 						addu $t6, $s3, $t2         #(userInput.length()- counter)
            li $t7, 1									 #loop counter 
 						li $t8, 16                 #base 16
 						li $v0, 16
 	LOOP2:    beq $t7, $t6, DECIMAL2     #if counter equals (userInput.length()- counter) end loop
 	          multu $v0, $t8             #16 *= 16
            mflo $v0 									 #store results in $v0 register
            addi $t7, $t7, 1           #increment counter
            j LOOP2
 DECIMAL2:  mult $t1, $v0
            mflo $v1
            addu $s1, $s1, $v1
            j EXIT
            
  LABEL3:   
 						sub $t1, $t3, $t4          #get the int value of the character
 						addi $t1, $t1, 10
 						addu $t6, $s3, $t2         #(userInput.length()- counter)
            li $t7, 1									 #loop counter 
 						li $t8, 16                 #base 16
 						li $v0, 16
 	LOOP3:    beq $t7, $t6, DECIMAL3     #if counter equals (userInput.length()- counter) end loop
 	          multu $v0, $t8             #16 *= 16
            mflo $v0 									 #store results in $v0 register
            addi $t7, $t7, 1           #increment counter
            j LOOP3
 DECIMAL3:  mult $t1, $v0
            mflo $v1
            addu $s1, $s1, $v1
            j EXIT
 		
 	
	ELSE:  
	       la $a0, invalid               #address of string to print
         li $v0, 4								     #system call code for printing string = 4
         syscall      
	
	STRLEN: 
					li $t2, 0			               #initialize count to 0
	WHILELOOP:   
					    lb $t4, 0($a0)           #load the next character into t4
							beq $t4, $zero, EXIT     #exit loop if character is null
							addi $a0, $a0, 1         #increment the string pointer
							addi $t2, $t0, 1         #increment the count
						  j WHILELOOP              #return to the top of the loop
						  
	EXIT:
	        jr $ra
	
	
	PRINT:  
					la $a0, output1              #address of string to print
          li $v0, 4								     #system call code for printing string = 4
          syscall

          la $a0, buffer               #reload byte space to primary address
          move $a0, $t0                #primary address = t1 address (load pointer)
          li $v0, 4                    #system call code for printing string = 4
          syscall
        
          la $a0, output2              #address of string to print
          li $v0, 4								     #system call code for printing string = 4
          syscall
	
				  la $a0, buffer               #reload byte space to primary address
          move $a0, $s1                #primary address = s1 address (load pointer)
          li $v0, 1                    #system call code for printing integer = 1
          syscall

