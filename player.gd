extends Area2D

@export var speed = 400; # speed pixels/sec
var screen_size: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
#as ready fires when node enters the screen so it is good to check the vieport size
	screen_size = get_viewport_rect().size;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO; # player movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("move_down"):
		velocity.y += 1;
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1;
		
	var is_player_moving = velocity.length() > 0;
	
	if is_player_moving:
		# we use normalized so that if player presess top and down the oucome wont be (1,1) * 400. This would let us move faster diagonally 
		velocity = velocity.normalized() * speed; 
		# play animation for movement
		var is_player_moving_horizontaly = velocity.x != 0;
		var is_player_moving_verticaly = velocity.y != 0;
	
		if is_player_moving_horizontaly:
			$AnimatedSprite2D.animation = "walk";
			var is_player_moving_left = velocity.x < 0;
			$AnimatedSprite2D.flip_h = is_player_moving_left;
		elif is_player_moving_verticaly:
			$AnimatedSprite2D.animation = "up";
			var is_player_moving_down = velocity.y > 0;
			$AnimatedSprite2D.flip_v = is_player_moving_down;
			$AnimatedSprite2D.play();
	else:
		$AnimatedSprite2D.stop();
		
	position += velocity * delta;
	# we use clamp to prevent user from leaving the screen
	position = position.clamp(Vector2.ZERO, screen_size);
