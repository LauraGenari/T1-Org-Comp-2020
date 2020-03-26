.data
	space:				.space 	 3
	menuInicial:			.asciiz "\nDigite C para calculo ou M para memoria.\n"
	menuMemoria:			.asciiz "\nDigite M3 para o antepenultimo resultado, M2 para o penultimo, M1 para o ultimo, ou M0 para voltar ao menu anterior\n"	
	opcoesStr:			.asciiz	 "Digite 1 para soma\nDigite 2 para subtracao\nDigite 3 para multiplicacao\nDigite 4 para divisao\nDigite 5 para potencia\nDigite 6 para raiz quadrada\nDigite 7 para Tabuada\nDigite 8 para fatorial\nDigite 9 para fibonacci\nDigite 10 para voltar ao menu inicial\n"
	entradaInvalidaStr:		.asciiz	 "Entrada invalida\n"
	entradaInvalidaZero:		.asciiz	 "Impossivel dividir por 0 digite novamente\n"
	somaStr:			.asciiz	 "Digite dois numeros positivos que deseja somar\n"
	somaResultadoStr:		.asciiz  "Resultado da soma: "
	subtracaoStr:			.asciiz  "Digite dois numeros positivos que deseja subtrair\n"
	subtracaoResultadoStr:		.asciiz  "Resultado da subtracao: "
	multStr:			.asciiz  "Digite dois numeros positivos que deseja multiplicar\n"
	multResultadoStr:		.asciiz  "Resultado da multiplicacao: "
	divisaoStr:			.asciiz  "Digite dois numeros positivos que deseja dividir\n"
	divisaoResultadoStr:		.asciiz  "Resultado da divisao: "
	potenciaStr:			.asciiz  "Digite dois numeros positivos, sendo o primeiro a base e o segundo o expoente\n"
	potenciaResultadoStr:		.asciiz  "Resultado da potencia: "
	tabuadaStr:			.asciiz  "Digite um numero positivo\n"
	tabuadaPrintResultado:		.asciiz	 "Tabudada do "
	tabuadaFormatResultado:		.asciiz	 ": "
	fatorialStr:			.asciiz  "Digite um numero inteiro positivo que deseja calcular o fatorial\n"
	fatorialResultado: 		.asciiz  "Resultado do fatorial: "
	fibonacciStr:			.asciiz  "Digite o inicio e o final do intervalo\n"
	fibonacciResultado:		.asciiz  "A sequencia e: "
	sqrtStr:			.asciiz  "Digite um numero positivo que deseja calcular a raiz quadrada:\n"
	sqrtResultadoStr:		.asciiz  "Resultdo da raiz: "
	ultimostr:			.asciiz "\nUltimo\n"
	penultimostr:			.asciiz "\npenultimo\n"
	antepenultimostr:		.asciiz "\nantepenultimo\n"
	quebraDeLinha:			.asciiz  "\n" 				#serve para formatar prints
	espaco:				.asciiz  " "				#serve para formatar prints
	zeroAsFloat:			.float 	 0.0 				#serve para auxiliar operacoes com floats
	umAsFloat:			.float	 1.0				#serve para auxiliar operacoes com flotas
	divisorPorDois:			.float 	 2.0 				#Auxiliador do sqrt
	vetorMem:			.float 	 0:4				#vetor float de tamanho 4 inicializado com 1's, ira ser usado para guardar os resultados
	tamanhoVetorMem:		.word	 4
	les:		.float 3
	
	.text
	.globl main
