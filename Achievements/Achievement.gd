# @author Xiaoyan Zhou
extends Control
onready var achievements : Node = get_tree().get_root().find_node("GridContainer", true, false)

var individualAchievement = load("res://Achievements/IndividualAchievement.tscn")
onready var sound_effect = $AudioStreamPlayer
func _ready():
	_achievements_check()


func _add_achievement(achieved):
	for achievementCode in User.game_state.achievements:
		if User.game_state["achievements"][achievementCode]["completed"] == achieved:
			var newAchievement = individualAchievement.instance()
			
			newAchievement.achievementName = User.game_state.achievements[achievementCode]["name"]
			newAchievement.achievementDescription = User.game_state.achievements[achievementCode]["desc"]
			newAchievement.achievementCompleted = User.game_state["achievements"][achievementCode]["completed"]
			
			if User.game_state.achievements[achievementCode].has('goal'):
				newAchievement.percentCompleted = (float(User.game_state.achievements[achievementCode]["current"]) / float(User.game_state.achievements[achievementCode]["goal"]))*100
			else:
				newAchievement.percentCompleted = 0
			
			achievements.add_child(newAchievement)


#check achievements
func _achievements_check():
	# first display the achievements player has, then show ones yet to achieve
	_add_achievement(true)
	_add_achievement(false)


func _on_BACK_pressed():

	sound_effect.play()
	yield(sound_effect, "finished")
	SceneChanger.change_scene("res://Game.tscn", "fade")
	
