  # analyze.asm
  # This file written 2015 by F Lundevall
  # Copyright abandoned - this file is in the public domain.

	.text
main:
	li	$s0,0x30
loop:
	move	$a0,$s0		# copy from s0 to a0

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window

	addi	$s0,$s0,0x3	# change from 1 to 3
	li	$t0,0x5d 	#93 - so that we "hit it" on the final iteration (s0==t0 when we should stop)
	bne	$s0,$t0,loop
	nop			# delay slot filler (just in case)

stop:	j	stop		# loop forever here
	nop			# delay slot filler (just in case)

#s0 = 48
#a0 = s0
#print(a0)
#s0 = s0 +1
#to = 91
#s0 != t0
#for(int i = 48; i!=93;i++){
#}
#
#


