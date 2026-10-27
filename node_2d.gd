extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fader.fade_out(0.5)
	if Global.minigameLista_vencido:
		$Button2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://Cenario2.tscn")


func _on_button_2_pressed() -> void:
	await Fader.fade_in(0.5)
	get_tree().change_scene_to_file("res://minigame.tscn")
