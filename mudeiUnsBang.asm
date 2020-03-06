# Calculadora em Assembly
# Operacoes:
#	- Soma (2 numeros)
#	- Subtracao (2 numeros)
#	- Multiplicacao (2 numeros, limitados a 16 bits)
#	- Divisao (2 numeros, limtados a 16 bits)
#	- Potencia (2 numeros)
#	- Raiz quadrada (1 numero)
#	- Tabuada (1 numero)
#	- Fatorial (1 numero)
#	- Fibonacci (2 numeros) 
# Exibir um menu com todas essas opcoes
# e a opcao de encerrar (sair do programa)
	.data
	.align 0
space:		.space 3
menuInicial:	.asciiz "Digite C para calculo ou M para memoria.\n"
menuMemoria:	.asciiz "\nDigite M3 para o antepenultimo resultado, M2 para o penultimo, M1 para o ultimo.\n"	
strMenuA:	.asciiz	"\nDigite o numero da operação desejada:\n1 - Soma\n2 - Subtração\n3 - Multiplicação\n4 - Divisão\n5 - Potencia\n"
strMenuB:	.asciiz	"6 - Raíz Quadrada\n7 - Tabuada\n8 - Fatorial\n9 - Fibonacci\n0 - Sair\n-1 - Voltar\n"
strOpInv:	.asciiz	"Opcao invalida.\n"
strNumA:	.asciiz	"Insira o primeiro operando: "	
strNumB:	.asciiz	"Insira o segundo operando: "
strNumC:	.asciiz	"Insira o operando: "
strNumInv:	.asciiz	"Operando(s) invalido(s).\n"
strPrintA:	.asciiz	"A resposta da operação eh: "
strPrintB:	.asciiz	".\n\n"
strDivResto:	.asciiz	"O resto eh: "
strTabuA:	.asciiz	" * "
strTabuB:	.asciiz	" = "
strBarraN:	.asciiz	"\n"
strSpace: 	.asciiz " "
strFibError:	.asciiz "Primeira posição não pode ser maior que a segunda"
strGetFibA:	.asciiz "Digite a primeira posição desejada da sequencia fibonacci: "
strGetFibB:	.asciiz "Digite a ultima posição desejada da sequencia fibonacci: "
strFibA:	.asciiz "A sequência eh: "

	.text
	.globl main
	main:
menuIni:
	li	$v0,	4				#Printar a primeira parte do menu.
	la	$a0,	menuInicial
	syscall
		
	li	$v0,	12				#Ler o carcter entrado.
	syscall
	
	move $t1, $v0
	
	beq $t1, 'C', loopMenuCalc
	beq $t1, 'M', loopMenuMem
	j endProg	

loopMenuMem:

	li	$v0,	4				#Printar a primeira parte do menu.
	la	$a0,	menuMemoria
	syscall
	
	li $v0, 8 # v0 = 8 => read string
	la $a0, space # a0 = pos mem -> posicao de armazenadas na mem
	li $a1, 3 # a1 = qtd de bytes/caracteres a serem lidos
	syscall #resultado da leitura salva em $a0
	
	move $t1, $a0
	
	lb $t2 ($t1)
	bne $t2, 'M', menuIni
	
	addi $t1, $t1, 1
	lb $t2 ($t1)
	
	beq $t2, '1', ultimo
	beq $t2, '2', penultimo
	beq $t2, '3', antepenultimo
	
	j endProg
	
ultimo:
	li	$v0,	4				#Printar a primeira parte do menu.
	la	$a0,	ultimostr
	syscall	
	
	j loopMenuMem
	
penultimo:
	li	$v0,	4				#Printar a primeira parte do menu.
	la	$a0,	penultimostr
	syscall
	
	j loopMenuMem
	
antepenultimo:	
	li	$v0,	4				#Printar a primeira parte do menu.
	la	$a0,	antepenultimostr
	syscall
	
	j loopMenuMem

