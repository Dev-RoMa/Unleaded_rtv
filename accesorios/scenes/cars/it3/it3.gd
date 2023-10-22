extends KinematicBody

var velocity = Vector3()
var acceleration = Vector3()
var friction = 5.0  # Adjust the friction value as needed
var gravity = Vector3(0, -9.8, 0)  # Adjust the gravity value as needed
var move_speed = 5.0
var turn_speed = 2.0
var is_accelerating = false

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		is_accelerating = true
		var angle_radians = deg2rad(rotation_degrees.y)  # Convert the angle to radians
		acceleration = Vector3(-sin(angle_radians), 0, cos(angle_radians)) * move_speed
	else:
		is_accelerating = false
		acceleration = -velocity.normalized() * friction

	if is_accelerating:
		if Input.is_action_pressed("ui_left"):
			rotate(Vector3(0, 1, 0), turn_speed * delta)
		elif Input.is_action_pressed("ui_right"):
			rotate(Vector3(0, -1, 0), turn_speed * delta)

	if is_on_floor():
		velocity.y = 0
	else:
		velocity += gravity * delta

	velocity += acceleration * delta
	move_and_slide(velocity, Vector3(0, 1, 0))
