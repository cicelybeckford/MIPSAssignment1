#PROGRAM: CONVERT HEXADECIMAL TO DECIMAL

.data  
        output1: .asciiz "\n" 
        invalid: .asciiz "Invalid Hexadecimal Number\n"
        buffer:  .space 9

.text
main:           li $v0, 8                  #system call code for reading string = 8
                la $a0, buffer             #load byte space into address
                li $a1, 9                  #allot the byte space for hexadecimal
                syscall
                        
                addiu $a1, $a0, 0          #move address of hexadecimal into $a1
                jal STRLEN                 #call procedure that computes the length of the string
                move $s3, $t2              #store length of string in s3 register
                              
                li $s1, 0						       #initialize decimal value to 0
                li $t2, 1								   #loop counter
                li $s4, '0'                #holds character '0'
                li $s5, '9' 						   #holds character '9'
                li $s6, 'a' 						   #holds character 'a'
                li $s7, 'f'							   #holds character 'f'
                li $t4, 'A'						     #holds character 'A'
                li $t5, 'F'						     #holds character 'F'		 
                        
FORLOOP:        move $t0, $t3
                lb $t3, ($a1)              #load the next character into t3
                beq $t0, 32, DO            #if the character in $t0(previous character) is a space
                bne $t2, 1, NOSPACE        #and it is not the first character jump to NOSPACE 
DO:             beq $t3, 32, JUMP          #or if $t0 and $t3 (current character) are spaces jump to bottom of loop
                                  
NOSPACE:				ble $t3, $s5, AND          #if the character is less than or equal to 9
                ble $t3, $t5, AND2         #if the character is less than or equal to 'F'
                ble $t3, $s7, AND3         #if the character is less than or equal to 'f'
                j INVALID
                                  
AND:            bge $t3, $s4, THEN         #and greater than or equal to 9 branch to LABEL1
AND2:			      bge $t3, $t4, THEN2        #and greater than or equal to 'A' branch to LABEL2
AND3:           bge $t3, $s6, THEN3        #and greater than or equal to 'a' branch to LABEL3
                j INVALID                  #jump to INVALID procedure
                                  
THEN:			      jal LABEL1                 #jump to LABEL1
                j JUMP                     #jump to bottom of loop
                                  
THEN2:		      jal LABEL2                 #jump to LABEL2
                j JUMP                     #jump to bottom of loop
                        
THEN3: 		      jal LABEL3                 #jump to LABEL3
                        
JUMP:           beq $t2, $s3, PRINT        #if counter equals string length end loop
                addiu $a1, $a1, 1          #increment the string pointer
                addiu $t2, $t2, 1          #increment counter
                j FORLOOP                  #return to the top of the loop
                        
                        
LABEL1:         subu $t1, $t3, $s4         #get the integer value of the character
                subu $t6, $s3, $t2         #length of hexadecimal - counter
                li $t7, 1									 #loop counter 
                li $t8, 16                 #load 16 into register $t8 
                li $v0, 16                 #load 16 into register $v0               
                beq $t6, $zero, ZERO       #if the character is the last character in the string jump to ZERO
                
LOOP:           beq $t7, $t6, DECIMAL      #if counter equals $t6 end loop
                multu $v0, $t8             #16 *= 16
                mflo $v0 									 #store result in $v0 register
                addiu $t7, $t7, 1          #increment counter
                j LOOP                     #return to top of loop
                
DECIMAL:        multu $t1, $v0             #multiply the integer by the results to get its value in the decimal
                mflo $v1                   #store result in the $v1 register
                j NONZERO                  #jump to NONZERO label
ZERO:           addu $v1, $t1, $zero       #store the integer value of the character in $v1 register 
NONZERO:        addu $s1, $s1, $v1         #add the contents of the $v1 register to the decimal value
                j EXIT                     #jump to EXIT label
                       
LABEL2:         sub $t1, $t3, $t4          #get the int value of the character
                addi $t1, $t1, 10          #add 10 to the integer value of letters to get the accurate value
                sub $t6, $s3, $t2          #length of hexadecimal - counter
                li $t7, 1									 #loop counter 
                li $t8, 16                 #load 16 into register $t8
                li $v0, 16                 #load 16 into register $v0
                beq $t6, $zero, ZERO       
                j LOOP                     #jump to LOOP
                                   