loopMenuCalc:
	li	$v0,	4				#Printar a primeira parte do menu.
	la	$a0,	strMenuA
	syscall
		
	li	$v0,	4				#Printar a segunda parte do menu.
	la	$a0,	strMenuB
	syscall
		
	li	$v0,	5				#Ler o primeiro numero entrado.
	syscall
		
	move	$t1,	$v0				#Salvar o numero entrado em t1.
		
	li	$t0,	-1				#Definir t0 para comparação.
	beq	$t1,	$t0,	menuIni			#Verifica se eh igual a 0, caso seja volta para o menu anterior.	
		
	li	$t0,	0				#Definir t0 para comparação.
	beq	$t1,	$t0,	endProg			#Verifica se eh igual a 0, caso seja finaliza o programa.
		
	li	$t0,	1				#Definir t0 para comparação.
	beq	$t1,	$t0,	soma			#Verifica se eh 1, caso seja inicia a operação de soma.
			
	li	$t0,	2				#Definir t0 para comparação.
	beq	$t1,	$t0,	subtracao		#Verifica se eh 2, caso seja inicia a operação de subtração.
			
	li	$t0,	3				#Definir t0 para comparação.
	beq	$t1	$t0,	multiplicacao		#Verifica se eh 3, caso seja inicia a operação de multiplicação.
			
	li	$t0,	4				#Definir t0 para comparação.
	beq	$t1,	$t0,	divisao			#Verifica se eh 4, caso seja inicia a operação de divisão.
			
	li	$t0,	5				#Definir t0 para comparação.
	beq	$t1,	$t0,	potencia		#Verifica se eh 5, caso seja inicia a operação de potenciação.
			
	li	$t0,	6				#Definir t0 para comparação.
	beq	$t1,	$t0,	raiz			#Verifica se eh 6, caso seja inicia a operação de raiciação.
			
	li	$t0,	7				#Definir t0 para comparação.
	beq	$t1,	$t0,	tabuada			#Verifica se eh 7, caso seja inicia a operação de tabuada.
			
			
	li	$t0,	8				#Definir t0 para comparação.
	beq	$t1,	$t0,	fatorial		#Verifica se eh 9, caso seja inicia a operação de fatoração.
			
	li	$t0,	9				#Definir t0 para comparação.
	beq	$t1,	$t0,	fibonacci		#Verifica se eh 10, caso seja inicia a operação fibonacci.
	
	li	$v0,	4				#Printar a primeira parte do menu.
	la	$a0,	strOpInv
	syscall
	
	j	loopMenuCalc
		
soma:
	jal	getTwoOp				#Chama a função que requisita dois operandos (e salva-os em v0 e v1).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	move	$a1,	$v1				#Move de v1 para a1 (a1 eh parametro de entrada na funcao).
	jal	funSoma					#Chama a função q realiza a soma (tendo operandos no a0 e a1) - retorna em v0.	
	j	print					#Pula pro label print para printar o resultado (que deve estar guardado em v0).
			
subtracao:
	jal	getTwoOp				#Chama a função que requisita dois operandos (e salva-os em v0 e v1).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	move	$a1,	$v1				#Move de v1 para a1 (a1 eh parametro de entrada na funcao).
	jal	funSub					#Chama a função q realiza a subtração (tendo operandos no a0 e a1) - retorna em v0.	
	j	print					#Pula pro label print para printar o resultado (que deve estar guardado em v0).
			
multiplicacao:
	jal	getTwoOp				#Chama a função que requisita dois operandos (e salva-os em a0 e a1).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	move	$a1,	$v1				#Move de v1 para a1 (a1 eh parametro de entrada na funcao).
	jal	funMult					#Chama a função q realiza a multiplicação (tendo operandos no a0 e a1) - retorna em v0.	
	li	$s0,	-2147483648			#Valor de erro no retorno eh -2147483648 (valor nao seria alcançado em operaçoes convencionais)
	beq	$v0,	$s0,	loopMenuCalc		#Se tiver erro (no retorno, v0) nao chama a label print, volta pro menu
	j	print					#Pula pro label print para printar o resultado (que deve estar guardado em v0).
		