main:
	
	menuIni:
		#printa a string com as opcoes C ou M do programa
		li $v0,	4								#Servico de printar string 4
		la $a0,	menuInicial							#carrega endereco da string
		syscall

		#Ler o carcter entrado.
		li $v0,	12								#servico de ler char 			
		syscall
	
		#guarda o char lido em v0
		move $t1, $v0								#t1 = v0
	
		beq $t1, 'C', mainLoop
		beq $t1, 'M', loopMenuMem
	j exit	

	loopMenuMem:
		#printa a string com os 3 numeros da memoria
		li	$v0,	4							#servico de printar string
		la	$a0,	menuMemoria						#carrega o endereco da string
		syscall

		li $v0, 8 								# v0 = 8 => read string
		la $a0, space 								# a0 = pos mem -> posicao de armazenadas na mem
		li $a1, 3 								# a1 = qtd de bytes/caracteres a serem lidos
		syscall 								#resultado da leitura salva em $a0
	
		move $t1, $a0
		
		lb $t2 ($t1)
		bne $t2, 'M', menuIni
	
		addi $t1, $t1, 1
		lb $t2 ($t1)
	
		beq $t2, '1', ultimo
		beq $t2, '2', penultimo
		beq $t2, '3', antepenultimo
		beq $t2, '0', menuIni
	
		j exit

	mainLoop:
		#printa a string com opcoes do programa
		li $v0, 4 								#servico para printar string
		la $a0, opcoesStr 							#carrega endereco da string
		syscall
											#le int e coloca no $v0
		li $v0, 5								#servico para ler inteiro
		syscall
		
		
		beq $v0, 1, soma
		beq $v0, 2, subtracao
		beq $v0, 3, multiplicacao
		beq $v0, 4, divisao
		beq $v0, 5, potencia
		beq $v0, 6, raiz
		beq $v0, 7, tabuada
		beq $v0, 8, fatorial
		beq $v0, 9, fibonacci
		beq $v0, 10, menuIni
		blt $v0, 0, entradaInvalida
		bgt $v0, 10, entradaInvalida
	
	#termina o programa
	exit:
	li $v0, 10
	syscall

ultimo:
	li $v0,	4									#Printar a primeira parte do menu.
	la $a0,	ultimostr
	syscall	
	
	#coloca em t0 o endereço do vetorMem
	la $t0, vetorMem
	
	#pega o primeiro item que indica onde vai ser colocado o novo, obs: nao tem problema colocar em int pq o primeiro valor nao e um float)
	l.s $f1, ($t0)									#$f1 = $t0[0]
	cvt.w.s $f1, $f1								#converte de float pra inteiro
	mfc1 $t1, $f1									#coloca o valor inteiro de f1 em t1
	
	#adiciona 1 pois a proxima a ser substituido e o valor anterior
	addi $t1, $t1, 2
	#checa se ele esta dentro do range de 3, caso nao corrige a posicao para 1
	ble $t1, 3, dentroDoRange2
		addi $t1, $zero, 1
	dentroDoRange2:
	
	#move o ponteiro do vetor ate a nova posicao a ser inserida
	sll $t1, $t1, 2									#$t1 = $t1*4
	add $t0, $t0, $t1								#$t0, = $t0 + $t1, andou ate a posicao do valor a ser substituido
	
	#carrega o valor do numero mais velho a ser inserido	
	l.s $f12, ($t0)							
	
	#move o ponteiro do vetor ate a primeira posicao
	sub $t0, $t0, $t1								#$t0  = $t0 + $t1, andou ate a primeira posicao
	srl $t1, $t1, 4									#$t1 = $t1/4
	
	#printa o float desejado
	li $v0, 2 									#servico para printar float
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j loopMenuMem
	
penultimo:
	li	$v0,	4								#Printar a primeira parte do menu.
	la	$a0,	penultimostr
	syscall
	
	#coloca em t0 o endereço do vetorMem
	la $t0, vetorMem
	
	#pega o primeiro item que indica onde vai ser colocado o novo, obs: nao tem problema colocar em int pq o primeiro valor nao e um float)
	l.s $f1, ($t0)									#$f1 = $t0[0]
	cvt.w.s $f1, $f1								#converte de float pra inteiro
	mfc1 $t1, $f1									#coloca o valor inteiro de f1 em t1
	
	#adiciona 1 pois a proxima a ser substituido e o valor anterior
	addi $t1, $t1, 1
	#checa se ele esta dentro do range de 3, caso nao corrige a posicao para 1
	ble $t1, 3, dentroDoRange1
		addi $t1, $zero, 1
	dentroDoRange1:
	
	#move o ponteiro do vetor ate a nova posicao a ser inserida
	sll $t1, $t1, 2									#$t1 = $t1*4
	add $t0, $t0, $t1								#$t0, = $t0 + $t1, andou ate a posicao do valor a ser substituido
	
	#carrega o valor do numero mais velho a ser inserido	
	l.s $f12, ($t0)							
	
	#move o ponteiro do vetor ate a primeira posicao
	sub $t0, $t0, $t1								#$t0  = $t0 + $t1, andou ate a primeira posicao
	srl $t1, $t1, 4									#$t1 = $t1/4
	
	#printa o float desejado
	li $v0, 2 									#servico para printar float
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	j loopMenuMem
	
