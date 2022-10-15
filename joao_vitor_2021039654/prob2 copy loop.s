.datavetor: .word 5 48 3 4 8 9 8 24 67 857 5 4 3 9
##### START MODIFIQUE AQUI START ########## END MODIFIQUE AQUI END #####.textmain:    la x12, vetor # carrega do vetor para o registrador x12, e o inicio dele     addi x14, x0, 1 # indica se é CFP(0) ou CNPJ(1)    jal x1, verificadastro # chama a função verificadastro    beq x0,x0,FIM # encerra o programa
##### START MODIFIQUE AQUI START #####

primeiraparte: 
   lw x6, 0(x12) # carrega o elemento do CPF/CNPJ
    mul x6, x6, x15 # realiza a multiplicacao dele por a k, que vai de ate 2, decrescendo 1 unidade a cada passo 
       add x19, x19, x6 # soma o resultado da multiplicação acima com as anteriores e guarda em x19        
       addi x15, x15, -1 # diminui 1 de k    
       addi x12, x12, 4 # anda para o proximo algarismo do CPF/CNPJ    
       bne x15, x14, primeiraparte # enquanto nao chegar na posicao no limite de descrescimento, continua a parte
    jalr x0, 0(x1) # retorna para a funcao verifica CPF/CNPJ

segundainteracao:    
    lw x5, 0(x12)  # carrega o elemento do CPF/CNPJ
    mul x5, x5, x13 # realiza a multiplicacao dele por a j, ate 2, decrescendo 1 unidade a cada passo    
    add x18, x18, x5 # soma o resultado da multiplicação acima com as anteriores e guarda em x18 
    addi x13, x13, -1 # diminui 1 de j    addi x12, x12, 4 # anda para o proximo algarismo do CPF/CNPJ    
    bne x13, x14, segundainteracao  # enquanto nao chegar na posicao limite de descrescimento realiza novamente a funcao        
    jalr x0, 0(x1) # retorna para a funcao verifica CPF/CNPJ

verificadigitoCPF:    
mul x19, x19, x15 # realiza a multiplicacao por 10 da primeira parte    
rem x19, x19, x13 # realiza o mod de 11   
 mul x18, x18, x15 # realiza a multiplicacao por 10 da segunda parte    
 rem x18, x18, x13 # realiza o mod de 11
    addi x12, x12, -40# volta a posicao do x12 para a primeiro digito    
    lw x7, 36(x12) # carrega o digito na posicao 10    
    lw x8, 40(x12) # carrega o digito na posica 11
    rem x18, x18, x15 # realiza o mod de 10 para normalizar valores maiores que 10    
    rem x19, x19, x15 # realiza o mod de 10 para normalizar valores maiores que 10
    bne x19, x7, falso # se o digito na posicao 10 for diferente do calculado, retorna falso   
     bne x18, x8, falso # se o digito na posicao 11 for diferente do calculado, retorna falso   
      addi x10, x10, 1 # se nao for, retorna verdadeiro       
       jalr x0, 0(x1) # retorna para a funcao verifica CPF        
       
       
       verificaCPF:    
       # addi x13, x0, 11 # aloca a quantidade de elementos que devem ser analisados          
        # addi x15, x0, 10 # coloca o valor em que se deve iniciar a multiplicacao
    lw x13, 4(sp) #  aloca a quantidade de elementos que devem ser analisados    

    lw x15, 8(sp) #  coloca o valor em que se deve iniciar a multiplicacao
    sw x16, 0(x1) # salva o valor de x16 na pilha, para retorno

    jal x1, primeiraparte # chama a primeira parte do algoritmo

    addi x12, x12, -36 # volta a posicao inical do CPF    
    jal x1, segundainteracao # chama a segunda parte do algoritmo

    # addi x13, x0, 11 # coloca 11 em x13 novamente para realizar o MOD   
    # addi x15, x0, 10 # coloca 10 em x13 novamente para realizar a multiplicação

    lw x13, 4(sp) # coloca 11 em x13 novamente para realizar o MOD    
    lw x15, 8(sp) # coloca 10 em x13 novamente para realizar a multiplicação

    jal x1, verificadigitoCPF #chama a funcao que verifica se os digitos sao iguais aos calculados    
    lw x1, 0(x16) # carrega o valor para retorno         
    beq x0, x0, retorna # chama a funcao para sair da analise do CPF

##### VERIFICAÇÃO CNPJ ######

