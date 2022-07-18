extends Node2D

onready var clouds_scene = preload("res://src/Objects/Clouds.tscn")
onready var spawns = $Spawn_location
onready var clouds_container = $Clouds_container

func _ready() -> void:
	randomize()

	world_generation('spawn')
	world_generation('check')

	spawns.queue_free()

func _process(_delta: float) -> void:
	clear_location()

func world_generation(par):
	var n_sets = spawns.get_child_count()
	for i in range(n_sets):
		var  n_sub_sets = spawns.get_child(i).get_child_count()
		for j in range(n_sub_sets):

#Spawns Clouds In Clouds_container With Specific Locations
			if par == 'spawn':
				if randf() < 0.4: 
					spawn_cloud(spawns.get_child(i).get_child(j).get_position(),i)

#Checks That Each Set Has Atleast One Cloud And May Spawn A Cloud If Not
			if par == 'check':
				if clouds_container.get_child(i).get_child_count() < 1:
					spawn_cloud(spawns.get_child(i).get_child(rand_range(0,n_sub_sets-1)).get_position(),i)

func spawn_cloud(pos,set):
	var cloud = clouds_scene.instance()
	cloud.position = pos + Vector2(rand_range(-16,16),rand_range(-48,48))
	clouds_container.get_child(set).add_child(cloud)

func clear_location():
	var last_sets = clouds_container.get_child_count() - 1
	if clouds_container.get_child(last_sets).get_child_count() == 0:
		queue_free()