LABEL3:         sub $t1, $t3, $s6          #get the int value of the character
                addi $t1, $t1, 10          #add 10 to the integer value of letters to get the accurate value
                sub $t6, $s3, $t2          #length of hexadecimal - counter
                li $t7, 1									 #loop counter 
                li $t8, 16                 #load 16 into register $t8
                li $v0, 16                 #load 16 into register $v0
                beq $t6, $zero, ZERO
                j LOOP                     #jump to LOOP
                          	
INVALID:        addu $v1, $t9, $s3           #add contents of $s3 and $t9
                beq $v1, 8, NEWLINE          #if the length of the user input
                beq $t9, 8, NEWLINE          #was 8 output a newline character
                j NOLINE                     #if not jump to NOLINE
NEWLINE:        la $a0, output1              #address of string to print
                li $v0, 4								     #system call code for printing string = 4
                syscall
                
NOLINE:         la $a0, invalid              #address of string to print
                li $v0, 4								     #system call code for printing string = 4
                syscall 
                j END                        #jump to label END
                        
STRLEN:         li $t2, 0			               #initialize count to 0
WHILELOOP:      lb $t4, ($a0)                #load the next character into $t4
                beq $t4, $zero, CHECK        #exit loop if character is null
                addi $a0, $a0, 1             #increment the string pointer
                addi $t2, $t2, 1             #increment the count
                j WHILELOOP                  #return to the top of the loop
                            
CHECK:          subiu $a0, $a0, 1            #decrement the string pointer
                lb $t4, ($a0)                #load character into $t4
                beq $t4, 10, LESS            #if previous character is equal to DLE jump to LESS
                j SPACE                      #if not jump to SPACE
                                        
LESS:           subiu $t2, $t2, 1            #decrement string length count
                subiu $a0, $a0, 1            #decrement string pointer
                lb $t4, ($a0)                #load character into $t4
                                                   
SPACE:          bne $t4, 32, EXIT            #if the character in $t4 is not a space jump to EXIT
                addiu $t9, $t9, 1            #otherwise increment value in $t9
                subiu $t2, $t2, 1            #and decrement string length count
                beq $t2, 0, INVALID          #if the length of string is equal to 0 jump to INVALID
                j CHECK                      #return to top of CHECK label
                                    
EXIT:           jr $ra                       #return to the address in the $ra register

NEGATIVE:       li $t0, 100000               #load 100000 into register $t0
                divu $s1, $t0                #divide the decimal value by 100000 to split 
                mflo $s1                     #store the quotient in $s1 register
                mfhi $v1                     #store the remainder in the $v1 register     
                bne $t9, 0, NOTEIGHT         #if length of the input was not 8 output a newline character
                la $a0, output1              #address of string to print
                li $v0, 4								     #system call code for printing string = 4
                syscall
                            
NOTEIGHT:		    move $a0, $s1                #primary address = s1 address (load pointer)
                li $v0, 1                    #system call code for printing integer = 1
                syscall                                
                move $a0, $v1                #move contents of $v1 register into $a0
                li $v0, 1                    #system call code for printing integer = 1
                syscall
                j END                        #jump to label END

PRINT:          blt $s1, $zero, NEGATIVE     #if the decimal value is negative jump to NEGATIVE label           
                addu $v1, $t9, $s3           #otherwise add $s9 and $t9 and store the results in $v1 
                beq $v1, 8, LINE             #if the length of the user input
                beq $t9, 8, LINE             #was 8 output a newline character
                j SKIP                       #if not jump to SKIP
                
LINE:           la $a0, output1              #address of string to print
                li $v0, 4								     #system call code for printing string = 4
                syscall
                          
SKIP:          	move $a0, $s1                #move decimal value into a0 register
                li $v0, 1                    #system call code for printing integer = 1
                syscall
                     
END:            li $v0, 10                   #terminate program 
                syscall                      #and exit