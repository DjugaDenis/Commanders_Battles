extends Button

var _is_dragging: bool = false
var _card: Control

@onready var _card_holder: Control = $CardHolder

func _ready() -> void:
	$"../../../../../../../..".cards_added.connect(_on_cards_added)

func _start_dragging_card() -> void:
	_card.reparent(self)
	
	while _is_dragging:
		_card.global_position = get_global_mouse_position() - _card.size / 2
		_card.visible = get_global_mouse_position().y > $"../../../../../../..".global_position.y
		await get_tree().process_frame
	
	_card.reparent(_card_holder)

func _on_cards_added() -> void:
	_card = $CardHolder.get_children()[0]

func _on_button_down() -> void:
	if not _is_dragging:
		_is_dragging = true
		_start_dragging_card()

func _on_button_up() -> void:
	_card.show()
	_is_dragging = false
