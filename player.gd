extends CharacterBody3D

const SPEED := 5.5
const JUMP_VELOCITY := 4.5
var gravity := 18.0
var health := 100.0
var hunger := 100.0
var thirst := 100.0
var inventory := {"Wood": 0, "Stone": 0, "Berries": 0}
var camera_pivot: Node3D
var camera: Camera3D
var move_input := Vector2.ZERO

func _ready():
    add_to_group("player")
    _build_character()
    _build_camera()

func _physics_process(delta):
    if not is_on_floor():
        velocity.y -= gravity * delta
    var input_dir = Vector3(move_input.x, 0, move_input.y)
    if input_dir.length() > 1:
        input_dir = input_dir.normalized()
    var direction = (transform.basis * input_dir).normalized()
    if direction:
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED
        rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), delta * 8.0)
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED * delta * 4)
        velocity.z = move_toward(velocity.z, 0, SPEED * delta * 4)
    move_and_slide()
    hunger = max(0, hunger - delta * 0.22)
    thirst = max(0, thirst - delta * 0.35)
    if hunger <= 0 or thirst <= 0:
        health = max(0, health - delta * 1.5)

func _build_character():
    var body = MeshInstance3D.new()
    var capsule = CapsuleMesh.new()
    capsule.radius = 0.38
    capsule.height = 1.7
    body.mesh = capsule
    var mat = StandardMaterial3D.new()
    mat.albedo_color = Color(0.62, 0.40, 0.23)
    body.material_override = mat
    body.position.y = 0.85
    add_child(body)
    var collision = CollisionShape3D.new()
    var shape = CapsuleShape3D.new()
    shape.radius = 0.38
    shape.height = 1.7
    collision.shape = shape
    collision.position.y = 0.85
    add_child(collision)

func _build_camera():
    camera_pivot = Node3D.new()
    camera_pivot.position.y = 1.5
    add_child(camera_pivot)
    camera = Camera3D.new()
    camera.position = Vector3(0, 3.0, 7.0)
    camera.look_at(Vector3.ZERO)
    camera.current = true
    camera_pivot.add_child(camera)

func set_move_input(value: Vector2):
    move_input = value

func collect(resource_type: String):
    inventory[resource_type] = inventory.get(resource_type, 0) + 1

func eat_berries():
    if inventory["Berries"] > 0:
        inventory["Berries"] -= 1
        hunger = min(100, hunger + 25)
