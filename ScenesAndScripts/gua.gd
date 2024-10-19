extends Control

@onready var show_yao_sound = $ShowYao

@export var length : int 
@export var width : int
@export var separation : int 

@onready var yao_1 = $Frame/MarginContainer/HBoxContainer/Yao1
@onready var yao_2 = $Frame/MarginContainer/HBoxContainer/Yao2
@onready var yao_3 = $Frame/MarginContainer/HBoxContainer/Yao3
@onready var yao_4 = $Frame/MarginContainer/HBoxContainer/Yao4
@onready var yao_5 = $Frame/MarginContainer/HBoxContainer/Yao5
@onready var yao_6 = $Frame/MarginContainer/HBoxContainer/Yao6

@onready var hbox = $Frame/MarginContainer/HBoxContainer

func show_yao():
	var yaos = [yao_1, yao_2, yao_3, yao_4, yao_5, yao_6]
	var yao : TextureRect = yaos[Global.yao]
	Global.yao += 1
	if Global.binary == 0:
		yao.texture = load("res://Assets/Art/separatedLine.svg")
	else:
		yao.texture = load("res://Assets/Art/straightLine.svg")
	yao.show()
	show_yao_sound.play()
	var tween = create_tween()
	tween.tween_property(yao, "modulate", Color(1, 1, 1), 0.25)


func _on_result_board_reset():
	Global.yao = 0
	Global.binary = 0
	Global.id = ""
	
	var tween = create_tween()
	tween.tween_property(hbox, "modulate", Color(1,1,1,0), 0.25).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	var yaos = [yao_1, yao_2, yao_3, yao_4, yao_5, yao_6]
	for yao in yaos:
		yao.hide()
		yao.modulate = Color(1, 1, 1, 0)
	hbox.modulate = Color(1,1,1,1)



