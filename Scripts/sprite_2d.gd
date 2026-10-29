extends CharacterBody2D

var dragging = false
var of = Vector2(0, 0)

const initial_x = 576
const initial_y = 162

var desafios = [
	{"imagem": preload("res://Sprites/imagens garagem/banana.jpg"), "lixeira_correta": 1}, 
	{"imagem": preload("res://Sprites/imagens garagem/ventilador.png"), "lixeira_correta": 2}, 
]

var indice_atual = 0

@onready var sprite_visual: Sprite2D = $Sprite2D

func _ready() -> void:
	carregar_desafio()

func _process(delta):
	if dragging:
		position = get_global_mouse_position() - of
		
	var tamanho_tela = get_viewport_rect().size
	position.x = clamp(position.x, 0, tamanho_tela.x)
	position.y = clamp(position.y, 0, tamanho_tela.y)

func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false

# Quando solta na Área 1 (Lixeira 1)
func _on_area_1_body_entered(body: Node2D) -> void:
	dragging = false
	verificar_resposta(1)

# Quando solta na Área 2 (Lixeira 2)
func _on_area_2_body_entered(body: Node2D) -> void:
	dragging = false
	verificar_resposta(2)

func verificar_resposta(lixeira_escolhida: int):
	var desafio_atual = desafios[indice_atual]
	
	if lixeira_escolhida == desafio_atual["lixeira_correta"]:
		print("Acertou!")
		indice_atual += 1
		
		
		if indice_atual < desafios.size():
			carregar_desafio()
			voltar()
		else:
			print("Fim do jogo!")
			hide() 
	else:
		print("Errou!")
		voltar()

func carregar_desafio():
	if indice_atual < desafios.size():
		sprite_visual.texture = desafios[indice_atual]["imagem"]

func voltar():
	position.x = initial_x
	position.y = initial_y
