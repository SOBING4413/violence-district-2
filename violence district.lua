-- ============================================================
-- SECTION 1: MOBILE/EXECUTOR DETECTION
-- ============================================================
local function detectMobilePlatform()
    local UserInputService = game:GetService("UserInputService")
    local hasTouchScreen = UserInputService.TouchEnabled
    local camera = workspace.CurrentCamera
    local viewportSize = camera and camera.ViewportSize or Vector2.new(0, 0)
    local isSmallScreen = viewportSize.X <= 1024 or viewportSize.Y <= 768
    local hasGyroscope = UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled
    local noKeyboard = not UserInputService.KeyboardEnabled
    local executorName = identifyexecutor and identifyexecutor() or "Unknown"
    local isMobileExecutor = executorName:lower():find("delta") or 
                             executorName:lower():find("arceus") or
                             executorName:lower():find("fluxus") or
                             executorName:lower():find("krnl")
    local isMobile = hasTouchScreen and (noKeyboard or isSmallScreen or hasGyroscope or isMobileExecutor)
    if hasTouchScreen and isMobileExecutor then
        isMobile = true
    end
    return isMobile
end

local isMobile = detectMobilePlatform()
local executorName = identifyexecutor and identifyexecutor() or "Unknown"

print("=== Violence District v1 ===")
print("Platform: " .. (isMobile and "Mobile" or "PC"))
print("Executor: " .. executorName)
print("===================================================")

-- ============================================================
-- SECTION 2: SERVICES
-- ============================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ============================================================
-- SECTION 3: THEMES
-- ============================================================
local Themes = {
    ["Modern"] = {
        Name = "Modern",
        Background = Color3.fromRGB(10, 10, 18),
        Surface = Color3.fromRGB(18, 18, 30),
        SurfaceAlt = Color3.fromRGB(25, 25, 42),
        Accent = Color3.fromRGB(255, 0, 102),
        AccentAlt = Color3.fromRGB(0, 255, 255),
        Text = Color3.fromRGB(230, 230, 255),
        TextDim = Color3.fromRGB(140, 140, 180),
        Border = Color3.fromRGB(255, 0, 102),
        Toggle = Color3.fromRGB(255, 0, 102),
        ToggleOff = Color3.fromRGB(60, 60, 80),
        Slider = Color3.fromRGB(0, 255, 255),
        Glow = Color3.fromRGB(255, 0, 102),
        TabActive = Color3.fromRGB(255, 0, 102),
        TabInactive = Color3.fromRGB(30, 30, 50),
        Notification = Color3.fromRGB(255, 0, 102),
    },
    ["Neon Blue"] = {
        Name = "Neon Blue",
        Background = Color3.fromRGB(8, 12, 22),
        Surface = Color3.fromRGB(14, 20, 36),
        SurfaceAlt = Color3.fromRGB(20, 28, 48),
        Accent = Color3.fromRGB(0, 150, 255),
        AccentAlt = Color3.fromRGB(0, 220, 255),
        Text = Color3.fromRGB(220, 235, 255),
        TextDim = Color3.fromRGB(120, 150, 190),
        Border = Color3.fromRGB(0, 150, 255),
        Toggle = Color3.fromRGB(0, 150, 255),
        ToggleOff = Color3.fromRGB(40, 50, 70),
        Slider = Color3.fromRGB(0, 220, 255),
        Glow = Color3.fromRGB(0, 150, 255),
        TabActive = Color3.fromRGB(0, 150, 255),
        TabInactive = Color3.fromRGB(20, 28, 48),
        Notification = Color3.fromRGB(0, 150, 255),
    },
    ["Blood Red"] = {
        Name = "Blood Red",
        Background = Color3.fromRGB(14, 8, 8),
        Surface = Color3.fromRGB(24, 12, 12),
        SurfaceAlt = Color3.fromRGB(36, 18, 18),
        Accent = Color3.fromRGB(220, 20, 20),
        AccentAlt = Color3.fromRGB(255, 80, 60),
        Text = Color3.fromRGB(255, 220, 220),
        TextDim = Color3.fromRGB(180, 120, 120),
        Border = Color3.fromRGB(220, 20, 20),
        Toggle = Color3.fromRGB(220, 20, 20),
        ToggleOff = Color3.fromRGB(60, 30, 30),
        Slider = Color3.fromRGB(255, 80, 60),
        Glow = Color3.fromRGB(220, 20, 20),
        TabActive = Color3.fromRGB(220, 20, 20),
        TabInactive = Color3.fromRGB(30, 14, 14),
        Notification = Color3.fromRGB(220, 20, 20),
    },
    ["Matrix Green"] = {
        Name = "Matrix Green",
        Background = Color3.fromRGB(5, 12, 5),
        Surface = Color3.fromRGB(10, 20, 10),
        SurfaceAlt = Color3.fromRGB(15, 30, 15),
        Accent = Color3.fromRGB(0, 220, 60),
        AccentAlt = Color3.fromRGB(0, 255, 120),
        Text = Color3.fromRGB(200, 255, 200),
        TextDim = Color3.fromRGB(100, 180, 100),
        Border = Color3.fromRGB(0, 220, 60),
        Toggle = Color3.fromRGB(0, 220, 60),
        ToggleOff = Color3.fromRGB(20, 50, 20),
        Slider = Color3.fromRGB(0, 255, 120),
        Glow = Color3.fromRGB(0, 220, 60),
        TabActive = Color3.fromRGB(0, 220, 60),
        TabInactive = Color3.fromRGB(10, 24, 10),
        Notification = Color3.fromRGB(0, 220, 60),
    },
    ["Purple Haze"] = {
        Name = "Purple Haze",
        Background = Color3.fromRGB(12, 8, 18),
        Surface = Color3.fromRGB(20, 14, 30),
        SurfaceAlt = Color3.fromRGB(30, 20, 45),
        Accent = Color3.fromRGB(160, 60, 255),
        AccentAlt = Color3.fromRGB(220, 120, 255),
        Text = Color3.fromRGB(230, 220, 255),
        TextDim = Color3.fromRGB(150, 130, 180),
        Border = Color3.fromRGB(160, 60, 255),
        Toggle = Color3.fromRGB(160, 60, 255),
        ToggleOff = Color3.fromRGB(50, 30, 70),
        Slider = Color3.fromRGB(220, 120, 255),
        Glow = Color3.fromRGB(160, 60, 255),
        TabActive = Color3.fromRGB(160, 60, 255),
        TabInactive = Color3.fromRGB(22, 16, 34),
        Notification = Color3.fromRGB(160, 60, 255),
    },
}

local CurrentTheme = Themes["Matrix Green"]
local ThemeUpdateCallbacks = {}

local function registerThemeCallback(callback)
    table.insert(ThemeUpdateCallbacks, callback)
end

local function applyTheme(themeName)
    if Themes[themeName] then
        CurrentTheme = Themes[themeName]
        for _, cb in ipairs(ThemeUpdateCallbacks) do
            pcall(cb, CurrentTheme)
        end
    end
end

-- ============================================================
-- SECTION 4: CUSTOM GUI LIBRARY
-- ============================================================
local CyberUI = {}
CyberUI.__index = CyberUI

-- Utility
local function safeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then return nil end
    return result
end

local function validateInstance(instance)
    return instance and typeof(instance) == "Instance" and instance.Parent ~= nil
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or CurrentTheme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.Parent = parent
    return stroke
end

local function createPadding(parent, top, bottom, left, right)
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, top or 4)
    padding.PaddingBottom = UDim.new(0, bottom or 4)
    padding.PaddingLeft = UDim.new(0, left or 8)
    padding.PaddingRight = UDim.new(0, right or 8)
    padding.Parent = parent
    return padding
end

local function createGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Rotation = rotation or 90
    gradient.Parent = parent
    return gradient
end

local function tweenProperty(obj, props, duration)
    local tween = TweenService:Create(obj, TweenInfo.new(duration or 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

-- ============================================================
-- NOTIFICATION SYSTEM (MOVED TO TOP)
-- ============================================================
local NotificationContainer

local function createNotificationContainer()
    if NotificationContainer and NotificationContainer.Parent then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CyberNotifications"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 100
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    NotificationContainer = Instance.new("Frame")
    NotificationContainer.Name = "Container"
    NotificationContainer.Size = UDim2.new(0, 320, 0, 300)
    NotificationContainer.Position = UDim2.new(0.5, -160, 0, 0)
    NotificationContainer.BackgroundTransparency = 1
    NotificationContainer.Parent = screenGui
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.VerticalAlignment = Enum.VerticalAlignment.Top
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = NotificationContainer
    
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)
    pad.Parent = NotificationContainer
end

local function notify(title, content, duration)
    createNotificationContainer()
    duration = duration or 3
    
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(1, 0, 0, 74)
    notif.BackgroundColor3 = CurrentTheme.Surface
    notif.BackgroundTransparency = 0.02
    notif.ClipsDescendants = true
    notif.Parent = NotificationContainer
    
    createCorner(notif, 10)
    
    local stroke = createStroke(notif, CurrentTheme.Notification, 1.5, 0.15)
    
    -- Glow overlay at top
    local glowOverlay = Instance.new("Frame")
    glowOverlay.Size = UDim2.new(1, 0, 0, 30)
    glowOverlay.Position = UDim2.new(0, 0, 0, 0)
    glowOverlay.BackgroundColor3 = CurrentTheme.Accent
    glowOverlay.BackgroundTransparency = 0.85
    glowOverlay.BorderSizePixel = 0
    glowOverlay.Parent = notif
    createGradient(glowOverlay, Color3.new(1,1,1), Color3.new(0,0,0), 90)
    
    -- Accent bar on left
    local accentBar = Instance.new("Frame")
    accentBar.Size = UDim2.new(0, 4, 1, -8)
    accentBar.Position = UDim2.new(0, 4, 0, 4)
    accentBar.BackgroundColor3 = CurrentTheme.Accent
    accentBar.BorderSizePixel = 0
    accentBar.Parent = notif
    createCorner(accentBar, 2)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -28, 0, 24)
    titleLabel.Position = UDim2.new(0, 18, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "⚡ " .. title
    titleLabel.TextColor3 = CurrentTheme.Accent
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notif
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, -28, 0, 30)
    contentLabel.Position = UDim2.new(0, 18, 0, 34)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = content
    contentLabel.TextColor3 = CurrentTheme.TextDim
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextSize = 12
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextWrapped = true
    contentLabel.Parent = notif
    
    -- Progress bar at bottom
    local progressBg = Instance.new("Frame")
    progressBg.Size = UDim2.new(1, -16, 0, 3)
    progressBg.Position = UDim2.new(0, 8, 1, -6)
    progressBg.BackgroundColor3 = CurrentTheme.ToggleOff
    progressBg.BorderSizePixel = 0
    progressBg.Parent = notif
    createCorner(progressBg, 2)
    
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    progressFill.BackgroundColor3 = CurrentTheme.Accent
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBg
    createCorner(progressFill, 2)
    
    -- Animate in from top (slide down)
    notif.Position = UDim2.new(0, 0, 0, -80)
    notif.Size = UDim2.new(1, 0, 0, 0)
    tweenProperty(notif, {Size = UDim2.new(1, 0, 0, 74), Position = UDim2.new(0, 0, 0, 0)}, 0.35)
    
    -- Progress bar animation
    tweenProperty(progressFill, {Size = UDim2.new(0, 0, 1, 0)}, duration)
    
    -- Auto remove
    task.delay(duration, function()
        if notif and notif.Parent then
            tweenProperty(notif, {Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1}, 0.3)
            task.wait(0.35)
            if notif and notif.Parent then
                notif:Destroy()
            end
        end
    end)
