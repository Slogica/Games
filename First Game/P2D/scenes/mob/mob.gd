extends RigidBody2D

# Función que se ejecuta cuando el nodo está listo
func _ready():
	$AnimatedSprite2D.play()
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()

# Función que se llama cuando el mob sale de la pantalla
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
