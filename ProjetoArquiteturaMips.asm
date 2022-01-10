.data

#CODE GENERATOR

### WORD BANK ###
BLUE:     .byte 'B'
GREEN:    .byte 'G'
ORANGE:   .byte 'O'
WHITE:    .byte 'W'
YELLOW:   .byte 'Y'
RED:      .byte 'R'

CODE: .space 400

MSG1: .asciiz "O Codigo e: "
MSG3: .asciiz "O Codigo era: "
ERROR: .asciiz "Introduza uma cor do universo de cores (B, G, O, W, Y, R)"

CODE_NUMBER : .asciiz "Quantos digitos no Codigo (Minimo 4):"
TRIES_NUMBER : .asciiz "Quantos tentativas (Minimo 2):"


BLACKCOUNTMSG: .asciiz "Tens "
BLACKCOUNTMSG1: .asciiz " cores certas na posicao correta"

WHITECOUNTMSG: .asciiz "Tens "
WHITECOUNTMSG1: .asciiz " cores certas na posicao errada"

LOSE: .asciiz "Perdeste!"

#PONTOS

PONTOS1: .asciiz "Ten(s) "
PONTOS2: .asciiz " pontos!"
PONTOS3: .asciiz "Ganhaste!"
PONTOS4: .asciiz "Recebeste "


#PRINT BOARD

BOARD: .space 100

.eqv DATA_SIZE 1      #SAME AS #DEFINE in C

#READ TRIES

MSG2: .asciiz " Tentativa:"
TRIES: .space 400

TRIES_TEMP: .space 400
CODE_TEMP: .space 400
REMOVE_TRY:       .byte 'X'
REMOVE_CODE:      .byte 'Z'

#E

confirmation_e: .asciiz     "Prime 'e' para parar, outra tecla para continuar"
e: .asciiz "e"
input_e: .space 80


#MISCELLANEOUS

NewLine:    .asciiz     "\n"
Tab:    .asciiz     "\t"
buffer: .space 20

.text


main:

	li $s5, 0

	j NUMBER_DIGITS_CODE
	
NUMBER_DIGITS_CODE:

	li $v0, 4
	la $a0, CODE_NUMBER 
	syscall 

	li $v0, 5             
	syscall               
	move $t2, $v0	
	
	slti $t4, $t2, 4
	beq $t4, 1, NUMBER_DIGITS_CODE
	
	j NUMBER_DIGITS_TRIES
	
NUMBER_DIGITS_TRIES:

	li $v0, 4
	la $a0, TRIES_NUMBER
	syscall 
	
	li $v0, 5             
	syscall               
	move $t3, $v0	

	slti $t4, $t3, 2
	beq $t4, 1, NUMBER_DIGITS_TRIES
	
	j LOOP_GAME
	
LOOP_GAME:

	li $t0, 0
	li $t1, 0

	li $v0, 4                		# printf("\n")
	la $a0, PONTOS1
	syscall
	
	li $v0, 1                		
	move $a0, $s5
	syscall
	
	li $v0, 4                		# printf("\n")
	la $a0, PONTOS2
	syscall
	
	li $v0, 4                		# printf("\n")
	la $a0, NewLine
	syscall

	j LOOP_RANDOM


LOOP_RANDOM:
	beq $t0, $t2, CHECK_REPEATED_CODE

	li $a1, 6
	li $v0, 42         		 # Service 42, random int
	syscall           		 # Generate random int (returns in $a0)

	beq $a0, 0, CBLUE		 #Switch (valor)
	beq $a0, 1, CGREEN
	beq $a0, 2, CORANGE
	beq $a0, 3, CWHITE
	beq $a0, 4, CYELLOW
	beq $a0, 5, CRED
  
CBLUE:
	la $a0, BLUE
	lb $t1, 0($a0)
	la $a0, CODE
	add $a0, $a0, $t0
	sb $t1, 0($a0)

	addi $t0, $t0 ,1  
	j LOOP_RANDOM

CGREEN:   
	la $a0, GREEN
	lb $t1, 0($a0)
	la $a0, CODE
	add $a0, $a0, $t0
	sb $t1, 0($a0)

	addi $t0, $t0 ,1
	j LOOP_RANDOM

