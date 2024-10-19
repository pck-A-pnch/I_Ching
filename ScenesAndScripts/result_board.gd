extends Control

@onready var animation_player = $AnimationPlayer
@onready var click = $Sounds/Click

signal reset

func _on_coin_flipper_show_board():
	animation_player.play("RESET")
	show()
	animation_player.play("show")


func _on_reset_pressed():
	click.play()
	animation_player.play_backwards("show")
	await animation_player.animation_finished
	hide()
	reset.emit()
	animation_player.play("RESET")
