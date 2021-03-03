local library = {}

-- Services --

local UserInputService = game:GetService("UserInputService")

-- Functions --

local function MakeGuiDraggable(guiObject)
	local isDragging;
	local dragInput;
	local dragStart;
	local startPos;
	
	local function update(input)
		local delta = input.Position - dragStart
		guiObject.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end

	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isDragging = true
			dragStart = input.Position
			startPos = guiObject.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					isDragging = false
				end
			end)
		end
	end)

	guiObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and isDragging then
			update(input)
		end
	end)
end

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

	MakeGuiDraggable(windowInstance)

	local titleBar = Instance.new("Frame")
	titleBar.AnchorPoint = Vector2.new(0.5, 0)
	titleBar.Size = UDim2.fromScale(1, 0.1)
	titleBar.Position = UDim2.fromScale(0.5, 0)
	titleBar.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	titleBar.BorderSizePixel = 0
	titleBar.Name = "TitleBar"
	titleBar.Parent = windowInstance

	local titleText = Instance.new("TextLabel")
	titleText.Text = "funny"
	titleText.Font = Enum.Font.Highway
	titleText.TextScaled = true
	titleText.Size = UDim2.fromScale(1, 1)
	titleText.BackgroundTransparency = 1
	titleText.Name = "TitleText"
	titleText.TextColor3 = Color3.new(1, 1, 1)
	titleText.Position = UDim2.fromScale(0, 0)
	titleText.Parent = titleBar

	local listFrame = Instance.new("Frame")
	listFrame.BorderSizePixel = 0
	listFrame.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	listFrame.AnchorPoint = Vector2.new(0, 1)
	listFrame.Size = UDim2.fromScale(0.3, 0.9)
	listFrame.Position = UDim2.fromScale(0, 1)
	listFrame.Name = "ListFrame"
	listFrame.Parent = windowInstance
	Instance.new("UIListLayout", listFrame)

	function window:SetTitle(newTitle: string)
		titleText.Text = newTitle
	end

	function window:AddListItem(itemName: string, itemIconId: number)
		local listItem = {}

		local listItemInstance = Instance.new("TextButton")
		listItemInstance.BackgroundTransparency = 1
		listItemInstance.Text = ""
		listItemInstance.Size = UDim2.fromScale(1, 0.15)
		listItemInstance.Parent = listFrame

		local listItemName = Instance.new("TextLabel")
		listItemName.BackgroundTransparency = 1
		listItemName.TextScaled = true
		listItemName.Text = itemName
		listItemName.Font = Enum.Font.Highway
		listItemName.TextColor3 = Color3.new(1, 1, 1)
		listItemName.AnchorPoint = Vector2.new(1, 0.5)
		listItemName.Position = UDim2.fromScale(0.98, 0.5)
		listItemName.Size = UDim2.fromScale(0.78, 0.9)
		listItemName.Parent = listItemInstance

		local listItemIcon = Instance.new("ImageLabel")
		listItemIcon.BackgroundTransparency = 1
		listItemIcon.AnchorPoint = Vector2.new(0, 0.5)
		listItemIcon.Size = UDim2.fromScale(0.2, 1)
		listItemIcon.Position = UDim2.fromScale(0.01, 0.5)
		listItemIcon.Image = "rbxassetid://" .. tostring(itemIconId)
		listItemIcon.Parent = listItemInstance
		Instance.new("UIAspectRatioConstraint", listItemIcon)
	end

	return window
end

return library
