.text
Inicializa:
    
    li $v1, 0                       # Detecta se o jogo já começou
    
    addi $sp, $sp, -28              # Adiciona espaco na pilha para os parametros a serem passados para as funcoes de desenho (economizando registradores)
    
    ###########Parte da barra##############
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 0($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 280                     # Adiciona a posicao inicial da barra em y
    sw $t8, 4($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 95                      # Adiciona a posicao inicial da barra em x
    sw $t8, 8($sp)                  # Adiciona a cor de t8 para a pilha

    jal Barra                       # Desenha a bola
    
    ###############Parte da bolinha#######
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 265                     # Adiciona a posicao inicial da bolinha em y
    sw $t8, 16($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 95                      # Adiciona a posicao inicial da bolinha em x
    sw $t8, 20($sp)                 # Adiciona a cor de t8 para a pilha
    
    #jal Bola                        # Desenha a barra
    
    ##############Parte dos Retangulos######
    li $t8, 0x00FF0000              # Adiciona a cor dos retangulos para t8
    sw $t8, 24($sp)                 # Adiciona a cor t8 para a pilha
    #jal InicializaRetangulos        # Desenha os Retangulos
    lui $t0, 0xFFFF
    lw $a1, 4($t0)
    j wait


######Desenhando a barra#########
Barra:

    lw $a2, 0($sp)                    # Carregando a cor branca para o registrador a2
    lw $s1, 4($sp)                    # y1 = y posicao final da barra
    lw $s0, 8($sp)                    # x1 = x posicao inicial da barra
    
    move $t8, $s0
 
    addi $t2, $s0, 50               # Limite de x para pintar a barra
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
    sw    $a2, 0($t0)                 # Coloca a cor branca ($a2) em $t0
    
    j     loop5                      # Volta para o loop de desenho


wait:
    li $t0, 0xffff0000
    lw $t1, ($t0)
    andi $t1, $t1, 0x0001
    beqz $t1, wait
    j Imprime
    
    
Imprime:
    lw $a0, 4($t0)
    beq $a0, 'a', MoverEsquerda      # Se for 'a' eh para mover a barra para a esquerda
    beq $a0, 'd', MoverDireita       # Se for 'd' tambem move a barra para a direita
    j wait
    
#############Move a barra Para a Esquerda#######
MoverEsquerda:
    
    lw   $t5, 8($sp)                 # Pega o valor de y da barra
    blt  $t5, -55, wait              # Se chegou no limite da tela pela esquerda nao mova
    
    li $t6, 0x00000000               # Adiciona a cor preta em t8
    sw $t6, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    subi $t5, $t5, 7                 # Adiciona 1 na posicao em y da barra
    sw   $t5, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t6, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t6, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    #li $a1, 0x00000062
    #sw $a1, 4($t0)
    lui $a1, 0x0000
    sw $a1, 4($t0)
    add $t5, $t5, 5
    jr $ra
        
    
#############Move a barra Para a Direita#######
MoverDireita:
    lw   $t5, 8($sp)                 # Pega o valor de y da barra
    bgt  $t5, 386, wait              # Se chegou no limite da tela pela direita nao mova
    
    li $t6, 0x00000000               # Adiciona a cor preta em t8
    sw $t6, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    addi $t5, $t5, 7                 # Adiciona 1 na posicao em y da barra
    sw   $t5, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t6, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t6, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    lui $a1, 0xFFFF
    sw $a1, 4($t0)
    j wait