end

-- ============================================================
-- MAIN GUI WINDOW (LANDSCAPE)
-- ============================================================
function CyberUI.CreateWindow(config)
    local self = setmetatable({}, CyberUI)
    self.Tabs = {}
    self.ActiveTab = nil
    self.Elements = {}
    self.IsMinimized = false
    
    -- Main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CyberUI_ViolenceDistrict"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 50
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    self.ScreenGui = screenGui
    
    -- LANDSCAPE Main Frame (wider, shorter)
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = isMobile and UDim2.new(0, 520, 0, 320) or UDim2.new(0, 680, 0, 380)
    mainFrame.Position = UDim2.new(0.5, isMobile and -260 or -340, 0.5, isMobile and -160 or -190)
    mainFrame.BackgroundColor3 = CurrentTheme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    self.MainFrame = mainFrame
    
    createCorner(mainFrame, 12)
    local mainStroke = createStroke(mainFrame, CurrentTheme.Border, 2, 0.1)
    self.MainStroke = mainStroke
    
    -- Outer glow shadow effect
    local shadowFrame = Instance.new("ImageLabel")
    shadowFrame.Name = "Shadow"
    shadowFrame.Size = UDim2.new(1, 30, 1, 30)
    shadowFrame.Position = UDim2.new(0, -15, 0, -15)
    shadowFrame.BackgroundTransparency = 1
    shadowFrame.Image = "rbxassetid://6015897843"
    shadowFrame.ImageColor3 = CurrentTheme.Accent
    shadowFrame.ImageTransparency = 0.85
    shadowFrame.ScaleType = Enum.ScaleType.Slice
    shadowFrame.SliceCenter = Rect.new(49, 49, 450, 450)
    shadowFrame.ZIndex = 0
    shadowFrame.Parent = mainFrame
    self.ShadowFrame = shadowFrame
    
    -- Title Bar (improved with gradient)
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 44)
    titleBar.BackgroundColor3 = CurrentTheme.Surface
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    createCorner(titleBar, 12)
    
    -- Title bar gradient overlay
    local titleGradientOverlay = Instance.new("Frame")
    titleGradientOverlay.Size = UDim2.new(1, 0, 1, 0)
    titleGradientOverlay.BackgroundColor3 = CurrentTheme.Accent
    titleGradientOverlay.BackgroundTransparency = 0.92
    titleGradientOverlay.BorderSizePixel = 0
    titleGradientOverlay.Parent = titleBar
    createCorner(titleGradientOverlay, 12)
    createGradient(titleGradientOverlay, Color3.new(1,1,1), Color3.new(0,0,0), 0)
    self.TitleGradientOverlay = titleGradientOverlay
    
    -- Fix bottom corners of title bar
    local titleFix = Instance.new("Frame")
    titleFix.Size = UDim2.new(1, 0, 0, 14)
    titleFix.Position = UDim2.new(0, 0, 1, -14)
    titleFix.BackgroundColor3 = CurrentTheme.Surface
    titleFix.BorderSizePixel = 0
    titleFix.Parent = titleBar
    self.TitleBar = titleBar
    self.TitleFix = titleFix
    
    -- Accent line under title (thicker, with glow)
    local accentLine = Instance.new("Frame")
    accentLine.Size = UDim2.new(1, 0, 0, 2)
    accentLine.Position = UDim2.new(0, 0, 0, 44)
    accentLine.BackgroundColor3 = CurrentTheme.Accent
    accentLine.BorderSizePixel = 0
    accentLine.Parent = mainFrame
    self.AccentLine = accentLine
    
    -- Accent glow line (subtle glow below accent)
    local accentGlow = Instance.new("Frame")
    accentGlow.Size = UDim2.new(1, 0, 0, 8)
    accentGlow.Position = UDim2.new(0, 0, 0, 44)
    accentGlow.BackgroundColor3 = CurrentTheme.Accent
    accentGlow.BackgroundTransparency = 0.85
    accentGlow.BorderSizePixel = 0
    accentGlow.Parent = mainFrame
    self.AccentGlow = accentGlow
    
    -- Status indicator dot (animated pulse)
    local statusDot = Instance.new("Frame")
    statusDot.Size = UDim2.new(0, 8, 0, 8)
    statusDot.Position = UDim2.new(0, 14, 0.5, -4)
    statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    statusDot.BorderSizePixel = 0
    statusDot.Parent = titleBar
    createCorner(statusDot, 4)
    self.StatusDot = statusDot
    
    -- Pulse animation for status dot
    task.spawn(function()
        while statusDot and statusDot.Parent do
            tweenProperty(statusDot, {BackgroundTransparency = 0.6}, 0.8)
            task.wait(0.8)
            tweenProperty(statusDot, {BackgroundTransparency = 0}, 0.8)
            task.wait(0.8)
        end
    end)
    
    -- Title Text
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -120, 1, 0)
    titleText.Position = UDim2.new(0, 28, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = config.Name or "🎮"
    titleText.TextColor3 = CurrentTheme.Accent
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = isMobile and 14 or 16
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    self.TitleText = titleText
    
    -- Version badge
    local versionBadge = Instance.new("TextLabel")
    versionBadge.Size = UDim2.new(0, 40, 0, 18)
    versionBadge.Position = UDim2.new(1, -160, 0.5, -9)
    versionBadge.BackgroundColor3 = CurrentTheme.Accent
    versionBadge.BackgroundTransparency = 0.7
    versionBadge.Text = "v1"
    versionBadge.TextColor3 = CurrentTheme.Accent
    versionBadge.Font = Enum.Font.GothamBold
    versionBadge.TextSize = 10
    versionBadge.Parent = titleBar
    createCorner(versionBadge, 4)
    self.VersionBadge = versionBadge
    
    -- Minimize Button (improved)
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
    minimizeBtn.Position = UDim2.new(1, -76, 0, 6)
    minimizeBtn.BackgroundColor3 = CurrentTheme.SurfaceAlt
    minimizeBtn.Text = "—"
    minimizeBtn.TextColor3 = CurrentTheme.TextDim
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 16
    minimizeBtn.Parent = titleBar
    createCorner(minimizeBtn, 8)
    self.MinimizeBtn = minimizeBtn
    
    -- Close Button (improved)
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -40, 0, 6)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = titleBar
    createCorner(closeBtn, 8)
    self.CloseBtn = closeBtn
    
    -- Tab Container (Left sidebar - slightly wider for landscape)
    local tabWidth = isMobile and 50 or 150
    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, tabWidth, 1, -48)
    tabContainer.Position = UDim2.new(0, 0, 0, 46)
    tabContainer.BackgroundColor3 = CurrentTheme.Surface
    tabContainer.BorderSizePixel = 0
    tabContainer.ScrollBarThickness = 2
    tabContainer.ScrollBarImageColor3 = CurrentTheme.Accent
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabContainer.Parent = mainFrame
    self.TabContainer = tabContainer
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 3)
    tabLayout.Parent = tabContainer
    
    local tabPad = Instance.new("UIPadding")
    tabPad.PaddingTop = UDim.new(0, 6)
    tabPad.PaddingLeft = UDim.new(0, 5)
    tabPad.PaddingRight = UDim.new(0, 5)
    tabPad.PaddingBottom = UDim.new(0, 6)
    tabPad.Parent = tabContainer
    
    -- Separator line between tabs and content
    local tabSeparator = Instance.new("Frame")
    tabSeparator.Size = UDim2.new(0, 1, 1, -48)
    tabSeparator.Position = UDim2.new(0, tabWidth, 0, 46)
    tabSeparator.BackgroundColor3 = CurrentTheme.Accent
    tabSeparator.BackgroundTransparency = 0.7
    tabSeparator.BorderSizePixel = 0
    tabSeparator.Parent = mainFrame
    self.TabSeparator = tabSeparator
    
    -- Content Container (wider in landscape)
    local contentContainer = Instance.new("ScrollingFrame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, -(tabWidth + 6), 1, -48)
    contentContainer.Position = UDim2.new(0, tabWidth + 4, 0, 46)
    contentContainer.BackgroundColor3 = CurrentTheme.Background
    contentContainer.BorderSizePixel = 0
    contentContainer.ScrollBarThickness = 3
    contentContainer.ScrollBarImageColor3 = CurrentTheme.Accent
    contentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    contentContainer.Parent = mainFrame
    self.ContentContainer = contentContainer
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 5)
    contentLayout.Parent = contentContainer
    
    local contentPad = Instance.new("UIPadding")
    contentPad.PaddingTop = UDim.new(0, 8)
    contentPad.PaddingBottom = UDim.new(0, 12)
    contentPad.PaddingLeft = UDim.new(0, 10)
    contentPad.PaddingRight = UDim.new(0, 10)
    contentPad.Parent = contentContainer
    
    -- Dragging
    local dragging = false
    local dragInput, mousePos, framePos
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            mainFrame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Minimize functionality
    local originalSize = mainFrame.Size
    minimizeBtn.MouseButton1Click:Connect(function()
        self.IsMinimized = not self.IsMinimized
        if self.IsMinimized then
            tweenProperty(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 46)}, 0.3)
            minimizeBtn.Text = "+"
        else
            tweenProperty(mainFrame, {Size = originalSize}, 0.3)
            minimizeBtn.Text = "—"
        end
    end)
    
    -- Close functionality
    closeBtn.MouseButton1Click:Connect(function()
        tweenProperty(mainFrame, {Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 0), BackgroundTransparency = 1}, 0.4)
        task.wait(0.45)
        screenGui:Destroy()
    end)
    
    -- Hover effects for buttons (PC only)
    if not isMobile then
        minimizeBtn.MouseEnter:Connect(function()
            tweenProperty(minimizeBtn, {BackgroundColor3 = CurrentTheme.Accent}, 0.15)
            tweenProperty(minimizeBtn, {TextColor3 = Color3.new(1,1,1)}, 0.15)
        end)
        minimizeBtn.MouseLeave:Connect(function()
            tweenProperty(minimizeBtn, {BackgroundColor3 = CurrentTheme.SurfaceAlt}, 0.15)
            tweenProperty(minimizeBtn, {TextColor3 = CurrentTheme.TextDim}, 0.15)
        end)
        closeBtn.MouseEnter:Connect(function()
            tweenProperty(closeBtn, {BackgroundColor3 = Color3.fromRGB(220, 40, 40)}, 0.15)
        end)
        closeBtn.MouseLeave:Connect(function()
            tweenProperty(closeBtn, {BackgroundColor3 = Color3.fromRGB(180, 30, 30)}, 0.15)
        end)
    end
    
    -- Toggle keybind (RightShift or Home)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Enum.KeyCode.Home then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)
    
    -- Theme update registration
    registerThemeCallback(function(theme)
        mainFrame.BackgroundColor3 = theme.Background
        titleBar.BackgroundColor3 = theme.Surface
        titleFix.BackgroundColor3 = theme.Surface
        accentLine.BackgroundColor3 = theme.Accent
        accentGlow.BackgroundColor3 = theme.Accent
        titleText.TextColor3 = theme.Accent
        mainStroke.Color = theme.Border
        tabContainer.BackgroundColor3 = theme.Surface
        tabContainer.ScrollBarImageColor3 = theme.Accent
        contentContainer.BackgroundColor3 = theme.Background
        contentContainer.ScrollBarImageColor3 = theme.Accent
        minimizeBtn.BackgroundColor3 = theme.SurfaceAlt
        minimizeBtn.TextColor3 = theme.TextDim
        tabSeparator.BackgroundColor3 = theme.Accent
        shadowFrame.ImageColor3 = theme.Accent
        versionBadge.BackgroundColor3 = theme.Accent
        versionBadge.TextColor3 = theme.Accent
        titleGradientOverlay.BackgroundColor3 = theme.Accent
    end)
    
    return self