antepenultimo:	
	li	$v0,	4								#Printar a primeira parte do menu.
	la	$a0,	antepenultimostr						
	syscall
	
	#coloca em t0 o endereço do vetorMem
	la $t0, vetorMem
	
	#pega o primeiro item que indica onde vai ser colocado o novo, obs: nao tem problema colocar em int pq o primeiro valor nao e um float)
	l.s $f1, ($t0)									#$f1 = $t0[0]
	cvt.w.s $f1, $f1								#converte de float pra inteiro
	mfc1 $t1, $f1									#coloca o valor inteiro de f1 em t1

	#move o ponteiro do vetor ate a nova posicao a ser inserida
	sll $t1, $t1, 2									#$t1 = $t1*4
	add $t0, $t0, $t1								#$t0, = $t0 + $t1, andou ate a posicao do valor a ser substituido
	
	#carrega o valor do numero mais velho a ser inserido	
	l.s $f12, ($t0)							
	
	#move o ponteiro do vetor ate a primeira posicao
	sub $t0, $t0, $t1								#$t0  = $t0 + $t1, andou ate a primeira posicao
	srl $t1, $t1, 4									#$t1 = $t1/4
	
	#printa o float desejado
	li $v0, 2 									#servico para printar float
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall

	j loopMenuMem

#pega o valor do $f0 e guarda ele na posicao mais antiga do vetorMem
adicionaVetorMem:
	#coloca em t0 o endereço do vetorMem
	la $t0, vetorMem
	
	#coloca em $t1 o valor do primeiro float do vetorMem
	l.s $f2, ($t0)									#coloca em f2 o primeiro valor							
	cvt.w.s $f2, $f2								#transforma de float pra int  
	mfc1 $t1, $f2									#guarda o int em f2 em t1
	
	#checa se o vetor esta zerado, caso esteja coloca todos os valores do vetor pra zero
	bne $t1, $zero, notZero
		#zera o t2
		addi $t2, $zero, 0
		
		#coloca o tamanho do vetor num registrador
		lw $t3, tamanhoVetorMem
		
		#coloca 1 no f1
		l.s $f1, umAsFloat
		
		loopPuttingOne:
			#guarda 1 em $t0[$t2]
			s.s $f1, ($t0)
			
			#anda o ponteiro em 1 pos
			addi $t0, $t0, 4
			addi $t2, $t2, 1						#incrementa 1 no iterador
		blt $t2, $t3, loopPuttingOne						#roda o numero de vezes igual ao tamanho do vetor
		
		#volta o ponteiro para a pos original
		sll $t3, $t3, 2								#$t3 = $t3*4
		sub $t0, $t0, $t3
		srl $t3, $t3, 2								#$t3 = $t3/4
	notZero:
	
	#coloca em $t1 o valor do primeiro float do vetorMem
	l.s $f2, ($t0)									#coloca em f2 o primeiro valor							
	cvt.w.s $f2, $f2								#transforma de float pra int  
	mfc1 $t1, $f2									#guarda o int em f2 em t1
	
	#move o ponteiro do vetor ate a nova posicao a ser inserida
	sll $t1, $t1, 2									#$t1 = $t1*4
	add $t0, $t0, $t1								#$t0, = $t0 + $t1, andou ate a posicao do valor a ser substituido
	
	#guarda na posicao mais antiga(indicada pelo $t0[0]) o novo numero
	s.s $f0, ($t0)									#$t0[$t0[0]] = $f12
	
	#move o ponteiro do vetor ate a primeira posicao
	sub $t0, $t0, $t1								#$t0  = $t0 + $t1, andou ate a primeira posicao
	srl $t1, $t1, 2									#$t1 = $t1/4
	
	#incrementa para ir pra proxima pos a ser inserida
	addi $t1, $t1, 1								#$t1 = $t1 + 1
	
	#corrige caso a prox posicao saia do range
	ble $t1, 3, dentroPosVal							#se $t1 for menor ou igual a 3 ta numa pos valida
		addi $t1, $zero, 1							#$t1 = 0 + 1, volta para posicao 1 pq significa que passou de 3		
	dentroPosVal:
	
	#guarda a prox posicao a ser inserida
	mtc1 $t1, $f1									#passa o valor de t1 para f1
	cvt.s.w $f1, $f1								#transforma f1 de inteiro para float
	s.s $f1, ($t0)									#$t0[0] = $t1, finalmente guarda na primeira pos do vetor o valor		
	
	jr $ra									
