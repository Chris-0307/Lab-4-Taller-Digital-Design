.data 

X: .word 8

.text
.global _start

_start:
	
	LDR r0, =X
	LDR r1, [r0]
	MOV r2, #1
	MOV r3, #1
	
loop:
	
	CMP r1, #0
	BEQ endf
	
	MUL r2, r2, r3
	
	CMP r1, r3
	BEQ endf
	
	ADD r3, r3, #1
	
	B loop

endf:

	B endf