CORANGE:  
	la $a0, ORANGE
	lb $t1, 0($a0)
	la $a0, CODE
	add $a0, $a0, $t0
	sb $t1, 0($a0)

	addi $t0, $t0 ,1
	j LOOP_RANDOM

CWHITE:  
	la $a0, WHITE
	lb $t1, 0($a0)
	la $a0, CODE
	add $a0, $a0, $t0
	sb $t1, 0($a0)

	addi $t0, $t0 ,1
	j LOOP_RANDOM

CYELLOW:  
	la $a0, YELLOW
	lb $t1, 0($a0)
	la $a0, CODE
	add $a0, $a0, $t0
	sb $t1, 0($a0)

	addi $t0, $t0 ,1
	j LOOP_RANDOM

CRED:
	la $a0, RED
	lb $t1, 0($a0)
	la $a0, CODE
	add $a0, $a0, $t0
	sb $t1, 0($a0)

	addi $t0, $t0 ,1
	j LOOP_RANDOM

CHECK_REPEATED_CODE:

	li $t0, 0
	li $t8, 0
	li $t6, 0

	move $t5, $t2
	addi $t5, $t5, 1
	
	la $s3, CODE
	
	j CHECK_REPEATED_CODE_WHILE_1
	
CHECK_REPEATED_CODE_WHILE_1:

	slt $t7, $t8, $t5   #t8<t5   $t8=i
	beq $t7, $0, PRINT_LOOP_RANDOM_RESET
	
	j CHECK_REPEATED_CODE_WHILE_RESET
	
CHECK_REPEATED_CODE_WHILE_RESET:

	move $t6, $t8
	addi $t6, $t6, 1
	la $s2, CODE
	add $s2, $s2, $t6
	
CHECK_REPEATED_CODE_WHILE_2:

	slt $t7, $t6, $t2   #t6<t2   $t6=j
	beq $t7, $0, CHECK_REPEATED_CODE_BACK
	

	
	lb      $t7,0($s2)
	lb      $t9, 0($s3)
	
	beq $t7, $t9, LOOP_RANDOM

	addi $t6, $t6, 1
	addi $s2, $s2, 1
	
	j CHECK_REPEATED_CODE_WHILE_2
	
CHECK_REPEATED_CODE_BACK:

	addi $t8, $t8, 1
	addi $s3, $s3, 1

	j CHECK_REPEATED_CODE_WHILE_1

PRINT_LOOP_RANDOM_RESET:

	la $t0, MSG1
	li $v0, 4
	move $a0, $t0
	syscall
	li $t0, 0

j PRINT_LOOP_RANDOM



PRINT_LOOP_RANDOM:  # imprimir codigo
	beq $t0, $t2, BOARD_
	
	lb $t1, CODE($t0)
	
	li $v0, 11
	move $a0, $t1
	syscall

	addi $t0, $t0, 1
	
	j PRINT_LOOP_RANDOM
	
	
BOARD_:

	li $v0, 4                		# printf("\n")
	la $a0, NewLine
	syscall
	
	
	
	la $s6, BOARD				     #Matriz 
	
	
	move $a2, $t2
	move $a3, $t3
	
	li $t1, 0
	
	jal BOARD_PRINT
	j PRINT_LOOP_RANDOM_RESET_END

BOARD_PRINT:
     li $t0, 0          	# i = 0
     add $t3, $zero, $a0
     j BOARD_PRINT_WHILE1
	
BOARD_PRINT_WHILE1:   				#First for loop printing the Matrix
	li $t2, 0
	
	slt $t2, $t0, $a3                   			# if (i < size) continue
        beq $t2, $zero, BOARD_PRINT_END       	# If not, already printed all matrix 
    
    	li $v0, 1
        addi $a0, $t0, 0
        syscall
    	
    	la $a0, MSG2
     	li $v0, 4
   	syscall
   	
	#--------------------------------------------------------------------------READ TRIES---------------------------------------------------------------------------------------
     	la $s0, TRIES			# s2 = apontador para TRIES
     	la $s1, CODE  			# s4 = apontador para CODE
     
       
    	move $a0,$s0				# ler as tentativas
     
     	li $a1,20
     	li $v0,8
     	syscall
       
	li    $t6, 0 	
	
	j COMPARE_LOOP_GOOD
	
   	