#1
soma:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 auxilia as operacoes com floats
	
	#printa a string somaStr
	li $v0, 4 									#servico de printar string
	la $a0, somaStr 								#carrega endereco da string
	syscall
	
	#le um float e o armazena em $f2
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido
	
	#printa a string somaResultadoStr
	li $v0, 4 									#servico de printar string
	la $a0, somaResultadoStr 							#carrega endereco da string
	syscall
	
	#printa a soma dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 									#servico para printar float
	add.s $f12, $f2, $f3 								#$f12 = $f2 + $f3
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	mov.s $f0, $f12									#move resultado para f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
	
	j mainLoop

#2	
subtracao:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 ira auxiliar as operacoes com floats
	
	#printa a string subtracaoStr
	li $v0, 4 									#servico de printar string
	la $a0, subtracaoStr 								#carrega endereco da string
	syscall
	
	#le um float e o armazena em $f2
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido
	
	#printa a string subtracaoResultadoStr
	li $v0, 4 									#servico de printar string
	la $a0, subtracaoResultadoStr 							#carrega endereco da string
	syscall	
	
	#printa a subtracao dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 									#servico para printar float
	sub.s $f12, $f2, $f3 								# $f12 = $f2 - $f3
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	mov.s $f0, $f12									#move resultado para f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
	
	j mainLoop	
	
#3
multiplicacao:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 ira auxiliar as operacoes com floats
	
	#printa a string multStr
	li $v0, 4 									#servico de printar string
	la $a0, multStr 								#carrega endereco da string
	syscall

	#le um float e o armazena em $f2
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido

	#printa a string multResultadoStr
	li $v0, 4 									#servico de printar string
	la $a0, multResultadoStr 							#carrega endereco da string
	syscall

	#printa a multiplicacao dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 									#servico para printar float
	mul.s $f12, $f2, $f3 								# $f12 = $f2 * $f3
	syscall
	
											#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	mov.s $f0, $f12									#move resultado para f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
	
	j mainLoop	
	
#4
divisao:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0, $f1 ira auxiliar as operacoes com floats
	
	#printa a string divisaoSt
	li $v0, 4 									#servico de printar string
	la $a0, divisaoStr 								#carrega endereco da string
	syscall

	#le um float e o armazena em $f2, que eh dividendo
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	
	#le um float e o armazena em $f3, que eh divisor
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	c.eq.s $f0,$f1 									#checa se $f0 = 0, caso sim seta bclt como verdadeiro
	bc1t entradazerodivisao 	
	add.s $f3, $f1, $f0 								#$f3 = $f1 + $f0, essencialmente armazena em $f3 o valor lido
	#printa a string divisaoResultadoStr
	li $v0, 4 									#servico de printar string
	la $a0, divisaoResultadoStr 							#carrega endereco da string
	syscall

	#printa a divisao dos dois numeros digitados, respectivamente nos registradores $f2 e $f3
	li $v0, 2 									#servico para printar float
	div.s $f12, $f2, $f3 								#$f12 = $f2/$f3
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	mov.s $f0, $f12									#move resultado para f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
	
	j mainLoop	