end

-- ============================================================
-- TAB CREATION
-- ============================================================
function CyberUI:CreateTab(name, icon)
    local tabData = {
        Name = name,
        Elements = {},
        ContentFrames = {},
    }
    
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = "Tab_" .. name
    tabBtn.Size = isMobile and UDim2.new(1, -4, 0, 38) or UDim2.new(1, -4, 0, 36)
    tabBtn.BackgroundColor3 = CurrentTheme.TabInactive
    tabBtn.Text = isMobile and (name:match("[\xE2-\xF4][\x80-\xBF]+") or name:sub(1, 2)) or name
    tabBtn.TextColor3 = CurrentTheme.TextDim
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = isMobile and 14 or 12
    tabBtn.TextTruncate = Enum.TextTruncate.AtEnd
    tabBtn.Parent = self.TabContainer
    
    createCorner(tabBtn, 8)
    
    tabData.Button = tabBtn
    
    -- Content page for this tab
    local contentPage = Instance.new("Frame")
    contentPage.Name = "Page_" .. name
    contentPage.Size = UDim2.new(1, 0, 0, 0)
    contentPage.AutomaticSize = Enum.AutomaticSize.Y
    contentPage.BackgroundTransparency = 1
    contentPage.Visible = false
    contentPage.Parent = self.ContentContainer
    
    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 5)
    pageLayout.Parent = contentPage
    
    tabData.ContentPage = contentPage
    
    -- Tab click handler
    tabBtn.MouseButton1Click:Connect(function()
        self:SwitchTab(tabData)
    end)
    
    -- Hover effects (PC only)
    if not isMobile then
        tabBtn.MouseEnter:Connect(function()
            if self.ActiveTab ~= tabData then
                tweenProperty(tabBtn, {BackgroundColor3 = CurrentTheme.SurfaceAlt}, 0.15)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if self.ActiveTab ~= tabData then
                tweenProperty(tabBtn, {BackgroundColor3 = CurrentTheme.TabInactive}, 0.15)
            end
        end)
    end
    
    table.insert(self.Tabs, tabData)
    
    -- Auto-select first tab
    if #self.Tabs == 1 then
        self:SwitchTab(tabData)
    end
    
    -- Theme update
    registerThemeCallback(function(theme)
        if self.ActiveTab == tabData then
            tabBtn.BackgroundColor3 = theme.TabActive
            tabBtn.TextColor3 = Color3.new(1, 1, 1)
        else
            tabBtn.BackgroundColor3 = theme.TabInactive
            tabBtn.TextColor3 = theme.TextDim
        end
    end)
    
    -- Return a tab interface for adding elements
    local tabInterface = {}
    tabInterface._data = tabData
    tabInterface._window = self
    
    function tabInterface:CreateSection(text)
        local section = Instance.new("Frame")
        section.Size = UDim2.new(1, 0, 0, 28)
        section.BackgroundTransparency = 1
        section.Parent = contentPage
        
        local sectionLabel = Instance.new("TextLabel")
        sectionLabel.Size = UDim2.new(1, 0, 1, 0)
        sectionLabel.BackgroundTransparency = 1
        sectionLabel.Text = "▸ " .. text:upper()
        sectionLabel.TextColor3 = CurrentTheme.Accent
        sectionLabel.Font = Enum.Font.GothamBold
        sectionLabel.TextSize = 11
        sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        sectionLabel.Parent = section
        
        local line = Instance.new("Frame")
        line.Size = UDim2.new(1, 0, 0, 1)
        line.Position = UDim2.new(0, 0, 1, -1)
        line.BackgroundColor3 = CurrentTheme.Accent
        line.BackgroundTransparency = 0.6
        line.BorderSizePixel = 0
        line.Parent = section
        
        registerThemeCallback(function(theme)
            sectionLabel.TextColor3 = theme.Accent
            line.BackgroundColor3 = theme.Accent
        end)
    end
    
    function tabInterface:CreateLabel(text)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 20)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = CurrentTheme.TextDim
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextWrapped = true
        label.Parent = contentPage
        
        registerThemeCallback(function(theme)
            label.TextColor3 = theme.TextDim
        end)
        
        return label
    end
    
    function tabInterface:CreateParagraph(config)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundColor3 = CurrentTheme.SurfaceAlt
        container.Parent = contentPage
        createCorner(container, 8)
        createStroke(container, CurrentTheme.Border, 1, 0.7)
        
        local pad = createPadding(container, 10, 10, 12, 12)
        
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 4)
        layout.Parent = container
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 18)
        title.BackgroundTransparency = 1
        title.Text = config.Title or ""
        title.TextColor3 = CurrentTheme.Accent
        title.Font = Enum.Font.GothamBold
        title.TextSize = 13
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = container
        
        local content = Instance.new("TextLabel")
        content.Size = UDim2.new(1, 0, 0, 0)
        content.AutomaticSize = Enum.AutomaticSize.Y
        content.BackgroundTransparency = 1
        content.Text = config.Content or ""
        content.TextColor3 = CurrentTheme.TextDim
        content.Font = Enum.Font.Gotham
        content.TextSize = 11
        content.TextXAlignment = Enum.TextXAlignment.Left
        content.TextWrapped = true
        content.Parent = container
        
        registerThemeCallback(function(theme)
            container.BackgroundColor3 = theme.SurfaceAlt
            title.TextColor3 = theme.Accent
            content.TextColor3 = theme.TextDim
        end)
    end
    
    function tabInterface:CreateToggle(config)
        local toggled = config.CurrentValue or false
        
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 34)
        container.BackgroundColor3 = CurrentTheme.SurfaceAlt
        container.Parent = contentPage
        createCorner(container, 8)
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -56, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = config.Name or "Toggle"
        label.TextColor3 = CurrentTheme.Text
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextTruncate = Enum.TextTruncate.AtEnd
        label.Parent = container
        
        local toggleBg = Instance.new("Frame")
        toggleBg.Size = UDim2.new(0, 42, 0, 22)
        toggleBg.Position = UDim2.new(1, -50, 0.5, -11)
        toggleBg.BackgroundColor3 = toggled and CurrentTheme.Toggle or CurrentTheme.ToggleOff
        toggleBg.BorderSizePixel = 0
        toggleBg.Parent = container
        createCorner(toggleBg, 11)
        
        local toggleCircle = Instance.new("Frame")
        toggleCircle.Size = UDim2.new(0, 18, 0, 18)
        toggleCircle.Position = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        toggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
        toggleCircle.BorderSizePixel = 0
        toggleCircle.Parent = toggleBg
        createCorner(toggleCircle, 9)
        
        -- Subtle shadow on toggle circle
        local circleShadow = Instance.new("ImageLabel")
        circleShadow.Size = UDim2.new(1, 6, 1, 6)
        circleShadow.Position = UDim2.new(0, -3, 0, -3)
        circleShadow.BackgroundTransparency = 1
        circleShadow.ImageTransparency = 0.7
        circleShadow.Image = "rbxassetid://6015897843"
        circleShadow.ImageColor3 = Color3.new(0, 0, 0)
        circleShadow.ScaleType = Enum.ScaleType.Slice
        circleShadow.SliceCenter = Rect.new(49, 49, 450, 450)
        circleShadow.ZIndex = 0
        circleShadow.Parent = toggleCircle
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(1, 0, 1, 0)
        toggleBtn.BackgroundTransparency = 1
        toggleBtn.Text = ""
        toggleBtn.Parent = container
        
        toggleBtn.MouseButton1Click:Connect(function()
            toggled = not toggled
            tweenProperty(toggleBg, {BackgroundColor3 = toggled and CurrentTheme.Toggle or CurrentTheme.ToggleOff}, 0.2)
            tweenProperty(toggleCircle, {Position = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, 0.2)
            if config.Callback then
                pcall(config.Callback, toggled)
            end
        end)
        
        registerThemeCallback(function(theme)
            container.BackgroundColor3 = theme.SurfaceAlt
            label.TextColor3 = theme.Text
            toggleBg.BackgroundColor3 = toggled and theme.Toggle or theme.ToggleOff
        end)
        
        return {
            Set = function(_, value)
                toggled = value
                tweenProperty(toggleBg, {BackgroundColor3 = toggled and CurrentTheme.Toggle or CurrentTheme.ToggleOff}, 0.2)
                tweenProperty(toggleCircle, {Position = toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}, 0.2)
            end
        }
    end
    
    function tabInterface:CreateButton(config)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 34)
        btn.BackgroundColor3 = CurrentTheme.SurfaceAlt
        btn.Text = config.Name or "Button"
        btn.TextColor3 = CurrentTheme.AccentAlt
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.Parent = contentPage
        createCorner(btn, 8)
        createStroke(btn, CurrentTheme.Accent, 1, 0.6)
        
        btn.MouseButton1Click:Connect(function()
            -- Flash effect
            tweenProperty(btn, {BackgroundColor3 = CurrentTheme.Accent}, 0.1)
            tweenProperty(btn, {TextColor3 = Color3.new(1, 1, 1)}, 0.1)
            task.wait(0.15)
            tweenProperty(btn, {BackgroundColor3 = CurrentTheme.SurfaceAlt}, 0.2)
            tweenProperty(btn, {TextColor3 = CurrentTheme.AccentAlt}, 0.2)
            
            if config.Callback then
                pcall(config.Callback)
            end
        end)
        
        -- Hover effects (PC only)
        if not isMobile then
            btn.MouseEnter:Connect(function()
                tweenProperty(btn, {BackgroundColor3 = CurrentTheme.Accent}, 0.15)
                tweenProperty(btn, {TextColor3 = Color3.new(1, 1, 1)}, 0.15)
            end)
            btn.MouseLeave:Connect(function()
                tweenProperty(btn, {BackgroundColor3 = CurrentTheme.SurfaceAlt}, 0.15)
                tweenProperty(btn, {TextColor3 = CurrentTheme.AccentAlt}, 0.15)
            end)
        end
        
        registerThemeCallback(function(theme)
            btn.BackgroundColor3 = theme.SurfaceAlt
            btn.TextColor3 = theme.AccentAlt
        end)
    end
    
    function tabInterface:CreateSlider(config)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 46)
        container.BackgroundColor3 = CurrentTheme.SurfaceAlt
        container.Parent = contentPage
        createCorner(container, 8)
        
        local minVal = config.Range[1]
        local maxVal = config.Range[2]
        local increment = config.Increment or 1
        local currentVal = config.CurrentValue or minVal
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -60, 0, 20)
        label.Position = UDim2.new(0, 12, 0, 2)
        label.BackgroundTransparency = 1
        label.Text = config.Name or "Slider"
        label.TextColor3 = CurrentTheme.Text
        label.Font = Enum.Font.Gotham
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 50, 0, 20)
        valueLabel.Position = UDim2.new(1, -58, 0, 2)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(currentVal)
        valueLabel.TextColor3 = CurrentTheme.AccentAlt
        valueLabel.Font = Enum.Font.GothamBold
        valueLabel.TextSize = 11
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = container
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, -24, 0, 6)
        sliderBg.Position = UDim2.new(0, 12, 0, 30)
        sliderBg.BackgroundColor3 = CurrentTheme.ToggleOff
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = container
        createCorner(sliderBg, 3)
        
        local fillPercent = (currentVal - minVal) / (maxVal - minVal)
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new(fillPercent, 0, 1, 0)
        sliderFill.BackgroundColor3 = CurrentTheme.Slider
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderBg
        createCorner(sliderFill, 3)
        
        local sliderKnob = Instance.new("Frame")
        sliderKnob.Size = UDim2.new(0, 14, 0, 14)
        sliderKnob.Position = UDim2.new(fillPercent, -7, 0.5, -7)
        sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
        sliderKnob.BorderSizePixel = 0
        sliderKnob.ZIndex = 2
        sliderKnob.Parent = sliderBg
        createCorner(sliderKnob, 7)
        
        -- Slider interaction
        local sliderBtn = Instance.new("TextButton")
        sliderBtn.Size = UDim2.new(1, 0, 0, 22)
        sliderBtn.Position = UDim2.new(0, 0, 0, 22)
        sliderBtn.BackgroundTransparency = 1
        sliderBtn.Text = ""
        sliderBtn.Parent = container
        
        local sliding = false
        
        local function updateSlider(inputPos)
            local relX = inputPos.X - sliderBg.AbsolutePosition.X
            local percent = math.clamp(relX / sliderBg.AbsoluteSize.X, 0, 1)
            local rawVal = minVal + (maxVal - minVal) * percent
            local snapped = math.floor(rawVal / increment + 0.5) * increment
            snapped = math.clamp(snapped, minVal, maxVal)
            
            -- Round to avoid floating point issues
            if increment >= 1 then
                snapped = math.floor(snapped)
            else
                snapped = tonumber(string.format("%.1f", snapped))
            end
            
            local newPercent = (snapped - minVal) / (maxVal - minVal)
            sliderFill.Size = UDim2.new(newPercent, 0, 1, 0)
            sliderKnob.Position = UDim2.new(newPercent, -7, 0.5, -7)
            valueLabel.Text = tostring(snapped)
            currentVal = snapped
            
            if config.Callback then
                pcall(config.Callback, snapped)
            end
        end
        
        sliderBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = true
                updateSlider(input.Position)
            end
        end)
        
        sliderBtn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateSlider(input.Position)
            end
        end)
        
        registerThemeCallback(function(theme)
            container.BackgroundColor3 = theme.SurfaceAlt
            label.TextColor3 = theme.Text
            valueLabel.TextColor3 = theme.AccentAlt
            sliderBg.BackgroundColor3 = theme.ToggleOff
            sliderFill.BackgroundColor3 = theme.Slider
        end)
    end
    
    function tabInterface:CreateDropdown(config)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(1, 0, 0, 34)
        container.BackgroundColor3 = CurrentTheme.SurfaceAlt
        container.ClipsDescendants = true
        container.Parent = contentPage
        createCorner(container, 8)
        
        local options = config.Options or {}
        local currentOption = config.CurrentOption or (options[1] or "")
        local isOpen = false
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.5, -5, 0, 34)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = config.Name or "Dropdown"
        label.TextColor3 = CurrentTheme.Text
        label.Font = Enum.Font.Gotham
        label.TextSize = 11
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container
        
        local dropBtn = Instance.new("TextButton")
        dropBtn.Size = UDim2.new(0.5, -10, 0, 28)
        dropBtn.Position = UDim2.new(0.5, 0, 0, 3)
        dropBtn.BackgroundColor3 = CurrentTheme.Background
        dropBtn.Text = currentOption .. " ▾"
        dropBtn.TextColor3 = CurrentTheme.AccentAlt
        dropBtn.Font = Enum.Font.GothamBold
        dropBtn.TextSize = 11
        dropBtn.Parent = container
        createCorner(dropBtn, 6)
        
        -- Option buttons (hidden initially)
        local optionFrames = {}
        for i, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, -12, 0, 28)
            optBtn.Position = UDim2.new(0, 6, 0, 34 + (i - 1) * 30)
            optBtn.BackgroundColor3 = CurrentTheme.Background
            optBtn.Text = opt
            optBtn.TextColor3 = CurrentTheme.TextDim
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 11
            optBtn.Parent = container
            createCorner(optBtn, 6)
            
            optBtn.MouseButton1Click:Connect(function()
                currentOption = opt
                dropBtn.Text = opt .. " ▾"
                isOpen = false
                tweenProperty(container, {Size = UDim2.new(1, 0, 0, 34)}, 0.2)
                if config.Callback then
                    pcall(config.Callback, opt)
                end
            end)
            
            if not isMobile then
                optBtn.MouseEnter:Connect(function()
                    tweenProperty(optBtn, {BackgroundColor3 = CurrentTheme.Accent}, 0.1)
                    optBtn.TextColor3 = Color3.new(1, 1, 1)
                end)
                optBtn.MouseLeave:Connect(function()
                    tweenProperty(optBtn, {BackgroundColor3 = CurrentTheme.Background}, 0.1)
                    optBtn.TextColor3 = CurrentTheme.TextDim
                end)
            end
            
            table.insert(optionFrames, optBtn)
        end
        
        dropBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            local targetHeight = isOpen and (34 + #options * 30 + 6) or 34
            tweenProperty(container, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.25)
            dropBtn.Text = currentOption .. (isOpen and " ▴" or " ▾")
        end)
        
        registerThemeCallback(function(theme)
            container.BackgroundColor3 = theme.SurfaceAlt
            label.TextColor3 = theme.Text
            dropBtn.BackgroundColor3 = theme.Background
            dropBtn.TextColor3 = theme.AccentAlt
            for _, optBtn in ipairs(optionFrames) do
                optBtn.BackgroundColor3 = theme.Background
                optBtn.TextColor3 = theme.TextDim
            end
        end)
    end
    
    return tabInterface
