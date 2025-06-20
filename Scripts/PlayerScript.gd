extends CharacterBody2D

@onready var sprt = $Sprite2D
@onready var anim = $AnimationPlayer
@export var StartingPoint = Vector2(position.x,position.y)

var coyote = 0.2
var cTime = 0

var isTouching = false

@export var intro: AudioStream
@export var main: AudioStream
@onready var audioOutput = $Music
@export var jmpSfx: AudioStream
@onready var Jsfx = $JumpEffect

var cur_tree : Node2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	audioOutput.stream = intro
	audioOutput.play()
	Jsfx.stream = jmpSfx
	print_debug("Audio on")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		cTime -= delta
	else:
		cTime = coyote

	# Handle Jump.
	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and cTime>0:
		velocity.y = JUMP_VELOCITY
		Jsfx.play()
		anim.play("ascend")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprt.scale.x = direction * abs($Sprite2D.scale.x)
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")

	move_and_slide()
	
	if isTouching:
		if position.y - cur_tree.position.y > 0:
			if position.x - cur_tree.position.x > 0:
				$Camera2D.offset = lerp($Camera2D.offset,abs(position - cur_tree.position) * -1,0.1)
			else:
				$Camera2D.offset = lerp($Camera2D.offset,y_inv(abs(position - cur_tree.position)),0.1)
		else:
			$Camera2D.offset = lerp($Camera2D.offset,abs(position - cur_tree.position),0.1)
		$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(2,2),0.1)
	else:
		$Camera2D.offset = lerp($Camera2D.offset,Vector2(0,0),0.1)
		$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(3,3),0.1)

func _on_world_border_body_entered(_body):
	position = StartingPoint

func _on_audio_stream_player_2d_finished():
	audioOutput.stream = main
	audioOutput.play()
	print_debug("Main on")

func y_inv(point):
	return Vector2(point.x,-point.y)
