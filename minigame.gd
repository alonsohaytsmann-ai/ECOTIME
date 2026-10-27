extends Control

@onready var texto_mensagem = $mensagem
@onready var botao_esq = $botaoesquerdo
@onready var botao_dir = $botaodireito

var perguntas = [
	{"certo": "SSD Novo", "imagem": preload("res://imagens minigame do rodrigo/SSD-minigame3.png"), "errado": "HD Antigo", "imagem2": preload("res://imagens minigame do rodrigo/HD-antigo-minigame3.png"), "motivo": "SSDs gastam bem menos energia."},
	{"certo": "Monitor LED", "imagem": preload("res://imagens minigame do rodrigo/Monitor-led-minigame3.png"), "errado": "Monitor CRT (Tubo)", "imagem2": preload("res://imagens minigame do rodrigo/Monitor-tubo-minigame3.png"), "motivo": "Monitores de tubo dissipam muita energia e calor."},
	{"certo": "Modo Suspensão", "imagem": preload("res://imagens minigame do rodrigo/Modo-suspensão-minigame3.png"), "errado": "Protetor de Tela", "imagem2": preload("res://imagens minigame do rodrigo/Protetor-tela-minigame3.png"), "motivo": "Protetor de tela mantém a placa de vídeo a trabalhar."}
]

var historico = []
var pergunta_atual
var acertos = 0  
var certa_esta_na_esquerda = true

func _ready():
	Fader.fade_out(0.5)
	texto_mensagem.add_theme_font_size_override("font_size", 22)
	nova_pergunta()

func nova_pergunta():
	var sorteio = randi() % 3
	pergunta_atual = perguntas[sorteio]
	
	while pergunta_atual in historico:
		sorteio = randi() % 3
		pergunta_atual = perguntas[sorteio]
	
	var pos = randi() % 2
	if pos == 0:
		certa_esta_na_esquerda = true
		botao_esq.text = pergunta_atual["certo"]
		botao_dir.text = pergunta_atual["errado"]
	else:
		certa_esta_na_esquerda = false
		botao_esq.text = pergunta_atual["errado"]
		botao_dir.text = pergunta_atual["certo"]
		
	texto_mensagem.text = "Escolha a opção sustentável."
	texto_mensagem.modulate = Color(0, 0, 0)
	
	if pergunta_atual.has("imagem"):
		$TextureRect.texture = pergunta_atual["imagem"]
	if pergunta_atual.has("imagem2"):
		$TextureRect2.texture = pergunta_atual["imagem2"]

func checar_resposta(clicou_na_esquerda):
	botao_esq.disabled = true
	botao_dir.disabled = true
	
	if clicou_na_esquerda == certa_esta_na_esquerda:

		texto_mensagem.text = "Acertou! " + pergunta_atual["motivo"]
		texto_mensagem.modulate = Color(0, 1, 0) 
		
		historico.append(pergunta_atual)
		acertos += 1  
		
		await get_tree().create_timer(2.0).timeout
		
		if acertos >= 3:
			texto_mensagem.text = "Fim do minigame!"
			texto_mensagem.modulate = Color(0, 0, 0)
			botao_esq.visible = false
			botao_dir.visible = false
			$TextureRect.visible = false
			$TextureRect2.visible = false
			$"Sair finalizado".visible = true
			return
		
		nova_pergunta()
		botao_esq.disabled = false
		botao_dir.disabled = false
		
	else:
		texto_mensagem.text = "Errou! Tente novamente. " + pergunta_atual["motivo"]
		texto_mensagem.modulate = Color(1, 0, 0)
		
		await get_tree().create_timer(2.0).timeout
		
		texto_mensagem.text = "Escolha a opção sustentável."
		texto_mensagem.modulate = Color(0, 0, 0)
		
		botao_esq.disabled = false
		botao_dir.disabled = false

func _on_botao_esquerdo_pressed():
	checar_resposta(true)

func _on_botao_direito_pressed():
	checar_resposta(false)


func _on_sair_finalizado_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenario3.tscn")
	Global.minigameLista_vencido = true
