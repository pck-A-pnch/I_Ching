extends PanelContainer

@onready var title = $MarginContainer/VBoxContainer/Title
@onready var description = $MarginContainer/VBoxContainer/Description/Description
@onready var author = $MarginContainer/VBoxContainer/Author

@onready var buttons = $MarginContainer/VBoxContainer/Buttons
@onready var first = $MarginContainer/VBoxContainer/Buttons/First
@onready var second = $MarginContainer/VBoxContainer/Buttons/Second

@onready var click = $"../Sounds/Click"

var file_path = "res://Assets/iChing.csv"

var titles : Array = []
var descriptions : Array = []
var ids : Array = []
var authors : Array = []

var id : String
var buttonIndex : int

func _ready():
	import_csv()
	Global.text_manager = self

func import_csv():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file == null:
			print("Error opening file: " + file_path)
			return
		while !file.eof_reached():
			var data_set = Array(file.get_csv_line())
			titles.append(data_set[3])
			descriptions.append(data_set[4])
			ids.append(data_set[1])
			authors.append(data_set[0])
		file.close()
	else:
		print("File does not exist: " + file_path)
	

func _draw():
	update_text()
	if Global.id == Global.id2:
		buttons.hide()
	else:
		buttons.show()

func update_text():
	if buttonIndex == 1:
		id = Global.id
		first.disabled = true
		second.disabled = false
	else:
		id = Global.id2
		first.disabled = false
		second.disabled = true
	var index
	for i in ids.size():
		if id == ids[i]:
			index = i
	title.text = str(index) + ". " + titles[index]
	description.text = descriptions[index]
	author.text = "Scritto da: " + authors[index]


func _on_first_pressed():
	click.play()
	buttonIndex = 1
	update_text()

func _on_second_pressed():
	click.play()
	buttonIndex = 2
	update_text()
