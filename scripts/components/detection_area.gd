extends Area3D

signal target_changed(new_target)

var _targets: Array[BattleObject]
var _towers: Array[BattleObject]

func _ready() -> void:
	if get_parent().get_object_owner() == BattleObject.Owner.Oponent:
		_towers = Player.instnce.towers
		set_collision_mask_value(2, true)
	else:
		_towers = Oponent.instnce.towers
		set_collision_mask_value(3, true)
	
	_update_closest_target()

func _update_closest_target() -> void:
	var targets: Array[BattleObject] = _targets
	if len(_targets) == 0:
		targets = _towers
	
	var closest_target: BattleObject = targets[0]
	for target in targets:
		if global_position.distance_to(target.global_position) - target.radius < global_position.distance_to(closest_target.global_position) - target.radius:
			closest_target = target
	
	target_changed.emit(closest_target)

func _on_body_entered(body: BattleObject) -> void:
	_targets.append(body)
	_update_closest_target()

func _on_body_exited(body: BattleObject) -> void:
	_targets.erase(body)
	_update_closest_target()
