local UILibrary = {}
UILibrary.__index = UILibrary

function UILibrary:NewWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = title or "UILibrary"
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    -- Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Text = title or "UILibrary"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Parent = TitleBar

    -- Tabs
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(0, 120, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 5)
    TabLayout.Parent = TabContainer

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -120, 1, -40)
    ContentFrame.Position = UDim2.new(0, 120, 0, 40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    local Pages = {}

    function UILibrary:AddPage(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.Text = tabName
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabButton.Parent = TabContainer

        local TabPage = Instance.new("Frame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = false
        TabPage.Parent = ContentFrame

        Pages[tabName] = TabPage

        TabButton.MouseButton1Click:Connect(function()
            for _, page in pairs(Pages) do
                page.Visible = false
            end
            TabPage.Visible = true
        end)

        return {
            AddButton = function(self, text, callback)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(0, 200, 0, 30)
                Button.Text = text
                Button.Font = Enum.Font.Gotham
                Button.TextSize = 14
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Button.Parent = TabPage

                Button.MouseButton1Click:Connect(function()
                    if callback then
                        callback()
                    end
                end)
            end,
            AddToggle = function(self, text, callback)
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Size = UDim2.new(0, 200, 0, 30)
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                ToggleFrame.Parent = TabPage

                local ToggleText = Instance.new("TextLabel")
                ToggleText.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleText.Text = text
                ToggleText.Font = Enum.Font.Gotham
                ToggleText.TextSize = 14
                ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleText.BackgroundTransparency = 1
                ToggleText.Parent = ToggleFrame

                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Size = UDim2.new(0.3, 0, 1, 0)
                ToggleButton.Position = UDim2.new(0.7, 0, 0, 0)
                ToggleButton.Text = "OFF"
                ToggleButton.Font = Enum.Font.Gotham
                ToggleButton.TextSize = 14
                ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
                ToggleButton.Parent = ToggleFrame

                local toggled = false
                ToggleButton.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    ToggleButton.Text = toggled and "ON" or "OFF"
                    ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(80, 0, 0)
                    if callback then
                        callback(toggled)
                    end
                end)
            end
        }
    end

    return UILibrary
end

return UILibrary
