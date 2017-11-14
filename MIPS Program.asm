#PROGRAM: CONVERT HEXADECIMAL TO DECIMAL

.data
				 prompt: .asciiz "Enter a Hexadecimal Value: "
				 output1: .asciiz "Hexadecimal: " 
				 output2: .asciiz "Decimal: " 
				 invalid: .asciiz "Invalid Hexadecimal Number\n"
				 buffer: .space 9

.text
main:
				 #t0 - holds user input (hexadecimal)
				 #t2 - loop counter
				 #s1 - holds the decimal value
				 #s3 - holds length of string
				 #t3 - holds integer 9

				 #get hexadecimal value
				 la $a0, prompt               #address of string to print 
				 li $v0, 4                    #system call code for printing string = 4
				 syscall

				 li $v0, 8                    #system call code for reading string = 8
				 la $a0, buffer               #load byte space into address
				 li $a1, 9                	  #allot the byte space for hexadecimal
				 syscall
	
         addi $a1, $a0, 0        		  #move address of hexadecimal into $a1
				 jal STRLEN                   #call strlen procedure
  			 addi $s3, $t2, -1            #store length of string in s3 register
				 addi $s0, $zero, 8      			#initialize $t3 to 8
				 ble $s3, $s0, IF         		#if string length less than or equal to 8 branch to IF
				 bgt $s3, $s0, ELSE       		#if string length greater than 8 branch to ELSE
        
  IF:    li $s1, 0						        #initialize decimal value to 0
  			 li $t2, 1										#loop counter
  			 li $s4 '0'              		  #holds character '0'
  			 li $s5, '9' 									#holds character '9'
  			 li $s6, 'a' 									#holds character 'a'
  			 li $s7, 'f'							    #holds character 'f'
  			 li $t4, 'A'						    	#holds character 'A'
  			 li $t5, 'F'						    	#holds character 'F'			 
  
  FORLOOP:  lb $t3, ($a1)             #load the next character into t3
            
            ble $t3, $s5, AND         #if the character is less than or equal to 9
            ble $t3, $t5, AND2        #if the character is less than or equal to 'F'
            ble $t3, $s7, AND3        #if the character is less than or equal to 'f'
            j ELSE
            
  AND:      bge $t3, $s4, THEN        #and greater than or equal to 9 branch to LABEL1
  AND2:			bge $t3, $t4, THEN2       #and greater than or equal to 'A' branch to LABEL2
  AND3:     bge $t3, $s6, THEN3       #and greater than or equal to 'a' branch to LABEL3
            j ELSE                    #jump to ELSE
            
  THEN:			jal LABEL1                #jump to LABEL1
            j JUMP                    #jump to bottom of loop
            
  THEN2:		jal LABEL2                #jump to LABEL2
  					j JUMP                    #jump to bottom of loop
  
  THEN3: 		jal LABEL3                #jump to LABEL3
  					j JUMP                    #jump to bottom of loop
  
  JUMP:     beq $t2, $s3, PRINT       #if counter equals string length end loop
            addi $a1, $a1, 1          #increment the string pointer
            addi $t2, $t2, 1          #increment counter
            j FORLOOP                 #jump to the beginning of the loop
  
  
  
  LABEL1:   sub $t1, $t3, $s4          #get the int value of the character
 						sub $t6, $s3, $t2          #(userInput.length()- counter)
            li $t7, 1									 #loop counter 
 						li $t8, 16                 #base 16
 						li $v0, 16
            
            beq $t6, $zero, ZERO
 	LOOP:     beq $t7, $t6, DECIMAL      #if counter equals (userInput.length()- counter) end loop
 	          multu $v0, $t8             #16 *= 16
            mflo $v0 									 #store results in $v0 register
            addi $t7, $t7, 1           #increment counter
            j LOOP
 DECIMAL:  multu $t1, $v0
           mflo $v1
           j NONZERO
 ZERO:     addu $v1, $t1, $zero
 NONZERO:  addu $s1, $s1, $v1
           j EXIT   
 
 LABEL2:    sub $t1, $t3, $t4          #get the int value of the character
 						addi $t1, $t1, 10
 						sub $t6, $s3, $t2         #(userInput.length()- counter)
            li $t7, 1									 #loop counter 
 						li $t8, 16                 #base 16
 						li $v0, 16

            beq $t6, $zero, ZERO2
 	LOOP2:    beq $t7, $t6, DECIMAL2     #if counter equals (userInput.length()- counter) end loop
 	          multu $v0, $t8             #16 *= 16
            mflo $v0 									 #store results in $v0 register
            addi $t7, $t7, 1           #increment counter
            j LOOP2
 DECIMAL2:  multu $t1, $v0
            mflo $v1
            j NONZERO2
 ZERO2:     addu $v1, $t1, $zero
 NONZERO2:  addu $s1, $s1, $v1
            j EXIT
             
  LABEL3:   sub $t1, $t3, $s6          #get the int value of the character
 						addi $t1, $t1, 10
 						sub $t6, $s3, $t2          #(userInput.length()- counter)
            li $t7, 1									 #loop counter 
 						li $t8, 16                 #base 16
 						li $v0, 16
  
            beq $t6, $zero, ZERO3
 	LOOP3:    beq $t7, $t6, DECIMAL3     #if counter equals (userInput.length()- counter) end loop
 	          multu $v0, $t8             #16 *= 16
            mflo $v0 									 #store results in $v0 register
            addi $t7, $t7, 1           #increment counter
            j LOOP3
 DECIMAL3:  multu $t1, $v0
            mflo $v1
            j NONZERO3
 ZERO3:     addu $v1, $t1, $zero
 NONZERO3:  addu $s1, $s1, $v1
            j EXIT
		
 	
	ELSE:  la $a0, invalid               #address of string to print
         li $v0, 4								     #system call code for printing string = 4
         syscall 
         j END     
	
	STRLEN:     li $t2, 0			               #initialize count to 0
	WHILELOOP:  lb $t4, ($a0)           #load the next character into t4
							beq $t4, $zero, EXIT     #exit loop if character is null
							addi $a0, $a0, 1         #increment the string pointer
							addi $t2, $t2, 1         #increment the count
						  j WHILELOOP              #return to the top of the loop
						  
	EXIT:   jr $ra

	LESS:   li $t0, 100000
          divu $s1, $t0
          mflo $s1
          mfhi $v1
        
          move $a0, $s1                #primary address = s1 address (load pointer)
          li $v0, 1                    #system call code for printing integer = 1
          syscall
            
          move $a0, $v1                #primary address = v1 address (load pointer)
          li $v0, 1                    #system call code for printing integer = 1
          syscall
          j END

	PRINT:  la $a0, output1              #address of string to print
          li $v0, 4								     #system call code for printing string = 4
          syscall

          la $a0, buffer               #reload byte space to primary address
          sub $a1, $a1, $s3 
          addi $a0, $a1, 1             #primary address = t1 address (load pointer)
          li $v0, 4                    #system call code for printing string = 4
          syscall
        
          la $a0, output2              #address of string to print
          li $v0, 4								     #system call code for printing string = 4
          syscall
	
          blt $s1, $zero, LESS
          move $a0, $s1                #primary address = s1 address (load pointer)
          li $v0, 1                    #system call code for printing integer = 1
          syscall
 
 END:     li $v0, 10                   # terminate program run and
          syscall                      # Exit 

