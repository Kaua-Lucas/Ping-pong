extends Area2D

var velocidade_da_bola : int = 200		
var posicao_inicial : Vector2 = Vector2(640,360)
										#X   Y
var direcao_inicial: Vector2
var nova_direcao: Vector2 

var y_min : float = 11
var y_max : float = 709

var pontuacaoP1 : int = 0
var pontuacaoP2 : int = 0

@onready var placarP1 : Label = $"../CanvasLayer/Control/Label"
@onready var placarP2 : Label = $"../CanvasLayer2/Control/Label"

@onready var impactoComParedes_som : AudioStreamPlayer = $"impacto-com-paredes"
@onready var impactoComGol_som : AudioStreamPlayer = $"impacto-com-gol"
@onready var impactoComPlayer_som : AudioStreamPlayer = $"impacto-com-player"

@onready var Menu : CanvasLayer = $"../menu"

func _ready() -> void:
	reset_boll()
	
	


func _process(delta: float) -> void:
	
	movimentacao(delta)
	colidir_com_a_parede()
	Menu_pausado()
	
	


func reset_boll():
	await get_tree().create_timer(1.5).timeout
	position = posicao_inicial
	escolher_direcao_inicial()
	
func escolher_direcao_inicial() -> void:
							#Array
	#escolhe a direção
	var x_aletorio: int = [ -1 , 1 ].pick_random()
	var y_aletorio: int = [ -1 , 1 ].pick_random()
	#recebe e aplica as novas direções
	direcao_inicial = Vector2(x_aletorio, y_aletorio)
	nova_direcao = direcao_inicial
	
func movimentacao(delta: float):
 	
	position += nova_direcao * velocidade_da_bola * delta
	
	
func colidir_com_a_parede() -> void:
	
	if position.y >= y_max or position.y <= y_min :
		
		nova_direcao.y *=  -1
		
		if position.x <= 1 or position.x >= 1280 :
			
			impactoComParedes_som.stop()
			
		else:
			impactoComParedes_som.play()




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogadores"):
		
		impactoComPlayer_som.play()
		nova_direcao.x *= -1
		velocidade_da_bola += 50
		
	if body.is_in_group("colisor_de_pontos"):
		
		impactoComParedes_som.stop()
		impactoComPlayer_som.stop()
		impactoComGol_som.play()
		
		if position.x <= 640:
			pontuacaoP2 += 1
			placarP2.text = str(pontuacaoP2)
			print("pontuacaoP2: ", pontuacaoP2)
			
		elif position.x >= 640:
			pontuacaoP1 += 1
			placarP1.text = str(pontuacaoP1)
			print("pontuacaoP1: ", pontuacaoP1)
			
		await get_tree().create_timer(1.5).timeout
		reset_boll()
		reset_veloc()
		
		if pontuacaoP1 >= 5 or pontuacaoP2 >= 5:
			pontuacaoP1 = 0
			pontuacaoP2 = 0
			placarP1.text = str(pontuacaoP1)
			placarP2.text = str(pontuacaoP2)
		
func reset_veloc():
	velocidade_da_bola = 200

func Menu_pausado():
	if Input.is_action_pressed("MENU"):
		get_tree().paused = true
		Menu.visible = true


	
