extends PanelContainer

@onready var title = $MarginContainer/VBoxContainer/Title
@onready var description = $MarginContainer/VBoxContainer/Description/Description
@onready var author = $MarginContainer/VBoxContainer/Author

var file_path = "res://Assets/iChing.csv"

var titles : Array = []
var descriptions : Array = []
var ids : Array = []
var authors : Array = []

var buttonIndexToId : Dictionary = {
1: Global.id,
2: Global.id2
}

func _ready():
	import_csv()

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
	var index
	for i in ids.size():
		if Global.id == ids[i]:
			index = i
	title.text = str(index) + ". " + titles[index]
	description.text = descriptions[index]
	author.text = "Scritto da: " + authors[index]
