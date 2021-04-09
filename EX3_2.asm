  .data
array:
    .word   17767, 9158, 39017, 18547,56401, 23807, 37962, 22764,124, 25282,
arrend:

msg_odd:    .asciiz     "The sum of the odd numbers is: "
msg_even:   .asciiz     "The sum of the even numbers is: "
msg_nl:     .asciiz     "\n"

    .text
    .globl  main
# main -- main program
#
# registers:
#   t0 -- even sum
#   t1 -- odd sum
#   t2 -- current array value
#   t3 -- isolation for even/odd bit
#   t6 -- array pointer
#   t7 -- array end pointer
main:
    li      $t0,0                   # zero out even sum
    li      $t1,0                   # zero out odd sum
    la      $t6,array               # address of array start
    la      $t7,arrend              # address of array end

main_loop:
    bge     $t6,$t7,main_done       # are we done? if yes, fly

    lw      $t2,0($t6)              # get value
    addiu   $t6,$t6,4               # point to next array element

    andi    $t3,$t2,1               # isolate LSB
    beqz    $t3,main_even           # if even, go to main_even

    add     $t1,$t1,$t2             # add to odd sum
    j       main_loop

main_even:
    add     $t0,$t0,$t2             # add to even sum
    j       main_loop

main_done:
    # output the even sum
    la      $a0,msg_even
    move    $a1,$t0
    jal     print

    # output the odd sum
    la      $a0,msg_odd
    move    $a1,$t1
    jal     print

    # terminate program
    li      $v0,10
    syscall

# print -- output a number
#
# arguments:
#   a0 -- pointer to message
#   a1 -- number to output
print:
    # output the message
    la      $v0,4
    syscall

    # output the number
    li      $v0,1
    move    $a0,$a1
    syscall

    # output a newline
    la      $a0,msg_nl
    li      $v0,4
    syscall

    jr      $ra                     # return