end

function CyberUI:SwitchTab(tabData)
    -- Deactivate all tabs
    for _, tab in ipairs(self.Tabs) do
        tab.ContentPage.Visible = false
        tweenProperty(tab.Button, {BackgroundColor3 = CurrentTheme.TabInactive}, 0.2)
        tab.Button.TextColor3 = CurrentTheme.TextDim
    end
    
    -- Activate selected tab
    tabData.ContentPage.Visible = true
    tweenProperty(tabData.Button, {BackgroundColor3 = CurrentTheme.TabActive}, 0.2)
    tabData.Button.TextColor3 = Color3.new(1, 1, 1)
    self.ActiveTab = tabData
    
    -- Reset scroll position
    self.ContentContainer.CanvasPosition = Vector2.new(0, 0)
end

function CyberUI:Destroy()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

-- ============================================================
-- SECTION 5: CONFIGURATION
-- ============================================================
local Config = {
    ESP = {
        Killer = false,
        Survivor = false,
        Generator = false,
        Gate = false,
        Hook = false,
        Pallet = false,
        Window = false,
        Pumpkin = false,
        ClosestHook = false,
        ShowOnlyClosestHook = false,
        ShowDistance = true,
        MaxDistance = 500
    },
    AutoFeatures = {
        AutoGenerator = false,
        GeneratorMode = "great",
        AutoLeaveGenerator = false,
        LeaveDistance = 15,
        LeaveKeybind = Enum.KeyCode.Q,
        AutoAttack = false,
        AttackRange = 10
    },
    Teleportation = {
        TeleportOffset = 3,
        SafeTeleport = true,
        TeleportDelay = 0.1
    },
    Performance = {
        UpdateRate = 0.5,
        UseDistanceCulling = true,
        MaxESPObjects = isMobile and 50 or 100,
        DisableParticles = false,
        LowerGraphics = false,
        DisableShadows = false,
        ReduceRenderDistance = false
    },
    Mobile = {
        TouchControlsEnabled = isMobile,
        ButtonSize = 80,
        ButtonTransparency = 0.3,
        AutoOptimize = true,
        AggressiveOptimization = false
    }
}

-- ============================================================
-- SECTION 6: STORAGE & HELPERS
-- ============================================================
local Highlights = {}
local BillboardGuis = {}
local LastUpdate = 0
local UpdateConnection = nil
local LeaveGeneratorConnection = nil
local AutoAttackConnection = nil
local ClosestHookHighlight = nil
local MobileUI = nil
local FPSCounterEnabled = false
local FPSCounterUI = nil

local function isKiller()
    return LocalPlayer.Team and LocalPlayer.Team.Name == "Killer"
end

local function isSurvivor()
    return LocalPlayer.Team and LocalPlayer.Team.Name == "Survivors"
end

-- ============================================================
-- SECTION 7: PERFORMANCE OPTIMIZATION
-- ============================================================
local function applyMobileOptimizations()
    if not isMobile then return end
    local lighting = game:GetService("Lighting")
    safeCall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        lighting.GlobalShadows = false
        lighting.FogEnd = 100
        lighting.Brightness = 2
        for _, effect in ipairs(lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = false end
        end
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") then obj.Enabled = false
            elseif obj:IsA("Trail") then obj.Enabled = false
            elseif obj:IsA("Beam") then obj.Enabled = false
            elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then obj.Enabled = false
            end
        end
        Workspace.StreamingEnabled = true
        Workspace.StreamingMinRadius = 32
        Workspace.StreamingTargetRadius = 64
        if Workspace:FindFirstChild("Terrain") then
            Workspace.Terrain.Decoration = false
        end
    end)
