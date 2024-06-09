class_name Player
extends Node3D

static var instnce: Player

@export var towers: Array[BattleObject]

var deck: Array[String]

func _init() -> void:
	instnce = self

func _ready() -> void:
	deck = ['test_unit', 'test_unit', 'test_unit', 'test_unit',
			'test_unit', 'test_unit', 'test_unit', 'test_unit']
