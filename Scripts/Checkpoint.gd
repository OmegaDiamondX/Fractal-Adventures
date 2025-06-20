extends Node2D

func _ready():
	$AnimationPlayer.play("cp_spin")

func _on_cp_collider_body_entered(body):
	body.StartingPoint = position
	self.queue_free()
