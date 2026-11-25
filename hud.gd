extends CanvasLayer

var player
var label: Label
var status: Label
var eat_button: Button
var touch_origin := Vector2.ZERO
var active_touch := -1

func _ready():
    var panel = PanelContainer.new()
    panel.position = Vector2(14, 14)
    panel.size = Vector2(300, 138)
    add_child(panel)
    var box = VBoxContainer.new()
    panel.add_child(box)
    label = Label.new()
    label.text = "WILD FRONTIER"
    label.add_theme_font_size_override("font_size", 22)
    box.add_child(label)
    status = Label.new()
    box.add_child(status)
    var hint = Label.new()
    hint.text = "Move: left side of screen | Collect: walk near items"
    hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    box.add_child(hint)
    eat_button = Button.new()
    eat_button.text = "Eat berries"
    eat_button.position = Vector2(14, 165)
    eat_button.size = Vector2(150, 52)
    eat_button.pressed.connect(_eat)
    add_child(eat_button)
    var help = Label.new()
    help.text = "Touch and drag on the lower-left area to move"
    help.position = Vector2(14, 225)
    add_child(help)

func _process(_delta):
    if player:
        status.text = "Health: %d   Hunger: %d   Thirst: %d\nWood: %d   Stone: %d   Berries: %d" % [
            int(player.health), int(player.hunger), int(player.thirst),
            player.inventory["Wood"], player.inventory["Stone"], player.inventory["Berries"]
        ]

func _eat():
    if player:
        player.eat_berries()

func _input(event):
    if not player:
        return
    if event is InputEventScreenTouch:
        if event.pressed and event.position.x < get_viewport().size.x * 0.55:
            active_touch = event.index
            touch_origin = event.position
            player.set_move_input(Vector2.ZERO)
        elif not event.pressed and event.index == active_touch:
            active_touch = -1
            player.set_move_input(Vector2.ZERO)
    elif event is InputEventScreenDrag and event.index == active_touch:
        var delta = (event.position - touch_origin) / 90.0
        player.set_move_input(Vector2(clamp(delta.x, -1, 1), clamp(delta.y, -1, 1)))
