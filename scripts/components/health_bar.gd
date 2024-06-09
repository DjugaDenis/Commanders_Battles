extends Node3D

@export var _health_bar_width: int = 350

@onready var _body: BattleObject = get_parent()
@onready var _level_label: Label = $SubViewport/CenterContainer/HBoxContainer/Panel/Label
@onready var _level_panet_container: PanelContainer = $SubViewport/CenterContainer/HBoxContainer/Panel
@onready var _health_progress_bar: ProgressBar = $SubViewport/CenterContainer/HBoxContainer/ProgressBar
@onready var _player_health_bar_theme: Theme = load("res://resources/themes/player/health_bar.tres")
@onready var _oponent_health_bar_theme: Theme = load("res://resources/themes/oponent/health_bar.tres")

func _ready() -> void:
	_body.health_changed.connect(_on_health_changed)
	
	match _body.get_object_owner():
		BattleObject.Owner.Player:
			_level_panet_container.theme = _player_health_bar_theme
			_health_progress_bar.theme = _player_health_bar_theme
		BattleObject.Owner.Oponent:
			_level_panet_container.theme = _oponent_health_bar_theme
			_health_progress_bar.theme = _oponent_health_bar_theme
	
	_health_progress_bar.custom_minimum_size.x = _health_bar_width

func _on_health_changed(new_health) -> void:
	if _health_progress_bar.max_value == 0:
		_health_progress_bar.max_value = new_health
	_health_progress_bar.value = new_health
