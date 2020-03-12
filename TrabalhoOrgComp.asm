							#Alunos:
    							# Mariela Hennies Lauand NUSP 10819012
    							# João Pedro Uchôa Cavalcante NUSP 10801169
    							# Bruno Germano do Nascimento NUSP 10893131
    							# Leonardo Chippe NUSP 9368730
	
	.data
	opcoesStr:				.asciiz	 "Digite 1 para soma\nDigite 2 para subtracao\nDigite 3 para multiplicacao\nDigite 4 para divisao\nDigite 5 para potencia\nDigite 6 para raiz quadrada\nDigite 7 para Tabuada\nDigite 8 para IMC\nDigite 9 para fatorial\nDigite 10 para fibonacci\nDigite 11 para encerrar\n"
	entradaInvalidaStr:		.asciiz	 "Entrada invalida\n"
	somaStr:				.asciiz	 "Digite dois numeros positivos que deseja somar\n"
	somaResultadoStr:		.asciiz  "Resultado da soma: "
	subtracaoStr:			.asciiz  "Digite dois numeros positivos que deseja subtrair\n"
	subtracaoResultadoStr:	.asciiz  "Resultado da subtracao: "
	multStr:				.asciiz  "Digite dois numeros positivos que deseja multiplicar\n"
	multResultadoStr:		.asciiz  "Resultado da multiplicacao: "
	divisaoStr:				.asciiz  "Digite dois numeros positivos que deseja dividir\n"
	divisaoResultadoStr:	.asciiz  "Resultado da divisao: "
	potenciaStr:			.asciiz  "Digite dois numeros positivos, sendo o primeiro a base e o segundo o expoente\n"
	potenciaResultadoStr:	.asciiz  "Resultado da potencia: "
	tabuadaStr:				.asciiz  "Digite um numero positivo\n"
	tabuadaPrintResultado:	.asciiz	 "Tabudada do "
	tabuadaFormatResultado:	.asciiz	 ": "
	imcStr:					.asciiz  "Digite o peso em Kg e a altura em metros\n"
	imcResultado: 			.asciiz  "Resultado do IMC: "
	fatorialStr:			.asciiz  "Digite um numero inteiro positivo que deseja calcular o fatorial\n"
	fatorialResultado: 		.asciiz  "Resultado do fatorial: "
	fibonacciStr:			.asciiz  "Digite o inicio e o final do intervalo\n"
	fibonacciResultado:		.asciiz  "A sequencia �: "
	sqrtStr:				.asciiz  "Digite um numero positivo que deseja calcular a raiz quadrada:\n"
	sqrtResultadoStr:		.asciiz  "Resultdo da raiz: "
	quebraDeLinha:			.asciiz  "\n" 				#serve para formatar prints
	espaco:					.asciiz  " "				#serve para formatar prints
	zeroAsFloat:			.float 	 0.0 				#serve para auxiliar operacoes com floats
	divisorPorDois:			.float 	 2.0 				#Auxiliador do sqrt
	umAsFloat:				.float	 1.0				#serve para auxiliar operacoes com flotas
	.text
	.globl main
main:
	mainLoop:
														#printa a string com opcoes do programa
		li $v0, 4 										#servico para printar string
		la $a0, opcoesStr 								#carrega endereco da string
		syscall
														#le int e coloca no $v0
		li $v0, 5										#servico para ler inteiro
		syscall
		
		
		beq $v0, 1, soma
		beq $v0, 2, subtracao
		beq $v0, 3, multiplicacao
		beq $v0, 4, divisao
		beq $v0, 5, potencia
		beq $v0, 6, raiz
		beq $v0, 7, tabuada
		beq $v0, 8, imc
		beq $v0, 9, fatorial
		beq $v0, 10, fibonacci
		beq $v0, 11, exitMainLoop
		blt $v0,0, entradaInvalida
		bgt $v0, 11, entradaInvalida
	exitMainLoop:
	li $v0, 10
	syscall

#1
soma:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 auxilia as operacoes com floats
	
	#printa a string somaStr
	li $v0, 4 											#servico de printar string
	la $a0, somaStr 									#carrega endereco da string
	syscall
	
	#le um float e o armazena em $f2
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido
	
	#printa a string somaResultadoStr
	li $v0, 4 											#servico de printar string
	la $a0, somaResultadoStr 							#carrega endereco da string
	syscall
	
	#printa a soma dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 											#servico para printar float
	add.s $f12, $f2, $f3 								#$f12 = $f2 + $f3
	syscall
	
														#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j mainLoop

