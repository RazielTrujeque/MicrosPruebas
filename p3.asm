;------------- definiciones e includes ------------------------------
;INCLUDE "m1280def.inc" ; Incluir definiciones de Registros para 1280
.INCLUDE "m2560def.inc" ; Incluir definiciones de Registros para 2560

.equ INIT_VALUE = 0 ; Valor inicial R24

;------------- inicializar ------------------------------------------
ldi R24,INIT_VALUE
;------------- implementar ------------------------------------------
call delay103uS
call delay1mS
call delay1S
call myRand ; Retorna valor en R25
;------------- ciclo principal --------------------------------------
arriba: inc R24
    cpi R24,10
    breq abajo
    out PORTA,R24
    rjmp arriba

abajo: dec R24
    cpi R24,0
    breq arriba
    out PORTA,R24
    rjmp abajo
    
    
delay103uS:
	ldi R24,7;				//1
	nxt:ldi R25,77;			//1n
		nxt2:dec R25;		//1m*1n
			brne nxt2;		//(2m-1)*n
		dec R24;			//1n
		brne nxt;			//2n-1
	ret
    
delay1mS:    
	ldi R24,130;				//1
	nxt3:ldi R25,10;			//1x
		nxt4:ldi R26,3;		//1x*1y
			nxt5:dec R26;	//1x*1y*1z
				brne nxt5;	//(2z-1)xy
			dec R25;		//1x*1y
			brne nxt4;		//(2y-1)x
		dec R24;			//1x
		brne nxt3;			//2x-1
	ret
	
delay1S:
    ldi R24,241;              //1
    nxt6:ldi R25,71;          //1x
	    nop                 //1x
	    nop                 //1x
	    nxt7:ldi R26,186;     //1x*1y
	        nop             //1x*1y
	        nop             //1x*1y
	        nxt8:dec R26;   //1x*1y*1z
	            nop         //1x*1y*1z
	            nop         //1x*1y*1z
	            brne nxt8;  //(2z-1)xy
	        dec R25;        //1x*1y
	        brne nxt7;      //(2y-1)x
	    dec R26;            //1x
    brne nxt;           //2x-1
    ret                 // +10 
    
myRand:  
; Configurar PORTB como salida (8 bits)
    ldi r16, 0xFF
    sts DDRB, r16
; Inicializar la semilla en r16 (puede ser cualquier valor entre 0 y 255)
    ldi r16, 0x7A    ; Ejemplo: semilla inicial 122
loop:
    ; Generar el siguiente n?mero pseudoaleatorio usando:
    ; X = (5 * X + 1) mod 256
    ; Multiplicar X por 5: X*5 = (X << 2) + X
    mov r18, r16     ; r18 = X (copia de la semilla actual)
    lsl r16        ; r16 = X * 2
    lsl r16        ; r16 = X * 4
    add r16, r18   ; r16 = 4*X + X = 5*X

    ; Sumar el incremento b = 1
    ldi r18, 1
    add r16, r18   ; r16 = 5*X + 1 (la aritm?tica en 8 bits es autom?ticamente mod 256)

    ; Ahora r16 contiene el nuevo n?mero aleatorio.
    ; Puedes enviarlo a PORTB para visualizarlo con LEDs:
    sts PORTB, r16

    ; (Opcional) Puedes agregar un retardo aqu? si lo deseas.

    rjmp loop     ; Repite el ciclo para generar el siguiente n?mero
ret