end

local function applyAggressiveMobileOptimizations()
    if not isMobile then return end
    applyMobileOptimizations()
    safeCall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Texture") or obj:IsA("Decal") then obj.Transparency = 1
            elseif obj:IsA("SurfaceAppearance") then obj.Parent = nil
            end
        end
        Config.Performance.UpdateRate = 1.0
        Config.Performance.MaxESPObjects = 25
    end)
end

local function applyPerformanceSettings()
    local lighting = game:GetService("Lighting")
    if Config.Performance.DisableParticles then
        safeCall(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then obj.Enabled = false end
            end
        end)
    end
    if Config.Performance.LowerGraphics then
        safeCall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    end
    if Config.Performance.DisableShadows then
        safeCall(function() lighting.GlobalShadows = false; lighting.FogEnd = 100 end)
    end
    if Config.Performance.ReduceRenderDistance then
        safeCall(function()
            Workspace.StreamingEnabled = true
            Workspace.StreamingMinRadius = 32
            Workspace.StreamingTargetRadius = 64
        end)
    end
end

local function resetPerformanceSettings()
    local lighting = game:GetService("Lighting")
    safeCall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then obj.Enabled = true end
        end
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        lighting.GlobalShadows = true
        lighting.FogEnd = 100000
        for _, effect in ipairs(lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = true end
        end
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Texture") or obj:IsA("Decal") then obj.Transparency = 0 end
        end
    end)
end

-- ============================================================
-- SECTION 8: TELEPORTATION HELPERS
-- ============================================================
local function getCharacterRootPart()
    if not LocalPlayer.Character then return nil end
    return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function isNearGenerator()
    local hrp = getCharacterRootPart()
    if not hrp then return false, nil end
    local map = Workspace:FindFirstChild("Map")
    if not map then return false, nil end
    local nearestGen, nearestDist = nil, math.huge
    for _, obj in ipairs(map:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Generator" then
            local genPart = obj:FindFirstChildWhichIsA("BasePart")
            if genPart then
                local distance = (genPart.Position - hrp.Position).Magnitude
                if distance < nearestDist then
                    nearestDist = distance
                    nearestGen = obj
                end
            end
        end
    end
    if nearestGen and nearestDist <= Config.AutoFeatures.LeaveDistance then
        return true, nearestGen, nearestDist
    end
    return false, nil, nil
end

local function safeTeleport(targetCFrame, offset)
    local hrp = getCharacterRootPart()
    if not hrp then
        notify("Error", "Character not found", 3)
        return false
    end
    offset = offset or Vector3.new(0, Config.Teleportation.TeleportOffset, 0)
    if Config.Teleportation.SafeTeleport then
        safeCall(function()
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    end
    hrp.CFrame = targetCFrame + offset
    if Config.Teleportation.SafeTeleport then
        task.delay(0.5, function()
            safeCall(function()
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
                end
            end)
        end)
    end
    return true
end

local function leaveGenerator()
    local hrp = getCharacterRootPart()
    if not hrp then return false end
    local isNear, nearestGen, distance = isNearGenerator()
    if not isNear then
        notify("Not Near", "You're not near any generator", 2)
        return false
    end
    local genPart = nearestGen:FindFirstChildWhichIsA("BasePart")
    if genPart then
        local direction = (hrp.Position - genPart.Position).Unit
        local escapeDistance = Config.AutoFeatures.LeaveDistance + 15
        local escapePosition = hrp.Position + (direction * escapeDistance)
        local escapeCFrame = CFrame.new(escapePosition, escapePosition + hrp.CFrame.LookVector)
        if safeTeleport(escapeCFrame, Vector3.new(0, 2, 0)) then
            notify("Escaped!", string.format("Moved %.0f studs away", escapeDistance), 2)
            return true
        end
    end
    return false
end

local function getAllGenerators()
    local generators = {}
    local map = Workspace:FindFirstChild("Map")
    if not map then return generators end
    for _, obj in ipairs(map:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Generator" then
            local genPart = obj:FindFirstChildWhichIsA("BasePart")
            if genPart then
                table.insert(generators, { model = obj, part = genPart, position = genPart.Position })
            end
        end
    end
    return generators
end

local function getGeneratorsByDistance()
    local hrp = getCharacterRootPart()
    if not hrp then return {} end
    local generators = getAllGenerators()
    for _, gen in ipairs(generators) do
        gen.distance = (gen.position - hrp.Position).Magnitude
    end
    table.sort(generators, function(a, b) return a.distance < b.distance end)
    return generators
end

-- ============================================================
-- SECTION 9: AUTO LEAVE & AUTO ATTACK
-- ============================================================
local function startAutoLeaveGenerator()
    if LeaveGeneratorConnection then return end
    if not isMobile then
        LeaveGeneratorConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Config.AutoFeatures.LeaveKeybind then
                leaveGenerator()
            end
        end)
        notify("Auto Leave", string.format("Press %s to leave generator", Config.AutoFeatures.LeaveKeybind.Name), 3)
    else
        notify("Mobile Mode", "Use the LEAVE button to escape generators", 3)
    end
end

local function stopAutoLeaveGenerator()
    if LeaveGeneratorConnection then
        LeaveGeneratorConnection:Disconnect()
        LeaveGeneratorConnection = nil
    end
    notify("Auto Leave", "Disabled", 2)
end

local function findClosestSurvivor()
    if not isKiller() then return nil, nil end
    local hrp = getCharacterRootPart()
    if not hrp then return nil, nil end
    local closestPlayer, closestDist = nil, math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team and player.Team.Name == "Survivors" and player.Character then
            local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local dist = (targetHRP.Position - hrp.Position).Magnitude
                if dist < closestDist and dist <= Config.AutoFeatures.AttackRange then
                    closestDist = dist
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer, closestDist
end

local function performAutoAttack()
    if not isKiller() then return end
    local target, distance = findClosestSurvivor()
    if not target then return end
    safeCall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            local attacks = remotes:FindFirstChild("Attacks")
            if attacks then
                local basicAttack = attacks:FindFirstChild("BasicAttack")
                if basicAttack then basicAttack:FireServer(false) end
            end
        end
    end)
end

local function startAutoAttack()
    if AutoAttackConnection then return end
    if not isKiller() then
        notify("Error", "You must be the Killer to use Auto Attack!", 3)
        return
    end
    AutoAttackConnection = RunService.Heartbeat:Connect(function()
        if Config.AutoFeatures.AutoAttack then performAutoAttack() end
    end)
    notify("Auto Attack", string.format("Enabled - Range: %d studs", Config.AutoFeatures.AttackRange), 3)
end

local function stopAutoAttack()
    if AutoAttackConnection then
        AutoAttackConnection:Disconnect()
        AutoAttackConnection = nil
    end
    notify("Auto Attack", "Disabled", 2)
end

-- ============================================================
-- SECTION 10: ESP FUNCTIONS
-- ============================================================
local function createHighlight(obj, color)
    if not validateInstance(obj) then return end
    if obj:FindFirstChild("H") then return end
    safeCall(function()
        local h = Instance.new("Highlight")
        h.Name = "H"
        h.Adornee = obj
        h.FillColor = color
        h.OutlineColor = color
        h.FillTransparency = 0.5
        h.OutlineTransparency = 0
        h.Parent = obj
        Highlights[obj] = h
    end)
end

local function removeHighlight(obj)
    if Highlights[obj] then
        safeCall(function()
            if validateInstance(Highlights[obj]) then Highlights[obj]:Destroy() end
        end)
        Highlights[obj] = nil
    end
    local existingH = obj:FindFirstChild("H")
    if existingH then existingH:Destroy() end
end

local function createLabel(obj, text, color)
    if not validateInstance(obj) then return end
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local rootPart = obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") or (obj:IsA("BasePart") and obj or nil)
    if not rootPart then return end
    local playerRoot = LocalPlayer.Character.HumanoidRootPart
    local distance = (playerRoot.Position - rootPart.Position).Magnitude
    if Config.Performance.UseDistanceCulling and distance > Config.ESP.MaxDistance then
        if BillboardGuis[obj] then
            safeCall(function()
                if validateInstance(BillboardGuis[obj]) then BillboardGuis[obj]:Destroy() end
            end)
            BillboardGuis[obj] = nil
        end
        return
    end
    if BillboardGuis[obj] and validateInstance(BillboardGuis[obj]) then
        local textLabel = BillboardGuis[obj]:FindFirstChild("TextLabel")
        if textLabel and Config.ESP.ShowDistance then
            textLabel.Text = string.format("%s\n%.0fm", text, distance)
        elseif textLabel then
            textLabel.Text = text
        end
        return
    end
    safeCall(function()
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Adornee = rootPart
        billboard.Parent = obj
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = color
        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextScaled = true
        textLabel.Text = Config.ESP.ShowDistance and string.format("%s\n%.0fm", text, distance) or text
        textLabel.Parent = billboard
        BillboardGuis[obj] = billboard
    end)
end

local function removeLabel(obj)
    if BillboardGuis[obj] then
        safeCall(function()
            if validateInstance(BillboardGuis[obj]) then BillboardGuis[obj]:Destroy() end
        end)
        BillboardGuis[obj] = nil
    end
end

local function clearAllESP()
    for obj, _ in pairs(Highlights) do removeHighlight(obj) end
    for obj, _ in pairs(BillboardGuis) do removeLabel(obj) end
    Highlights = {}
    BillboardGuis = {}
end

local function updatePlayerESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Team then
            local teamName = player.Team.Name
            if teamName == "Killer" and Config.ESP.Killer then
                createHighlight(player.Character, Color3.fromRGB(255, 0, 0))
                createLabel(player.Character, player.Name .. "\n[KILLER]", Color3.fromRGB(255, 0, 0))
            elseif teamName == "Survivors" and Config.ESP.Survivor then
                createHighlight(player.Character, Color3.fromRGB(0, 255, 0))
                createLabel(player.Character, player.Name .. "\n[SURVIVOR]", Color3.fromRGB(0, 255, 0))
            else
                removeHighlight(player.Character)
                removeLabel(player.Character)
            end
        end
    end
end

local function updateGeneratorESP()
    if not Config.ESP.Generator then return end
    safeCall(function()
        local map = Workspace:FindFirstChild("Map")
        if not map then return end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Generator" then
                createHighlight(obj, Color3.fromRGB(203, 132, 66))
                createLabel(obj, "Generator", Color3.fromRGB(203, 132, 66))
            end
        end
    end)
end

local function updateGateESP()
    if not Config.ESP.Gate then return end
    safeCall(function()
        local map = Workspace:FindFirstChild("Map")
        if not map then return end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Gate" then
                createHighlight(obj, Color3.fromRGB(255, 255, 255))
                createLabel(obj, "Gate", Color3.fromRGB(255, 255, 255))
            end
        end
    end)
end

local function updateHookESP()
    if not Config.ESP.Hook then return end
    safeCall(function()
        local map = Workspace:FindFirstChild("Map")
        if not map then return end
        if Config.ESP.ShowOnlyClosestHook then
            local hrp = getCharacterRootPart()
            if not hrp then return end
            local closestHook, closestDist = nil, math.huge
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Hook" then
                    local hookPart = obj:FindFirstChildWhichIsA("BasePart")
                    if hookPart then
                        local dist = (hookPart.Position - hrp.Position).Magnitude
                        if dist < closestDist then closestDist = dist; closestHook = obj end
                    end
                end
            end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Hook" then
                    removeHighlight(obj); removeLabel(obj)
                end
            end
            if closestHook then
                if closestHook:FindFirstChild("Model") then
                    for _, part in ipairs(closestHook.Model:GetDescendants()) do
                        if part:IsA("MeshPart") then createHighlight(part, Color3.fromRGB(255, 255, 0)) end
                    end
                end
                createLabel(closestHook, "CLOSEST HOOK", Color3.fromRGB(255, 255, 0))
            end
        else
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Hook" then
                    if obj:FindFirstChild("Model") then
                        for _, part in ipairs(obj.Model:GetDescendants()) do
                            if part:IsA("MeshPart") then createHighlight(part, Color3.fromRGB(255, 0, 0)) end
                        end
                    end
                    createLabel(obj, "Hook", Color3.fromRGB(255, 0, 0))
                end
            end
        end
    end)
end

local function updatePalletESP()
    if not Config.ESP.Pallet then return end
    safeCall(function()
        local map = Workspace:FindFirstChild("Map")
        if not map then return end
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Palletwrong" then
                createHighlight(obj, Color3.fromRGB(255, 255, 0))
                createLabel(obj, "Pallet", Color3.fromRGB(255, 255, 0))
            end
        end
    end)
end

local function updateWindowESP()
    if not Config.ESP.Window then return end
    safeCall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Window" then
                createHighlight(obj, Color3.fromRGB(173, 216, 230))
                createLabel(obj, "Window", Color3.fromRGB(173, 216, 230))
            end
        end
    end)
