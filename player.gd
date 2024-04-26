extends Area2D

@export var speed = 400; # speed pixels/sec
var screen_size: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
#as ready fires when node enters the screen so it is good to check the vieport size
	screen_size = get_viewport_rect().size;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