divisao:
	jal	getTwoOp				#Chama a função que requisita dois operandos (e salva-os em v0 e v1).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	move	$a1,	$v1				#Move de v1 para a1 (a1 eh parametro de entrada na funcao).
	jal	funDiv					#Chama a função q realiza a divisão (tendo operandos no a0 e a1) - sem retorno.
	j	loopMenuCalc				#Retorna para o menu (divisao tem print proprio, pois imprime o resto)
					
potencia:
	jal	getTwoOp				#Chama a função que requisita dois operandos (e salva-os em v0 e v1).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	move	$a1,	$v1				#Move de v1 para a1 (a1 eh parametro de entrada na funcao).
	jal	funPow					#Chama a função q realiza a potenciação (tendo operandos no a0 e a1) - retorno em v0.	
	li	$s0,	-2147483648			#Valor de erro no retorno eh -2147483648 (valor nao seria alcançado em operaçoes convencionais)
	beq	$v0,	$s0,	loopMenuCalc		#Se tiver erro (no retorno, v0) nao chama a label print, volta pro menu
	j	print					#Pula pro label print para printar o resultado (que deve estar guardado em v0).

tabuada:
	jal	getOneOp				#Chama a função que requisita um operandos (e salva-o em v0).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	jal	funTabu					#Chama a função q realiza a tabuada (tendo operando no a0) - sem retorno.	
	j	loopMenuCalc				#Retorna para o menu, pois a funcao soh imprime, nao tem retorno

raiz:
	jal	getOneOp				#Chama a função que requisita um operandos (e salva-o em v0 ).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	jal	funSqrt					#Chama a função q realiza a raiz quadrada (tendo operando no a0).	
	li	$s0,	-2147483648			#Valor de erro no retorno eh -2147483648 (valor nao seria alcançado em operaçoes convencionais)
	beq	$v0,	$s0,	loopMenuCalc		#Se tiver erro (no retorno, v0) nao chama a label print, volta pro menu
	j	print					#Pula pro label print para printar o resultado (que deve estar guardado em v0).

fatorial:	
	jal	getOneOp				#Chama a função que requisita um operando (e salva-o em v0 ).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	jal	funFat					#Chama a função q realiza o fatorial (tendo operando no a0) - retorno no v0.	
	li	$s0,	-2147483648			#Valor de erro no retorno eh -2147483648 (valor nao seria alcançado em operaçoes convencionais)
	beq	$v0,	$s0,	loopMenuCalc		#Se tiver erro (no retorno, v0) nao chama a label print, volta pro menu
	j	print					#Pula pro label print para printar o resultado (que deve estar guardado em v0).

fibonacci:	
	jal	getFibPos				#Chama a função que requisita as posicoes para fibonacci (e salva-os em v0 e v1 ).
	move	$a0,	$v0				#Move de v0 para a0 (a0 eh parametro de entrada na funcao).
	move	$a1,	$v1				#Move de v1 para a1 (a1 eh parametro de entrada na funcao).
	jal	funFibo					#Chama a função q realiza a divisão (tendo operandos no a0 e a1) - sem retorno.
	j	loopMenuCalc				#Retorna para o menu, pois a funcao soh imprime, nao tem retorno
	
print:
	move	$t0,	$v0				#Move a resposta final (que sera salvo em v0) para t0 evitando perdas.
	li	$v0,	4				#Imprime a resposta final.
	la	$a0,	strPrintA			# "A resposta da operação eh: "
	syscall
			
	li	$v0,	1				#Apresenta o numero da resposta da operação.
	move	$a0,	$t0				#O numero foi armazenado em t0, temporariamente
	syscall	
			
	li	$v0,	4				#Imprime o final da resposta.
	la	$a0,	strPrintB			# ".\n\n"
	syscall
			
	j loopMenuCalc
			
endProg:
	li 	$v0,	10				#Finaliza o programa.
	syscall						
	
	
	
