extends Control

@onready var tempo_label: Label = $Tempo

func _process(delta: float) -> void:
	if get_tree().paused:
		return
	if Global.tempo > 0:
		Global.tempo -= delta
		tempo_label.text = "Tempo: " + str(int(Global.tempo))
	else:
		$"Fim de jogo".visible = true
		$"Botao voltar para o menu perdeu".visible = true
		$Panel.visible = true
		$Pausar.visible = false
		$Tempo.visible = false
		$Sprite2D.visible = false
		$"Botao Lista".visible = false

func _on_botao_voltar_para_o_menu_perdeu_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenarios/tela_do_menu.tscn")
	Global.tem_chave = false
	Global.minigamePc_vencido = false
	Global.minigameLista_vencido = false
	Fader.fade_out(0.5)


func _on_botao_despausar_pressed() -> void:
	get_tree().paused = false
	$Panel.visible=false
	$VBoxContainer.visible = false
	$Pausado.visible = false
	$Pausar.visible = true
	$Tempo.visible = true
	$Sprite2D.visible = true
	$"Botao Lista".visible = true
func _on_botao_voltar_para_o_menu_pausa_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenarios/tela_do_menu.tscn")
	Global.tem_chave = false
	Global.minigamePc_vencido = false
	Global.minigameLista_vencido = false
	Fader.fade_out(0.5)

func _on_pausar_pressed() -> void:
	get_tree().paused = true
	$Panel.visible=true
	$VBoxContainer.visible = true
	$Pausado.visible = true
	$Pausar.visible = false
	$Tempo.visible = false
	$Sprite2D.visible = false
	$"Botao Lista".visible = false


func _on_botao_lista_pressed() -> void:
	if Global.minigamePc_vencido == false:
		$"Papelzao/Check 1".visible = false
	if Global.minigameLista_vencido == false:
		$"Papelzao/Check 2".visible = false
	$Panel.visible=true
	$Pausar.visible = false
	$"Botao Lista".visible = false
	$Papelzao.visible = true
	



func _on_voltar_pressed() -> void:
	$Panel.visible = false
	$Papelzao.visible = false
	$"Botao Lista".visible = true
	$Pausar.visible = true