#2	
subtracao:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 ira auxiliar as operacoes com floats
	
	#printa a string subtracaoStr
	li $v0, 4 											#servico de printar string
	la $a0, subtracaoStr 								#carrega endereco da string
	syscall
	
	#le um float e o armazena em $f2
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido
	
	#printa a string subtracaoResultadoStr
	li $v0, 4 							#servico de printar string
	la $a0, subtracaoResultadoStr 						#carrega endereco da string
	syscall
	
	#printa a subtracao dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 											#servico para printar float
	sub.s $f12, $f2, $f3 								# $f12 = $f2 - $f3
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j mainLoop	
	
#3
multiplicacao:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 ira auxiliar as operacoes com floats
	
	#printa a string multStr
	li $v0, 4 											#servico de printar string
	la $a0, multStr 									#carrega endereco da string
	syscall

	#le um float e o armazena em $f2
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido

	#printa a string multResultadoStr
	li $v0, 4 											#servico de printar string
	la $a0, multResultadoStr 							#carrega endereco da string
	syscall

	#printa a multiplicacao dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 											#servico para printar float
	mul.s $f12, $f2, $f3 								# $f12 = $f2 * $f3
	syscall
	
														#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j mainLoop	
	
#4
divisao:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 ira auxiliar as operacoes com floats
	
	#printa a string divisaoStr
	li $v0, 4 											#servico de printar string
	la $a0, divisaoStr 									#carrega endereco da string
	syscall

	#le um float e o armazena em $f2, que eh dividendo
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3, que eh divisor
	li $v0, 6 											#servico de ler um float
	syscall
	c.le.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido

	#printa a string divisaoResultadoStr
	li $v0, 4 											#servico de printar string
	la $a0, divisaoResultadoStr 						#carrega endereco da string
	syscall

	#printa a divisao dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 											#servico para printar float
	div.s $f12, $f2, $f3 								#$f12 = $f2/$f3
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j mainLoop	

#5
potencia:
	#printa a string potenciaStr
	li $v0, 4 											#servico de printar string
	la $a0, potenciaStr 								#carrega endereco da string
	syscall
	
	#le um inteiro e o armazena em $a1, que eh a base
	li $v0, 5 											#servico de ler inteiro
	syscall
	ble $v0, 0, entradaInvalida 						#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
	addi $a1, $v0, 0 									#$a1 = $v0 + 0, essencialmente armazena o numero lido em $a1
	
	#le um inteiro e o armazena em $a2, que eh o exponencial
	li $v0, 5 											#servico de ler inteiro
	syscall
	ble $v0, 0, entradaInvalida 						#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
	addi $a2,$v0, 0 									#$2 = $v0 + 0, essencialmente armazena o numero lido em $a2
	
	li $t0, 0 											#$t0 = 0, $t0 sera usado como um contador
	li $t1, 1											#$t1 = 1, $t1 sera usado para guardar os valores das potencias subsequentes
	
	loopPotencia:
		beq $t0, $a2, exitLoopPotencia 					#checa se $t0 eh igual a $a2, caso sim sai do loop
		
			mul $t1, $t1, $a1 							#$t1 = $t1 * $a1
			addi $t0, $t0, 1 							#incrementa 1 ao contador da potencia
			j loopPotencia 								#volta para o comeco da potencia
		
	exitLoopPotencia:									#label de saida do loop
	
	
	#faz a quebra de linha para formatacao do print
	li $v0, 4 											#servico de printar string
	la $a0, potenciaResultadoStr 						#carrega endereco da string
	syscall
	
	#printa o resultado da potencia armazenado em $t1
	li $v0, 1 											#servico de printar inteiro
	addi $a0, $t1, 0 									#$a0 = $t1
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j mainLoop
	
#6
raiz:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0
	
	#printa a string sqrtStr
	la $a0, sqrtStr 									#carrega endereco da string
	li $v0, 4 											#servico de printar string
	syscall

	#le um float e o armazena em $f2
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	 
	l.s $f5, divisorPorDois								#Carrega em f5 o valor 2
	div.s $f6, $f2, $f5									# $f6 = $f0/2 
	add.s $f3, $f1, $f2 								#$f3 = $f1 + $f2, essencialmente armazena em $f3 o valor de f2
	l.s $f8, umAsFloat									#Carrega 1 em t0
	cvt.s.w $f7, $f7									#Converte o inteiro de f7 para float
	add.s $f7, $f1, $f1									#$f7 = 0

