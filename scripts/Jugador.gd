extends KinematicBody

var camera_angle = 0
var mouse_sensitivity=0.3
var camera_change = Vector2()

var velocity = Vector3()
var direction = Vector3()

const FLY_SPEED= 10
const FLY_ACCEL=4
var flying = false

var gravity = -9.8 * 3
const MAX_SPEED=20
const MAX_RUNNING_SPEED=40
const ACCEL=2
const DEACCEL=6

var jump_height=15

var mouseGrabbed=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	aim()
	if flying:
		fly(delta)
	else:
		walk(delta)
	
func _input(event):
	if Input.is_action_just_pressed("grab_mouse"):
			if mouseGrabbed:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				mouseGrabbed=false
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				mouseGrabbed=true
	if event is InputEventMouseMotion:
		camera_change=event.relative

		
func walk(delta):
	# resetear la direccion del jugador
	direction=Vector3()
	
	# rotacion de la camara
	var aim=$Cabeza/Camera.get_global_transform().basis

	# comprobamos los inputs y cambiamos la direccion
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	
	direction=direction.normalized()
	
	#direccion objetivo
	velocity.y += gravity * delta
	
	var temp_velocity=velocity
	temp_velocity.y=0
	
	var speed
	if Input.is_action_pressed("move_sprint"):
		speed= MAX_RUNNING_SPEED
	else:
		speed = MAX_SPEED
	
	var target=direction * speed
	
	var acceleration
	#si dos vectores van en la misma direccion (mas o menos)
	#el dot product sera mayor que 0
	if direction.dot(temp_velocity)>0:
		acceleration=ACCEL
	else:
		acceleration=DEACCEL
	
	
	#tenemos en cuenta la aceleracion
	temp_velocity=temp_velocity.linear_interpolate(target, acceleration*delta)
	
	velocity.x=temp_velocity.x
	velocity.z=temp_velocity.z
	
	#nos movemos
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y=jump_height
	
func fly(delta):
	# resetear la direccion del jugador
	direction=Vector3()
	
	# rotacion de la camara
	var aim=$Cabeza/Camera.get_global_transform().basis

	# comprobamos los inputs y cambiamos la direccion
	if Input.is_action_pressed("move_forward"):
		direction -= aim.z
	
	if Input.is_action_pressed("move_backward"):
		direction += aim.z
	
	if Input.is_action_pressed("move_left"):
		direction -= aim.x
	
	if Input.is_action_pressed("move_right"):
		direction += aim.x
	
	direction=direction.normalized()
	
	#direccion objetivo
	var target = direction * FLY_SPEED
	
	#tenemos en cuenta la aceleracion
	velocity=velocity.linear_interpolate(target, FLY_ACCEL*delta)
	
	#nos movemos
	move_and_slide(velocity)

func aim():
	if camera_change.length()>0:
		$Cabeza.rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
		
		var change= -camera_change.y *mouse_sensitivity
		if change + camera_angle< 90 and change + camera_angle > -90:
			$Cabeza/Camera.rotate_x(deg2rad(change))
			camera_angle+=change
		camera_change=Vector2()
	


func _on_Area_body_entered(body):
	if body.name== "Jugador":
		flying= true


func _on_Area_body_exited(body):
	if body.name== "Jugador":
		flying= false