BOARD_PRINT_WHILE2:				#Second for loop printing the Matrix
        li $t2, 0	
        slt $t2, $t1, $a2             		# if (j < size) continue
        beq $t2, $zero, BOARD_RESET_PRINT       # if not, already printed the whole line

        mul $t5, $t0, $a2  			# t5 = rowIndex * colSize
        add $t5, $t5, $t1  			# t5 = (rowIndex * colSize) + colIndex
        sll $t4, $t5, 0   			# t5 = (rowIndex * colSize + colIndex) * DATA_SIZE
        add $t5, $t4, $s6  			# t5 = (rowIndex * colSize + colIndex * DATA_SIZE) + base adress
        
        lb $t8, ($s0)
        sb $t8, ($t5)
      
        addi $t1, $t1, 1                	# j++
        addi $s0, $s0, 1
        j BOARD_PRINT_WHILE2
        
BOARD_RESET_PRINT:

	li $t1, 0 #COLS   j=0
	li $t2, 0 #LINHAS i=0

BOARD_PRINT_ALL_MATRIX:
	li $t8, 0
	sle $t8, $t2, $t0                   			# if (i <= size) continue
        beq $t8, $zero, BOARD_PRINT_END_LINE        	# If not, already printed all matrix 
        li $t1, 0
        
BOARD_PRINT_ALL_MATRIX2:

	li $t8, 0
   	slt $t8, $t1, $a2             		# if (j < size) continue
        beq $t8, $zero, BOARD_PRINT_ALL_MATRIX_I       # if not, already printed the whole line

        mul $t5, $t2, $a2  			# t5 = rowIndex * colSize
        add $t5, $t5, $t1  			# t5 = (rowIndex * colSize) + colIndex
        sll $t4, $t5, 0   			# t5 = (rowIndex * colSize + colIndex) * DATA_SIZE
        add $t5, $t4, $s6  			# t5 = (rowIndex * colSize + colIndex * DATA_SIZE) + base adress
	 
	li $v0, 11
        lb $a0, 0($t5)                          # printf("%d", c)
        syscall
        
        li $v0, 4
        la $a0, Tab                 		# printf("\t")
        syscall
        
        addi $t1, $t1, 1
        j BOARD_PRINT_ALL_MATRIX2
        
BOARD_PRINT_ALL_MATRIX_I:         

        li $v0, 4
        la $a0, NewLine
        syscall
    
        addi $t2, $t2, 1                	# i++  
        
	j BOARD_PRINT_ALL_MATRIX                                             
 
BOARD_PRINT_END_LINE :                		# printf("\n")
	
        li $v0, 4
        la $a0, NewLine
        syscall
    
        addi $t0, $t0, 1                	# i++
    
	beq $t0, 10, POINTS
        
        j BOARD_PRINT_WHILE1
        
BOARD_PRINT_END:                      		# End
        jr $ra

 j BOARD_PRINT_WHILE2
 
 
 

COMPARE_LOOP_GOOD:

	beq $t6, $a2, START_COMPARE

	lb $t8, ($s0)                   # get next char from TRIES
	lb 	$t5, WHITE			 # they are valid
	beq     $t8, $t5, GOOD            
	lb 	$t5, BLUE
	beq     $t8, $t5, GOOD  
	lb 	$t5, GREEN		
	beq     $t8, $t5, GOOD  
	lb 	$t5, YELLOW	
	beq     $t8, $t5, GOOD  
	lb 	$t5, ORANGE	
	beq     $t8, $t5, GOOD  
	lb 	$t5, RED
	beq     $t8, $t5, GOOD  
	
	li $v0, 4
	la $a0, ERROR
	syscall
	
	li $v0, 4                		# printf("\n")
	la $a0, NewLine
	syscall
	
	j BOARD_PRINT_WHILE1
	
GOOD:

	addi 	$t6, $t6, 1		   #incrementar loop para verificar GOOD
	addi    $s0,$s0,1                  # point to next char no input
	j COMPARE_LOOP_GOOD	
	
	
START_COMPARE:
	# comeca por copiar o TRIES e o CODE para variaveis temporarias
	li $t5, 0
