extends Node


func _ready():
	SignalBus.connect("coinPickedUp", self, "coinAchievements")
	SignalBus.connect("slimeKilled", self, "slimeKilledAchievement")
	SignalBus.connect("itemBought", self, "itemBoughtAchievement")


func checkSignalMatches(signalName, value):
	for achievementKey in User.game_state.achievements:
		if User.game_state.achievements[achievementKey].has('signalName'):
			if User.game_state.achievements[achievementKey]["signalName"] == signalName:
				if User.game_state.achievements[achievementKey]["completed"] == false:
					User.game_state.achievements[achievementKey]["current"] += value
					
					if User.game_state.achievements[achievementKey]["current"] >= User.game_state.achievements[achievementKey]["goal"]:
						SignalBus.emit_signal("achievementMet", achievementKey)
	
	for questKey in User.game_state.quests:
		if questKey.substr(0, 5) != "quest": continue
		if User.game_state.quests[questKey]["signalName"] == signalName:
			if User.game_state.quests[questKey]["completed"] == false:
				User.game_state.quests[questKey]["current"] += value
				
				if User.game_state.quests[questKey]["current"] >= User.game_state.quests[questKey]["goal"]:
					User.game_state.quests[questKey]["completed"] = true
					SignalBus.emit_signal("questMet", questKey)


func coinAchievements(value):
	checkSignalMatches("coinPickedUp", value)


func slimeKilledAchievement(type):
	checkSignalMatches("slimeKilled", 1)


func itemBoughtAchievement():
	checkSignalMatches("itemBought", 1)