end

local function updatePumpkinESP()
    if not Config.ESP.Pumpkin then return end
    safeCall(function()
        local map = Workspace:FindFirstChild("Map")
        if not map then return end
        local pumpkins = map:FindFirstChild("Pumpkins")
        if not pumpkins then return end
        for _, obj in ipairs(pumpkins:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:find("Pumpkin") then
                createHighlight(obj, Color3.fromRGB(255, 140, 0))
                createLabel(obj, "Pumpkin", Color3.fromRGB(255, 140, 0))
            end
        end
    end)
end

local function updateAllESP()
    local currentTime = tick()
    if currentTime - LastUpdate < Config.Performance.UpdateRate then return end
    LastUpdate = currentTime
    local espCount = 0
    for obj, h in pairs(Highlights) do
        if not validateInstance(obj) or not validateInstance(h) then Highlights[obj] = nil
        else espCount = espCount + 1 end
    end
    for obj, gui in pairs(BillboardGuis) do
        if not validateInstance(obj) or not validateInstance(gui) then BillboardGuis[obj] = nil end
    end
    if espCount >= Config.Performance.MaxESPObjects then return end
    updatePlayerESP()
    updateGeneratorESP()
    updateGateESP()
    updateHookESP()
    updatePalletESP()
    updateWindowESP()
    updatePumpkinESP()
end

local function startESP()
    if UpdateConnection then return end
    UpdateConnection = RunService.Heartbeat:Connect(updateAllESP)
    notify("ESP", "All ESP features activated", 2)
end

local function stopESP()
    if UpdateConnection then UpdateConnection:Disconnect(); UpdateConnection = nil end
    clearAllESP()
    notify("ESP", "All ESP disabled", 2)
end

-- ============================================================
-- SECTION 11: MOBILE CONTROLS
-- ============================================================
local function createMobileControls()
    if not isMobile then return end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MobileControls"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local leaveButton = Instance.new("TextButton")
    leaveButton.Name = "LeaveGenerator"
    leaveButton.Size = UDim2.new(0, Config.Mobile.ButtonSize, 0, Config.Mobile.ButtonSize)
    leaveButton.Position = UDim2.new(1, -100, 0.5, -40)
    leaveButton.BackgroundColor3 = CurrentTheme.Accent
    leaveButton.BackgroundTransparency = Config.Mobile.ButtonTransparency
    leaveButton.Text = "LEAVE"
    leaveButton.TextColor3 = Color3.new(1, 1, 1)
    leaveButton.TextScaled = true
    leaveButton.Font = Enum.Font.GothamBold
    leaveButton.Parent = screenGui
    createCorner(leaveButton, 10)
    
    leaveButton.MouseButton1Click:Connect(function() leaveGenerator() end)
    
    local tpButton = Instance.new("TextButton")
    tpButton.Name = "TeleportGen"
    tpButton.Size = UDim2.new(0, Config.Mobile.ButtonSize, 0, Config.Mobile.ButtonSize)
    tpButton.Position = UDim2.new(1, -100, 0.5, 60)
    tpButton.BackgroundColor3 = CurrentTheme.AccentAlt
    tpButton.BackgroundTransparency = Config.Mobile.ButtonTransparency
    tpButton.Text = "TP GEN"
    tpButton.TextColor3 = Color3.new(1, 1, 1)
    tpButton.TextScaled = true
    tpButton.Font = Enum.Font.GothamBold
    tpButton.Parent = screenGui
    createCorner(tpButton, 10)
    
    tpButton.MouseButton1Click:Connect(function()
        local generators = getGeneratorsByDistance()
        if #generators > 0 then
            safeTeleport(generators[1].part.CFrame)
            notify("Teleported!", "Moved to closest generator", 2)
        end
    end)
    
    local success = pcall(function()
        screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end)
    if success then
        notify("Mobile Controls", "Touch controls enabled!", 3)
        MobileUI = screenGui
    end
end

-- ============================================================
-- SECTION 12: FPS COUNTER
-- ============================================================
local function createFPSCounter()
    if FPSCounterUI then return end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FPSCounter"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 120, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = CurrentTheme.Surface
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    createCorner(frame, 8)
    createStroke(frame, CurrentTheme.Accent, 1, 0.5)
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1, 0, 1, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    fpsLabel.TextStrokeTransparency = 0
    fpsLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 18
    fpsLabel.Parent = frame
    
    -- Dragging
    local dragging = false
    local dragInput, mousePos, framePos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; mousePos = input.Position; framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
    
    local lastTime = tick()
    local frameCount = 0
    RunService.Heartbeat:Connect(function()
        if not FPSCounterEnabled then return end
        frameCount = frameCount + 1
        local currentTime = tick()
        if currentTime - lastTime >= 1.5 then
            local fps = math.floor(frameCount / (currentTime - lastTime))
            frameCount = 0; lastTime = currentTime
            if fps >= 60 then fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            elseif fps >= 30 then fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            else fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0) end
            fpsLabel.Text = string.format("FPS: %d", fps)
        end
    end)
    
    pcall(function() screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)
    FPSCounterUI = screenGui
    FPSCounterEnabled = true
    notify("FPS Counter", "Enabled - Drag to move!", 3)
end

local function removeFPSCounter()
    if FPSCounterUI then FPSCounterUI:Destroy(); FPSCounterUI = nil; FPSCounterEnabled = false end
end

-- ============================================================
-- SECTION 13: CREATE THE WINDOW & TABS
-- ============================================================
local Window = CyberUI.CreateWindow({
    Name = "Admin Panel | VIOLENCE DISTRICT"
})

-- ===================== CREDITS TAB =====================
local CreditsTab = Window:CreateTab("ℹ️ Credits")
CreditsTab:CreateSection("DEVELOPER")
CreditsTab:CreateLabel("Created by: Sobing4413")
CreditsTab:CreateLabel("Version: 1.0")
CreditsTab:CreateLabel("")
CreditsTab:CreateLabel("🌟 Thank you for using my script!")

CreditsTab:CreateSection("DISCORD COMMUNITY")
CreditsTab:CreateLabel("Join for updates, support & more!")
CreditsTab:CreateLabel("Discord: discord.gg/CnNqEVFxh6")

CreditsTab:CreateButton({
    Name = "📋 Copy Discord Invite Link",
    Callback = function()
        local success = pcall(function() setclipboard("https://discord.gg/CnNqEVFxh6") end)
        if success then
            notify("Copied!", "discord.gg/CnNqEVFxh6 copied to clipboard!", 4)
        else
            notify("Discord", "discord.gg/CnNqEVFxh6 - Copy manually!", 5)
        end
    end
})

CreditsTab:CreateSection("SCRIPT INFO")
CreditsTab:CreateLabel("Game: Violence District")
CreditsTab:CreateLabel("Platform: " .. (isMobile and "📱 Mobile" or "💻 PC"))
CreditsTab:CreateLabel("Executor: " .. executorName)
CreditsTab:CreateLabel("UI: Modern Landscape")

CreditsTab:CreateParagraph({
    Title = "✨ What's New in v1",
    Content = "✅ Custom Modern GUI\n✅ 5 Theme Options\n✅ No External UI Dependencies\n✅ Smoother Animations\n✅ Better Mobile Support\n✅ All Original Features"
})

CreditsTab:CreateParagraph({
    Title = "All Features",
    Content = "• Player & Object ESP\n• Auto-Complete Generators\n• Smart Auto Attack (Killer)\n• Quick Leave Generator\n• Advanced Teleportation\n• Performance Boost\n• Killer Powers\n• Touch Controls\n• Theme Customization"
})

-- ===================== ESP TAB =====================
local ESPTab = Window:CreateTab("👁️ ESP")
ESPTab:CreateSection("PLAYER ESP")

ESPTab:CreateToggle({
    Name = "Killer ESP (Red)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Killer = Value
        if Value then startESP()
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Team and player.Team.Name == "Killer" then
                    removeHighlight(player.Character); removeLabel(player.Character)
                end
            end
        end
    end
})

ESPTab:CreateToggle({
    Name = "Survivor ESP (Green)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Survivor = Value
        if Value then startESP()
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Team and player.Team.Name == "Survivors" then
                    removeHighlight(player.Character); removeLabel(player.Character)
                end
            end
        end
    end
})

ESPTab:CreateSection("OBJECT ESP")

