class_name StatePlayer
extends CharacterBody2D

#Dependencies
@onready var ground_ray: RayCast2D = $ground_ray

#Debug
@onready var label: Label = $Label

#MOVEMENT SECTION

#setup Variables
@export var MAX_SPEED: int = 1000
@export var acceleration: float = 50

var input: Vector2 = Vector2.ZERO

# JUMP SECTION
@export var max_jump: int = 2

var jump_count : int = max_jump
var jumped : bool = false

#setup Veriables
@export var jump_height: float = 300
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_decent: float = 0.4


#jump Calculation
@onready var jump_velocity :float = ((2.0 * jump_height) / jump_time_to_peak ) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_decent * jump_time_to_decent)) * -1 

#State Pattern shit
enum States {IDLE, WALK, JUMP}
var state = States.IDLE

#State Functions
func change_state(newState):
	match newState:
		States.IDLE:
			label.text = "IDLE"
		States.WALK:
			label.text = "WALK"
		States.JUMP:
			label.text = "JUMP"
			
	state = newState

func _physics_process(delta: float) -> void:
	applay_gravity(delta)
	match state:
		
		States.IDLE:
			idle()
		
		States.WALK:
			walk()
		
		States.JUMP:
			jump()
	
	move_and_slide()

# IDLE STATE FUNCTIONS
func idle():
	
	velocity.x = move_toward(velocity.x,0, acceleration)
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		change_state(States.WALK)
	
	if Input.is_action_just_pressed("ui_up"):
		change_state(States.JUMP)

#WALK STATE FUNCTIONS
func walk():
	input.x = Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, MAX_SPEED * input.x, acceleration)
	if !Input.is_anything_pressed():
		change_state(States.IDLE)
	if Input.is_action_just_pressed("ui_up"):
		change_state(States.JUMP)

#JUMP STATE FUNCTIONS
func jump():
	input.x = Input.get_axis("ui_left", "ui_right")
	velocity.x = move_toward(velocity.x, MAX_SPEED * input.x, acceleration)
	if !jumped and can_jump():
		jump_count -=1
		velocity.y = jump_velocity
		jumped=true
	elif grounded():
		change_state(States.IDLE)
	if can_jump():
		if Input.is_action_just_pressed("ui_up"):
			jumped=false
	

func get_gravity() ->float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func applay_gravity(delta):
	velocity.y += get_gravity() * delta

func grounded():
	if ground_ray.is_colliding():
		jump_count = max_jump
		jumped = false
		return true

func can_jump():
	if grounded() or jump_count>0:
		return true
	else: 
		return false
