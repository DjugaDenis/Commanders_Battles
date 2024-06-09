extends Node

var speed = 5
var accel = 10

var _target: BattleObject
@onready var _body: BattleObject = get_parent()
@onready var _navigator: NavigationAgent3D = _body.get_node("NavigationAgent3D")

func _ready() -> void:
	_body.get_node("DetectionArea").target_changed.connect(_on_target_changed)

func _process(delta) -> void:
	var direction = Vector3()
	
	_navigator.target_position = _target.global_position
	direction = _navigator.get_next_path_position() - _body.global_position
	direction = direction.normalized()
	
	_body.velocity = _body.velocity.lerp(direction * speed, accel * delta)
	
	_body.move_and_slide()

func _on_target_changed(new_target: BattleObject) -> void:
	_target = new_target
