-- UI Library (MyUI)
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
    self.MainWindow.Size = UDim2.new(0, 500, 0, 300)
    self.MainWindow.Position = UDim2.new(0.5, -250, 0.5, -150)
    self.MainWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.MainWindow.Parent = self.ScreenGui

    -- Tab container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Size = UDim2.new(0, 100, 1, 0)
    self.TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 0)
    self.TabContainer.Parent = self.MainWindow

    -- Content area (to hold UI elements for each tab)
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Size = UDim2.new(1, -100, 1, 0)
    self.ContentArea.Position = UDim2.new(0, 100, 0, 0)
    self.ContentArea.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    self.ContentArea.Parent = self.MainWindow

    -- Create tabs
    self.Tabs = {}

    return self
end

-- Function to create a new tab
function MyUI:addTab(name)
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 40)
    tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.TextSize = 18
    tabButton.Parent = self.TabContainer

    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Parent = parent

    button.MouseButton1Click:Connect(callback)
end

-- Function to add a slider
function MyUI:addSlider(parent, minValue, maxValue, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 200, 0, 30)
    sliderFrame.Position = UDim2.new(0, 0, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    sliderFrame.Parent = parent

    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(0, 10, 1, 0)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
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
    toggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    toggle.Text = text
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 18
    toggle.Parent = parent

    toggle.MouseButton1Click:Connect(function()
        toggle.BackgroundColor3 = toggle.BackgroundColor3 == Color3.fromRGB(0, 200, 0) and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 200, 0)
        callback(toggle.BackgroundColor3 == Color3.fromRGB(0, 200, 0))
    end)
end

return MyUI
