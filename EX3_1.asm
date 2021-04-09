.data
	array:.word 40 55 66 7 8 12 23 34 45 89		#declare fix array
	nxtline:.asciiz "\n"
	SUM:.asciiz "Sum: "
.text

main	:
	addi $t0,$t0,40		#array size constant
	addi $t4,$t4,90		#Loop counter
	addi $t9,$t9,1		#Input counter
	addi $t5,$t5,10		#Division
	
	li $v0,4
	la $a0,nxtline		#go to the next line
	syscall
	

total	:
	beq $t1,$t0,average	#if ($t1 == $t2) goto average //$t1 is offset //$t2 = 40
	lw $t2,array($t1)	#$t2 = array[$t1] 
	addi $t1,$t1,4
	add $s1,$s1,$t2		#$s1 = $s1 + $s2
	j total			# loop going back to total
	
average	:
	div $s1,$s5		#$s1/$s5 // $s5 = 10
	mfhi $s2		#renainder
	mflo $s3		#Quotient
printsum	:
	li $v0,4
	la $a0,nxtline
	syscall
	
	li $v0,4
	la $a0,SUM		#print the sum
	syscall
	
	move $a0,$s1
	li $v0,1
	syscall
	
li $v0,10			#return 0
syscall