getOneOp:
	addi	$sp,	$sp,	-4			#'Aloca' espaço na stack.
	sw	$ra,	0($sp)				#Carrega o $ra no espaço reservado.
	
	li	$v0,	4				#Imprime a string requisitando a entrada de um numero.
	la	$a0,	strNumC				# "Insira o operando: "
	syscall	
		
	li	$v0,	5				#Ler o primeiro inteiro entrdo e salvar na stack.
	syscall
	
	lw	$ra,	0($sp)				#Desempilha $ra.
	addi	$sp,	$sp,	4			#'Desaloca' a memória.
	jr	$ra
		
						
getTwoOp:
	addi	$sp,	$sp,	-4			#'Aloca' espaço na stack.
	sw	$ra,	0($sp)				#Carrega o $ra no espaço reservado.

	li	$v0,	4				#Imprime a string requisitando a entrada de um numero.
	la	$a0,	strNumA				# "Insira o primeiro operando: "
	syscall	
	
	li	$v0,	5				#Le o primeiro inteiro entrado.
	syscall
	
	move	$t0,	$v0				#Armazena o inteiro em t0 (temporariamente)
			
	li	$v0,	4				#Imprime a string requisitando a entrada de mais um numero.
	la	$a0,	strNumB				# "Insira o segundo operando: "
	syscall
	
	li	$v0,	5				#Le o segundo inteiro entrado.
	syscall
	
	move	$v1,	$v0				#Salva o segundo inteiro em v1
	move	$v0,	$t0				#Salva o primeiro inteiro em v0
			
	lw	$ra,	0($sp)				#Desempilha $ra.
	addi	$sp,	$sp,	4			#'Desaloca' a memória.
	jr	$ra					#Retorna
	

getFibPos:
	addi	$sp,	$sp,	-4			#'Aloca' espaço na stack.
	sw	$ra,	0($sp)				#Carrega o $ra no espaço reservado.
	
	li	$v0,	4				#Imprime a string requisitando a entrada de um numero.
	la	$a0,	strGetFibA			# "Digite a primeira posição desejada da sequencia fibonacci:"
	syscall	
	
	li	$v0,	5				#Le o primeiro inteiro entrado.
	syscall
	
	move	$t0,	$v0				#Armazena o inteiro em t0 (temporariamente)
	
	li	$v0,	4				#Imprime a string requisitando a entrada de mais um numero.
	la	$a0,	strGetFibB			# "Digite a ultima posição desejada da sequencia fibonacci:"
	syscall	
	
	li	$v0,	5				#Le o segundo inteiro entrado.
	syscall
	
	move	$v1,	$v0				#Salva o segundo inteiro em v1
	move	$v0,	$t0				#Salva o primeiro inteiro em v0
				
	lw	$ra,	0($sp)				#Desempilha $ra.
	addi	$sp,	$sp,	4			#'Desaloca' a memória.
	jr	$ra					#Retorna.
	
	#Funcao Soma	
funSoma:
	addi 	$sp, 	$sp, 	-12			#'Aloca' espaço na stack.
	sw 	$ra, 	0($sp)				#Carrega o $ra no espaço reservado.
	sw	$a0,	4($sp)				#Carrega o $a0 no espaço reservado.
	sw	$a1,	8($sp)				#Carrega o $a1 no espaço reservado.
	
	add	$v0,	$a0,	$a1			#Soma a0 com a1 e armazena a resposta em v0.	
	
	lw	$a1,	8($sp)				#Desempilha $a1
	lw	$a0,	4($sp)				#Desempilha $a0
	lw 	$ra,	0($sp)				#Desempilha $ra.
	addi 	$sp, 	$sp, 	12			#'Desaloca' a memória.
	jr 	$ra					#Volta para o lugar onde foi chamado.
	
	#Funcao Subtracao
funSub:
	addi 	$sp, 	$sp, 	-12			#'Aloca' espaço na stack.
	sw 	$ra, 	0($sp)				#Carrega o $ra no espaço reservado.
	sw	$a0,	4($sp)				#Carrega o $a0 no espaço reservado.
	sw	$a1,	8($sp)				#Carrega o $a1 no espaço reservado.
	
	sub	$v0,	$a0,	$a1			#Subtrai a1 de a0 e armazena a resposta em v0.
	
	lw	$a1,	8($sp)				#Desempilha $a1
	lw	$a0,	4($sp)				#Desempilha $a0
	lw 	$ra,	0($sp)				#Desempilha $ra.
	addi 	$sp, 	$sp, 	12			#'Desaloca' a memória.			
	jr 	$ra					#Volta para o lugar onde foi chamado.

	#Funcao Multiplicacao	
