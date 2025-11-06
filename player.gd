extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const CLIMB_SPEED = 200.0

var on_ladder: bool
var climbing: bool
var GRAVITY

func _on_climbable_body_entered(body: Node2D) -> void:
	
	pass # Replace with function body.
func _ladder_detect():
	if $ladder_detact_ray.is_colliding() and !is_on_floor():
		if Input.is_action_just_pressed("ui_up") or Input.is_action_pressed("ui_down"):
			on_ladder = true
	else:
		pass

func movement(_delta: float) -> void:
	var _x_input: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
func ladder_movement(_delta: float):
	pass
	

func _on_area_2d_body_entered(_body: Node2D):
	_ladder_detect()
	on_ladder = true

func _on_area_2d_body_exited(_body: Node2D):
	on_ladder = false
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	var grounded = is_on_floor()
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if on_ladder:
		var vertical_dir = Input.get_axis('up', 'down')
		if vertical_dir:
			velocity.y = vertical_dir * CLIMB_SPEED
			climbing = true
		else: 
			velocity.y = move_toward(velocity.y, 0, CLIMB_SPEED)
			if grounded: climbing = false
	elif not grounded:
a		velocity += GRAVITY * delta
	
	

	# Handle jump.
	if Input.is_action_just_pressed("ui_jump") and is_on_floor() and not climbing:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_wall() and not is_on_floor() and Input.is_action_just_pressed("ui_jump"):
		velocity.y = JUMP_VELOCITY  # Jump upwards
		

	move_and_slide()
	

   
 

   
