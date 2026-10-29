extends Control

func _ready() -> void:
	Fader.fade_out(0.5)
	if Global.tem_chave == true:
		$Chave.visible =  false

func _on_porta_cenario_1_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario1.tscn")


func _on_porta_cenario_3_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenarios/Cenario3.tscn")


func _on_porta_cenario_4_pressed() -> void:
	if Global.tem_chave == true:
		await Fader.fade_in(0.5)
		get_tree().change_scene_to_file("res://Cenarios/Cenario1.tscn")
	if Global.tem_chave == false:
		$"Porta bloqueada".visible = true
		$"Porta bloqueada/Timer porta".start()


func _on_chave_pressed() -> void:
	Global.tem_chave = true
	$"Chave possuida".visible = true
	$"Chave possuida/Timer chave".start()
	$Chave.visible = false

func _on_timer_chave_timeout() -> void:
	$"Chave possuida".visible = false


func _on_timer_porta_timeout() -> void:
	$"Porta bloqueada".visible = false