loopRaiz:
	div.s $f4, $f2, $f3 								# $f4 = $f2/$f3, divide n por x e coloca numa aux
	add.s $f4, $f4, $f3 								#$f4 = $f4 + $f2, coloca em aux a soma de x com n/x
	div.s $f4, $f4, $f5									# $f4/2 
	add.s $f3, $f4, $f1									#x = aux
	c.lt.s $f7, $f6										#Caso verdadeiro, setta bclt como verdadeiro
	add.s $f7, $f7, $f8									#Incrementa o f7 para progredir no loop
	bc1t loopRaiz										#Caso verdadeiro, vai para loop


	li $v0, 4 											#servico de printar string
	la $a0, sqrtResultadoStr  							#carrega endereco da string
	syscall

	#printa o resultado da raiz
	add.s $f12, $f1, $f3 								#move para $f12 o resultado
	li $v0, 2 											#servico de printar float
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall

	j mainLoop

 
#7
tabuada:
	#printa a string tabuadaStr
	li $v0, 4 											#servico de printar string
	la $a0, tabuadaStr 									#carrega endereco da string
	syscall
	
	#le um inteiro e o armazena em $a1, que eh a base
	li $v0, 5 											#servico de ler inteiro
	syscall
	ble $v0, 0, entradaInvalida 						#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
	
	li $t0, 1 											#$t0 = 1, para poder comecar a tabuada do 1 em diante
	li $t1, 0 											#$t1 = 0, ele sera usado para receber o resultado das multiplicacao
	addi $t3, $v0, 0 									#$t3 = $v0 + 0
	
	#printa a string tabuadaPrintResultado
	li $v0, 4 											#servico de printar string
	la $a0, tabuadaPrintResultado 						#armazena o endereco da string
	syscall
	
	#printa o numero base da tabuada 
	li $v0, 1 											#servico de printar inteiro
	addi $a0, $t3, 0 									#$a0 = $t3 + 0
	syscall
	
	loopTabuada:
		bgt $t0, 10, exitLoopTabuada 					#checa se $t0 eh maior que 10, caso sim sai do loop
		
		mul $t1, $t0, $t3 								#$t1 = $t0 * $t3
		
		#printa a string quebraDeLinha
		li $v0, 4 										#servico de printar string
		la $a0, quebraDeLinha 							#carrega endereco da string
		syscall
		
		#printa o numero atual da tabuada
		li $v0, 1 										#servico de printar inteiro
		addi $a0, $t0, 0 								#$a0 = $t0 + 0
		syscall
		
		#printa a string tabuadaFormatResultado
		li $v0, 4 										#servico de printar string
		la $a0, tabuadaFormatResultado 					#armazena endereco da string
		syscall
		
		#printa o resultado da multiplicacao
		li $v0, 1 										#servico de printar inteiro
		addi $a0, $t1, 0 								#$a0 = $t1 + 0
		syscall
	
		addi $t0, $t0, 1 								#atualiza o contador do loop
		j loopTabuada
	exitLoopTabuada:									#label de saida do loop
	
	#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
 	j mainLoop
 
#8
imc:
	#printa a string imcStr
 	li $v0, 4 											#servico de printar string
 	la $a0, imcStr 										#carrega o endereco da string
 	syscall
 	
 	#le um float e o armazena em $f2
	#ou seja, f2 contem o peso
	li $v0, 6 											#servico de ler um float
	syscall
	c.lt.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3
	#ou seja f3 contem a altura
	li $v0, 6 											#servico de ler um float
	syscall
	c.le.s $f0, $f1 									#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido
	
	mul.s $f3, $f3, $f3 								#$f3 = $f3*$f3 (altura ao quadrado)
	div.s $f12, $f2, $f3 								#f12 = $f4 / $f3
	
	#printa a string imcResultado
	li $v0, 4 											#servico de printar string
	la $a0, imcResultado
	syscall
	
	#printa o resultado do imc
	li $v0, 2 											#servico de printar float
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j mainLoop
 		
 	
#9
fatorial:
	#printa a string fatorialStr
 	li $v0, 4 											#servico de printar string
 	la $a0, fatorialStr 								#armazena endereco da string
 	syscall
 	
	#le o inteiro para calcular o fatorial
 	li $v0, 5 											#servico de ler inteiro
 	syscall
 	ble $v0, 0, entradaInvalida 						#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
 	
 	move $a0, $v0
	jal Calculafatorial
	move $t0,$v0
	
		#printa a string fatorialResultado
        li $v0, 4 										#servico de printar string
        la $a0, fatorialResultado 						#armazena o endereco da string
        syscall
         
		#imprime o resultado
        move $a0, $t0 									#move o resultado para $a0
        li $v0, 1 										#servico de printar inteiro
        syscall
         
    													#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	         
        j mainLoop

	Calculafatorial:									#funcao recursiva para calcular o fatorial
		addi $sp, $sp, -8 								#reserva espaco
		sw $a0, 0($sp) 									#adiciona $a0
		sw $ra, 4($sp) 									#adiciona $ra
		beq $a0, $zero, retorna1 						#condicao de parada
		addi $a0, $a0, -1 								#decrementa o parametro da funcao
		jal Calculafatorial 							#chama a funcao novamente
	
		addi $a0, $a0, 1 								#incrementa parametro da chamada
		mul $v0, $v0, $a0 								#calcula fat
		j retornaFat

	retorna1: 
		addi $v0, $zero, 1 								#retorna 1
	retornaFat:
		lw $a0, 0($sp) 									#desempilha
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra 
		
