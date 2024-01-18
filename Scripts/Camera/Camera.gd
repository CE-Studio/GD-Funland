extends Camera3D


const EASE_RATE = 5.0

enum CamState {Static, FollowStatic, FollowPlane, Follow3P}

var target:Node3D
var old_target:Node3D
var cur_state:CamState
var ease_time = 0.0


func _ready():
    pass


func _process(delta):
    ease_time += delta
    if target != null:
        var ease_point = -(cos(PI * ease_time) - 1.0) * 0.5 if ease_time < 1.0 else 1.0
        var target_pos:Vector3
        var target_rot:Vector3
        if old_target != null:
            target_pos = old_target.position.lerp(target.position, ease_point)
            target_rot = old_target.rotation.lerp(target.rotation, ease_point)
        else:
            target_pos = position.lerp(target.position, ease_point)
            target_rot = rotation.lerp(target.rotation, ease_point)
        position = position.slerp(target.position, EASE_RATE * delta)
        rotation = rotation.slerp(target.rotation, EASE_RATE * delta)


func set_state(new_state:CamState, new_target:Node3D, instant:bool):
    cur_state = new_state
    old_target = target
    target = new_target
    if instant:
        position = target.position
        rotation = target.rotation
    ease_time = 0.0