funMult:
	addi 	$sp, 	$sp, 	-12			#'Aloca' espaço na stack.
	sw 	$ra, 	0($sp)				#Carrega o $ra no espaço reservado.
	sw	$a0,	4($sp)				#Carrega o $a0 no espaço reservado.
	sw	$a1,	8($sp)				#Carrega o $a1 no espaço reservado.
	
	li	$s0,	-32768				#Valor minimo que pode ser multiplicado.
	blt	$a0,	$s0,	errorMult		#Se for menor que o minimo, erro.
	blt	$a1,	$s0,	errorMult		#Se for menor que o minimo, erro.
	
	li	$s1,	32767				#Valor maximo que pode ser multiplicado.
	bgt	$a0,	$s1,	errorMult		#Se for maior que o maximo, erro.
	bgt	$a1,	$s1,	errorMult		#Se for maior que o maximo, erro.
	
	mul	$v0,	$a0,	$a1			#Multiplica a0 com a1 e armazena a resposta em v0.			
	j	endMult					#Vai para o fim (para retornar).
	
errorMult:
	li	$v0,	4				#Printar erro.
	la	$a0,	strNumInv			# "Operando(s) invalido(s).\n"
	syscall
	
	li	$v0,	-2147483648			#Valor usado para representar erro (nenhuma operaçao chegaria nesse resultado).
							#O valor representa o -inf, menos infinito).
endMult:
	lw	$a1,	8($sp)				#Desempilha $a1.
	lw	$a0,	4($sp)				#Desempilha $a0.
	lw 	$ra,	0($sp)				#Desempilha $ra.
	addi 	$sp, 	$sp, 	12			#'Desaloca' a memória.			
	jr 	$ra					#Volta para o lugar onde foi chamado.
	
	#Funcao Divisao
funDiv:
	addi 	$sp, 	$sp, 	-12			#'Aloca' espaço na stack.
	sw 	$ra, 	0($sp)				#Carrega o $ra no espaço reservado.
	sw	$a0,	4($sp)				#Carrega o $a0 no espaço reservado.
	sw	$a1,	8($sp)				#Carrega o $a1 no espaço reservado.
	
	beq	$a1,	$zero,	errorDiv		#Se o divisor for zero, erro.
	
	li	$s0,	-32768				#Valor minimo que pode ser dividido.
	blt	$a0,	$s0,	errorDiv		#Se for menor que o minimo, erro.
	blt	$a1,	$s0,	errorDiv		#Se for menor que o minimo, erro.
	
	li	$s1,	32767				#Valor maximo que pode ser dividido.
	bgt	$a0,	$s1,	errorDiv		#Se for maior que o maximo, erro.
	bgt	$a1,	$s1,	errorDiv		#Se for maior que o maximo, erro.
	
	div	$a0,	$a1				#Divide a0 por a1 e armazena a resposta em v0.
	
	mflo	$t0					#Move o resultado para t0.
	mfhi	$t1					#Move o resto para t1.
	
	li	$v0,	4				#Printa string resultado.
	la	$a0,	strPrintA			# "A resposta da operação eh: "
	syscall
	
	li	$v0,	1				#Printa a resposta.
	move	$a0,	$t0				#Resultado esta guardado em t0.
	syscall
	
	li	$v0,	4				#Printa string pula linha.
	la	$a0,	strBarraN			# "\n"
	syscall
	
	li	$v0,	4				#Printa string resto.
	la	$a0,	strDivResto			# "O resto eh: "
	syscall
	
	li	$v0,	1				#Printa o resto.
	move	$a0,	$t1				#Resto esta guardado em t1.
	syscall
	
	li	$v0,	4				#Printa string fim de resposta.
	la	$a0,	strPrintB			# ".\n\n"
	syscall
					
	j	endDiv					#Depois de printar vai para o fim da funcao.
	
