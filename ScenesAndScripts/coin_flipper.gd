extends Control

@onready var coin_1 = $VBoxContainer/HBoxContainer/Coin1
@onready var coin_2 = $VBoxContainer/HBoxContainer/Coin2
@onready var coin_3 = $VBoxContainer/HBoxContainer/Coin3

@onready var coin_flip = $Sounds/CoinFlip

@onready var flip_b = $VBoxContainer/Flip

signal draw_yao
signal show_board

@export_range(0, 1.0) var anim_vel : float

var tails := 0
var heads := 0


func flip():
	tails = 0
	heads = 0
	
	flip_b.text = "ASPETTA..."
	flip_b.disabled = true
	#COIN 1 
	flip_random_coin(coin_1)
	await get_tree().create_timer(anim_vel).timeout
	
	#COIN 2
	flip_random_coin(coin_2)
	await get_tree().create_timer(anim_vel).timeout
	
	#COIN 3
	flip_random_coin(coin_3)
	await get_tree().create_timer(anim_vel).timeout
	
	if heads > tails:
		Global.binary = 1
	else:
		Global.binary = 0
	
	
	flip_b.disabled = false
	flip_b.text = "LANCIA!"
	draw_yao.emit()
	
	if Global.yao == 6:
		flip_b.disabled = true
		await get_tree().create_timer(0.5).timeout
		show_board.emit()
		Global.text_manager.buttonIndex = 1


func flip_random_coin(coin : TextureRect):
	coin_flip.play()
	coin.modulate = Color(1, 1, 1, 0)
	if randi_range(0,1) == 0:
		result(0, coin)
	else:
		result(1, coin)
	var tween = create_tween()
	tween.tween_property(coin, "modulate", Color(1,1,1), anim_vel).set_ease(Tween.EASE_IN_OUT)

func result(n : int, coin : TextureRect):
	if n == 0:
		tails += 1
		coin.texture = load("res://Assets/Art/coinCross.svg")
	elif n == 1:
		heads += 1
		coin.texture = load("res://Assets/Art/coinHeads.svg")


func _on_flip_pressed():
	if Global.yao < 6:
		flip()


func _on_reset():
	flip_b.text = "LANCIA!"
	flip_b.disabled = false


