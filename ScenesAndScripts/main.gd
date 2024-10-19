extends Control

@onready var version = $DownSection/Version

var music_bus = AudioServer.get_bus_index("SFX")

func _ready():
	get_window().size = DisplayServer.screen_get_size()
	Global.yao = 0
	Global.binary = 0
	version.text = "Versione " + ProjectSettings.get("application/config/version") + " - Edoardo Albanese"


func _on_exit_pressed():
	get_tree().quit()


func _on_mute_toggled(_toggled_on):
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