errorDiv:
	li	$v0,	4				#Printar erro.
	la	$a0,	strNumInv			# "Operando(s) invalido(s).\n"
	syscall

endDiv:	
	lw	$a1,	8($sp)				#Desempilha $a1.
	lw	$a0,	4($sp)				#Desempilha $a0.
	lw 	$ra,	0($sp)				#Desempilha $ra.
	addi 	$sp, 	$sp, 	12			#'Desaloca' a memória.			
	jr 	$ra					#Retorna.	
	
	#Funcao Potencia
funPow:
	addi 	$sp, 	$sp, 	-12			#'Aloca' espaço na stack.
	sw 	$ra, 	0($sp)				#Carrega o $ra no espaço reservado.
	sw	$a0,	4($sp)				#Carrega o $a0 no espaço reservado.
	sw	$a1,	8($sp)				#Carrega o $a1 no espaço reservado.
	
	move 	$t0, 	$a1 				#Guarda o expoente no $t0.
	move 	$a1, 	$a0				#$a1 e $a0 tem o mesmo valor, a base.
	addi 	$a0, 	$zero, 	1 			#$a0 recebe 1.
	
	addi	$v0,	$zero,	1			#$v0 recebe 1 (valor de retorno para fatorial de 0)
	
	blt	$t0,	$zero,	errPow			#Se o expoente for menor que zero, mostra erro
loopPow: 	
	beq 	$t0, 	$zero, 	endLoopPow		#Quando $t0 for igual a $zero, acaba o loop. 
	jal 	funMult					#Chama a função de multiplicação (Multiplica a0 por a1).
	
	li	$s0,	-2147483648			#Valor usado para representar erro (nenhuma operaçao chegaria nesse resultado).
	beq	$v0,	$s0,	endLoopPow 		#Se o retorno foir igual ao erro, acaba o loop
	
	addi 	$t0, 	$t0,	-1			#Decrementa $t0.
	move	$a0,	$v0				#Move o retorno (da funcao de multiplicacao) pra $a0
	j 	loopPow					#Executa o loop

errPow:	
	li	$v0,	4				#Printar erro.
	la	$a0,	strNumInv
	syscall
	
	li	$v0,	-2147483648			#Valor usado para representar erro (nenhuma operaçao chegaria nesse resultado).
	
endLoopPow:
	lw	$a1,	8($sp)				#Desempilha $a1
	lw	$a0,	4($sp)				#Desempilha $a0
	lw 	$ra,	0($sp)				#Desempilha $ra.
	addi 	$sp, 	$sp, 	12			#'Desaloca' a memória.
	jr 	$ra					#Retorna para onde foi chamado.
	
	#Funcao Tabuada	
funTabu:
	addi	$sp,	$sp,	-8			#'Aloca' espaço na stack.
	sw	$ra,	0($sp)				#Carrega o $ra no espaço resevado.
	sw	$a0,	4($sp)				#Carrega o $a0 no espaço reservado.
	
	li 	$t1,	1				#Carrega 1 no $t1 (usado como contador)
	li	$t3,	10				#Carrega 10 para comparar (quando chega ao fim)
	
	move	$t0,	$a0				#Armazena $a0 em $t0, temporariamente
loopTabu:
	move	$a0,	$t0				#Move o operando para $a0
	move	$a1,	$t1				#Move o contador para $a1
	jal	funMult					#Chama a funçao de multiplicaçao
	
	li	$s0,	-2147483648			#Carrega o valor de erro em $s0
	beq	$v0,	$s0,	endLoopTabu		#Se o retorno for igual ao erro, acaba o loop
	
	move	$t2,	$v0				#Guarda o resultado em $t2
	
	li	$v0,	1				#Printa um int
	move	$a0,	$t0				#Move para $a0 o numero a ser printado(operando)
	syscall						
	
	li	$v0,	4				#Printa uma string
	la	$a0,	strTabuA			#Carrega a string a ser printada (*)
	syscall						
	
	li	$v0,	1				#Printa um int
	move	$a0,	$t1				#Carrega o int a ser printado (contador)
	syscall						
	
	li	$v0,	4				#Printa uma string
	la	$a0,	strTabuB			#Carrega a string a ser printada (=)
	syscall						
	
	li	$v0,	1				#Printaa um int
	move	$a0,	$t2				#Carrega o int a ser printado (resultado)
	syscall						
	
	li	$v0,	4				#Printa uma string
	la	$a0,	strBarraN			#Carrega a string a ser printada (\n)
	syscall						
	
	beq	$t1,	$t3,	endLoopTabu		#Se o contador for igual a 10, acaba o loop
	addi	$t1,	$t1,	1			#Incrementa o contador
	
	j loopTabu					#Realiza o loop

