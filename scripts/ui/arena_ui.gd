extends CanvasLayer

signal cards_added

const _CARDS_PATH: String = "res://scenes/ui/cards/"

@export var _card_holders: Array[MarginContainer]

var _deck: Array[String]

func _ready() -> void:
	await get_tree().process_frame
	_deck = _mix_deck(Player.instnce.deck)
	for i in range(len(_card_holders)):
		var card = load(_CARDS_PATH + _deck[i] + ".tscn").instantiate()
		_card_holders[i].add_child(card)
	
	cards_added.emit()

func _mix_deck(start_deck: Array[String]) -> Array[String]:
	randomize()
	var new_deck: Array[String]
	
	for i in range(len(start_deck)):
		var r = randi_range(0, len(start_deck) - 1)
		new_deck.append(start_deck[r])
		start_deck.pop_at(r)
	
	return new_deck
