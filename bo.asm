.data

    listX: .word -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449
    listY: .word 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134
    listB: .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

.text

Inicializa:
    
    li $v1, 0                       # Detecta se o jogo já começou
    
    addi $sp, $sp, -40              # Adiciona espaco na pilha para os parametros a serem passados para as funcoes de desenho (economizando registradores)
    
    ###########Parte da barra##############
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 0($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 280                     # Adiciona a posicao inicial da barra em y
    sw $t8, 4($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 0                       # Adiciona a posicao inicial da barra em x
    sw $t8, 8($sp)                  # Adiciona a cor de t8 para a pilha

    jal Barra                       # Desenha a bola
    
    ###############Parte da bolinha#######
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 270                     # Adiciona a posicao inicial da bolinha em y
    sw $t8, 16($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 0                       # Adiciona a posicao inicial da bolinha em x
    sw $t8, 20($sp)                 # Adiciona a cor de t8 para a pilha
    
    jal Bola                        # Desenha a barra
    
    ##############Parte dos Retangulos######
    li $t8, 0x00FF0000              # Adiciona a cor dos retangulos para t8
    sw $t8, 24($sp)                 # Adiciona a cor t8 para a pilha
    sw $zero, 28($sp)               # Adiciona a posicao em y de um retangulo na pilha (mais facil para deletar depois)
    sw $zero, 32($sp)               # Adiciona a posicao em x de um retangulo na pilha (mais facil para deletar depois)
    jal InicializaRetangulos        # Desenha os Retangulos
    
    li $t8, 4                       # Comeca com 4 vidas
    sw $t8, 36($sp)                 # Guarda a quantidade de vidas
    
    j loop9                         # Inicia o jogo
    
    
################Funcoes de acessar os vetores###################
################Vetor de posicoes em x#########################
AcessaLX:

    la $t1, listX        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    lw $t4, 0($t1)       # pega o valor na celula de listX
    jr $ra		 #retorna RA


################Vetor de posicoes em y#########################
AcessaLY:

    la $t1, listY        # coloca o entere?o em $t3			
    move $t2, $k1	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    lw $t4, 0($t1)       # pega o valor na celula de listY
    jr $ra		 #retorna RA

  
################Vetor de falgs#################################  
AcessaLB:

    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    lw $t4, 0($t1)       # pega o valor na celula de listB
    jr $ra		 #retorna RA



######Desenhando varios retangulos#####
InicializaRetangulos:

    lw $a2, 24($sp)                # Carregando a cor que esta pilha para os retangulos
    li $k0, 0
    li $k1, 0
    move $s3, $ra

loop3:
    jal  AcessaLX
    move $s4, $t4
    jal  AcessaLY
    move $s2, $t4
    addi $k0, $k0, 1
    addi $k1, $k1, 1
    bge  $s2, 78, MudaCorVerde  
    ble  $k1, 118, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos            
    jr $s3

    
MudaCorVerde:    
    li  $a2, 0x0000FF00              # Muda $a2 para verde
    
    bge $s2, 106, MudaCorAzul        # Muda a cor dos retangulos para azul
    
    ble  $k1, 118, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos
    jr $s3                           # Inicia o programa
    
    
MudaCorAzul:

    li  $a2, 0x000000FF              # Muda $a2 para azul
    
    ble  $k1, 118, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos
    jr $s3                           # Inicia o programa
    

######Desenhando um retangulo#####
DesenhaRetangulo:
    move $s1, $s2                    # y1 = y posicao inicial de y para desenhar o retangulo
    move $s0, $s4                    # x1 = x posicao inicial de x para desenhar o retangulo
 
    addi $t2, $s0, 28                # Posicao final de x
    addi $t1, $s1, 10                # Posicao final de y
    
    j loop
    

loop:

   blt  $s0, $t2, DrawPixel          # Enquanto x1 ainda nao atingiu o limite (t0) pinte o pixel (s0,s1)
   addi $s1, $s1, 1                  # Quando x1 chegar no limite (t0) adiciona 1 em y1 (pula linha)
   
 
loop2:

   move $s0, $s4                     # Reseta x1 para o inicio
 
   blt  $s1, $t1, DrawPixel          # Enquanto y1 nao atingiu o limite (t1) pinte o pixel (s0, s1)
   j loop3                           # Quando terminar o retangulo va desenhar o proxima retangulo

 
DrawPixel:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor de (a2) em t0

    j     loop                       # Volta para o loop de desenho


######Desenhando a barra#########
Barra:

    lw $a2, 0($sp)                    # Carregando a cor branca para o registrador a2
    lw $s1, 4($sp)                    # y1 = y posicao inicial da barra
    lw $s0, 8($sp)                    # x1 = x posicao inicial da barra
    
    move $t8, $s0
 
    addi $t2, $s0, 150               # Limite de x para pintar a barra
    addi $t1, $s1, 5                 # limite de y para pintar a barra
    
    j  loop5                         # Comece a desenhar
    
 
loop5:

   blt $s0, $t2, DrawPixel3          # Enquanto o inicio nao atingiu o limite (100) pinta os pixels em (s0, s1)
   addi $s1, $s1, 1                  # Pula para a proxima linha
   
   
loop6:

    
    move $s0, $t8                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel3         # Enquanto nao chegou no limite em y continue desenhando
    jr  $ra                          # Se chegou termine o programa
 
 
DrawPixel3:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j     loop5                      # Volta para o loop de desenho
    
    
#####Desenhando a bolinha######
Bola:

    lw $a2, 12($sp)                  # Carregando a cor branca para o registrador a2
    lw $s1, 16($sp)                  # y1 = y posicao inicial de y para desenhar a "bolinha"
    lw $s0, 20($sp)                  # x1 = x posicao inicial de x para desenhar a "bolinha"
    
    move $t8, $s0
 
    addi $t2, $s0, 12                # Posicao final de x
    addi $t1, $s1, 8                 # Posicao final de y
    
    j    loop7                       # Comece a desenhar
    
 
loop7:

   blt $s0, $t2, DrawPixel4          # Enquanto $s0 nao atingiu o limite (em x) pinta os pixels em (s0, s3)
   j   loop8                         # Finaliza o programa
   
   
loop8:

    addi $s1, $s1, 1                 # Pula para a proxima linha
    move $s0, $t8                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel4         # Enquanto $s1 nao chegou no limite em y continue desenhando
    jr  $ra                          # Se chegou va para o loop do jogo
 
 
DrawPixel4:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop7                          # Volta para o loop de desenho
   
           
#############Detecta a entrada###########
DetectaEntrada:
    lw $a3, 4($t0)                   # Guarda o valor digitado
    move $a1, $ra                    # Guarda o endereço de quem chamou
    beq $a3, 'a', MoverEsquerda      # Se for 'a' eh para mover a barra para a esquerda
    beq $a3, 'd', MoverDireita       # Se for 'd' tambem move a barra para a direita
    beq $a3, 'e', LimpaTela          # Teste para ver se o jogo eh restartado direitinho
    jr $a1                           # Se nao for nem 'a', 'd' ou 'e' volta pra quem chamou
 
     
#################Pinta o retangulo de preto######################
pintaPreto:
    lw $s1, 28($sp)                  # y1 = y posicao inicial de y para desenhar o retangulo
    lw $s0, 32($sp)                  # x1 = x posicao inicial de x para desenhar o retangulo
    li $a2, 0x00000000
    
    move $t8, $s0
 
    addi $t2, $s0, 28                # Posicao final de x
    addi $t1, $s1, 10                # Posicao final de y
    
    j loop11
    

loop11:

   blt  $s0, $t2, DrawPixel5          # Enquanto x1 ainda nao atingiu o limite (t0) pinte o pixel (s0,s1)
   addi $s1, $s1, 1                  # Quando x1 chegar no limite (t0) adiciona 1 em y1 (pula linha)
   
 
loop12:

   move $s0, $t8                     # Reseta x1 para o inicio
 
   blt  $s1, $t1, DrawPixel5          # Enquanto y1 nao atingiu o limite (t1) pinte o pixel (s0, s1)
   jr $ra                            # Quando terminar o retangulo volta pra quem chamou

 
DrawPixel5:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor de (a2) em t0

    j     loop11                     # Volta para o loop de desenho

#################Funcoes de colisao para as subidas########################
#################Funcoes para o movimento de subi 1 da bola################
ColisaoY7:
    li $s5, 50
    
    j Colisao

 
ColisaoY6:
    li $s5, 64
    
    ble $t8, 60, ColisaoY7          # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao


ColisaoY5:
    li $s5, 78
    
    ble $t8, 74, ColisaoY6          # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao


ColisaoY4:
    li $s5, 92
    
    ble $t8, 88, ColisaoY5          # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao


ColisaoY3:
    li $s5, 106
    
    ble $t8, 102, ColisaoY4          # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao


ColisaoY2:
    li $s5, 120
    
    ble $t8, 116, ColisaoY3          # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao


ColisaoY1:
    li $s5, 134
    
    ble $t8, 130, ColisaoY2          # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao
    
    
#################Caso nao haja colisao continua o movimento################
ContinuarMov:
    sw   $s6, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $v1, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverBolaUp
   

VerificaPassagem:
    bnez $t5, MoverDown2
    
    j ContinuarMov


#######################Verifica se o final da bola vai bater em um bloco####    
VerificaFinal:
    move $v1, $t7
    
    addi $s7, $s7, 12
    
    jal FindPosY
    jal FindPosX
    jal AcessaLB
    
    beq $t9, $v0, VerificaPassagem
    beqz $t4, ContinuarMov
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j MoverDown2


##############Verifica se ha colisao#####################################
Colisao:
    move $s6, $t8
    move $s7, $t7
    move $v1, $t7
    li $t5, 0
    
    blt  $s6, $s5, ContinuarMov
    
    jal FindPosY
    jal FindPosX
    move $v0, $t9
    jal AcessaLB
    
    beqz $t4, VerificaFinal
    
    li $t5, 1
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j VerificaFinal


#################Funcoes para o movimento de subi 2 da bola################
ColisaoY72:
    li $s5, 50
    
    j Colisao2


ColisaoY62:
    li $s5, 64
    
    ble $t8, 60, ColisaoY72         # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao2


ColisaoY52:
    li $s5, 78
    
    ble $t8, 74, ColisaoY62         # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao2


ColisaoY42:
    li $s5, 92
    
    ble $t8, 88, ColisaoY52         # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao2


ColisaoY32:
    li $s5, 106
    
    ble $t8, 102, ColisaoY42         # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao2


ColisaoY22:
    li $s5, 120
    
    ble $t8, 116, ColisaoY32         # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao2


ColisaoY12:
    li $s5, 134
    
    ble $t8, 130, ColisaoY22         # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j Colisao2


ColisaoUp2:
    jal Colisao2
    
    j MoverBolaDown

VerificaFinal3:
    move $v1, $t8
    
    addi $t8, $t8, 10     #adiciona a posicao da bola
    
    jal FindPosY
    jal FindPosX
    jal AcessaLB
    
    beq $t9, $v0, VerificaPassagem
    beqz $t4, ContinuarMov
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j MoverDown2
#############verifica colisao em x###############################
Colisao3:
    move $s6, $t8
    move $s7, $t7
    addi $t7, $t7, 12        #faz para armazenar a posicao inicial da bola
    move $v1, $t7
    subi $t7, $t7, 12        #retorna ao valor inial de t7
    
    li $t5, 0
    
    blt  $s6, $s5, ContinuarMov
    
    jal FindPosY
    jal FindPosX
    move $v0, $t9
    jal AcessaLB
    
    beqz $t4, VerificaFinal3
    
    li $t5, 1
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j VerificaFinal3


ColisaoX17:
   li $s5, 449
   
   ble $t7, 417, ColisaoX16     #se chegou no próximo retangulo
   
   j Colisao3
   
 ColisaoX16:
   li $s5, 417
   
   ble $t7, 385, ColisaoX15     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX15:
   li $s5, 385
   
   ble $t7, 353, ColisaoX14     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX14:
   li $s5, 353
   
   ble $t7, 321, ColisaoX13     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX13:
   li $s5, 321
   
   ble $t7, 289, ColisaoX12     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX12:
   li $s5, 289
   
   ble $t7, 257, ColisaoX11     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX11:
   li $s5, 257
   
   ble $t7, 225, ColisaoX10     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX10:
   li $s5, 225
   
   ble $t7, 193, ColisaoX9     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX9:
   li $s5, 193
   
   ble $t7, 161, ColisaoX8     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX8:
   li $s5, 161
   
   ble $t7, 129, ColisaoX16     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX7:
   li $s5, 129
   
   ble $t7, 97, ColisaoX6     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX6:
   li $s5, 97
   
   ble $t7, 65, ColisaoX5     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX5:
   li $s5, 65
   
   ble $t7, 33, ColisaoX4     #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX4:
   li $s5, 33
   
   ble $t7, 1 , ColisaoX3    #se chegou no próximo retangulo
   
   j Colisao3
   
ColisaoX3:
   li $s5, 1
   
   ble $t7, -31, ColisaoX2     #se chegou no próximo retangulo
   
   j Colisao3
   
 ColisaoX2:
   li $s5, -31
   
   ble $t7, -63, ColisaoX1    #se chegou no próximo retangulo
   
   j Colisao3
   
   ColisaoX1:
   
   j Colisao3
   
#################Caso nao haja colisao continua o movimento################
ContinuarMov2:
    sw   $s6, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $v1, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverUp2


VerificaPassagem2:
    bnez $t5, MoverDown2
    
    j ContinuarMov2   
    
    
#######################Verifica se o final da bola vai bater em um bloco###### 
VerificaFinal2:
    move $v1, $t7
    
    addi $s7, $s7, 12
    
    jal FindPosY
    jal FindPosX
    jal AcessaLB
    
    beq $t9, $v0, VerificaPassagem2
    beqz $t4, ContinuarMov2
    
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j MoverDown2
         

##############Verifica se ha colisao#####################################    
Colisao2:
    move $v0, $ra
    move $s6, $t8
    move $s7, $t7
    move $v1, $t7
    li $t5, 0
    
    blt  $s6, $s5, ContinuarMov2
    
    jal FindPosY
    jal FindPosX
    move $v0, $t9
    jal AcessaLB
    
    beqz $t4, VerificaFinal2 
    
    li $t5, 1
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    j VerificaFinal2


#########################Procura a posicao y do retangulo no vetor#########################
FindPosY:
    move $s3, $ra                    # Guarda o endereco de quem chamou
    li $k1, -1                       # Contador de pos do vetor em y
    li $s0, 0                        # Posicao incial q tem $t8 em y
    
loop14:
    addi $k1, $k1, 1                 # Move a posicao do vetor
    jal AcessaLY                     # Acessa a posicao $k1 no vetor de y
    bne $t4, $s5, loop14             # Enquanto nao achou o comeco em y continua procurando
    move $s0, $k1                    # Se achou move o valor da posicao para $s0
    sw $s5, 28($sp)                  # Salva na pilha o y q talvez deva ser pintado de preto
    jr $s3                           # Retorna pra quem chamou

################implementa a parte da colisão direita, com o y#####################################    
 loop15:
    subi $k1, $k1, 1                 #decrementa em y, para ver qual é o último valor 
    jal AcessaLY                     #acessa o valor no range de y 
    blt $t4, $s5, loop15             #enquanto o valor de s5 for menor que t4,  vou para o loop
    move $s0, $k1                    
    sw $s5, 28($sp)                   #empilho o valor de x
    jr $s3                           #retorno quem chamou
    

#########################Procura a posicao x do retangulo no vetor######################### 
FindPosX:
    move $s3, $ra                    # Guarda o endereco de quem chamou
    move $k0, $s0                    # Inicia a procura no primeiro y = $t8
    subi $k0, $k0, 1
    
    
loop13:
    addi $k0, $k0, 1
    jal AcessaLX
    bgt $s7, $t4, loop13             # Enquanto nao achar o x que a bola bate continua a procurar
    subi $k0, $k0, 1
    jal AcessaLX                   # Move para s1 o valor do x igual ou maior q o da bola
    sw $t4, 32($sp)                  # Salva na pilha o x q talvez deva ser pintado de preto
    move $t9, $t4
    jr $s3                           # Volta pra quem chamou

################# loop que implementa a parte da colisão direita (em x )########################################
loop16:
    subi $k0, $k0, 1                #vou decrementando o meu valor de x, para ir verificando da parede esq para a dir
    jal AcessaLX		    #acesso os valores no range de x 
    bne $s7, $t4, loop16             # Enquanto nao achar o x que a bola bate continua a procurar
    subi $k0, $k0, 1
    jal AcessaLX                   # Move para s1 o valor do x igual ou maior q o da bola
    sw $t4, 32($sp)                  # salva na pilha o valor que devo pintar de preto
    move $t9, $t4
    jr $s3                           #retorno a funçãio
    

#################Funcoes de colisao para as descidas########################   

#################Funcoes para o movimento de desci 1 da bola################
ColisaoDescidaY7:
    li $s5, 50
    
    bge $t8, 64, ColisaoDescidaY6    # Se chegou na sexta fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida


ColisaoDescidaY6:
    li $s5, 64
    
    bge $t8, 78, ColisaoDescidaY5   # Se chegou na quinta fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida


ColisaoDescidaY5:
    li $s5, 78
    
    bge $t8, 92, ColisaoDescidaY4    # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida


ColisaoDescidaY4:
    li $s5, 92
    
    bge $t8, 106, ColisaoDescidaY3   # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida


ColisaoDescidaY3:
    li $s5, 106
    
    bge $t8, 120, ColisaoDescidaY2    # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida


ColisaoDescidaY2:
    li $s5, 120
    
    bge $t8, 134, ColisaoDescidaY1    # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida


ColisaoDescidaY1:
    li $s5, 134
    
    bgt $t8, $s1, ContinuarMovDescida
    
    j ColisaoDescida
    
    
VerificaPassagemDescida:
    bnez $t5, MoverBolaUp
    
    j ContinuarMovDescida 
    
    
#################Caso nao haja colisao continua o movimento################
ContinuarMovDescida:
    sw   $s6, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $v1, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverBolaDown
   

#######################Verifica se o final da bola vai bater em um bloco####    
VerificaFinalDescida:
    move $v1, $t7
    move $t9, $k0
    
    addi $s7, $s7, 12
    
    jal FindPosY
    jal FindPosX
    jal AcessaLB
    
    beq $t9, $v0, VerificaPassagemDescida
    
    beqz $t4, ContinuarMovDescida
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j MoverBolaUp


##############Verifica se ha colisao#####################################
ColisaoDescida:
    move $s6, $t8
    move $s7, $t7
    move $v1, $t7
    li $t5, 0
    
    blt  $s6, $s5, ContinuarMovDescida
    
    jal FindPosY
    jal FindPosX
    move $v0, $t9
    jal AcessaLB
    
    beqz $t4, VerificaFinalDescida
    li $t5, 1
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j VerificaFinalDescida


#################Funcoes para o movimento de descida 2 da bola################
ColisaoDescidaY72:
    li $s5, 50
    
    bge $t8, 64, ColisaoDescidaY62    # Se chegou na sexta fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida2


ColisaoDescidaY62:
    li $s5, 64
    
    bge $t8, 78, ColisaoDescidaY52   # Se chegou na quinta fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida2


ColisaoDescidaY52:
    li $s5, 78
    
    bge $t8, 92, ColisaoDescidaY42    # Se chegou na quarta fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida2


ColisaoDescidaY42:
    li $s5, 92
    
    bge $t8, 106, ColisaoDescidaY32   # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida2


ColisaoDescidaY32:
    li $s5, 106
    
    bge $t8, 120, ColisaoDescidaY22    # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida2


ColisaoDescidaY22:
    li $s5, 120
    
    bge $t8, 134, ColisaoDescidaY12   # Se chegou nasegunda fileira em y dos retangulos veja se vai colidir
    
    j ColisaoDescida2


ColisaoDescidaY12:
    li $s5, 134
    move $s6, $t8
    move $s7, $t7
    move $v1, $t7
    
    addi $s1, $s5, 10
    
    bgt $t8, $s1, ContinuarMovDescida2
    
    j ColisaoDescida2
    
    
VerificaPassagemDescida2:
    bnez $t5, MoverUp2
    
    j ContinuarMovDescida2 
    
    
#################Caso nao haja colisao continua o movimento################
ContinuarMovDescida2:
    sw   $s6, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $v1, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverDown2
   

#######################Verifica se o final da bola vai bater em um bloco####    
VerificaFinalDescida2:
    move $v1, $t7
    
    addi $s7, $s7, 12
    
    jal FindPosY
    jal FindPosX
    jal AcessaLB
    
    beq $t9, $v0, VerificaPassagemDescida
    
    beqz $t4, ContinuarMovDescida2
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j MoverUp2


##############Verifica se ha colisao#####################################
ColisaoDescida2:
    move $s6, $t8
    move $s7, $t7
    move $v1, $t7
    li $t5, 0
    
    bgt  $s6, $s5, ContinuarMovDescida2
    
    jal FindPosY
    jal FindPosX
    move $v0, $t9
    jal AcessaLB
    
    beqz $t4, VerificaFinalDescida2
    li $t5, 1
    
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    addi $t8, $s5, 10
    sw $t8, 16($sp)
    sw $v1, 20($sp)
    jal Bola
    
    jal pintaPreto
    
    la $t1, listB        # coloca o entere?o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere?o
    li $t4, 0
    sw $t4, 0($t1)       # pega o valor na celula de listB
    
    j VerificaFinalDescida2
    
          
############Move a bolinha#####################
MoverBola:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    bnez $t1, DetectaEntrada         # Se tiver algo na entrada padrão vá verificar se deve mover a barra
    # Depois continua a desenhar a bolinha
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,-5		     # soma a posição em y	
    addi $t7,$t7,-5		     # soma a posição em x
    blt $t8,37,MoverBolaDown         # Se a bola chegar em y na posicao 37 muda o movimento
    blt $t7,-60,MoverBolaUp          # Se a bola chegar em x na posicao -60 muda o movimento
          
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverBola

############Move a bolinha Up #####################
MoverBolaUp:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    bnez $t1, DetectaEntrada         # Se tiver algo na entrada padrão vá verificar se deve mover a barra
    # Depois continua a desenhar a bolinha
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,-5		     # soma a posição em y	
    addi $t7,$t7,5		     # soma a posição em x
    blt $t8,37,MoverBolaDown	     # Verifica se a bolinha atingiu o chao
    bgt $t7,429,MoverUp2             # Verifica se a bolinha atingiu o limite da tela a direita
    ble $t8, 144, ColisaoY1          # Se chegou na primeira y dos retangulos veja se vai colidir
             
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverBolaUp
   
            
########Movimento de Descida###########
MoverBolaDown:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    bnez $t1, DetectaEntrada         # Se tiver algo na entrada padrão vá verificar se deve mover a barra
    # Depois continua a desenhar a bolinha
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,5		     # add em y	
    addi $t7,$t7,5		     # add em x	
   
    bge  $t8,265,verifica	     # Verifica lim do teto
    bgt $t7,429,MoverDown2 	     # Verifica se a bolinha atingiu o limite da tela a direita
    bge $t8, 50, ColisaoDescidaY7
	         
         
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverBolaDown

MoverDown2:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    bnez $t1, DetectaEntrada         # Se tiver algo na entrada padrão vá verificar se deve mover a barra
    # Depois continua a desenhar a bolinha
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    #lw   $a3, 4($sp)
    
    addi $t8,$t8,5		     # add em y	
    addi $t7,$t7,-5		     # add em x	
    bge  $t8,265,verifica2	     # para
    blt $t7,-70,MoverBolaDown
    bge $t8, 50, ColisaoDescidaY72
     
              
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverDown2    
    

MoverUp2:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    bnez $t1, DetectaEntrada         # Se tiver algo na entrada padrão vá verificar se deve mover a barra
    # Depois continua a desenhar a bolinha
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,-5		     # soma a posição em y	
    addi $t7,$t7,-5		     # soma a posição em x
    blt $t8,37,MoverDown2
    bgt $t7,429,MoverUp2
    blt $t7,-70,MoverBolaUp
    ble $t8, 144, ColisaoY12         # Se chegou na primeira y dos retangulos veja se vai colidir
             
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j MoverUp2 
                  
           
#######################Para de mover a bolinha########################################                                                                                        
stope:    
    lw $t2, 36($sp)                 # Pega aquantidade de vidas
    subi $t2, $t2, 1                # Subtrai em 1 a quantidade de vidas
    sw $t2, 36($sp)                 # Coloca a nova quantidade de vidas
    bnez $t2, Redesenha             # Se ainda nao acabaram as vidas continua o jogo
    li $t2, 0x00FFFFFF               # Adiciona a cor branca em t8
    sw $t2, 12($sp)                  # Adiciona t8 para a pilha  
    jal Bola
    j end                           # Se ja acabou temrina o programa                   

####################VErifica se a bolinha esta dentro do range em x da barra########
VerificaRange:
    addi $t2,$t2,150
    blt $t7, $t2,MoverBolaUp
    
    li $t8, 265
    sw  $t8, 16($sp)
    j stope
    
###############Verifica se vai bater na barra################################
verifica:
	lw $t2, 8($sp)
	bgt $t7, $t2,VerificaRange
	
	li $t8, 265
	sw  $t8, 16($sp)
	j stope


VerificaRange2:
    addi $t2,$t2,150
    blt $t7, $t2,MoverUp2
    
    li $t8, 265
    sw  $t8, 16($sp)
    j stope 

 verifica2:
	lw $t2, 8($sp)
	bgt $t7, $t2,MoverUp2
	
	li $t8, 265
	sw  $t8, 16($sp)
	j stope 
    

AlcancouLimite:
    jr $a1


#############Move a barra Para a Esquerda#######
MoverEsquerda:
    
    lw   $t5, 8($sp)                 # Pega o valor de y da barra
    blt  $t5, -55, AlcancouLimite    # Se chegou no limite da tela pela esquerda nao mova
    
    li $t6, 0x00000000               # Adiciona a cor preta em t8
    sw $t6, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    subi $t5, $t5, 11                # Adiciona 1 na posicao em y da barra
    sw   $t5, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t6, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t6, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    jr $a1
        
    
#############Move a barra Para a Direita#######
MoverDireita:
    lw   $t5, 8($sp)                 # Pega o valor de y da barra
    bgt  $t5, 282, AlcancouLimite    # Se chegou no limite da tela pela direita nao mova
    
    li $t6, 0x00000000               # Adiciona a cor preta em t8
    sw $t6, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    addi $t5, $t5, 11                 # Adiciona 1 na posicao em y da barra
    sw   $t5, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t6, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t6, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    jr $a1

#############Detecta Entrada##########
VerificaEntrada:

    ######Le da entrada padrao um caracter######
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    bnez $t1, DetectaEntrada         # Se tiver algo na entrada padrão vá verificar se deve mover a barra
    jr $ra                           # Volta pra quem chamou
    
DetectaInicio:
    lw $a3, 4($t0)                   # Guarda o valor digitado
    beq $a3, ' ', MoverBola          # Se o valor digitado for " " então comeca o jogo
    sw $zero, 4($t0)
    j loop9
    
    
#############Loop do Inicio do jogo#############  
loop9:
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    beqz $t1, loop9
    j DetectaInicio
    

Redesenha:
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    jal Barra                        # Pinta a Barra de preto
    
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    jal Bola                         # Pinta a Bolinha de preto
    
    ###########Parte da barra##############
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 0($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 280                     # Adiciona a posicao inicial da barra em y
    sw $t8, 4($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 0                       # Adiciona a posicao inicial da barra em x
    sw $t8, 8($sp)                  # Adiciona a cor de t8 para a pilha

    jal Barra                       # Desenha a bola
    
    ###############Parte da bolinha#######
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 265                     # Adiciona a posicao inicial da bolinha em y
    sw $t8, 16($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 0                       # Adiciona a posicao inicial da bolinha em x
    sw $t8, 20($sp)                 # Adiciona a cor de t8 para a pilha
    
    jal Bola                        # Desenha a barra
    
    j loop9                         # Comeca o jogo

    
LimpaTela:  
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    jal Barra                        # Pinta a Barra de preto
    
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    jal Bola                         # Pinta a Bolinha de preto
    
    addi $sp, $sp, 32                # Desaloca espaço na pilha
    
    j Inicializa                     # Restarta o jogo
    
end:

    ####Sai do programa########
    li $v0, 10
    syscall
