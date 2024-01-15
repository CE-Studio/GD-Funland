extends CharacterBody3D

# For authentic MC running speed, use 4.317
const TOP_SPEED = 6.5
const ACCELERATION = 50.0
const TURN_ACCEL = 10.0
const JUMP_VELOCITY = 8.0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 0.0
var direction:Vector3


@onready var cam = $"../Camera3D"


func _physics_process(delta):
    if not is_on_floor():
        velocity.y -= gravity * delta
    if Input.is_action_pressed("Jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY
    var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackward")
    if input_dir != Vector2.ZERO:
        speed = clampf(speed + (ACCELERATION * delta), 0.0, TOP_SPEED)
    else:
        speed = clampf(speed - (ACCELERATION * delta), 0.0, TOP_SPEED)
    if speed == 0.0:
        direction = Vector3.ZERO
    var new_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if new_dir:
        new_dir.rotated(Vector3(0, 1, 0), deg_to_rad(cam.rotation.y))
        direction = Vector3(lerpf(direction.x, new_dir.x, TURN_ACCEL * delta), 0, lerpf(direction.z, new_dir.z, TURN_ACCEL * delta))
    velocity.x = direction.x * speed
    velocity.z = direction.z * speed
    move_and_slide()