endLoopTabu:
	lw	$a0,	4($sp)				#Desempilha $a0
	lw	$ra,	0($sp)				#Desempilha $ra
	addi	$sp,	$sp,	8			#'Desaloca' a memoria
	jr	$ra					
	
	#Funcao Raiz Quadrada
funSqrt:
	# O algoritmo usado para achar a raiz inteira eh uma aproxima��o que funciona da seguinte forma:
	# Para se encontrar a raiz de um inetrio n, um inteiro x se inicia com o valor de n.
	# � feito ent�o um loop que � realizado n/2 vezes em que a cada passo x � atualizado com a m�dia entre x e n/x.
	# Desse modo ao chegar na n/2-esima itera��o o resultado em x sera o numero inteiro que se referiria ao floor da raiz de n.
	# o Algoritimo em C usado como base eh:
	# int sqroot(int n){
	#	int x = n;
	#	for(int i = 0; i < n/2; i++)
	#		x = (x + n/x) / 2;
	#
	#	return x;
	#}
	addi	$sp,	$sp,	-8			#'Aloca' espa�o na stack.
	sw	$ra,	4($sp)				#Carrega o $ra no espa�o resevado.
	sw	$a0,	0($sp)				#Carrega o $a0 no espa�o reservado.
	
	blt	$a0,	$zero,	errSqrt			#Se o operando for menor que 0, mostra erro.
	#inicializa��oo das vari�veis
	move	$t0,	$a0				#$t0 = n	//t0 eh onde sera guardado o valor de n.
	addi	$t1,	$zero,	0			#$t1= i = 0	//t1 sera o i, que eh inicializado com 0.
	move	$t2,	$t0				#$t2 = x = n	//t2 eh x, que eh inicializado com n.
	addi	$t3,	$zero,	2			#$t3 = 2	//t3 sera um auxiliar para dividir por 2 na hora da media.
	div 	$t0,	$t3				#$lo = n/2	
	mflo	$t4					#t4 = $lo	//t4 sera ent�o n/2 que indica o final do loop.
	
loopSqrt:
	#o codigo a seguir representa a atribui��o a x do valor da m�dia entre x e n/x.
	div	$t0,	$t2				#n/x
	mflo	$t5					#t5 = n/x	//t5 eh uma variavel auxiliar que guarda n/x para que seja 
							#		//realizada a media.
	add	$t2,	$t5,	$t2			#t2 = x + n/x	
	div	$t2,	$t3				#(x + n/x)/2	
	mflo	$t2					#$t2 = (x+n/x)/2//aqui temos ent�o x recebendo (x + n/x)/2, ou seja, 
							#		//a media entre x e n/x.
	addi	$t1,	$t1, 	1			#i++		//i eh incrementado.
	blt 	$t1,	$t4,	loopSqrt		#if($t1 < $t4) -> loop // enquanto i for menor que n/2 o loop continua.
	
	move	$v0,	$t2				#return $t2	// ao chegar ao final do loop x eh retornado pela fun��o.
	
	j	endSqrt					#jump para a funaliza��o da fun��o.
	
errSqrt:
	li	$v0,	4				#Printar erro.
	la	$a0,	strNumInv
	syscall
	
	li	$v0,	-2147483648
	
endSqrt:
	lw	$ra,	4($sp)				#Desempilha
	lw	$a0,	0($sp)				#Desempilha
	addi	$sp,	$sp,	 8			#Retorna $sp para pos original
	jr	$ra					#retorna o procedimento
	
	#Funcao Fatorial
