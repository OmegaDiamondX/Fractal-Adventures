extends Node2D

@export var id : int = 1
@export var value: int
@export var property = GlobalVariables.PropertyChanged.ANGLE1
@onready var player = get_node("/root/SceneRoot/Player")

@onready var OwnTree = get_node("/root/SceneRoot/FractalTrees/FractalTree"+str(id))

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.cur_tree = OwnTree
		body.isTouching = true
		var playerSldr = body.get_node("/root/SceneRoot/CanvasLayer/Panel/HSlider")
		if playerSldr == null:
			print_debug("No slider on board")
		GlobalVariables.ch_property = property
		GlobalVariables.changing_id = id
		match property:
			GlobalVariables.PropertyChanged.ANGLE1:
				playerSldr.value = OwnTree.angle1
			GlobalVariables.PropertyChanged.ANGLE2:
				playerSldr.value = OwnTree.angle2
			GlobalVariables.PropertyChanged.LENGTH1:
				playerSldr.set_value_no_signal(OwnTree.length1 / 50 * 360)
			GlobalVariables.PropertyChanged.LENGTH2:
				playerSldr.set_value_no_signal(OwnTree.length2 / 50 * 360)
		body.get_node("/root/SceneRoot/CanvasLayer/Panel").visible = true
		body.get_node("Camera2D").offset = Vector2(1,1)

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		body.isTouching = false
		body.get_node("/root/SceneRoot/CanvasLayer/Panel").visible = false

func _on_h_slider_value_changed(value):
	self.value = value
	
func y_inv(point):
	return Vector2(point.x,-point.y)
