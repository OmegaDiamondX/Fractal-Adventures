extends Node2D

@export var length1 = 25
@export var length2 = 25
@export_range(0,360,1) var angle1 : int = 225
@export_range(0,360,1) var angle2 : int = 315
var start_point = Vector2(position.x,position.y)
@onready var stbody = $StaticBody2D
var collArray = []

@export var bleep: AudioStream
@onready var bSfx = $Bleep

func _ready():
	print_debug("don't forget to signal the tree")
	bSfx.stream = bleep

func _draw():
	draw_tree(start_point,length1,length2,angle1,angle2)

func draw_tree(start, l1, l2,a1, a2):
	if l1 > 2 or l2 > 2:
		var end1 = start + Vector2(l1 * cos(deg_to_rad(a1)), l1 * sin(deg_to_rad(a1)))
		var end2 = start + Vector2(l2 * cos(deg_to_rad(a2)), l2 * sin(deg_to_rad(a2)))
		
		draw_line(start, end1, Color(1, 0, 0))
		draw_line(start, end2, Color(1, 0, 0))
		
		var collider1 = CollisionShape2D.new()
		var collider2 = CollisionShape2D.new()
		
		var shape1 = SegmentShape2D.new()
		shape1.a = start
		shape1.b = end1
		collider1.shape = shape1
		
		var shape2 = SegmentShape2D.new()
		shape2.a = start
		shape2.b = end2
		collider2.shape = shape2
		
		stbody.add_child(collider1)
		stbody.add_child(collider2)
		
		var diff = abs(a1-a2)/2
		
		draw_tree(end1, l1 * 0.7, l2 * 0.7,a1 - diff, a1 + diff)
		draw_tree(end2, l1 * 0.7, l2 * 0.7,a2 - diff, a2 + diff)

func _on_h_slider_value_changed(_value): 
	bSfx.play()
	for n in stbody.get_children():
		stbody.remove_child(n)
		n.queue_free()
	queue_redraw()
