.data
vetor: .word 0 2 1 3 6 2 2 5 6 4 2
##### START MODIFIQUE AQUI START #####
#addi x13, x0, 11 # marca o registrador 13 como 11
##### END MODIFIQUE AQUI END #####
.text
main:
    la x12, vetor # carrega do vetor para o registrador x12, e o inicio dele 
    addi x14, x0, 0 # indica se é CFP ou CNPJ   
    jal x1, verificadastro # chama a função verificadastro
    beq x0,x0,FIM # encerra o programa

##### START MODIFIQUE AQUI START #####

primeiraiteracao:
	lw x6, 0(x12)
	mul x6, x6, x15
    add x17, x17, x6
    #sw x6, 0(x12)
	addi x15, x15, -1
	#addi x14, x14, 1
	addi x12, x12, 4
    bne x15, x14, primeiraiteracao
    jalr x0, 0(x1)


segundainteracao:
	lw x5, 0(x12)
	mul x5, x5, x13
    add x18, x18, x5
    #sw x6, 0(x12)
	addi x13, x13, -1
	#addi x14, x14, 1
	addi x12, x12, 4
    bne x13, x14, segundainteracao
    jalr x0, 0(x1)
    
verificadigito:
	mul x17, x17, x15 # realiza a multiplicacao por 10 dos primeiros 9 elementos
    mul x18, x18, x15 # realiza a multiplicacao por 10 dos primeiros 10 elementos
    jalr x0, 0(x1)	
    
    
verificacpf: 
	add x17, x0, x0 # guarda a soma de todos os valores do vetor na primeira passada
    add x18, x0, x0 # guarda a soma de todos os valores do vetor na segunda rodada
	addi x14, x0, 1 # o limite minimo que o vetor deve realizar as somas
	addi x13, x0, 11 # aloca a quantidade de elementos que o vetor tem
    #add x13, x13, x12 # adiciona o inicio do vetor a x13
    addi x15, x0, 10 # coloca 10 o valor 10 em x14
    #slli x15, x15, 2 
    # sw x15, 0(x12) # guarda o valor de x15 em na primeira pos de x12
    sw x16, 0(x1)
    jal x1, primeiraiteracao
    addi x12, x12, -36 # volta a posicao do x12 para a primeira
    jal x1, segundainteracao
    addi x13, x0, 11 # coloca 11 em x13 novamente para realizar o MOD
    addi x15, x0, 10 # coloca 10 em x13 novamente para realizar a multiplicação
    jal x1, verificadigito
    lw x1, 0(x16)
    beq x0, x0, retorna

verificacnpj: 


retorna:
    jalr x0, 0(x1) # realiza o retorno da funcao

verificadastro: 
	beq x14, x0, verificacpf # se o valor do registrador x14 for zero, chama a função verificacpf
    jal x1, verificacnpj # se o valor do registrador x14 for diferente de zero, chama a função verificacnpj
    jal x0,retorna # chama a função retorna

##### END MODIFIQUE AQUI END #####

FIM: 
    add x1, x0, x10