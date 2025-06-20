extends Node2D

@export var labelText:String
@onready var lbl = $Label
@export var addTexture: Texture2D
@onready var addSpr = $AdditionalSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	lbl.text = labelText
	addSpr.texture = addTexture

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		lbl.visible = true
		if addTexture !=null:
			addSpr.visible = true


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		lbl.visible = false
		addSpr.visible = false
