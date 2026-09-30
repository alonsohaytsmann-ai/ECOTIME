extends Control

@onready var texto_mensagem = $mensagem
@onready var botao_esq = $botaoesquerdo
@onready var botao_dir = $botaodireito

var perguntas = [
	{"certo": "SSD Novo", "errado": "HD Antigo", "motivo": "SSDs gastam bem menos energia."},
	{"certo": "Monitor LED", "errado": "Monitor CRT (Tubo)", "motivo": "Monitores de tubo dissipam muita energia em calor."},
	{"certo": "Modo Suspensão", "errado": "Protetor de Tela", "motivo": "Protetor de tela mantém a placa de vídeo trabalhando."}
]

var historico = []

var pergunta_atual
var contador = 0
var certa_esta_na_esquerda = true

func _ready():
	texto_mensagem.add_theme_font_size_override("font_size", 22)
	nova_pergunta()
	historico.append(pergunta_atual)

func nova_pergunta():
	var sorteio = randi() % 3
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
	texto_mensagem.modulate = Color(1, 1, 1)

func checar_resposta(clicou_na_esquerda):
	botao_esq.disabled = true
	botao_dir.disabled = true
	
	if clicou_na_esquerda == certa_esta_na_esquerda:
		texto_mensagem.text = "Acertou. " + pergunta_atual["motivo"]
		texto_mensagem.modulate = Color(0, 1, 0)
	else:
		texto_mensagem.text = "Errou. " + pergunta_atual["motivo"]
		texto_mensagem.modulate = Color(1, 0, 0)
		
	await get_tree().create_timer(2.0).timeout
	
	if len(historico) == 3:
		texto_mensagem.text = "Fim do minigame!"
		botao_esq.visible = false
		botao_dir.visible = false
		return
	
	nova_pergunta()
	while pergunta_atual in historico:
		nova_pergunta()
	
	historico.append(pergunta_atual)
		
	botao_esq.disabled = false
	botao_dir.disabled = false

func _on_botao_esquerdo_pressed():
	checar_resposta(true)

func _on_botao_direito_pressed():
	checar_resposta(false)
