class_name BattleObject
extends CollisionObject3D

signal health_changed(new_health)

enum BattleObjectType {
	Tower,
	Building,
	Unit
}

enum Owner {
	Player,
	Oponent
}

@export var _type: BattleObjectType
@export var _owner: Owner
@export var _level: int = 1
@export var _health: int:
	set(value):
		_health = value
		health_changed.emit(_health)

var radius: float:
	get:
		return get_node("CollisionShape3D").shape.radius

func get_health() -> int:
	return _health

func get_object_type() -> BattleObjectType:
	return _type

func get_object_owner() -> Owner:
	return _owner

func take_damage(damage: int) -> void:
	await get_tree().process_frame
	_health -= damage
	if _health <= 0:
		_die()

func _ready() -> void:
	health_changed.emit(_health)
	set_collision_layer_value(2 if _owner == BattleObject.Owner.Player else 3, true)

func _die() -> void:
	Remover.remove_object(self)
