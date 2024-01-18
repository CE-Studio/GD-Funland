extends Node3D


@onready var target := $"Target"
@onready var cam := $"../Camera3D"


func _ready():
    pass


func _process(delta):
    pass


func _on_trigger_touched(body):
    cam.set_state(cam.CamState.Static, target, false)
