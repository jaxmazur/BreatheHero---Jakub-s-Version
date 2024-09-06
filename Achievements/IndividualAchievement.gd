extends PanelContainer

export(String) var achievementName = "Sample Name"
export(String) var achievementDescription = "Sample description."
export(bool) var achievementCompleted = false
export(float, 0, 100, 0.01) var percentCompleted = 0

export(NodePath) var title 
export(NodePath) var desc 
export(NodePath) var completeBadge 
export(NodePath) var completeText 
export(NodePath) var progressBar


func _ready():
	get_node(title).text = achievementName
	get_node(desc).text = achievementDescription
	get_node(completeBadge).visible = achievementCompleted
	get_node(completeText).visible = achievementCompleted
	get_node(progressBar).value = percentCompleted
	
	if achievementCompleted:
		add_stylebox_override("panel", get_stylebox("panel").duplicate())
		get_stylebox("panel").bg_color = Color8(93, 103, 181)
