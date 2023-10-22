extends KinematicBody

var speed = 100.0  # Adjust this value to control the movement speed.
var rotation_speed = 1.0  # Adjust this value to control the rotation speed.
var gravity = Vector3(0, -9.8, 0)
var sprite_s
var sprite_r
var sprite_l
var gear = 0

func _ready():
	sprite_s = get_node("Sprite3D")
	sprite_r = get_node("Sprite3D2")
	sprite_l = get_node("Sprite3D3")
	pass
	# Initialization code here, if needed.

func _process(delta):
	print(gear)

	if gear == 0:
		speed = 0

	if gear == 1:
		speed = 10

	if gear == 2:
		speed = 100

	if Input.is_action_just_pressed("shift_up"):
		gear += 1
		if gear >= 3:
			gear = 2
	elif Input.is_action_just_pressed("shift_down"):
		gear -= 1
		if gear <= -1:
			gear = 0

	# Input handling
	var move_direction = Vector3(0, 0, 0)
	if Input.is_action_pressed("ui_up"):
		sprite_st8()
		move_direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		move_direction.z += 1
	if Input.is_action_pressed("ui_right"):
		sprite_turn()
		rotate_y(-rotation_speed * delta)
	if Input.is_action_pressed("ui_left"):
		sprite_turn_l()
		rotate_y(rotation_speed * delta)

	# Check if the character is on the floor and apply gravity if not
	if not is_on_floor():
		move_direction += gravity * delta

	# Normalize the move direction if necessary
	if move_direction.length() > 1:
		move_direction = move_direction.normalized()

	# Rotate the move direction to align with the character's orientation
	move_direction = global_transform.basis.xform(move_direction)

	# Move the KinematicBody
	move_and_slide(move_direction * speed)

func sprite_st8():
	sprite_s.visible = true
	sprite_r.visible = false
	sprite_l.visible = false
	
func sprite_turn():
	sprite_r.visible = true
	sprite_s.visible = false

func sprite_turn_l():
	sprite_l.visible = true
	sprite_s.visible = false
