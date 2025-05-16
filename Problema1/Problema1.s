.data   @Almacenamiento de datos previo
array:  .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
y:      .word 5

.text
.global _start

_start:
    LDR r0, =array  @Se guarda en el registro r0 la dirección del inicio del arreglo de valores, el primer valor.     
    MOV r1, #0      @El registro r1 guarda el índice por el cual va el recorrido del arreglo, se inicia en 0.     
    LDR r2, =y      @El registro r2 guarda la dirección de la constante "y" definida por el usuario
    LDR r3, [r2]    @El registro r3 guarda el valor de la constante "y"    

loop:
    CMP r1, #10     @Condición para terminar el ciclo (for), si el índice ya es 10 pues el índice en un arreglo de 10 valores llega hasta 9.      
    BEQ end         @Salto al final del código    

    MOV r4, r1      @Se guarda en el actual ciclo de manera separada el valor de i     
    MOV r7, #4      @Se guarda en r7 el número 4   
    MUL r4, r4, r7  @Se calcula el espacio que hay entre la dirección del inicio del arreglo y el índice actual (cada valor toma 4 de espacio)     
    ADD r5, r0, r4  @Se calcula la dirección de memoria en r5 del valor donde está actualmente i con la dirección de memoria inicial y el espacio recién calculado     
    LDR r6, [r5]    @Se guarda en r6 el valor de r5     

    CMP r6, r3      @Se compara si array[i] < y, si ese es el caso se hace una suma, sino, se hace una multiplicación    
    BLT else         

    MUL r6, r6, r3  @array[i] = array[i] * y     
    STR r6, [r5]        
    B next

else:
    ADD r6, r6, r3  @array[i] = array[i] + y      
    STR r6, [r5]          

next:
    ADD r1, r1, #1  @Se suma un uno al índice para así avanzar de posición en el array       
    B loop

end:
    B end