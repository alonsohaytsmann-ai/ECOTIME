extends TextureRect
@onready var parafuso = $"parafuso"
@onready var chavinha = $"chavinha"
var tween_chave: Tween
var botao_atual: Button
var restantes: int = 0
var animando: bool = false
func _ready() -> void:
	for filho in get_children():
		position = (get_viewport_rect().size - size) / 2
		parafuso.position = size / 2.0
		if filho is Button:
			filho.focus_mode = Control.FOCUS_NONE
			filho.pressed.connect(_on_parafuso_clicado.bind(filho))
			restantes += 1

func _on_parafuso_clicado(botao: Button) -> void:
	if chavinha.visible or animando:
		return
	botao_atual = botao
	parafuso.frame = 0
	parafuso.visible = true
	chavinha.visible = true
	chavinha.set_position(Vector2 ())
	_nova_posicao_chave()

func _nova_posicao_chave() -> void:
	chavinha.size= Vector2(50, 50)
	chavinha.position = Vector2(randi_range(768, 1152), randi_range(0, 552))
	_animar_chavinha()

func _animar_chavinha() -> void:
	var tamanho_tela = get_viewport_rect().size
	var posicao_inicial = chavinha.position
	var posicao_final = Vector2(tamanho_tela.x - posicao_inicial.x, tamanho_tela.y - posicao_inicial.y)
	if tween_chave:
		tween_chave.kill()
	tween_chave = create_tween()
	tween_chave.tween_property(chavinha, "position", posicao_final, 1.0)
	tween_chave.finished.connect(_nova_posicao_chave)

func _input(event: InputEvent) -> void:
	if not chavinha.visible or animando:
		return
	var cliq = (event is InputEventScreenTouch and event.pressed)
	if event.is_action_pressed("ui_accept") or cliq:
		get_viewport().set_input_as_handled()
		_verity()
	
var acertos = 0
func _verity() -> void:
	var centro_chave = chavinha.global_position + (chavinha.size / 2.0)
	if centro_chave.distance_to(parafuso.global_position) <= 60.0:
		print ("acerto")
		if tween_chave:
			tween_chave.kill()
		chavinha.visible = false
		animando = true
		parafuso.play("girando")
		await parafuso.animation_finished
		parafuso.visible = false
		animando = false
		if botao_atual:
			botao_atual.visible = false
		restantes -= 1
		if restantes <= 0:
			print("acabo")
	else:
		print ("errado")
