class_name Player
extends CharacterBody2D

#Dependencies
@onready var ground_ray: RayCast2D = $ground_ray


#MOVEMENT SECTION

#setup Variables
@export var MAX_SPEED: int = 1000
@export var acceleration: float = 50

var input: Vector2 = Vector2.ZERO

# JUMP SECTION
@export var max_jump: int = 2
var jump_count : int = max_jump

#setup Veriables
@export var jump_height: float = 300
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_decent: float = 0.4

#jump Calculation
@onready var jump_velocity :float = ((2.0 * jump_height) / jump_time_to_peak ) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_decent * jump_time_to_decent)) * -1 

func _physics_process(delta: float) -> void:
	
	applay_gravity(delta)
	
	input.x = Input.get_axis("ui_left", "ui_right")
	input = input.normalized()
	
	velocity.x = move_toward(velocity.x, MAX_SPEED * input.x, acceleration)
	
	if Input.is_action_just_pressed("ui_up") and can_jump():
		jump()
	
	move_and_slide()

func jump():
	jump_count -=1
	velocity.y = jump_velocity

func get_gravity() ->float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func applay_gravity(delta):
	velocity.y += get_gravity() * delta

func grounded():
	if ground_ray.is_colliding():
		jump_count = max_jump
		return true

func can_jump():
	if grounded() or jump_count>0:
		return true
	else: 
		return false
