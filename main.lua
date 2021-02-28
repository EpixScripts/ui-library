local library = {}

function library:CreateWindow(parent: ScreenGui, size: UDim2)
	local window = {}
	
	local windowInstance = Instance.new("Frame")
	windowInstance.Size = size
	windowInstance.AnchorPoint = Vector2.new(0.5, 0.5)
	windowInstance.Position = UDim2.fromScale(0.5, 0.5)
	windowInstance.BorderSizePixel = 0
	windowInstance.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	windowInstance.Name = "WindowFrame"
	windowInstance.Parent = parent

	window.Instance = windowInstance

	local titleBar = Instance.new("Frame")
	titleBar.AnchorPoint = Vector2.new(0.5, 0)
	titleBar.Size = UDim2.fromScale(1, 0.1)
	titleBar.Position = UDim2.fromScale(0.5, 0)
	titleBar.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	titleBar.BorderSizePixel = 0
	titleBar.Name = "TitleBar"
	titleBar.Parent = windowInstance

	local titleIcon = Instance.new("ImageLabel")
	titleIcon.Image = "rbxassetid://68437732"
	titleIcon.Size = UDim2.fromScale(0.1, 1)
	titleIcon.Position = UDim2.fromScale(0, 0)
	titleIcon.BackgroundTransparency = 1
	titleIcon.Name = "TitleIcon"
	titleIcon.Parent = titleBar
	Instance.new("UIAspectRatioConstraint", titleIcon)

	local titleText = Instance.new("TextLabel")
	titleText.Text = "funny"
	titleText.Font = Enum.Font.Highway
	titleText.TextScaled = true
	titleText.AnchorPoint = Vector2.new(0, 0.5)
	titleText.Size = UDim2.fromScale(0.9, 1)
	titleText.BackgroundTransparency = 1
	titleText.Name = "TitleText"
	titleText.Parent = titleBar

	function window:SetTitle(newTitle: string)
		titleText.Text = newTitle
	end

	function window:SetTitleIcon(newIconId: number)
		titleIcon.Image = "rbxassetid://" .. tostring(newIconId)
	end
	
	return window
end

return library
