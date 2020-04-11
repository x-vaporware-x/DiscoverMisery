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
	
func _physics_process(delta):
	if currentTimeBetweenImpulses>=timeBetweenImpulses_seconds:
		currentTimeBetweenImpulses=delta
		
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
