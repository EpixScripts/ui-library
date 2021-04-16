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

-- Classes --

local ListItemClass = {}
ListItemClass.__index = ListItemClass

function ListItemClass:GetTab()
	return self.tab
end

local TabItemClass = {}
TabItemClass.__index = TabItemClass

function TabItemClass:GetCurrentValue()
	return self.value
end

local TabClass = {}
TabClass.__index = TabClass

function TabClass:AddItem(valueType, defaultValue, itemName: string)
	local tabItem = setmetatable({}, TabItemClass)
	tabItem.value = defaultValue
	
	local tabItemInstance = Instance.new("Frame")
	tabItemInstance.SizeConstraint = Enum.SizeConstraint.RelativeXX
	tabItemInstance.BackgroundTransparency = 1
	tabItemInstance.Size = UDim2.fromScale(1, 0.2)
	tabItemInstance.Parent = self.Instance
	
	local tabItemNameLabel = Instance.new("TextLabel")
	tabItemNameLabel.AnchorPoint = Vector2.new(0, 0.5)
	tabItemNameLabel.BackgroundTransparency = 1
	tabItemNameLabel.Position = UDim2.fromScale(0.05, 0.5)
	tabItemNameLabel.Size = UDim2.fromScale(0.4, 0.8)
	tabItemNameLabel.Font = Enum.Font.Highway
	tabItemNameLabel.Text = itemName
	tabItemNameLabel.TextScaled = true
	tabItemNameLabel.TextColor3 = Color3.new(1, 1, 1)
	tabItemNameLabel.Parent = tabItemInstance
	
	if valueType == "function" then
		local itemRunButton = Instance.new("TextButton")
		itemRunButton.AnchorPoint = Vector2.new(1, 0.5)
		itemRunButton.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
		itemRunButton.BorderSizePixel = 0
		itemRunButton.Position = UDim2.fromScale(0.95, 0.5)
		itemRunButton.Size = UDim2.fromScale(0.45, 0.9)
		itemRunButton.Font = Enum.Font.Highway
		itemRunButton.Text = "Run"
		itemRunButton.TextColor3 = Color3.new(1, 1, 1)
		itemRunButton.TextScaled = true
		itemRunButton.Name = "RunButton"
		itemRunButton.Parent = tabItemInstance
		
		itemRunButton.Activated:Connect(function()
			defaultValue()
		end)
	elseif valueType == "boolean" then
		local itemToggleButton = Instance.new("TextButton")
		itemToggleButton.AnchorPoint = Vector2.new(1, 0.5)
		itemToggleButton.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
		itemToggleButton.BorderSizePixel = 0
		itemToggleButton.Position = UDim2.fromScale(0.95, 0.5)
		itemToggleButton.Size = UDim2.fromScale(0.45, 0.9)
		itemToggleButton.Font = Enum.Font.Highway
		itemToggleButton.Text = defaultValue and "On" or "Off"
		itemToggleButton.TextColor3 = Color3.new(1, 1, 1)
		itemToggleButton.TextScaled = true
		itemToggleButton.Name = "ToggleButton"
		itemToggleButton.Parent = tabItemInstance
		
		itemToggleButton.Activated:Connect(function()
			tabItem.value = not tabItem.value
			itemToggleButton.Text = tabItem.value and "On" or "Off"
		end)
	elseif valueType == "string" then
		local stringInputBox = Instance.new("TextBox")
		stringInputBox.AnchorPoint = Vector2.new(1, 0.5)
		stringInputBox.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
		stringInputBox.BorderSizePixel = 0
		stringInputBox.ClearTextOnFocus = false
		stringInputBox.Position = UDim2.fromScale(0.95, 0.5)
		stringInputBox.Size = UDim2.fromScale(0.45, 0.9)
		stringInputBox.Font = Enum.Font.Highway
		stringInputBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
		stringInputBox.PlaceholderText = "String Input"
		stringInputBox.Text = tostring(defaultValue)
		stringInputBox.TextColor3 = Color3.new(1, 1, 1)
		stringInputBox.TextScaled = true
		stringInputBox.Name = "StringInputBox"
		stringInputBox.Parent = tabItemInstance
		
		stringInputBox:GetPropertyChangedSignal("Text"):Connect(function()
			tabItem.value = stringInputBox.Text
		end)
	end
	
	return tabItem
end

local WindowClass = {}
WindowClass.__index = WindowClass

