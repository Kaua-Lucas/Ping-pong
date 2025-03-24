extends StaticBody2D

@export var jogador1 : bool
var velocidade_do_jogador : int = 500

func _ready() -> void:
	pass

#Sera executado dependendo da taxa de quadros do jogo
func _process(delta) -> void:
	
	
	movimentacao_do_jogador(delta)
	Limitador_da_tela ()


func movimentacao_do_jogador(delta : float):

#Aqui recebe a posição do player e se a tecla...
#foi pressionada para alterar a posição original.
	if jogador1:	# jogador 1
		
		if Input.is_action_pressed("mv-cima-1"):
		
			global_position.y -= velocidade_do_jogador * delta
		
			#if global_position.y <= 72:
			
				#global_position.y += velocidade_do_jogador * delta
				
	
		elif Input.is_action_pressed("mv-baixo-1"):
		
			global_position.y += velocidade_do_jogador * delta
		
			#if global_position.y >= 648:
			
				#global_position.y -= velocidade_do_jogador * delta
				
	else: #jogador 2
		
		if Input.is_action_pressed("mv-cima-2"):
			
			global_position.y -= velocidade_do_jogador * delta
		
			#if global_position.y <= 72:
			
				#global_position.y += velocidade_do_jogador * delta
				
		elif Input.is_action_pressed("mv-baixo-2"):
			
			global_position.y += velocidade_do_jogador * delta
		
			#if global_position.y >= 648:
			
				#global_position.y -= velocidade_do_jogador * delta
																
func Limitador_da_tela ():
	#global_position.y é a posição no eixo y do player 
	global_position.y = clamp(global_position.y, 65, 655) 
	#clamp("global_position.y" é oque sera limitado, "65" é o mínimo, "655" é o maximo);
	