#10
fibonacci:
	#printa a string fibonnaciStr
 	li $v0, 4 											#servico de printar string
 	la $a0, fibonacciStr 								#armazena endereco da string
 	syscall
 	
	#le o primeiro numero para calcular a sequencia
 	li $v0, 5 											#servico de ler inteiro
 	syscall
 	ble $v0, 0, entradaInvalida 						#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
 	move $a2, $v0 										#armazena o numero em $a0
 	
	#le o segundo numero para calcular a sequencia
 	li $v0, 5 											#servico de ler inteiro
 	syscall
 	move $a1, $v0 										#armazena $v0 em $a1
 	ble $a1, $a2, entradaInvalida 						#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
 	
	#printa a string fibonnaciResultado
 	li $v0, 4 											#servico de printar string
 	la $a0, fatorialResultado 							#armazena endereco da string
 	syscall
 	
 	addi $t3, $zero, 1 									#$t3 <= 1
 	
 	loopFibo:
 	add $v0, $zero, $zero
 	move $s0, $a1 										#armazena o valor de $a1 em $s0
 	jal CalculaFibonacci								#imprime o resultado
 														
        move $a0, $v0 									#move o resultado para $a0
        li $v0, 1 										#servico de printar inteiro
        syscall
        
	#printa a string espaco
 	li $v0, 4 											#servico de printar string
 	la $a0, espaco 										#armazena endereco da string
 	syscall
 	
 	addi $a1, $a1, -1 									#diminui $a1
     
 	ble $a2, $a1, loopFibo
 	
 	#printa a string quebraDeLinha
	li $v0, 4 											#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
 	
 	j mainLoop
 	
 	CalculaFibonacci:
 	addi $sp, $sp, -12 									#reserva espaco na pilha
 	sw $s0, 0($sp) 										#$s0 recebe parametro
 	sw $s1, 4($sp) 										#$s1 eh temporario
 	sw $ra, 8($sp) 										#adiciona $ra
 	volta:												#ble $s0, $zero, saiFibonacci0 condicao de parada
 	ble $s0, $t3, saiFibonacci1 						#retorna 1
 	move $t1, $s0 										#t1 <- $s1
 	addi $s0, $t1, -1 									#parametro para a chamada fibonacii(n-1)
 	addi $s1, $t1, -2 									#parametro para a chamada fibonacii(n-1)
 	jal CalculaFibonacci
 	ble $s1, $zero, saiFibonacci0 						#condicao de parada
 	ble $s1, $t3, saiFibonacci1 						#condicao de parada
 	move $t1, $s1 										#t1 <- $s1
 	addi $s0, $t1, -1 									#parametro para a chamada fibonacii(n-1)
 	addi $s1, $t1, -2 									#parametro para a chamada fibonacii(n-1)
 	j CalculaFibonacci 									#parametro para a chamada fibonacii(n-2)
 	#j CalculaFatorial
 	
 	saiFibonacci0: 										#desempilha
 	lw $s0, 0($sp) 
 	lw $s1, 4($sp)
 	lw $ra, 8($sp)  
 	addi $sp, $sp, 12
 	jr $ra
 	
 	saiFibonacci1: 										#desemplinha
 	lw $s0, 0($sp) 
 	lw $s1, 4($sp)
 	lw $ra, 8($sp)  
 	addi $sp, $sp, 12
 	addi $v0, $v0, 1 									#soma 1 ao resultado
 	jr $ra	
 	

	
	
entradaInvalida:
	#printa a string entradaInvalidaStr
	li $v0, 4 											#servico de printar string
	la $a0, entradaInvalidaStr 							#armazena endereco da string
	syscall
	j mainLoop


