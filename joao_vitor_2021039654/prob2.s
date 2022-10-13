.data
vetor: .word 1 2 3 4 5 6 7 8 9 10 11
##### START MODIFIQUE AQUI START #####
##### END MODIFIQUE AQUI END #####
.text
main:
    la x12, vetor # carrega do vetor para o registrador x12, e o inicio dele 
    addi x14, x0, 0 # indica se é CFP ou CNPJ   
    jal x1, verificadastro # chama a função verificadastro
    beq x0,x0,FIM # encerra o programa

##### START MODIFIQUE AQUI START #####

primeiraiteracao:
	lw x6, 0(x12) # carrega o elemento do cpf
	mul x6, x6, x15 # realiza a multiplicacao dele por a k, que vai de 10 a 2, decrescendo 1 unidade a cada passo, comecando na primeira posicao do CPF e indo ate a 9
    add x17, x17, x6 # soma o resultado da multiplicação acima com as anteriores e guarda em x17
	addi x15, x15, -1 # diminui 1 de k
	addi x12, x12, 4 # anda para o proximo algarismo do CPF
    bne x15, x14, primeiraiteracao # enquanto nao chegar na posicao 9 realiza novamente a funcao
    jalr x0, 0(x1) # retorna para a funcao verifica CPF


segundainteracao:
	lw x5, 0(x12)  # carrega o elemento do cpf
	mul x5, x5, x13 # realiza a multiplicacao dele por a j, que vai de 11 a 2, decrescendo 1 unidade a cada passo, comecando na primeira posicao do CPF e indo ate a 10
    add x18, x18, x5 # soma o resultado da multiplicação acima com as anteriores e guarda em x18 
	addi x13, x13, -1 # diminui 1 de j
	addi x12, x12, 4 # anda para o proximo algarismo do CPF
    bne x13, x14, segundainteracao  # enquanto nao chegar na posicao 10 realiza novamente a funcao
    jalr x0, 0(x1) # retorna para a funcao verifica CPF

falso: # da para reutilizar!!!!
	addi x10, x10, 0 # coloca a resposta como falsa
    jalr x0, 0(x1) # retorna para a funcao verifica CPF 

verificadigito: # da para reutilizar!!!! eu acho
	mul x17, x17, x15 # realiza a multiplicacao por 10 dos primeiros 9 elementos
    rem x17, x17, x13 # realiza o mod de 11
    mul x18, x18, x15 # realiza a multiplicacao por 10 dos primeiros 10 elementos
    rem x18, x18, x13 # realiza o mod de 11
    addi x12, x12, -40# volta a posicao do x12 para a primeira
    lw x7, 36(x12) # carrega o digito na posicao 10
    lw x8, 40(x12) # carrega o digito na posica 11
    rem x18, x18, x15 # realiza o mod de 10 para normalizar valores maiores que 10
    rem x17, x17, x15 # realiza o mod de 10 para normalizar valores maiores que 10
    bne x17, x7, falso # se o digito na posicao 10 for diferente do calculado, retorna falso
    bne x18, x8, falso # se o digito na posicao 11 for diferente do calculado, retorna falso
   	addi x10, x10, 1 # se nao for, retorna verdadeiro
    jalr x0, 0(x1) # retorna para a funcao verifica CPF
    
    
verificacpf: 
	add x17, x0, x0 # guarda a soma de todos os valores do vetor na primeira passada
    add x18, x0, x0 # guarda a soma de todos os valores do vetor na segunda rodada
	addi x14, x0, 1 # o limite minimo que o vetor deve realizar as somas
	addi x13, x0, 11 # aloca a quantidade de elementos que o vetor tem
    addi x15, x0, 10 # coloca 10 o valor 10 em x14
    sw x16, 0(x1) # salva o valor de x16 na pilha, para retorno
    jal x1, primeiraiteracao # chama a primeira parte do algoritmo
    addi x12, x12, -36 # volta a posicao do x12 para a primeira
    jal x1, segundainteracao # chama a segunda parte do algoritmo
    addi x13, x0, 11 # coloca 11 em x13 novamente para realizar o MOD
    addi x15, x0, 10 # coloca 10 em x13 novamente para realizar a multiplicação
    jal x1, verificadigito #chama a funcao que verifica se os digitos sao iguais aos calculados
    lw x1, 0(x16) # carrega o valor para retorno 
    beq x0, x0, retorna # chama a funcao para sair da analise do CPF

verificacnpj: 


retorna: # da para reutilizar!!!!
    jalr x0, 0(x1) # realiza o retorno da funcao

verificadastro: 
	beq x14, x0, verificacpf # se o valor do registrador x14 for zero, chama a função verificacpf
    jal x1, verificacnpj # se o valor do registrador x14 for diferente de zero, chama a função verificacnpj
    jal x0,retorna # chama a função retorna

##### END MODIFIQUE AQUI END #####

FIM: 
    add x1, x0, x10