	.data
		MyArray: .word 2, 4, 6, 8, 10, 12, 14, 16, 18, 20
		String: .asciiz "Enter an index: "
	.text
	
main:
	la $a1, MyArray # Load the address of array MyArray into $a1

	li $v0, 4
	la $a0, String
	syscall
	
	li $v0, 5
	syscall
	
	addi $t0, $t0, 0 # Declare a counter $t0 = 0;
	
	lw $a0, 0($a1)
FindIndex:
	slt $t1, $t0, $v0 # $t1 == ($t0 < $v0 ? 1 : 0 )
	
	beq $t1, $0, Exit
	
	# If $t1 is 0
		addi $t0, $t0, 1 # Increment $t0
		
		addi $a1, $a1, 4 # Increment the index by 1
		
		lw $a0, 0($a1) # Store element at index $t0 into $t1
		
		j FindIndex
	
	# If $t1 is 1
Exit:
	li $v0, 1
	syscall