#5
potencia:
	#printa a string potenciaStr
	li $v0, 4 									#servico de printar string
	la $a0, potenciaStr 								#carrega endereco da string
	syscall
	
	#le um inteiro e o armazena em $a1, que eh a base
	li $v0, 5 									#servico de ler inteiro
	syscall
	ble $v0, 0, entradaInvalida 							#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
	addi $a1, $v0, 0 								#$a1 = $v0 + 0, essencialmente armazena o numero lido em $a1
	
	#le um inteiro e o armazena em $a2, que eh o exponencial
	li $v0, 5 									#servico de ler inteiro
	syscall
	ble $v0, 0, entradaInvalida 							#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
	addi $a2,$v0, 0 								#$2 = $v0 + 0, essencialmente armazena o numero lido em $a2
	
	li $t0, 0 									#$t0 = 0, $t0 sera usado como um contador
	li $t1, 1									#$t1 = 1, $t1 sera usado para guardar os valores das potencias subsequentes
	
	loopPotencia:
		beq $t0, $a2, exitLoopPotencia 						#checa se $t0 eh igual a $a2, caso sim sai do loop
		
			mul $t1, $t1, $a1 						#$t1 = $t1 * $a1
			addi $t0, $t0, 1 						#incrementa 1 ao contador da potencia
			j loopPotencia 							#volta para o comeco da potencia
		
	exitLoopPotencia:								#label de saida do loop
	
	
	#faz a quebra de linha para formatacao do print
	li $v0, 4 									#servico de printar string
	la $a0, potenciaResultadoStr 							#carrega endereco da string
	syscall
	
	#printa o resultado da potencia armazenado em $t1
	li $v0, 1 									#servico de printar inteiro
	addi $a0, $t1, 0 								#$a0 = $t1
	syscall
	
	mtc1 $a0, $f0									#transfere dados de a0 para f0
	cvt.s.w $f0, $f0								#converte o inteiro em f0 para float e carrega em f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	
	j mainLoop
	
#6
raiz:
	lwc1 $f1, zeroAsFloat 								#$f1 = 0.0
	
	#printa a string sqrtStr
	la $a0, sqrtStr 								#carrega endereco da string
	li $v0, 4 									#servico de printar string
	syscall

	#le um float e o armazena em $f2
	li $v0, 6 									#servico de ler um float
	syscall
	c.lt.s $f0, $f1 								#checa se $f0 < 0, caso sim seta bclt como verdadeiro
	bc1t entradaInvalida 								#caso verdadeiro ira para o label entradaInvalida
	add.s $f2, $f1, $f0 								#$f2 = $f1 + $f0, essencialmente armazena em $f2 o valor lido
	 
	l.s $f5, divisorPorDois								#Carrega em f5 o valor 2
	div.s $f6, $f2, $f5								# $f6 = $f0/2 
	add.s $f3, $f1, $f2 								#$f3 = $f1 + $f2, essencialmente armazena em $f3 o valor de f2
	l.s $f8, umAsFloat								#Carrega 1 em t0
	cvt.s.w $f7, $f7								#Converte o inteiro de f7 para float
	add.s $f7, $f1, $f1								#$f7 = 0

loopRaiz:
	div.s $f4, $f2, $f3 								# $f4 = $f2/$f3, divide n por x e coloca numa aux
	add.s $f4, $f4, $f3 								#$f4 = $f4 + $f2, coloca em aux a soma de x com n/x
	div.s $f4, $f4, $f5								# $f4/2 
	add.s $f3, $f4, $f1								#x = aux
	c.lt.s $f7, $f6									#Caso verdadeiro, setta bclt como verdadeiro
	add.s $f7, $f7, $f8								#Incrementa o f7 para progredir no loop
	bc1t loopRaiz									#Caso verdadeiro, vai para loop


	li $v0, 4 									#servico de printar string
	la $a0, sqrtResultadoStr  							#carrega endereco da string
	syscall

	#printa o resultado da raiz
	add.s $f12, $f1, $f3 								#move para $f12 o resultado
	li $v0, 2 									#servico de printar float
	syscall
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	mov.s $f0, $f12									#move resultado para f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
		

	j mainLoop

 