function WindowClass:AddListItem(itemName: string, itemIconId: number?)
	local listItem = setmetatable({}, ListItemClass)

	local listItemInstance = Instance.new("TextButton")
	listItemInstance.Text = ""
	listItemInstance.BackgroundColor3 = Color3.new(0.6, 0.6, 0.6)
	listItemInstance.BorderSizePixel = 0
	listItemInstance.Size = UDim2.fromScale(1, 0.15)
	listItemInstance.Parent = self.listFrame

	local listItemName = Instance.new("TextLabel")
	listItemName.BackgroundTransparency = 1
	listItemName.TextScaled = true
	listItemName.Text = itemName
	listItemName.Font = Enum.Font.Highway
	listItemName.TextColor3 = Color3.new(1, 1, 1)
	listItemName.AnchorPoint = Vector2.new(0.5, 0.5)
	listItemName.Position = UDim2.fromScale(0.5, 0.5)
	listItemName.Size = UDim2.fromScale(itemIconId and 0.78 or 0.94, 0.94)
	listItemName.Parent = listItemInstance

	if itemIconId then
		local listItemIcon = Instance.new("ImageLabel")
		listItemIcon.BackgroundTransparency = 1
		listItemIcon.AnchorPoint = Vector2.new(0, 0.5)
		listItemIcon.Size = UDim2.fromScale(0.2, 1)
		listItemIcon.Position = UDim2.fromScale(0.01, 0.5)
		listItemIcon.Image = "rbxassetid://" .. tostring(itemIconId)
		listItemIcon.Parent = listItemInstance
		Instance.new("UIAspectRatioConstraint", listItemIcon)
	end

	local tabFrame = Instance.new("Frame")
	tabFrame.BackgroundTransparency = 1
	tabFrame.AnchorPoint = Vector2.new(1, 1)
	tabFrame.Size = UDim2.fromScale(0.65, 0.9)
	tabFrame.Position = UDim2.fromScale(1, 1)
	tabFrame.Visible = false
	tabFrame.Name = "TabFrame"
	tabFrame.Parent = self.Instance.TabFrames
	local tabLayout = Instance.new("UIListLayout")
	tabLayout.Padding = UDim.new(0.01, 0)
	tabLayout.Parent = tabFrame

	local listTab = setmetatable({}, TabClass)
	listTab.Instance = tabFrame
	listItem.tab = listTab
	table.insert(self.Tabs, listTab)
	
	listItemInstance.Activated:Connect(function()
		self:SetCurrentTab(listTab)
	end)

	return listItem
end

function WindowClass:SetTitle(newTitle: string)
	self.titleText.Text = newTitle
end

function WindowClass:SetCurrentTab(listTab)
	for _, tab in ipairs(self.Tabs) do
		tab.Instance.Visible = false
	end
	listTab.Instance.Visible = true
end

-- Main Function --

function library:CreateWindow(parent: ScreenGui, size: UDim2)
	local self = setmetatable({}, WindowClass)

	local windowInstance = Instance.new("Frame")
	windowInstance.Size = size
	windowInstance.AnchorPoint = Vector2.new(0.5, 0.5)
	windowInstance.Position = UDim2.fromScale(0.5, 0.5)
	windowInstance.BorderSizePixel = 0
	windowInstance.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
	windowInstance.SizeConstraint = Enum.SizeConstraint.RelativeXX
	windowInstance.Name = "WindowFrame"
	windowInstance.Parent = parent

	self.Instance = windowInstance
	self.Tabs = {}

	MakeGuiDraggable(windowInstance)

	self.titleBar = Instance.new("Frame")
	self.titleBar.AnchorPoint = Vector2.new(0, 0)
	self.titleBar.Size = UDim2.fromScale(1, 0.1)
	self.titleBar.Position = UDim2.fromScale(0, 0)
	self.titleBar.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	self.titleBar.BorderSizePixel = 0
	self.titleBar.Name = "TitleBar"
	self.titleBar.Parent = windowInstance

	self.titleText = Instance.new("TextLabel")
	self.titleText.Text = "<Unnamed>"
	self.titleText.Font = Enum.Font.Highway
	self.titleText.TextScaled = true
	self.titleText.Size = UDim2.fromScale(0.98, 1)
	self.titleText.BackgroundTransparency = 1
	self.titleText.Name = "TitleText"
	self.titleText.TextColor3 = Color3.new(1, 1, 1)
	self.titleText.AnchorPoint = Vector2.new(1, 0)
	self.titleText.Position = UDim2.fromScale(1, 0)
	self.titleText.Parent = self.titleBar

	self.listFrame = Instance.new("Frame")
	self.listFrame.BorderSizePixel = 0
	self.listFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
	self.listFrame.AnchorPoint = Vector2.new(0, 1)
	self.listFrame.Size = UDim2.fromScale(0.35, 0.9)
	self.listFrame.Position = UDim2.fromScale(0, 1)
	self.listFrame.Name = "ListFrame"
	self.listFrame.Parent = windowInstance
	Instance.new("UIListLayout", self.listFrame)

	local TabFramesFolder = Instance.new("Folder", windowInstance)
	TabFramesFolder.Name = "TabFrames"

	return self
end

-- Return --

return library
