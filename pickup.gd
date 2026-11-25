extends Node3D

@export var resource_type := "Wood"
var spin := 0.0

func _ready():
    var mesh = MeshInstance3D.new()
    var sphere = SphereMesh.new()
    sphere.radius = 0.28
    sphere.height = 0.56
    mesh.mesh = sphere
    var mat = StandardMaterial3D.new()
    match resource_type:
        "Wood": mat.albedo_color = Color(0.48, 0.25, 0.10)
        "Stone": mat.albedo_color = Color(0.48, 0.50, 0.52)
        "Berries": mat.albedo_color = Color(0.65, 0.10, 0.18)
    mat.emission_enabled = true
    mat.emission = mat.albedo_color * 0.15
    mesh.material_override = mat
    add_child(mesh)

func _process(delta):
    spin += delta
    rotation.y = spin
    if not is_inside_tree():
        return
    var p = get_tree().get_first_node_in_group("player")
    if p and global_position.distance_to(p.global_position) < 1.8:
        p.collect(resource_type)
        queue_free()
