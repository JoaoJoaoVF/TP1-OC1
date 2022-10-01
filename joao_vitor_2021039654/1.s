
.data
vetor: .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

.text
main:
    la x12, vetor # carrega o vetor para o registrador x12
    addi x13, x0, 20 # aloca a quantidade de elementos que o vetor 
    addi x13, x13, -1 # remove o valor de 1 casa do size do vetor
    slli x13, x13, 2 # realiza a multiplicação do size-1 por 2^4 resultando na quantidade de espaco de 4 bits necessario para guardar o vetor
    add x13, x13, x12 # adiciona o vetor na pilha 
    jal x1, inverte # chama a funcao para inveter o vetor e guarda o local
    beq x0, x0, FIM
    
##### START MODIFIQUE AQUI START #####
inverte: 

    lw x5, 0(x13) # carrega o primeiro elemento do vetor
    lw x6, 0(x12) # carrega o ultimo elemento do vetor
    beq x6, x5, FIM # se os valores de x6 e x5 forem iguais acaba
    blt x13, x12 FIM # se o valore de x13 for < que x12 forem iguais acaba
    sw x5, 0(x12) # coloca o primeiro elemento da pilha na ultima posicao
    sw x6, 0(x13) # coloca o ultimo elemento da pilha na primeira posicao
    addi x12, x12, 4 # avanca 1 posicao na pilha 
    addi x13, x13, -4 # retorna 1 posicao na pilha 

    beq x0,x0, inverte

    
##### END MODIFIQUE AQUI END #####
FIM: 
    add x1, x0, x10