extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_button_pressed():
	print("start")
	get_tree().change_scene("res://accesorios/scenes/track02/game.tscn")
	



func _on_TextureButton_pressed():
	get_tree().quit()
