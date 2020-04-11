extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player=KinematicBody
const SPEED=1000
var currentTimeBetweenImpulses=0
var timeBetweenImpulses_seconds=2
# Called when the node enters the scene tree for the first time.
func _ready():
	player=get_parent().get_parent().get_node("Jugador")
	timeBetweenImpulses_seconds=timeBetweenImpulses_seconds+timeBetweenImpulses_seconds*rand_range(0,1)
	var initialImpulse=Vector3(rand_range(0,1),rand_range(0,1),rand_range(0,1))
	initialImpulse=initialImpulse.normalized()*rand_range(SPEED/2,SPEED)
	apply_central_impulse(initialImpulse)
	
func _physics_process(delta):
	if currentTimeBetweenImpulses>=timeBetweenImpulses_seconds:
		currentTimeBetweenImpulses=delta
		if(rand_range(0,1)<0.1):
			var randomImpulse=Vector3(rand_range(0,1),rand_range(0,1),rand_range(0,1))
			randomImpulse=randomImpulse.normalized()*rand_range(SPEED/2,SPEED)
			linear_velocity=Vector3()
			apply_central_impulse(randomImpulse)
		else:
			var playerPos=player.translation
			var myPos=translation
	
			var direction=playerPos-myPos
			direction=direction.normalized()
	
			var target=direction*SPEED
			linear_velocity=Vector3()	
			
			apply_central_impulse(target)
	else:
		currentTimeBetweenImpulses=currentTimeBetweenImpulses+delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