ESPTab:CreateToggle({
    Name = "Generator ESP (Orange)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Generator = Value
        if Value then startESP()
        else
            local map = Workspace:FindFirstChild("Map")
            if map then
                for _, obj in ipairs(map:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name == "Generator" then
                        removeHighlight(obj); removeLabel(obj)
                    end
                end
            end
        end
    end
})

ESPTab:CreateToggle({
    Name = "Gate ESP (White)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Gate = Value
        if Value then startESP() end
    end
})

ESPTab:CreateToggle({
    Name = "Hook ESP (Red)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Hook = Value
        if Value then startESP()
        else
            local map = Workspace:FindFirstChild("Map")
            if map then
                for _, obj in ipairs(map:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name == "Hook" then
                        removeHighlight(obj); removeLabel(obj)
                    end
                end
            end
        end
    end
})

ESPTab:CreateToggle({
    Name = "Show Only Closest Hook",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.ShowOnlyClosestHook = Value
        local map = Workspace:FindFirstChild("Map")
        if map then
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Hook" then
                    removeHighlight(obj); removeLabel(obj)
                end
            end
        end
        if Config.ESP.Hook then updateHookESP() end
        notify("Hook ESP", Value and "Showing only closest hook" or "Showing all hooks", 2)
    end
})

ESPTab:CreateToggle({
    Name = "Pallet ESP (Yellow)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Pallet = Value
        if Value then startESP() end
    end
})

ESPTab:CreateToggle({
    Name = "Window ESP (Light Blue)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Window = Value
        if Value then startESP() end
    end
})

ESPTab:CreateToggle({
    Name = "Pumpkin ESP (Orange)",
    CurrentValue = false,
    Callback = function(Value)
        Config.ESP.Pumpkin = Value
        if Value then startESP() end
    end
})

ESPTab:CreateSection("ESP SETTINGS")

ESPTab:CreateToggle({
    Name = "Show Distance",
    CurrentValue = true,
    Callback = function(Value) Config.ESP.ShowDistance = Value end
})

ESPTab:CreateSlider({
    Name = "Max Distance",
    Range = {100, 1000},
    Increment = 50,
    CurrentValue = 500,
    Callback = function(Value) Config.ESP.MaxDistance = Value end
})

ESPTab:CreateSlider({
    Name = "Update Rate (seconds)",
    Range = {0.1, 2},
    Increment = 0.1,
    CurrentValue = 0.5,
    Callback = function(Value) Config.Performance.UpdateRate = Value end
})

ESPTab:CreateSlider({
    Name = "Max ESP Objects",
    Range = {25, 500},
    Increment = 25,
    CurrentValue = isMobile and 50 or 100,
    Callback = function(Value) Config.Performance.MaxESPObjects = Value end
})

-- ===================== GAMEPLAY TAB =====================
local GameplayTab = Window:CreateTab("🎮 Gameplay")
GameplayTab:CreateSection("AUTO FEATURES")

GameplayTab:CreateToggle({
    Name = "Auto Complete Generators",
    CurrentValue = false,
    Callback = function(Value)
        Config.AutoFeatures.AutoGenerator = Value
        notify("Auto Generator", Value and "Enabled" or "Disabled", 2)
    end
})

GameplayTab:CreateDropdown({
    Name = "Generator Mode",
    Options = {"Great (Fast)", "Normal (Slow)"},
    CurrentOption = "Great (Fast)",
    Callback = function(Option)
        Config.AutoFeatures.GeneratorMode = Option == "Great (Fast)" and "great" or "normal"
    end
})

GameplayTab:CreateSection("QUICK ESCAPE")

GameplayTab:CreateToggle({
    Name = "Enable Quick Leave Generator",
    CurrentValue = false,
    Callback = function(Value)
        Config.AutoFeatures.AutoLeaveGenerator = Value
        if Value then startAutoLeaveGenerator() else stopAutoLeaveGenerator() end
    end
})

if not isMobile then
    GameplayTab:CreateDropdown({
        Name = "Leave Keybind",
        Options = {"Q", "E", "F", "G", "X", "Z", "V", "B"},
        CurrentOption = "Q",
        Callback = function(Option)
            local keyMap = {
                Q = Enum.KeyCode.Q, E = Enum.KeyCode.E, F = Enum.KeyCode.F,
                G = Enum.KeyCode.G, X = Enum.KeyCode.X, Z = Enum.KeyCode.Z,
                V = Enum.KeyCode.V, B = Enum.KeyCode.B
            }
            Config.AutoFeatures.LeaveKeybind = keyMap[Option]
            if Config.AutoFeatures.AutoLeaveGenerator then
                stopAutoLeaveGenerator(); startAutoLeaveGenerator()
            end
            notify("Keybind", "Leave key set to: " .. Option, 2)
        end
    })
end

GameplayTab:CreateSlider({
    Name = "Detection Range (studs)",
    Range = {5, 30},
    Increment = 1,
    CurrentValue = 15,
    Callback = function(Value) Config.AutoFeatures.LeaveDistance = Value end
})

GameplayTab:CreateButton({
    Name = "⚡ Leave Generator Now",
    Callback = function() leaveGenerator() end
})

GameplayTab:CreateSection("MANUAL ACTIONS")

GameplayTab:CreateButton({
    Name = "⚡ Complete All Generators (Instant)",
    Callback = function()
        local map = Workspace:FindFirstChild("Map")
        if not map then notify("Error", "Map not found", 3); return end
        local completed = 0
        safeCall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if not remotes then return end
            local genRemotes = remotes:FindFirstChild("Generator")
            if not genRemotes then return end
            local repairEvent = genRemotes:FindFirstChild("RepairEvent")
            local skillCheckEvent = genRemotes:FindFirstChild("SkillCheckResultEvent")
            if not repairEvent or not skillCheckEvent then return end
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Generator" then
                    for _, point in ipairs(obj:GetChildren()) do
                        if point.Name:find("GeneratorPoint") then
                            pcall(function()
                                for i = 1, 10 do
                                    repairEvent:FireServer(point, true)
                                    skillCheckEvent:FireServer("success", 1, obj, point)
                                end
                                completed = completed + 1
                            end)
                        end
                    end
                end
            end
        end)
        if completed > 0 then
            notify("Complete!", string.format("Completed %d generator(s)", completed), 4)
        else
            notify("Failed", "Could not find generators", 3)
        end
    end
})

GameplayTab:CreateSection("KILLER POWERS")

GameplayTab:CreateToggle({
    Name = "Auto Attack Nearby Survivors",
    CurrentValue = false,
    Callback = function(Value)
        Config.AutoFeatures.AutoAttack = Value
        if Value then startAutoAttack() else stopAutoAttack() end
    end
})

GameplayTab:CreateSlider({
    Name = "Auto Attack Range (studs)",
    Range = {5, 20},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(Value) Config.AutoFeatures.AttackRange = Value end
})

GameplayTab:CreateButton({
    Name = "⚡ Activate Killer Power",
    Callback = function()
        safeCall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local killerRemotes = remotes:FindFirstChild("Killers")
                if killerRemotes then
                    local killerFolder = killerRemotes:FindFirstChild("Killer")
                    if killerFolder then
                        local activatePower = killerFolder:FindFirstChild("ActivatePower")
                        if activatePower then
                            activatePower:FireServer()
                            notify("Power", "Killer power triggered", 2)
                        end
                    end
                end
            end
        end)
    end
})

GameplayTab:CreateButton({
    Name = "⚡ Basic Attack (Killer)",
    Callback = function()
        safeCall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            if remotes then
                local attacks = remotes:FindFirstChild("Attacks")
                if attacks then
                    local basicAttack = attacks:FindFirstChild("BasicAttack")
                    if basicAttack then
                        basicAttack:FireServer(false)
                        notify("Attack", "Basic attack executed", 2)
                    end
                end
            end
        end)
    end
})

-- ===================== TELEPORT TAB =====================
local TeleportTab = Window:CreateTab("🚀 Teleport")
TeleportTab:CreateSection("GENERATOR TELEPORTATION")

TeleportTab:CreateButton({
    Name = "⚡ TP to Closest Generator",
    Callback = function()
        local generators = getGeneratorsByDistance()
        if #generators == 0 then notify("Not Found", "No generators found", 3); return end
        local closest = generators[1]
        if safeTeleport(closest.part.CFrame) then
            notify("Teleported!", string.format("Closest generator (%.0fm)", closest.distance), 3)
        end
    end
})

