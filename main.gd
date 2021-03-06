extends Node

export (PackedScene) var mob_scene
var score = 0



func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$DeathSound.play()
	$Music.stop()


func new_game():
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("get ready...")
	$StartTimer.start()
	$Music.play()
	get_tree().call_group("mobs", "queue_free")
	$Character.start($StartPosition.position)
	
	yield($StartTimer, "timeout")
	
	$HUD.show_message(" ")
	$ScoreTimer.start()
	$MobTimer.start()
	

func _ready():
	randomize()

func _on_MobTimer_timeout():
	var mob_spawn_location = $mobPath/mobSpawnLocation
	mob_spawn_location.unit_offset = rand_range(0, 0.22)
	

	var mob = mob_scene.instance()
	add_child(mob)
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	
	
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	
	