START_COMPARE_LOOP:
	la $t6, TRIES
	la $t2, TRIES_TEMP
	add $t6, $t6, $t5
	add $t2, $t2, $t5
	lb $t3, 0($t6)
	sb $t3, 0($t2)

	la $t6, CODE
	la $t2, CODE_TEMP
	add $t6, $t6, $t5
	add $t2, $t2, $t5
	lb $t3, 0($t6)
	sb $t3, 0($t2)

	addi $t5, $t5, 1
	beq $t5, $a2, BLACKCOUNT_RESET
	j START_COMPARE_LOOP
	
	
	
#BLACKCOUNT
BLACKCOUNT_RESET:  
	
	la   $s0, TRIES			# s0 = apontador para TRIES
	la	$s1, CODE  			# s1 = apontador para CODE
	
	li $t5, 0					#Blackcount
   	li $t6, 0
   	
	j BLACKCOUNT

BLACKCOUNT:
	
	beq     $t6, $a2, TERMINA_BLACKCOUNT

	lb      $t8,($s0)             # get next char from TRIES
	lb      $t9, 0($s1)          # get next "char" from CODE
			
	beq     $t8,$t9, BLACK_COUNTER              # they are the same

	addi    $t6, $t6, 1		#counter	
	addi    $s0,$s0,1                  # point to next char no input
	addi    $s1,$s1,1                  # point to next char no code	
	
	j BLACKCOUNT	

BLACK_COUNTER:
	# modificamos o valor do TRIES (para zero) para nao voltar a contar
	la $t8, REMOVE_TRY
	lb $t8, 0($t8)
	la $t9, TRIES_TEMP
	add $t9, $t9, $t6
	sb $t8, 0($t9)
	# modificamos o valor do CODE (para um) para nao voltar a contar
	la $t8, REMOVE_CODE
	lb $t8, 0($t8)
	la $t9, CODE_TEMP
	add $t9, $t9, $t6
	sb $t8, 0($t9)

	addi    $t6, $t6, 1		#counter
	addi    $s0,$s0,1                  # point to next char no input
	addi    $s1,$s1,1                  # point to next char no code	
	addi    $t5, $t5, 1		   #Blackcount++
	j BLACKCOUNT


TERMINA_BLACKCOUNT:		
	li $v0, 4
	la $a0, NewLine                 		# printf("\n")
	syscall
   
   	li $v0, 4
	la $a0, BLACKCOUNTMSG                 		
	syscall
   
   	li $v0, 1
   	move $a0, $t5
   	syscall
   	
   	move $s3, $t5
   
   	li $v0, 4
	la $a0, BLACKCOUNTMSG1                 		
	syscall
   
   
	li $v0, 4
	la $a0, NewLine                 		# printf("\n")
	syscall
   
	j WHITECOUNT_RESET

#WHITECOUNT
WHITECOUNT_RESET:
   	li $t6, 0       # iterador do CODE
	la $s0, CODE_TEMP  			# s0 = apontador para CODE
	li $t5, 0       # WHITECOUNT
	j WHITECOUNT_EACH_CODE

WHITECOUNT_EACH_CODE:
	beq     $t6, $a2, TERMINA_WHITECOUNT
	la $s2, TRIES_TEMP			# s2 = apontador para TRIES
   	li $t7, 0       # iterador do TRIES
	j WHITECOUNT

WHITECOUNT_EACH_CODE_INC:
	addi    $t6, $t6, 1
	addi    $s0, $s0, 1                  # point to next char no code
	j WHITECOUNT_EACH_CODE

WHITECOUNT:
	
	beq     $t7, $a2, WHITECOUNT_EACH_CODE_INC
	beq     $t6, $t7, WHITECOUNT_CONTINUE

	lb      $t8, 0($s2)                   # get next char from TRIES
	lb      $t9, 0($s0)          # get next "char" from CODE
	addi    $t7, $t7, 1		#iterador do tries
			
	beq     $t8, $t9, WHITE_COUNTER              # they are the same
	addi    $s2, $s2, 1                  # point to next char no code	
	j WHITECOUNT

WHITECOUNT_CONTINUE:
	addi    $t7, $t7, 1		# avancar iterador
	addi    $s2, $s2, 1             # avancar apontador
	j WHITECOUNT

