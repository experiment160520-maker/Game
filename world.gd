extends Node3D

const PLAYER_SCRIPT = preload("res://scripts/player.gd")
const PICKUP_SCRIPT = preload("res://scripts/pickup.gd")

var player
var hud
var world_time := 0.0

func _ready():
    _make_environment()
    _make_ground()
    _make_forest()
    _make_player()
    hud = get_node("HUD")
    hud.player = player

func _process(delta):
    world_time += delta
    var sun = get_node_or_null("Sun")
    if sun:
        sun.rotation.x = -0.35 + sin(world_time * 0.025) * 0.18

func _make_environment():
    var env = WorldEnvironment.new()
    var e = Environment.new()
    e.background_mode = Environment.BG_SKY
    e.sky = Sky.new()
    e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    e.ambient_light_color = Color(0.55, 0.65, 0.75)
    e.ambient_light_energy = 0.7
    e.tonemap_mode = Environment.TONE_MAPPER_FILMIC
    env.environment = e
    add_child(env)
    var sun = DirectionalLight3D.new()
    sun.name = "Sun"
    sun.rotation_degrees = Vector3(-45, -30, 0)
    sun.light_energy = 1.1
    add_child(sun)

func _make_ground():
    var ground = StaticBody3D.new()
    ground.name = "Ground"
    var mesh = MeshInstance3D.new()
    var plane = PlaneMesh.new()
    plane.size = Vector2(180, 180)
    mesh.mesh = plane
    var mat = StandardMaterial3D.new()
    mat.albedo_color = Color(0.20, 0.34, 0.17)
    mat.roughness = 1.0
    mesh.material_override = mat
    ground.add_child(mesh)
    var shape = CollisionShape3D.new()
    var box = BoxShape3D.new()
    box.size = Vector3(180, 1, 180)
    shape.shape = box
    shape.position.y = -0.5
    ground.add_child(shape)
    add_child(ground)

func _make_forest():
    for i in range(75):
        var x = randf_range(-75, 75)
        var z = randf_range(-75, 75)
        if Vector2(x, z).length() < 9:
            continue
        _make_tree(Vector3(x, 0, z))
    for i in range(28):
        var x = randf_range(-55, 55)
        var z = randf_range(-55, 55)
        if Vector2(x, z).length() < 7:
            continue
        var p = Node3D.new()
        p.set_script(PICKUP_SCRIPT)
        p.position = Vector3(x, 0.65, z)
        p.resource_type = ["Wood", "Stone", "Berries"].pick_random()
        add_child(p)

func _make_tree(pos: Vector3):
    var tree = StaticBody3D.new()
    tree.position = pos
    var trunk = MeshInstance3D.new()
    var cylinder = CylinderMesh.new()
    cylinder.top_radius = 0.22
    cylinder.bottom_radius = 0.35
    cylinder.height = 2.4
    trunk.mesh = cylinder
    var bark = StandardMaterial3D.new()
    bark.albedo_color = Color(0.25, 0.14, 0.08)
    trunk.material_override = bark
    trunk.position.y = 1.2
    tree.add_child(trunk)
    var leaves = MeshInstance3D.new()
    var crown = SphereMesh.new()
    crown.radius = 1.35
    crown.height = 2.7
    leaves.mesh = crown
    var green = StandardMaterial3D.new()
    green.albedo_color = Color(0.10, randf_range(0.25, 0.42), 0.12)
    leaves.material_override = green
    leaves.position.y = 3.0
    tree.add_child(leaves)
    var col = CollisionShape3D.new()
    var shape = CylinderShape3D.new()
    shape.radius = 0.42
    shape.height = 2.4
    col.shape = shape
    col.position.y = 1.2
    tree.add_child(col)
    add_child(tree)

func _make_player():
    player = CharacterBody3D.new()
    player.name = "Player"
    player.set_script(PLAYER_SCRIPT)
    player.position = Vector3(0, 1, 0)
    add_child(player)