funFat:
	addi	$sp,	$sp,	-8			# move o ponteiro de stack
	sw	$a0,	0($sp)				# armazena $a0 na pilha
	sw	$ra,	4($sp)				# armazena $ra na pilha
		
	blt	$a0,	$zero,	errFat			#se o operando for zero, mostra erro
	li	$t0,	12				#carrega 12 em $t0
	bgt	$a0,	$t0,	errFat			#se o operando for maior que 12, mostra erro (estoura o int)
	
	addi	$t3,	$zero,	1			# valor fixo 1
	addi	$v0,	$zero,	1			# fat = 1
	
loopFat:
	ble	$a0,	$t3,	endFat			# se for menor que um, pula pro fim do loop
	mul	$v0,	$v0,	$a0			# multiplica fat pelo numero sendo decrescido
	addi	$a0,	$a0,	-1			# decresce o numero
	j	loopFat

errFat:
	li	$v0,	4				#Printar erro.
	la	$a0,	strNumInv
	syscall
	
	li	$v0,	-2147483648			#retorna valor de erro

endFat:
	lw	$a0,	0($sp)				# desempilha o $a0
	lw	$ra,	4($sp)				# desempilha o $ra
	addi	$sp,	$sp,	8			# reseta posicao ponteiro de stack

	jr	$ra					# volta para onde $ra aponta
	
	#Funcao Fibonacci
funFibo:	
	addi	$sp,	$sp,	-12			#desloca $sp
	sw	$ra,	8($sp)				#guarda	$ra
	sw	$a0,	0($sp)				#guarda $a0
	sw	$a1,	4($sp)				#guarda $a1
	move	$t0,	$a0				#$t0 -> pos inicial
	move	$t1,	$a1				#$t1 -> pos final	
	bgt 	$t0,	$t1,	fiboError		#if($t1 < $t0) erro
	
	ble	$t0,	$zero,	fiboOpInv		#if ($t0 < 0) erro
	
	la	$a0,	strFibA				#Imprime o inicio da resposta da função
	li	$v0,	4
	syscall
	li	$t2,	0				#$t2 = n-1 = 0				//inicializa os valores como os iniciais
	li	$t3,	1				#$t3 = n = 1				//da fibonacci.
	li	$t4,	1				#$t4 = cont = 1				//e o contador como 1 indicando 
							#					//que esta iniciando na primeira posi��o.
	
fiboCheck:
	blt	$t4,	$t0,	fiboCalc		#if(cont < posInicial) n�o printa 	//se isso acontece quer dizer que
							#					//a posi��o atual n�o esta no limite 
							#					//estipulado pelo usuario.
	#imprime resultado
	li	$v0,	1	
	move	$a0,	$t3				#print n
	syscall
	la	$a0,	strSpace			#print " "
	li	$v0,	4
	syscall
	bge	$t4,	$t1,	endFibo			#if(cont >= posFinal) Termina
	
fiboCalc:
	#calculo -> check
	move	$t6,	$t3				#aux = n
	add	$t3,	$t2,	$t3			#n+1 = n + n-1			//o proximo da sequencia recebe
							#				//soma do numero anterior e o antecessor.
	move	$t2,	$t6				#n-1 = n			
	addi	$t4,	$t4,	1			#cont++
	j	fiboCheck
	
fiboOpInv:
	la	$a0,	strNumInv			#imprime string de erro
	li	$v0,	4
	syscall
	
	j	endFibo
	
fiboError:
	la	$a0,	strFibError			#imprime string de erro
	li	$v0,	4
	syscall
	
endFibo:	
	la	$a0,	strBarraN			#impreme \n  dps da sequencia
	li	$v0,	4
	syscall
	
	#retorna funcao
	lw	$a0,	0($sp)				#
	lw	$a1,	4($sp)				#Desempilha
	lw	$ra,	8($sp)				#
	addi	$sp,	$sp,	12			#retorna $sp para pos inicial
	jr	$ra					#retorna o procedimento
