class_name Oponent
extends Node3D

static var instnce: Oponent

@export var towers: Array[BattleObject]

func _init() -> void:
	instnce = self
