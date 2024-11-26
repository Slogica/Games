extends Node

# Exporta la escena del mob para instancias
@export var mob_scene: PackedScene
var score

# Función que se llama al finalizar el juego
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
# Función que inicia un nuevo juego
func new_game():
	get_tree().call_group(&"mobs", &"queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

# Función que se ejecuta cada vez que el temporizador de mobs termina
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress = randi()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

# Función que se llama cada vez que el temporizador de puntaje termina
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

# Función que se llama cuando el temporizador de inicio termina
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
