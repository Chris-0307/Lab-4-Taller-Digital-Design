.text
.global _start

_start:
	LDR R0, =0x1000     @Dirección del teclado: 0x1000
	LDR R1, =0x2000     @Dirección del contador: 0x2000

    MOV R5, #0xE000   @ARMv4 solo mueve valores de 8 bits rotados. Se necesita un número base primero para las direcciones de las flechas
					  @Ese número base es 0xE000 ya que las direcciones de ambas flechas inician así
    ORR R6, R5, #0x0048     @Carga R6 = 0xE048 con un or con el número base y 0x0048, el cual es la flecha hacia arriba
    ORR R7, R5, #0x0050     @Carga R7 = 0xE050 con un or con el número base y 0x0050, el cual es la flecha hacia abajo
	
loop:

	LDRH R2, [R0]  @Se lee el valor de la tecla con 16 bits
	
	CMP R2, R6     @Se compara para saber si la flecha actual leída es la flecha de arriba, si es, se va a su sección correspondiente.
    BEQ up

	CMP R2, R7     @Se compara para saber si la flecha actual leída es la flecha de abajo, si es, se va a su sección correspondiente.
    BEQ down
	
	B loop   @Si no se presiona nada o la tecla presionada no es una de las dos flechas evaluadas, se vuelve a iniciar la verificación.
	
up:
    LDR R3, [R1]  @Se guarda en el registro R3 el valor del contador
    ADD R3, R3, #1  @Se suma 1 al contador del programa
    STR R3, [R1]   @Se guarda el contador actualizado en su dirección de memoria: 0x2000
    B loop  @Se regresa a la verificación de flechas
	
down:

	LDR R3, [R1]     @Se guarda en el registro R3 el valor del contador
    SUB R3, R3, #1   @Se resta 1 al contador del programa
    STR R3, [R1]     @Se guarda el contador actualizado en su dirección de memoria: 0x2000
    B loop  @Se regresa a la verificación de flechas