WHITE_COUNTER:
	addi 	$t5, $t5, 1         # Whitecount++
	j WHITECOUNT_EACH_CODE_INC  # break


TERMINA_WHITECOUNT:
	la $s0, TRIES
	la $s1, CODE
	li $t6, 0
   
	li $v0, 4
	la $a0, NewLine                 		# printf("\n")
	syscall
   
   	li $v0, 4
	la $a0, WHITECOUNTMSG                 		
	syscall
   
   	li $v0, 1
   	move $a0, $t5
   	syscall
   
   	li $v0, 4
	la $a0, WHITECOUNTMSG1                 		
	syscall
   
   
	li $v0, 4
	la $a0, NewLine                 		# printf("\n")
	syscall

	j COMPARE_LOOP


COMPARE_LOOP:

	lb      $t8,($s0)             # get next char from TRIES
	lb      $t9, 0($s1)          # get next "char" from CODE

	bne     $t8,$t9,CMPNE              # they are different

	addi    $s0,$s0,1                  # point to next char no input
	addi    $s1,$s1,1                  # point to next char no code	
	addi    $t6,$t6,1

	beq     $t6, $a2, CMPEQ

	j COMPARE_LOOP
 


POINTS:

	mul $t5, $s3, 3				#last round x3 number of correct guesses
	add $s5, $s5, $t5			#3x + previous points
        
     	beq $s3, 0, LOST			#missed everything
        
     	li $v0, 4                		
	la $a0, PONTOS4
	syscall
        
     	li $v0, 1		
	move $a0, $t5
	syscall
        
     	li $v0, 4                		
	la $a0, PONTOS2
	syscall
	 
	li $v0, 4
     	la $a0, NewLine
     	syscall
	 
     	j BOARD_PRINT_WHILE1 
 
LOST:

	li $v0, 4
	la $a0, LOSE
	syscall
	
	li $v0, 4
	la $a0, NewLine
     	syscall
	
	bne $s5, 0, LOST_POINTS
	
	j BOARD_PRINT_WHILE1
 
 
LOST_POINTS:

	sub $s5, $s5, 3
	
	j BOARD_PRINT_WHILE1
 
CMPNE:

       la $s0, TRIES
       li $t1, 0
       li $t6, 0
       j BOARD_PRINT_WHILE2


CMPEQ:

	mul $t5, $s3, 3
	add $s5, $s5, $t5
	
     	j PRINT_LOOP_RANDOM_RESET_END
     
	

PRINT_LOOP_RANDOM_RESET_END:
	li $s0, 0
	la $t0, MSG3
	li $v0, 4
	move $a0, $t0
	syscall
	j PRINT_LOOP_RANDOM_END

PRINT_LOOP_RANDOM_END:  # imprimir codigo
	beq $s0, $a2, confirme_loop_e
	
	lb $t6, CODE($s0)
	
	li $v0, 11
	move $a0, $t6
	syscall

	addi $s0, $s0, 1
	
	j PRINT_LOOP_RANDOM_END
	

confirme_loop_e:

	li $v0, 4                		
	la $a0, NewLine
	syscall

 	li $v0, 4                		
	la $a0, PONTOS1
	syscall

	li $v0, 1		
	move $a0, $s5
	syscall

	li $v0, 4                		
	la $a0, PONTOS2
	syscall

	li $v0, 4                		
	la $a0, NewLine
	syscall

   	la $a0, confirmation_e
   	li $v0,4
    	syscall
    
	li $v0, 4                		
	la $a0, NewLine
	syscall
    
    	la      $s2, input_e
    	move    $t2, $s2
    
    	move    $a0,$t2
    	li      $a1,79
    	li      $v0,8
    	syscall
   
    	la $s3, e
    	j compare_e

compare_e:

     lb      $t2,($s2)                  # get next char from str1
     lb      $t3,($s3)                  # get next char from str2
     
     bne     $t2,$t3, NUMBER_DIGITS_CODE              # are they different? if yes, fly

     beq     $t2,$zero, END             # at EOS? yes, fly (strings equal)

     addi    $s2,$s2,4                  # point to next char
     addi    $s3,$s3,4                  # point to next charOWRBG
     
     j       compare_e	
	
END:
	
	li $v0, 10
	syscall