#7
tabuada:
	#printa a string tabuadaStr
	li $v0, 4 									#servico de printar string
	la $a0, tabuadaStr 								#carrega endereco da string
	syscall
	
	#le um inteiro e o armazena em $a1, que eh a base
	li $v0, 5 									#servico de ler inteiro
	syscall
	ble $v0, 0, entradaInvalida 							#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
	
	li $t0, 1 									#$t0 = 1, para poder comecar a tabuada do 1 em diante
	li $t1, 0 									#$t1 = 0, ele sera usado para receber o resultado das multiplicacao
	addi $t3, $v0, 0 								#$t3 = $v0 + 0
	
	#printa a string tabuadaPrintResultado
	li $v0, 4 									#servico de printar string
	la $a0, tabuadaPrintResultado 							#armazena o endereco da string
	syscall
	
	#printa o numero base da tabuada 
	li $v0, 1 									#servico de printar inteiro
	addi $a0, $t3, 0 								#$a0 = $t3 + 0
	syscall
	
	loopTabuada:
		bgt $t0, 10, exitLoopTabuada 						#checa se $t0 eh maior que 10, caso sim sai do loop
		
		mul $t1, $t0, $t3 							#$t1 = $t0 * $t3
		
		#printa a string quebraDeLinha
		li $v0, 4 								#servico de printar string
		la $a0, quebraDeLinha 							#carrega endereco da string
		syscall
		
		#printa o numero atual da tabuada
		li $v0, 1 								#servico de printar inteiro
		addi $a0, $t0, 0 							#$a0 = $t0 + 0
		syscall
		
		#printa a string tabuadaFormatResultado
		li $v0, 4 								#servico de printar string
		la $a0, tabuadaFormatResultado 						#armazena endereco da string
		syscall
		
		#printa o resultado da multiplicacao
		li $v0, 1 								#servico de printar inteiro
		addi $a0, $t1, 0 							#$a0 = $t1 + 0
		syscall
	
		addi $t0, $t0, 1 							#atualiza o contador do loop
		j loopTabuada
	exitLoopTabuada:								#label de saida do loop
	
	#guarda na memoria
	mtc1 $a0, $f0									#transfere dados de a0 para f0
	cvt.s.w $f0, $f0								#converte o inteiro em f0 para float e carrega em f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
	
	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
 	j mainLoop	
 	
#9
fatorial:
	#printa a string fatorialStr
 	li $v0, 4 									#servico de printar string
 	la $a0, fatorialStr 								#armazena endereco da string
 	syscall
 	
	#le o inteiro para calcular o fatorial
 	li $v0, 5 									#servico de ler inteiro
 	syscall
 	ble $v0, 0, entradaInvalida 							#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
 	
 	move $a0, $v0
	jal Calculafatorial
	move $t0,$v0
	
		#printa a string fatorialResultado
        li $v0, 4 									#servico de printar string
        la $a0, fatorialResultado 							#armazena o endereco da string
        syscall
         
		#imprime o resultado
        move $a0, $t0 									#move o resultado para $a0
        li $v0, 1 									#servico de printar inteiro
        syscall
        
        #guarda na memoria
	mtc1 $a0, $f0									#transfere dados de a0 para f0
	cvt.s.w $f0, $f0								#converte o inteiro em f0 para float e carrega em f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria  
	
    		#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	         
        j mainLoop

	Calculafatorial:								#funcao recursiva para calcular o fatorial
		addi $sp, $sp, -8 							#reserva espaco
		sw $a0, 0($sp) 								#adiciona $a0
		sw $ra, 4($sp) 								#adiciona $ra
		beq $a0, $zero, retorna1 						#condicao de parada
		addi $a0, $a0, -1 							#decrementa o parametro da funcao
		jal Calculafatorial 							#chama a funcao novamente
	
		addi $a0, $a0, 1 							#incrementa parametro da chamada
		mul $v0, $v0, $a0 							#calcula fat
		j retornaFat

	retorna1: 
		addi $v0, $zero, 1 							#retorna 1
	retornaFat:
		lw $a0, 0($sp) 								#desempilha
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra 
		
