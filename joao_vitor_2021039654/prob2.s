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
	mul x13, x13, x15
    sw x13, 0(x12)
	addi x15, x15, -1
	addi x13, x12, 1
    bne x13, x15, primeiraiteracao
    jalr x0, 0(x2)
    
segundainteracao:


verificacpf: 
	#addi x13, x0, 11 # aloca a quantidade de elementos que o vetor tem
    add x13, x13, x12 # adiciona o inicio do vetor a x13
    addi x15, x0, 10 # coloca 10 o valor 10 em x14
    # slli x14, x14, 2 
    sw x15, 0(x12)
    jal x2, primeiraiteracao
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
    add x1, x0, x10vetor: .word 0 2 1 3 6 2 2 5 6 4 2
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
	mul x13, x13, x15
    sw x13, 0(x12)
	addi x15, x15, -1
	addi x13, x12, 1
    bne x13, x15, primeiraiteracao
    jalr x0, 0(x2)
    
segundainteracao:


verificacpf: 
	#addi x13, x0, 11 # aloca a quantidade de elementos que o vetor tem
    add x13, x13, x12 # adiciona o inicio do vetor a x13
    addi x15, x0, 10 # coloca 10 o valor 10 em x14
    # slli x14, x14, 2 
    sw x15, 0(x12)
    jal x2, primeiraiteracao
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