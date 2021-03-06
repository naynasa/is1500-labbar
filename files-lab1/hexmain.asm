  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,17		# change this to test different values
	jal	hexasc		# call hexasc - same as hexasc(a0)
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
  #
#hexasc(15) => F
#hexasc(0) => etc.
#extracts the least significant bits

#parameter $a0 - 4 least significant bits are turned into ascii hex representation all others are ignored
#return $v0 - 7 significant bits ascii representation of $a0
.text
hexasc:
	andi	$a0,$a0,0xF#XXXX...X[YYYY] AND 0000..0[1111] = 0000.0[YYYY]
	li	$t0,9 # store 9 for the comparison in ble in an arbitrary register
	ble    	$a0,$t0,hexasc_if#$a0<10
	nop
	j	hexasc_else #else
	hexasc_if:
		#we know that $a0<10 (<10 is the same as <= 9)
		addi	$a0,$a0,48 #'0' in ASCII <=> 48, '1' in ASCII <=> 49 etc.
		j hexasc_contine
		nop
	hexasc_else:
		addi	$a0,$a0,55 #65-10 since A <=> ASCII 65, A in hex is 10 in base 10
	hexasc_contine:	
	li	$v0,0
	add	$v0,$a0,$v0
	jr	$ra
	nop


