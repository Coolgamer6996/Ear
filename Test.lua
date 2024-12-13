-- MyUI Library with Black and Red Futuristic Theme
local MyUI = {}
MyUI.__index = MyUI

-- Create the main UI
function MyUI:new()
    local self = setmetatable({}, MyUI)

    -- Create the main screen GUI
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Main window frame
    self.MainWindow = Instance.new("Frame")
    self.MainWindow.Size = UDim2.new(0, 600, 0, 400)
    self.MainWindow.Position = UDim2.new(0.5, -300, 0.5, -200)
    self.MainWindow.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    self.MainWindow.BorderSizePixel = 2
    self.MainWindow.BorderColor3 = Color3.fromRGB(255, 0, 0)  -- Red border
    self.MainWindow.Parent = self.ScreenGui

    -- Header Frame (with username and avatar)
    self.Header = Instance.new("Frame")
    self.Header.Size = UDim2.new(1, 0, 0, 60)
    self.Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.Header.BorderSizePixel = 0
    self.Header.Parent = self.MainWindow

    -- Player's Avatar Image
    self.AvatarImage = Instance.new("ImageLabel")
    self.AvatarImage.Size = UDim2.new(0, 50, 0, 50)
    self.AvatarImage.Position = UDim2.new(0, 10, 0, 5)
    self.AvatarImage.Image = "rbxassetid://" .. game.Players.LocalPlayer.UserId  -- Displays the player's avatar
    self.AvatarImage.Parent = self.Header

    -- Player's Name
    self.Username = Instance.new("TextLabel")
    self.Username.Size = UDim2.new(0, 200, 0, 60)
    self.Username.Position = UDim2.new(0, 70, 0, 0)
    self.Username.BackgroundTransparency = 1
    self.Username.Text = game.Players.LocalPlayer.Name
    self.Username.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Red text
    self.Username.TextSize = 22
    self.Username.Font = Enum.Font.GothamBold
    self.Username.Parent = self.Header

    -- Tab container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Size = UDim2.new(0, 150, 1, 0)
    self.TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 60)
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.Parent = self.MainWindow

    -- Content area (to hold UI elements for each tab)
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Size = UDim2.new(1, -150, 1, 0)
    self.ContentArea.Position = UDim2.new(0, 150, 0, 60)
    self.ContentArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    self.ContentArea.Parent = self.MainWindow

    -- Create tabs
    self.Tabs = {}

    return self
end

-- Function to create a new tab
function MyUI:addTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 40)
    tabButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    tabButton.TextSize = 18
    tabButton.Font = Enum.Font.GothamBold
    tabButton.BorderSizePixel = 0
    tabButton.Parent = self.TabContainer

    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabContent.Visible = false
    tabContent.Parent = self.ContentArea

    table.insert(self.Tabs, {Button = tabButton, Content = tabContent})

    tabButton.MouseButton1Click:Connect(function()
        self:switchTab(tabContent)
    end)
end

-- Function to switch between tabs
function MyUI:switchTab(newTab)
    for _, tab in ipairs(self.Tabs) do
        tab.Content.Visible = false
    end
    newTab.Visible = true
end

-- Function to add a button
function MyUI:addButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0, 0, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red button
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- Black border
    button.Parent = parent

    button.MouseButton1Click:Connect(callback)

    -- Hover effect for button
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end)
end

-- Function to add a slider
function MyUI:addSlider(parent, minValue, maxValue, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 200, 0, 30)
    sliderFrame.Position = UDim2.new(0, 0, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderFrame.BorderSizePixel = 1
    sliderFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)  -- Red border
    sliderFrame.Parent = parent

    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(0, 10, 1, 0)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red slider
    slider.Text = ""
    slider.Parent = sliderFrame

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local function moveSlider(input)
                local xPos = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, 200)
                slider.Position = UDim2.new(xPos / 200, 0, 0, 0)
                local value = math.floor((xPos / 200) * (maxValue - minValue)) + minValue
                callback(value)
            end
            game:GetService("UserInputService").InputChanged:Connect(moveSlider)
        end
    end)
end

-- Function to add a toggle switch
function MyUI:addToggle(parent, text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 200, 0, 50)
    toggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    toggle.Text = text
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 18
    toggle.Font = Enum.Font.GothamBold
    toggle.BorderSizePixel = 1
    toggle.BorderColor3 = Color3.fromRGB(255, 0, 0)  -- Red border
    toggle.Parent = parent

    toggle.MouseButton1Click:Connect(function()
        toggle.BackgroundColor3 = toggle.BackgroundColor3 == Color3.fromRGB(0, 150, 0) and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 150, 0)
        callback(toggle.BackgroundColor3 == Color3.fromRGB(0, 150, 0))
    end)
end

return MyUI
