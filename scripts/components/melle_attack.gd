extends Node3D

@export var _damage: int
@export var _radius: float
@export var _attack_rate: float

var _target: BattleObject

@onready var _body: BattleObject = get_parent()

func _ready() -> void:
	_body.get_node("DetectionArea").target_changed.connect(_on_target_changed)
	_attack()

func _attack() -> void:
	while get_tree():
		if _target != null:
			if global_position.distance_to(_target.global_position) - _target.radius - _body.radius <= _radius:
				_target.take_damage(_damage)
				await get_tree().create_timer(_attack_rate).timeout
		await get_tree().process_frame

func _on_target_changed(new_target: BattleObject) -> void:
	_target = new_target
