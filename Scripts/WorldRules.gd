extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func map(value, start1, stop1, start2, stop2):
	var range1 = stop1 - start1
	var range2 = stop2 - start2
	return start2 + (value - start1) / range1 * range2

func _on_h_slider_value_changed(value):
	var ftree = get_node("FractalTrees/FractalTree"+str(GlobalVariables.changing_id))
	match GlobalVariables.ch_property:
		GlobalVariables.PropertyChanged.ANGLE1:
			ftree.angle1 = value
		GlobalVariables.PropertyChanged.ANGLE2:
			ftree.angle2 = value
		GlobalVariables.PropertyChanged.LENGTH1:
			ftree.length1 = map(value,0,360,0,50)
		GlobalVariables.PropertyChanged.LENGTH2:
			ftree.length2 = map(value,0,360,0,50)
