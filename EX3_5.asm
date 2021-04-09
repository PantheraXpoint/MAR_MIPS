.data
	array:	.space 40
	spacing: .asciiz " "
	nxtline: .asciiz "\n"
	prompt:	.asciiz "Please enter 10 integers:\n"
	output: .asciiz "The output after sorting:\n"
.text

main:
	addi $t0,$t0,40 #array size constant
	addi $t4,$t4,90 #Loop counter
	addi $t9,$t9,1 #Input counter
	addi $s5,$s5,10 #Division
	
	li $v0,4
	la $a0,prompt  		#print out the 'Please enter 10 integers:\n'
	syscall
	
input:
	beq	$t1,$t0,continue	# if $t1 == $t0
	
	li	$v0,5
	syscall				# input the value
	move	$t2,$v0
	
	sw	$t2,array($t1)		#array[$t1] = $t2
	addi	$t1,$t1,4
	addi 	$t9,$t9,1		#update input counter(1-10)
	
	j input				#loop until 10 times input/$t9
continue:
	#reinitialize register
	move	$t1, $zero		#for array(x)
	move	$t2, $zero
	addi	$t2,$t2,4		#for array(x + 1)
	move	$s0,$zero
	addi	$s0,$s0,1		#condition check
	
sort:
	#checking condition for swapping array element
	beq	$t3,$t4,calculation	#finish loop -- if ($t3 == $t4) // $t3 is a loop counter and $t4 = 90
	beq	$t2,$t0,continue	#reinitialize array offset for looping
	
	lw	$t5,array($t1)		#checking condition $t5 = array[$t1] // $t5 = array[x]
	lw	$t6,array($t2)		#$t6 = array[$t2] // $t6 = array[x + 1]
	
	addi	$t3,$t3,1		#increment 1
	
	slt	$t7,$t5,$t6		#if $t5 < $t6 then $t7 = 1 else $t7 = 0
	beq	$t7,$s0,swap		#if ($t7 == &s0) goto swap
	
	addi	$t1,$t1,4
	addi	$t2,$t2,4
	
	j sort
swap:
	sw	$t5,array($t2)	#array[$t2] = $t5 or array[x + 1] = $t5
	sw	$t6,array($t1)	#array[$t1] = $t6 or array[x] = $t6
	addi	$t1,$t1,4	#$t1 = $t1 + 4
	addi	$t2,$t2,4	#$t2 = $t2 + 4
	j sort
calculation:
	#reinitialize register
	move	$t1,$zero	#array element
	move	$t2,$zero	#temporary holder
	move	$t3,$zero	#first array element
	move	$t4,$zero
	addi	$t4,$t4,36	#last array element
	move	$t5,$zero
	move	$t6,$zero
	move	$t7,$zero
out:
	lw	$t5,array($t3)	#$t5 = array[0] // for max value
	lw	$t6,array($t4)	#$t6 = array[36] // for min value
	
	li	$v0,4
	la	$a0,output
	syscall
element:
	#print element of array in descending order
	beq	$t7,$t0,next	#while ($t7 < $t0)
	lw	$t8,array($t7)	#load array $t7 to $t8, $t8 = array[$t7]
	addi	$t7,$t7,4	#add immediate $t7 with 4, $t7 = $t7 + 4
	
	move	$a0,$t8		#print $t8
	li	$v0,1
	syscall
	beq	$t7,$t0,element	#if ($t0 != 40)
	li	$v0,4
	la	$a0,spacing	#print space
	syscall
	j element
next:
	li $v0,4
	la $a0,nxtline	#print nextline
	syscall
li $v0,10	#return 0
syscall