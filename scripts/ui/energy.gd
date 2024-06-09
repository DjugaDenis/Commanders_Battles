extends CenterContainer

var _current_energy: float = 0:
	set(value):
		_current_energy = value
		_label.text = str(int(_current_energy))
		_progress_bar.value = _current_energy
var _max_energy: int = 10
var _energy_recovery_rate: float = 0.01

@onready var _label: Label = $HBoxContainer/ColorRect/Label
@onready var _progress_bar: ProgressBar = $HBoxContainer/CenterContainer/ProgressBar

func _ready():
	_progress_bar.min_value = 0
	_progress_bar.max_value = _max_energy
	_update_energy()

func _update_energy():
	while true:
		if _current_energy < _max_energy:
			_current_energy += _energy_recovery_rate
		
		await get_tree().create_timer(0.03).timeout
