extends CanvasLayer

var achievementMessage = load("res://Achievements/AchievementMessage.tscn")


func _ready():
	SignalBus.connect("achievementMet", self, "show_achievement")


func show_achievement(achievementCode):
	if User.game_state.achievements[achievementCode]["completed"] == true:
		return
	
	User.game_state.achievements[achievementCode]["completed"] = true
	var msg = achievementMessage.instance()
	msg.achievementCode = achievementCode
	$Control.add_child(msg)