verificadigitoCNPJ:     
    mul x19, x19, x15 # realiza a multiplicacao por 10 da primeira parte    
    rem x19, x19, x13 # realiza o mod de 11    
    mul x18, x18, x15 # realiza a multiplicacao por 10 da segunda parte    
    rem x18, x18, x13 # realiza o mod de 11
    addi x12, x12, -52 # volta a posicao do inical do CNPJ    
    lw x7, 48(x12) # carrega o digito na posicao 13    
    lw x8, 52(x12) # carrega o digito na posica 14
    rem x18, x18, x15 # realiza o mod de 10 para normalizar valores maiores que 10    
    rem x19, x19, x15 # realiza o mod de 10 para normalizar valores maiores que 10
    bne x19, x7, falso # se o digito na posicao 13 for diferente do calculado, retorna falso    
    bne x18, x8, falso # se o digito na posicao 14 for diferente do calculado, retorna falso    
    addi x10, x10, 1 # se nao for, retorna verdadeiro
    jalr x0, 0(x1) # retorna para a funcao verifica CNPJ


verificaCNPJ: 

    #addi x13, x0, 5 # aloca a quantidade de elementos que devem ser analisados    
    # addi x15, x0, 5 # coloca o valor em que se deve iniciar a multiplicacao

    lw x13, 0(sp) # aloca a quantidade de elementos que devem ser analisados    
    lw x15, 0(sp) # coloca o valor em que se deve iniciar a multiplicacao

    sw x16, 0(x1) # salva o valor de x16 na pilha, para retorno    
    jal x1, primeiraparte # chama a primeira parte do algoritmo

    addi x12, x12, -16 # volta a posicao do x12 para a primeira    
    addi x13, x13, 1 # adiciona 1 a x13 para realizar a segunda rodada   

    jal x1, segundainteracao # chama a segunda parte do algoritmo

    addi x12, x12, -4 # volta para a posicao central do CNPJ 

    addi x13, x0, 8 # aloca a quantidade de elementos que devem ser analisados    
    addi x15, x0, 9 # coloca o valor em que se deve iniciar a multiplicacao    
    
    # sw x16, 0(x1) # salva o valor de x16 na pilha, para retorno    
    jal x1, primeiraparte # chama a primeira parte do algoritmo

    addi x12, x12, -28 # volta para a posicao central do CNPJ    
    addi x13, x0, 9 # coloca o valor em que se deve iniciar a multiplicacao    
    
    jal x1, segundainteracao # chama a segunda parte do algoritmo

    #addi x13, x0, 11 # coloca 11 em x13 para realizar o MOD    
    #addi x15, x0, 10 # coloca 10 em x13 para realizar a multiplicação

    lw x13, 4(sp) # coloca 11 em x13 para realizar o MOD    
    lw x15, 8(sp) # coloca 10 em x13 para realizar a multiplicação

    jal x1, verificadigitoCNPJ #chama a funcao que verifica se os digitos sao iguais aos calculados    
    lw x1, 0(x16) # carrega o valor para retorno 
    beq x0, x0, retorna # chama a funcao para sair da analise do CPF


falso:     
    addi x10, x10, 0 # coloca a resposta como falsa   
    jalr x0, 0(x1) # retorna para a funcao verifica CPF/CNPJ

retorna:   
    jalr x0, 0(x1) # realiza o retorno da funcao

verificadastro:     

    add x19, x0, x0 # guarda a soma de todos os valores do vetor na primeira parte   
    add x18, x0, x0 # guarda a soma de todos os valores do vetor na segunda parte

    # beq x0, x0, adicionadadosnapilha # chama a funcao para adicionar os dados na pilha

    addi sp, sp, -40 # aloca um espaço na pilha  

    addi x28, x0, 5 # coloca o valor 5 em x28    
    sw x28, 0(sp) # salva o valor de 5 na pilha   

    addi x28, x28, 6 # coloca o valor 11 em x28    
    sw x28, 4(sp) # salva o valor de 11 na pilha   

    addi x28, x28, -1 # coloca o valor 10 em x28   
    sw x28, 8(sp) # salva o valor de 10 na pilha
    
    addi x14, x0, 1 # o valor em que o vetor deve chegar para parar
    beq x14, x0, verificaCPF # se o valor do registrador x14 for zero, chama a função verificaCPF    
    jal x1, verificaCNPJ # se o valor do registrador x14 for diferente de zero, chama a função verificaCNPJ  
    jal x0,retorna # chama a função retorna


##### END MODIFIQUE AQUI END #####
FIM:     add x1, x0, x10
