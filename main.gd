extends Node

@export var mob_scene: PackedScene;
var score;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;
	#new_game();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_hit():
	pass # Replace with function body.


func game_over():
	$ScoreTimer.stop();
	$MobTimer.stop();
	$HUD.show_game_over();
	
func new_game():
	# group is setup next to signals in mobs scene. We can call a group with a specific method. This way we can destroy all creeps
	get_tree().call_group("mobs", "queue_free");
	score = 0;
	$HUD.update_score(score);
	$HUD.show_message("Get Ready");
	$Player.start($StartPosition.position);
	$StartTimer.start(); # this will start other timers


func _on_score_timer_timeout():
	score += 1;
	$HUD.update_score(score);


func _on_start_timer_timeout():
	# we start two other timers from start timer
	$MobTimer.start();
	$ScoreTimer.start();
	
func _on_mob_timer_timeout():
	# spawning mobs
	var mob = mob_scene.instantiate();
	# this is how we access node of a node
	var mob_spawn_location = $MobPath/MobSpawnLocation;
	mob_spawn_location.progress_ratio = randf();

	var direction  = mob_spawn_location.rotation + PI/2;
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4);
	mob.rotation = direction;
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0);
	mob.linear_velocity = velocity.rotated(direction);
	add_child(mob);
	