#10
fibonacci:
	#printa a string fibonnaciStr
 	li $v0, 4 									#servico de printar string
 	la $a0, fibonacciStr 								#armazena endereco da string
 	syscall
 	
	#le o primeiro numero para calcular a sequencia
 	li $v0, 5 									#servico de ler inteiro
 	syscall
 	ble $v0, 0, entradaInvalida 							#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
 	move $a2, $v0 									#armazena o numero em $a0
 	
	#le o segundo numero para calcular a sequencia
 	li $v0, 5 									#servico de ler inteiro
 	syscall
 	move $a1, $v0 									#armazena $v0 em $a1
 	ble $a1, $a2, entradaInvalida 							#checa se a entrada eh maior que 0, caso nao vai para o label entradaInvalida
 	add $a3, $a1, $zero
 	
	#printa a string fibonnaciResultado
 	li $v0, 4 									#servico de printar string
 	la $a0, fibonacciResultado 							#armazena endereco da string
 	syscall
 	
 	addi $t3, $zero, 1 								#$t3 <= 1
 	
 	loopFibo:
 	add $v0, $zero, $zero
 	move $s0, $a1 									#armazena o valor de $a1 em $s0
 	jal CalculaFibonacci								#imprime o resultado
 														
        move $a0, $v0 									#move o resultado para $a0
        li $v0, 1 									#servico de printar inteiro
        syscall
        
	bne $a1, $a3, notSaveJump 							#verifica se e a primeira iteracao
        #guarda na memoria
        add $t7, $a0, $zero								#guarda resultado em t7
	mtc1 $t7, $f0									#transfere dados de t7 para f0
	cvt.s.w $f0, $f0								#converte o inteiro em f0 para float e carrega em f0
	jal adicionaVetorMem								#chama funcao de adicionar na memoria
 	
 	notSaveJump:
	#printa a string espaco
 	li $v0, 4 									#servico de printar string
 	la $a0, espaco 									#armazena endereco da string
 	syscall
 	
 	addi $a1, $a1, -1 								#diminui $a1
     
 	ble $a2, $a1, loopFibo
 	
 	#printa a string quebraDeLinha
	li $v0, 4 									#servico de printar string
	la $a0, quebraDeLinha 								#carrega endereco da string
	syscall
	
	
 	j mainLoop
 	
 	CalculaFibonacci:
 	addi $sp, $sp, -12 								#reserva espaco na pilha
 	sw $s0, 0($sp) 									#$s0 recebe parametro
 	sw $s1, 4($sp) 									#$s1 eh temporario
 	sw $ra, 8($sp) 									#adiciona $ra
 	volta:										#ble $s0, $zero, saiFibonacci0 condicao de parada
 	ble $s0, $t3, saiFibonacci1 							#retorna 1
 	move $t1, $s0 									#t1 <- $s1
 	addi $s0, $t1, -1 								#parametro para a chamada fibonacii(n-1)
 	addi $s1, $t1, -2 								#parametro para a chamada fibonacii(n-1)
 	jal CalculaFibonacci
 	ble $s1, $zero, saiFibonacci0 							#condicao de parada
 	ble $s1, $t3, saiFibonacci1 							#condicao de parada
 	move $t1, $s1 									#t1 <- $s1
 	addi $s0, $t1, -1 								#parametro para a chamada fibonacii(n-1)
 	addi $s1, $t1, -2 								#parametro para a chamada fibonacii(n-1)
 	j CalculaFibonacci 								#parametro para a chamada fibonacii(n-2)
 	#j CalculaFatorial
 	
 	saiFibonacci0: 									#desempilha
 	lw $s0, 0($sp) 
 	lw $s1, 4($sp)
 	lw $ra, 8($sp)  
 	addi $sp, $sp, 12
 	jr $ra
 	
 	saiFibonacci1: 									#desemplinha
 	lw $s0, 0($sp) 
 	lw $s1, 4($sp)
 	lw $ra, 8($sp)  
 	addi $sp, $sp, 12
 	addi $v0, $v0, 1 								#soma 1 ao resultado
 	jr $ra	

entradazerodivisao:
	li $v0, 4 									#servico de printar string
	la $a0, entradaInvalidaZero 							#armazena endereco da string
	syscall
	j divisao								#volta para a função da divisão
	
entradaInvalida:
	#printa a string entradaInvalidaStr
	li $v0, 4 									#servico de printar string
	la $a0, entradaInvalidaStr 							#armazena endereco da string
	syscall
	j mainLoop