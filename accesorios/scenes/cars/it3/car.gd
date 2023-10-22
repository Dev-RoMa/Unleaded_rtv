extends Sprite3D
## I AM BIG IDIOT IMPORTING THESE FROM OLD PROJECT Q_Q
## CAN U TRY SILENT TP FROM DOOM? BIG IDIOT BIG IDIOT URGH
#remember here its where u start all the variables
#these are for the car movements and if the car can move, boolean
var speed = 0
#angle of steering from the input multiplier
var steer = 0.001
var angle = 270
#your ole friendly raycasts, can only be used with 3d bodies wont work on sprites
#ouch, these are to see if the car its ouf of the track and to count the control points
var raycast_gravity
#these are to make the car feel its moving, its an up and down movement
var move_up
#these are for initializing the variables/sprites/models and the rest
var animations
func _ready():
	animations = get_node("AnimationPlayer")
	raycast_gravity = get_node("raycast_gravity")
	
#these update every frame, this is where whatever
#change needs to be persistent, such as a car moving go
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		#speed increment
		#if gear == 1:
		speed = speed + 1
		if speed > 5:
			speed = 5
		# calculate the new pos
		var x_delta = speed * delta * cos(angle * PI / 180)
		var y_delta = speed * delta * sin(angle * PI / 180)
		#straight
		translation.x -= x_delta
		translation.z += y_delta
		rotation_degrees.y = (angle + 90)
	#remember to add code to stop the car
	else:
		speed -= 1
		if speed <= 0:
			speed = 0
	#steering the car
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("hard") and speed > 0:
		angle += 2
		if angle < 0:
			angle += 360
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("hard") and speed > 0:
		angle -= 2
		if angle > 360:
			angle -= 360
	elif Input.is_action_pressed("ui_left") and speed > 0:
		angle += 1
		if angle > 360:
			angle -= 360
	elif Input.is_action_pressed("ui_right") and speed > 0:
		animations.play("turn_car")
		angle -= 1
		if angle < 0:
			angle += 360
	else:
		visible = true
	# calculate the new position
	var x_delta = speed * delta * cos(angle * PI / 180.0)
	var y_delta = speed * delta * sin(angle * PI / 180.0)
	#straight
	translation.x -= x_delta
	translation.z += y_delta
	
	var collider = raycast_gravity.get_collider()
	print(collider)
	#if raycast_gravity.is_colliding():
	#	translation.y = 0
	#else:
	#	translation.y = 10
	
#here goes the code that modify the r a y c a s t s
func _physics_process(delta):
	pass
