.data

    listX: .word -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449, -63, -31, 1, 33, 65, 97, 129, 161, 193, 225, 257, 289, 321, 353, 385, 417, 449
    listY: .word 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 92, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 106, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134, 134
    listB: .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    
.text

Inicializa:
    
    li $v1, 0                       # Detecta se o jogo j� come�ou
    
    addi $sp, $sp, -28              # Adiciona espaco na pilha para os parametros a serem passados para as funcoes de desenho (economizando registradores)
    
    ###########Parte da barra##############
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 0($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 280                     # Adiciona a posicao inicial da barra em y
    sw $t8, 4($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 95                      # Adiciona a posicao inicial da barra em x
    sw $t8, 8($sp)                  # Adiciona a cor de t8 para a pilha

    jal Barra                       # Desenha a barra
    
    ###############Parte da bolinha#######
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 265                     # Adiciona a posicao inicial da bolinha em y
    sw $t8, 16($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 95                      # Adiciona a posicao inicial da bolinha em x
    sw $t8, 20($sp)                 # Adiciona a cor de t8 para a pilha
    
    jal Bola                        # Desenha a barra
    
    ##############Parte dos Retangulos######
    li $t8, 0x00FF0000              # Adiciona a cor dos retangulos para t8
    sw $t8, 24($sp)                 # Adiciona a cor t8 para a pilha
    jal InicializaRetangulos        # Desenha os Retangulos
    
    j end                         # Inicia o jogo

    
AcessaLX:

    la $t1, listX        # coloca o entere�o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere�o
    lw $t4, 0($t1)       # pega o valor na celula de listX
    move $s4, $t4	 # passa t4 (valor no indice do vetor) para RA
    jr $ra		 #retorna RA

AcessaLY:

    la $t1, listY        # coloca o entere�o em $t3			
    move $t2, $k1	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere�o
    lw $t4, 0($t1)       # pega o valor na celula de listY
    move $s2, $t4	 # passa t4 (valor no indice do vetor) para RA
    jr $ra		 #retorna RA
    
AcessaLB:

    la $t1, listB        # coloca o entere�o em $t3
    move $t2, $k0	 # coloca o indice em $t2
    add $t2, $t2, $t2    # dobra o indice
    add $t2, $t2, $t2    # dobra o indice de novo (4x agora)
    add $t1, $t2, $t1    # Combina os 2 componentes do endere�o
    lw $t4, 0($t1)       # pega o valor na celula de listB
    move $ra, $t4	 # passa t4 (valor no indice do vetor) para RA
    jr $ra		 #retorna RA
    
    

######Desenhando varios retangulos#####


InicializaRetangulos:

    lw   $a2, 24($sp)                # Carregando a cor que esta pilha para os retangulos
    li $k0, 0
    li $k1, 0   
    #la   $t3, listX		     # carrega lista listX em t3
    #li   $t2, 0			     # coloca posicao 0 em t2
    #add  $t1, $t2, $t3		     # combina os dois elementos para acesso
    #move $s2, $t1	             # y0 = y posicao inicial de y
    #li $k0, 0
    jal AcessaLY
    #move $s2, $ra
    
    
    #la   $t3, listY		     # carrega a lista listY em t3
    #li   $t2, 0			     # coloca a posicao 0 em t2
    #add  $t1, $t2, $t3    	     # combina os dois elementos para acesso
    #move $s3, $t1 	             # x0 = x posicao inicial de x
    jal AcessaLX
    #move $s4, $ra

    #move $s3, $s4                    # posicao inicial do x que sera deslocado

    li $t8, 450               # posicao final do retangulo em x
    li $t9, 134                # posicao final do retangulo em y

    addi $t4, $s2, 96                # define a fileira que irei mudar para a cor verde
    addi $t5, $s2, 132               # define a fileira que irei mudar para a cor azul

loop3:
    jal  AcessaLX
    jal AcessaLY
    addi $k0, $k0, 1
    addi $k1, $k1, 1
    bge  $s2, 78, MudaCorVerde  
    ble  $k1, 118, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos
    j loop9                         # Inicia o programa

    
MudaCorVerde:
    #beq $a2, 0x00000000, NaoMudaCor  # Caso seja final de jogo o valor de a2 sera preto
    
    li  $a2, 0x0000FF00              # Muda $a2 para verde
    
    bge $s2, 106, MudaCorAzul        # Muda a cor dos retangulos para azul
    
    ble  $k1, 118, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos
    j loop9                         # Inicia o programa
    
    
MudaCorAzul:

    li  $a2, 0x000000FF              # Muda $a2 para azul
    
    ble  $k1, 118, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos
    j loop9                        # Inicia o programa
    
NaoMudaCor:
   blt $k1, 7, DesenhaRetangulo    # Enquanto nao chegar no final das fileiras continue desenhando retangulos
   jr  $ra                           # Se chegou va desenhar a barra
    

######Desenhando um retangulo#####

DesenhaRetangulo:
    
    move $s1, $s2                    # y1 = y posicao inicial de y para desenhar o retangulo
    move $s0, $s4                    # x1 = x posicao inicial de x para desenhar o retangulo
 
    addi $t2, $s0, 28                # Posicao final de x
    addi $t1, $s1, 10                # Posicao final de y
    

loop:

   blt  $s0, $t2, DrawPixel          # Enquanto x1 ainda nao atingiu o limite (t0) pinte o pixel (s0,s1)
   addi $s1, $s1, 1                  # Quando x1 chegar no limite (t0) adiciona 1 em y1 (pula linha)
   
 
loop2:

   move $s0, $s4                     # Reseta x1 para o inicio
 
   blt  $s1, $t1, DrawPixel          # Enquanto y1 nao atingiu o limite (t1) pinte o pixel (s0, s1)
   j    loop3                        # Quando terminar o retangulo va desenhar o proxima retangulo

 
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
    lw $s1, 4($sp)                    # y1 = y posicao final da barra
    lw $s0, 8($sp)                    # x1 = x posicao inicial da barra
    
    move $t8, $s0
 
    addi $t2, $s0, 150                # Limite de x para pintar a barra
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
 
    addi $t2, $s0, 14                # Posicao final de x
    addi $t1, $s1, 12                # Posicao final de y
    
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
    
 contaVidas:
    li, $t2, 4                       #inicializa com 4 vidas
         
 loop10:  #loop que verifica cada itera��o quando a bola bate na barra
   bgt $t2, 0, MoverBola              #enquanto houver vida, movo a bola
   jal verificaPos                   # pego uma posicao para ver se h� retangulos
   beq $t2, 0 LimpaTela		     
#############Detecta a entrada###########
DetectaEntrada:
    
    beq $v0, ' ', DetectaInicio      # Enquanto $a3 for igual a 'espa�o' mova a bolinha
    beq $v0, 'a', MoverEsquerda      # Se for 'a' eh para mover a barra para a esquerda
    beq $v0, 'd', MoverDireita       # Se for 'd' tambem move a barra para a direita
    beq $v0, 'e', LimpaTela          # Teste para ver se o jogo eh restartado direitinho
    j   loop9                        # Se nao for nem 'a', 'd' ou 'espa�o' va para o loop
   

excluiRet:
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    jal pintaPreto		     #pinta o retangulo de preto
    
pintaPreto:
   j DesenhaRetangulo		      #desenha um retangulo preto no lugar
   
   
 verificaPos:
    addi $a0, $t4, 0                 #salva o valor armazenado em uma pos do vetor em $a0
    beq $a0, 1, excluiRet	     #se a posi��o tiver um retangulo flag =1, ent�o deleta o retangulo
    jal MoverBola
    
#coordenadas x e y de cada linha de blocos:
#1. x=-28  y = 4
#2. x= -44  y = 20
#3.  x = -58  y = 34
#4.  x = 152   y= 102
#5.  x = 89    y = 66
#6.   x = 250   y = 66
#7.   x= 290  y= 56

############Move a bolinha#####################
MoverBola:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,-5		     # soma a posi��o em y	
    addi $t7,$t7,-5		     # soma a posi��o em x
    blt $t8,4,MoverBolaDown         # Se a bola chegar em y na posicao 37 muda o movimento
    blt $t7,-28,MoverBolaDown          # Se a bola chegar em x na posicao -60 muda o movimento

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
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,-5		     # soma a posi��o em y	
    addi $t7,$t7,5		     # soma a posi��o em x
    blt $t8,37,MoverBolaDown	     # Verifica se a bolinha atingiu o chao
    bgt $t7,429,MoverUp2		     # Verifica se a bolinha atingiu o limite da tela a direita

              
             
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
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    lw   $a3, 4($sp)		     #Carregando o valor inicial da barra	
    
    addi $t8,$t8,5		     # add em y	
    addi $t7,$t7,5		     # add em x	
   
    bgt $t8,265,verifica	     # Verifica lim do teto
    bgt $t7,429,MoverDown2 	     # Verifica se a bolinha atingiu o limite da tela a direita	
	         
         
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
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    lw   $a3, 4($sp)
    
    addi $t8,$t8,5		     # add em y	
    addi $t7,$t7,-5		     # add em x	
    bgt $t8,265,verifica2	     # para
    blt $t7,-70,MoverBolaDown
     
              
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
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,-5		     # soma a posi��o em y	
    addi $t7,$t7,-5		     # soma a posi��o em x
    blt $t8,37,MoverDown2
    bgt $t7,429,MoverUp2
    blt $t7,-70,MoverBolaUp 
             
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    
    j MoverUp2 
                                                                                    
stope:
    li $t8, 0x00FFFFFF               # Adiciona a cor branca em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha  
    jal Bola
    
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    j end
    
verifica:
	lw $t2, 8($sp)
	blt $t7, $t2,MoverBolaUp
	addi $t2,$t2,150
	blt $t7, $t2,MoverBolaUp
	j stope

 verifica2:
	lw $t2, 8($sp)
	blt $t7, $t2,MoverUp2
	addi $t2,$t2,150
	blt $t7, $t2,MoverUp2
	j stope 

#############Move a barra Para a Esquerda#######
MoverEsquerda:
    
    lw   $t7, 8($sp)                 # Pega o valor de y da barra
    blt  $t7, -55, loop9             # Se chegou no limite da tela pela esquerda nao mova
    
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    subi $t7, $t7, 7                 # Adiciona 1 na posicao em y da barra
    sw   $t7, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    j loop9
        
    
#############Move a barra Para a Direita#######
MoverDireita:
    lw   $t7, 8($sp)                 # Pega o valor de y da barra
    bgt  $t7, 386, loop9             # Se chegou no limite da tela pela direita nao mova
    
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    addi $t7, $t7, 7                 # Adiciona 1 na posicao em y da barra
    sw   $t7, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    j loop9


#############Verifica se o jogo ja comecou##########
DetectaInicio:
    beq $v1, 0, SetaInicio          # Se o jogo ainda nao come�ou entao va setar $v1 para 1 e iniciar o jogo
    j loop9
    
SetaInicio:
    li $v1, 1                       # Seta a variavel de controle para joga iniciado
    j MoverBola                     # Va mover a bolinha

#############Loop do jogo##########
loop9:

    ######Le da entrada padrao um caracter######
    li $v0, 12                       # Da load no registrador $v0 com o codigo de ler_caracter
    syscall
    
    j DetectaEntrada                 # Va tratar a entrada
    
    
LimpaTela:  
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    jal Barra                        # Pinta a Barra de preto
    
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    jal Bola                         # Pinta a Bolinha de preto
    
    li $t8, 0x00000000               # Adiciona a cor dos retangulos para t8
    sw $t8, 24($sp)                  # Adiciona a cor t8 para a pilha
    jal InicializaRetangulos         # Desenha os Retangulos
    
    addi $sp, $sp, 28                # Desaloca espa�o na pilha
    
    j Inicializa                     # Restarta o jogo
    
end:

    ####Sai do programa########
    li $v0, 10
    syscall