TeleportTab:CreateButton({
    Name = "⚡ TP to Farthest Generator",
    Callback = function()
        local generators = getGeneratorsByDistance()
        if #generators == 0 then notify("Not Found", "No generators found", 3); return end
        local farthest = generators[#generators]
        if safeTeleport(farthest.part.CFrame) then
            notify("Teleported!", string.format("Farthest generator (%.0fm)", farthest.distance), 3)
        end
    end
})

TeleportTab:CreateButton({
    Name = "⚡ TP Through All Generators",
    Callback = function()
        local generators = getGeneratorsByDistance()
        if #generators == 0 then notify("Not Found", "No generators found", 3); return end
        notify("Starting", string.format("Teleporting through %d generators...", #generators), 3)
        task.spawn(function()
            for i, gen in ipairs(generators) do
                if not getCharacterRootPart() then break end
                safeTeleport(gen.part.CFrame)
                notify("Generator " .. i, string.format("At %d/%d (%.0fm)", i, #generators, gen.distance), 2)
                task.wait(Config.Teleportation.TeleportDelay)
            end
            notify("Complete!", "Visited all generators", 3)
        end)
    end
})

TeleportTab:CreateButton({
    Name = "📋 Show Generator List (Console)",
    Callback = function()
        local generators = getGeneratorsByDistance()
        if #generators == 0 then notify("Not Found", "No generators found", 3); return end
        print("\n=== GENERATOR LIST ===")
        for i, gen in ipairs(generators) do
            print(string.format("%d. Generator at %.0fm - Position: %s", i, gen.distance, tostring(gen.position)))
        end
        print("======================\n")
        notify("List Printed", string.format("Found %d generators - Check console (F9)", #generators), 3)
    end
})

TeleportTab:CreateSection("OTHER TELEPORTS")

TeleportTab:CreateButton({
    Name = "⚡ TP to Nearest Gate",
    Callback = function()
        local hrp = getCharacterRootPart()
        if not hrp then notify("Error", "Character not found", 3); return end
        local map = Workspace:FindFirstChild("Map")
        if not map then notify("Error", "Map not found", 3); return end
        local nearestGate, nearestDist = nil, math.huge
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Gate" then
                local gatePart = obj:FindFirstChildWhichIsA("BasePart")
                if gatePart then
                    local dist = (gatePart.Position - hrp.Position).Magnitude
                    if dist < nearestDist then nearestGate = gatePart; nearestDist = dist end
                end
            end
        end
        if nearestGate then
            safeTeleport(nearestGate.CFrame)
            notify("Teleported", string.format("Gate (%.0fm)", nearestDist), 3)
        else
            notify("Not Found", "No gates found", 3)
        end
    end
})

TeleportTab:CreateSection("SURVIVOR WIN")

TeleportTab:CreateButton({
    Name = "🏃 Escape Game (Survivor Only)",
    Callback = function()
        if not isSurvivor() then notify("Error", "You must be a Survivor!", 3); return end
        local hrp = getCharacterRootPart()
        if not hrp then notify("Error", "Character not found", 3); return end
        local map = Workspace:FindFirstChild("Map")
        if not map then notify("Error", "Map not found", 3); return end
        local gate = nil
        for _, obj in ipairs(map:GetDescendants()) do
            if obj:IsA("Model") and obj.Name == "Gate" then gate = obj; break end
        end
        if not gate then notify("Error", "No gates found", 3); return end
        local escapeZone = gate:FindFirstChild("Escape") or gate:FindFirstChildWhichIsA("BasePart")
        if escapeZone then
            safeTeleport(escapeZone.CFrame, Vector3.new(0, 5, 0))
            task.wait(0.5)
            safeCall(function()
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if remotes then
                    local gateRemote = remotes:FindFirstChild("Gate")
                    if gateRemote then
                        local escapeEvent = gateRemote:FindFirstChild("Escape")
                        if escapeEvent then escapeEvent:FireServer() end
                    end
                end
            end)
            notify("Escape!", "Teleported to exit - Walk through!", 4)
        else
            notify("Error", "Could not find escape zone", 3)
        end
    end
})

TeleportTab:CreateSection("TELEPORT SETTINGS")

TeleportTab:CreateSlider({
    Name = "Teleport Height Offset",
    Range = {0, 10},
    Increment = 1,
    CurrentValue = 3,
    Callback = function(Value) Config.Teleportation.TeleportOffset = Value end
})

TeleportTab:CreateSlider({
    Name = "Multi-Teleport Delay (sec)",
    Range = {0.1, 5},
    Increment = 0.1,
    CurrentValue = 0.1,
    Callback = function(Value) Config.Teleportation.TeleportDelay = Value end
})

TeleportTab:CreateToggle({
    Name = "Safe Teleport (No Collision)",
    CurrentValue = true,
    Callback = function(Value) Config.Teleportation.SafeTeleport = Value end
})

-- ===================== SETTINGS TAB =====================
local SettingsTab = Window:CreateTab("⚙️ Settings")
SettingsTab:CreateSection("THEME SELECTION")

SettingsTab:CreateDropdown({
    Name = "🎨 Select Theme",
    Options = {"Modern", "Neon Blue", "Blood Red", "Matrix Green", "Purple Haze"},
    CurrentOption = "Modern",
    Callback = function(Option)
        applyTheme(Option)
        notify("Theme Changed", "Applied: " .. Option, 3)
    end
})

SettingsTab:CreateSection("PERFORMANCE OPTIONS")

SettingsTab:CreateToggle({
    Name = "Disable Particles & Effects",
    CurrentValue = false,
    Callback = function(Value)
        Config.Performance.DisableParticles = Value
        applyPerformanceSettings()
        notify("Performance", Value and "Particles disabled" or "Particles enabled", 2)
    end
})

SettingsTab:CreateToggle({
    Name = "Lower Graphics Quality",
    CurrentValue = false,
    Callback = function(Value)
        Config.Performance.LowerGraphics = Value
        applyPerformanceSettings()
        notify("Performance", Value and "Graphics lowered" or "Graphics reset", 2)
    end
})

SettingsTab:CreateToggle({
    Name = "Disable Shadows",
    CurrentValue = false,
    Callback = function(Value)
        Config.Performance.DisableShadows = Value
        applyPerformanceSettings()
        notify("Performance", Value and "Shadows disabled" or "Shadows enabled", 2)
    end
})

SettingsTab:CreateToggle({
    Name = "Reduce Render Distance",
    CurrentValue = false,
    Callback = function(Value)
        Config.Performance.ReduceRenderDistance = Value
        applyPerformanceSettings()
        notify("Performance", Value and "Render distance reduced" or "Normal", 2)
    end
})

SettingsTab:CreateToggle({
    Name = "Use Distance Culling (ESP)",
    CurrentValue = true,
    Callback = function(Value)
        Config.Performance.UseDistanceCulling = Value
        notify("Performance", Value and "Culling enabled" or "Culling disabled", 2)
    end
})

SettingsTab:CreateButton({
    Name = "🚀 Apply All Performance Boosts",
    Callback = function()
        Config.Performance.DisableParticles = true
        Config.Performance.LowerGraphics = true
        Config.Performance.DisableShadows = true
        Config.Performance.ReduceRenderDistance = true
        Config.Performance.UseDistanceCulling = true
        applyPerformanceSettings()
        notify("Performance", "All boosts applied!", 3)
    end
})

SettingsTab:CreateButton({
    Name = "🔄 Reset Performance Settings",
    Callback = function()
        Config.Performance.DisableParticles = false
        Config.Performance.LowerGraphics = false
        Config.Performance.DisableShadows = false
        Config.Performance.ReduceRenderDistance = false
        resetPerformanceSettings()
        notify("Performance", "Settings reset", 2)
    end
})

if isMobile then
    SettingsTab:CreateSection("📱 MOBILE CONTROLS")
    
    SettingsTab:CreateToggle({
        Name = "Enable Touch Controls",
        CurrentValue = true,
        Callback = function(Value)
            Config.Mobile.TouchControlsEnabled = Value
            if Value and not MobileUI then createMobileControls()
            elseif not Value and MobileUI then MobileUI:Destroy(); MobileUI = nil end
        end
    })
    
    SettingsTab:CreateSlider({
        Name = "Button Size",
        Range = {60, 120},
        Increment = 10,
        CurrentValue = 80,
        Callback = function(Value)
            Config.Mobile.ButtonSize = Value
            if MobileUI then MobileUI:Destroy(); createMobileControls() end
        end
    })
    
    SettingsTab:CreateSlider({
        Name = "Button Transparency",
        Range = {0, 0.8},
        Increment = 0.1,
        CurrentValue = 0.3,
        Callback = function(Value)
            Config.Mobile.ButtonTransparency = Value
            if MobileUI then
                for _, button in ipairs(MobileUI:GetChildren()) do
                    if button:IsA("TextButton") then button.BackgroundTransparency = Value end
                end
            end
        end
    })
    
    SettingsTab:CreateSection("📱 MOBILE PERFORMANCE")
    
    SettingsTab:CreateToggle({
        Name = "Auto Mobile Optimization",
        CurrentValue = true,
        Callback = function(Value)
            Config.Mobile.AutoOptimize = Value
            if Value then applyMobileOptimizations(); notify("Mobile", "Optimizations applied!", 3)
            else resetPerformanceSettings(); notify("Mobile", "Optimizations reset", 2) end
        end
    })
    
    SettingsTab:CreateToggle({
        Name = "🔥 ULTRA Performance Mode",
        CurrentValue = false,
        Callback = function(Value)
            Config.Mobile.AggressiveOptimization = Value
            if Value then
                applyAggressiveMobileOptimizations()
                notify("ULTRA MODE", "Maximum FPS boost!", 4)
            else
                resetPerformanceSettings()
                if Config.Mobile.AutoOptimize then applyMobileOptimizations() end
                notify("ULTRA MODE", "Disabled", 2)
            end
        end
    })
    
    SettingsTab:CreateButton({
        Name = "🚀 Apply All Mobile Optimizations",
        Callback = function()
            Config.Performance.DisableParticles = true
            Config.Performance.LowerGraphics = true
            Config.Performance.DisableShadows = true
            Config.Performance.ReduceRenderDistance = true
            Config.Performance.UseDistanceCulling = true
            Config.Performance.UpdateRate = 1.0
            Config.Performance.MaxESPObjects = 25
            applyAggressiveMobileOptimizations()
            notify("ALL OPTIMIZATIONS", "Maximum mobile performance! 🚀", 5)
        end
    })
    
    SettingsTab:CreateButton({
        Name = "🔄 Reset All Optimizations",
        Callback = function()
            Config.Performance.DisableParticles = false
            Config.Performance.LowerGraphics = false
            Config.Performance.DisableShadows = false
            Config.Performance.ReduceRenderDistance = false
            Config.Performance.UpdateRate = 0.5
            Config.Performance.MaxESPObjects = 50
            Config.Mobile.AutoOptimize = false
            Config.Mobile.AggressiveOptimization = false
            resetPerformanceSettings()
            notify("Reset", "All settings restored", 3)
        end
    })
end

SettingsTab:CreateSection("DISPLAY")

SettingsTab:CreateToggle({
    Name = "Show FPS Counter",
    CurrentValue = false,
    Callback = function(Value)
        if Value then createFPSCounter() else removeFPSCounter(); notify("FPS Counter", "Disabled", 2) end
    end
})

SettingsTab:CreateSection("SCRIPT CONTROLS")

SettingsTab:CreateButton({
    Name = "🗑️ Clear All ESP",
    Callback = function() clearAllESP(); notify("Cleared", "All ESP cleared", 2) end
})

SettingsTab:CreateButton({
    Name = "🔄 Refresh ESP",
    Callback = function() clearAllESP(); updateAllESP(); notify("Refreshed", "ESP refreshed", 2) end
})

SettingsTab:CreateButton({
    Name = "❌ Unload Script",
    Callback = function()
        stopESP(); clearAllESP(); stopAutoLeaveGenerator(); stopAutoAttack()
        resetPerformanceSettings(); removeFPSCounter()
        if MobileUI then MobileUI:Destroy() end
        Window:Destroy()
        notify("Unloaded", "Script unloaded - Goodbye!", 2)
    end
})

-- ============================================================
-- SECTION 14: AUTO GENERATOR LOOP
-- ============================================================
task.spawn(function()
    while task.wait(0.2) do
        if Config.AutoFeatures.AutoGenerator then
            safeCall(function()
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                if not remotes then return end
                local genRemotes = remotes:FindFirstChild("Generator")
                if not genRemotes then return end
                local repairEvent = genRemotes:FindFirstChild("RepairEvent")
                local skillCheckEvent = genRemotes:FindFirstChild("SkillCheckResultEvent")
                if not repairEvent or not skillCheckEvent then return end
                local map = Workspace:FindFirstChild("Map")
                if not map then return end
                for _, obj in ipairs(map:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name == "Generator" then
                        for _, point in ipairs(obj:GetChildren()) do
                            if point.Name:find("GeneratorPoint") then
                                pcall(function()
                                    repairEvent:FireServer(point, true)
                                    local result = Config.AutoFeatures.GeneratorMode == "great" and "success" or "neutral"
                                    local value = Config.AutoFeatures.GeneratorMode == "great" and 1 or 0
                                    skillCheckEvent:FireServer(result, value, obj, point)
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ============================================================
-- SECTION 15: INITIALIZE
-- ============================================================
if isMobile then
    task.wait(1)
    createMobileControls()
    if Config.Mobile.AutoOptimize then
        task.wait(0.5)
        applyMobileOptimizations()
        notify("Mobile Mode", "Auto-optimizations applied!", 4)
    end
end