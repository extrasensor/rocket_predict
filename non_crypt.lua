--[[
    ╔══════════════════════════════════════════╗
    ║     🚀 ROCKET PREDICT KEY SYSTEM 🚀     ║
    ║          Premium Ultra Edition           ║
    ╚══════════════════════════════════════════╝
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Проверка устройства
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local deviceType = isMobile and "Mobile" or "PC"

-- Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RocketPredictKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Защита GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = game:GetService("CoreGui")
end

-- Функция создания Tween
local function Tween(object, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local tween = TweenService:Create(object, TweenInfo.new(duration, style, direction), properties)
    tween:Play()
    return tween
end

-- Функция копирования
local function copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
        return true
    elseif syn and syn.write_clipboard then
        syn.write_clipboard(text)
        return true
    elseif Clipboard and Clipboard.set then
        Clipboard.set(text)
        return true
    end
    return false
end

-- ═══════════════════════════════════════════
-- ПОЛНОЭКРАННЫЙ АНИМИРОВАННЫЙ ФОН
-- ═══════════════════════════════════════════

local FullBackground = Instance.new("Frame")
FullBackground.Name = "FullBackground"
FullBackground.Size = UDim2.new(1, 0, 1, 0)
FullBackground.Position = UDim2.new(0, 0, 0, 0)
FullBackground.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
FullBackground.BorderSizePixel = 0
FullBackground.BackgroundTransparency = 0.3
FullBackground.Parent = ScreenGui

-- Размытие фона
local BackgroundBlur = Instance.new("Frame")
BackgroundBlur.Size = UDim2.new(1, 0, 1, 0)
BackgroundBlur.BackgroundTransparency = 1
BackgroundBlur.Parent = FullBackground

-- Создание минималистичных звёзд
local stars = {}
for i = 1, 25 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, 2, 0, 2)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(120, 150, 220)
    star.BackgroundTransparency = math.random(60, 80) / 100
    star.BorderSizePixel = 0
    star.Parent = BackgroundBlur

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = star

    table.insert(stars, star)

    -- Плавное мерцание
    spawn(function()
        while star.Parent do
            Tween(star, {BackgroundTransparency = math.random(40, 90) / 100}, math.random(30, 50) / 10, Enum.EasingStyle.Sine)
            task.wait(math.random(30, 50) / 10)
        end
    end)
end

-- Создание 3 больших плавных градиентных волн
local waves = {}
for i = 1, 3 do
    local wave = Instance.new("Frame")
    wave.Size = UDim2.new(0, math.random(500, 700), 0, math.random(500, 700))
    wave.Position = UDim2.new(math.random(-30, 130) / 100, 0, math.random(-30, 130) / 100, 0)
    wave.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    wave.BackgroundTransparency = 0.95
    wave.BorderSizePixel = 0
    wave.Parent = BackgroundBlur

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = wave

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 120, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 80, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 80, 150))
    }
    gradient.Rotation = math.random(0, 360)
    gradient.Parent = wave

    table.insert(waves, wave)

    -- Очень медленное плавное движение
    spawn(function()
        while wave.Parent do
            local targetPos = UDim2.new(
                math.random(-30, 130) / 100, 0,
                math.random(-30, 130) / 100, 0
            )
            Tween(wave, {Position = targetPos}, math.random(20, 30), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            Tween(gradient, {Rotation = gradient.Rotation + math.random(20, 40)}, math.random(20, 30), Enum.EasingStyle.Sine)
            task.wait(math.random(20, 30))
        end
    end)
end

-- Интерактивность с мышью - волны следуют за курсором
local mouseFollower = Instance.new("Frame")
mouseFollower.Size = UDim2.new(0, 300, 0, 300)
mouseFollower.AnchorPoint = Vector2.new(0.5, 0.5)
mouseFollower.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
mouseFollower.BackgroundTransparency = 0.96
mouseFollower.BorderSizePixel = 0
mouseFollower.Parent = BackgroundBlur

local followerCorner = Instance.new("UICorner")
followerCorner.CornerRadius = UDim.new(1, 0)
followerCorner.Parent = mouseFollower

local followerGradient = Instance.new("UIGradient")
followerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 150, 255))
}
followerGradient.Parent = mouseFollower

-- Следование за мышью
RunService.RenderStepped:Connect(function()
    local mousePos = UserInputService:GetMouseLocation()
    local screenSize = ScreenGui.AbsoluteSize

    Tween(mouseFollower, {
        Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
    }, 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    -- Вращение градиента
    followerGradient.Rotation = (followerGradient.Rotation + 0.5) % 360
end)

-- Эффект клика - волны от клика
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()

        -- Создаём волну от клика
        for i = 1, 3 do
            local ripple = Instance.new("Frame")
            ripple.Size = UDim2.new(0, 20, 0, 20)
            ripple.Position = UDim2.new(0, mousePos.X - 10, 0, mousePos.Y - 10)
            ripple.AnchorPoint = Vector2.new(0.5, 0.5)
            ripple.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
            ripple.BackgroundTransparency = 0.3
            ripple.BorderSizePixel = 0
            ripple.Parent = BackgroundBlur

            local rippleCorner = Instance.new("UICorner")
            rippleCorner.CornerRadius = UDim.new(1, 0)
            rippleCorner.Parent = ripple

            task.delay(i * 0.1, function()
                Tween(ripple, {
                    Size = UDim2.new(0, 200, 0, 200),
                    BackgroundTransparency = 1
                }, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

                task.delay(1, function()
                    ripple:Destroy()
                end)
            end)
        end

        -- Пульсация звёзд при клике
        for _, star in ipairs(stars) do
            Tween(star, {
                BackgroundTransparency = 0.2,
                Size = UDim2.new(0, 4, 0, 4)
            }, 0.2)
            task.delay(0.2, function()
                Tween(star, {
                    BackgroundTransparency = math.random(60, 80) / 100,
                    Size = UDim2.new(0, 2, 0, 2)
                }, 0.5)
            end)
        end

        -- Пульсация волн
        for _, wave in ipairs(waves) do
            Tween(wave, {BackgroundTransparency = 0.85}, 0.2)
            task.delay(0.2, function()
                Tween(wave, {BackgroundTransparency = 0.95}, 0.8)
            end)
        end
    end
end)

-- ═══════════════════════════════════════════
-- ЭКРАН ВЫБОРА УСТРОЙСТВА
-- ═══════════════════════════════════════════

local DeviceSelectFrame = Instance.new("Frame")
DeviceSelectFrame.Name = "DeviceSelectFrame"
DeviceSelectFrame.Size = UDim2.new(1, 0, 1, 0)
DeviceSelectFrame.BackgroundTransparency = 1
DeviceSelectFrame.Parent = ScreenGui
DeviceSelectFrame.ZIndex = 10

-- Заголовок
local DeviceTitle = Instance.new("TextLabel")
DeviceTitle.Size = UDim2.new(0, 500, 0, 60)
DeviceTitle.Position = UDim2.new(0.5, -250, 0.35, -30)
DeviceTitle.BackgroundTransparency = 1
DeviceTitle.Text = "🖥️ ВЫБЕРИТЕ УСТРОЙСТВО"
DeviceTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
DeviceTitle.TextSize = isMobile and 24 or 36
DeviceTitle.Font = Enum.Font.GothamBold
DeviceTitle.ZIndex = 11
DeviceTitle.Parent = DeviceSelectFrame

local DeviceTitleGradient = Instance.new("UIGradient")
DeviceTitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
}
DeviceTitleGradient.Parent = DeviceTitle

local DeviceSubtitle = Instance.new("TextLabel")
DeviceSubtitle.Size = UDim2.new(0, 500, 0, 30)
DeviceSubtitle.Position = UDim2.new(0.5, -250, 0.35, 35)
DeviceSubtitle.BackgroundTransparency = 1
DeviceSubtitle.Text = "SELECT YOUR DEVICE"
DeviceSubtitle.TextColor3 = Color3.fromRGB(150, 180, 255)
DeviceSubtitle.TextSize = isMobile and 12 or 18
DeviceSubtitle.Font = Enum.Font.Gotham
DeviceSubtitle.ZIndex = 11
DeviceSubtitle.Parent = DeviceSelectFrame

-- Контейнер кнопок
local DeviceButtonsContainer = Instance.new("Frame")
DeviceButtonsContainer.Size = UDim2.new(0, isMobile and 300 or 520, 0, isMobile and 220 or 100)
DeviceButtonsContainer.Position = UDim2.new(0.5, isMobile and -150 or -260, 0.5, isMobile and -110 or -50)
DeviceButtonsContainer.BackgroundTransparency = 1
DeviceButtonsContainer.ZIndex = 11
DeviceButtonsContainer.Parent = DeviceSelectFrame

-- Функция создания кнопки устройства
local function createDeviceButton(text, icon, position, color1, color2)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, isMobile and 280 or 240, 0, isMobile and 90 or 80)
    button.Position = position
    button.BackgroundColor3 = color1
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false
    button.ZIndex = 12
    button.Parent = DeviceButtonsContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = button

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    }
    gradient.Rotation = 45
    gradient.Parent = button

    -- Светящаяся рамка
    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(1, 4, 1, 4)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundColor3 = color1
    glow.BackgroundTransparency = 0.5
    glow.BorderSizePixel = 0
    glow.ZIndex = 11
    glow.Parent = button

    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 15)
    glowCorner.Parent = glow

    -- Иконка
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, isMobile and 45 or 50, 0, isMobile and 45 or 50)
    iconLabel.Position = UDim2.new(0, isMobile and 15 or 20, 0.5, isMobile and -22 or -25)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextSize = isMobile and 28 or 32
    iconLabel.ZIndex = 13
    iconLabel.Parent = button

    -- Текст
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, isMobile and -75 or -85, 1, 0)
    label.Position = UDim2.new(0, isMobile and 65 or 75, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = isMobile and 16 or 22
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = button

    -- Hover эффект (только для ПК)
    if not isMobile then
        button.MouseEnter:Connect(function()
            Tween(button, {Size = UDim2.new(0, 250, 0, 85)}, 0.2)
            Tween(glow, {Size = UDim2.new(1, 10, 1, 10)}, 0.2)
        end)

        button.MouseLeave:Connect(function()
            Tween(button, {Size = UDim2.new(0, 240, 0, 80)}, 0.2)
            Tween(glow, {Size = UDim2.new(1, 4, 1, 4)}, 0.2)
        end)
    end

    return button
end

-- Кнопки
local PCDeviceButton = createDeviceButton(
    "💻 ПК / PC",
    "🖥️",
    UDim2.new(isMobile and 0.5 or 0, isMobile and -140 or 0, isMobile and 0 or 0.5, isMobile and 0 or -40),
    Color3.fromRGB(100, 150, 255),
    Color3.fromRGB(150, 100, 255)
)

local MobileDeviceButton = createDeviceButton(
    "📱 ТЕЛЕФОН / MOBILE",
    "📲",
    UDim2.new(isMobile and 0.5 or 1, isMobile and -140 or -240, isMobile and 0 or 0.5, isMobile and 110 or -40),
    Color3.fromRGB(255, 100, 200),
    Color3.fromRGB(255, 150, 100)
)

-- Авто-определение
local AutoDetect = Instance.new("TextLabel")
AutoDetect.Size = UDim2.new(0, 500, 0, 30)
AutoDetect.Position = UDim2.new(0.5, -250, 0.65, 0)
AutoDetect.BackgroundTransparency = 1
AutoDetect.Text = "✨ Обнаружено: " .. deviceType .. " / Detected: " .. deviceType
AutoDetect.TextColor3 = Color3.fromRGB(100, 255, 150)
AutoDetect.TextSize = isMobile and 11 or 14
AutoDetect.Font = Enum.Font.GothamMedium
AutoDetect.ZIndex = 11
AutoDetect.Parent = DeviceSelectFrame

-- ═══════════════════════════════════════════
-- ГЛАВНОЕ ОКНО
-- ═══════════════════════════════════════════

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = isMobile and UDim2.new(0.95, 0, 0, 420) or UDim2.new(0, 550, 0, 400)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Visible = false
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- Стеклянный эффект
local GlassEffect = Instance.new("Frame")
GlassEffect.Size = UDim2.new(1, 0, 1, 0)
GlassEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GlassEffect.BackgroundTransparency = 0.95
GlassEffect.BorderSizePixel = 0
GlassEffect.Parent = MainFrame

local GlassCorner = Instance.new("UICorner")
GlassCorner.CornerRadius = UDim.new(0, 20)
GlassCorner.Parent = GlassEffect

-- Неоновая светящаяся рамка (многослойная)
for i = 1, 3 do
    local GlowBorder = Instance.new("Frame")
    GlowBorder.Size = UDim2.new(1, 6 * i, 1, 6 * i)
    GlowBorder.Position = UDim2.new(0.5, 0, 0.5, 0)
    GlowBorder.AnchorPoint = Vector2.new(0.5, 0.5)
    GlowBorder.BackgroundTransparency = 0.3 + (i * 0.2)
    GlowBorder.BorderSizePixel = 0
    GlowBorder.ZIndex = -i
    GlowBorder.Parent = MainFrame

    local GlowCorner = Instance.new("UICorner")
    GlowCorner.CornerRadius = UDim.new(0, 20)
    GlowCorner.Parent = GlowBorder

    local GlowGradient = Instance.new("UIGradient")
    GlowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 150)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 150, 255)),
        ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 150))
    }
    GlowGradient.Parent = GlowBorder

    -- Постоянное вращение
    spawn(function()
        while GlowBorder.Parent do
            Tween(GlowGradient, {Rotation = 360}, 4 - i, Enum.EasingStyle.Linear)
            task.wait(4 - i)
            GlowGradient.Rotation = 0
        end
    end)
end

-- Внутренний градиент
local InnerGradient = Instance.new("UIGradient")
InnerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
}
InnerGradient.Rotation = 135
InnerGradient.Parent = MainFrame

-- ═══════════════════════════════════════════
-- ЛОГОТИП И ИКОНКА
-- ═══════════════════════════════════════════

local LogoContainer = Instance.new("Frame")
LogoContainer.Size = UDim2.new(0, 100, 0, 100)
LogoContainer.Position = UDim2.new(0.5, -50, 0, -30)
LogoContainer.BackgroundTransparency = 1
LogoContainer.Parent = MainFrame

-- Вращающийся круг за иконкой
local LogoCircle = Instance.new("Frame")
LogoCircle.Size = UDim2.new(1.2, 0, 1.2, 0)
LogoCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
LogoCircle.AnchorPoint = Vector2.new(0.5, 0.5)
LogoCircle.BackgroundTransparency = 0.5
LogoCircle.BorderSizePixel = 0
LogoCircle.Parent = LogoContainer

local LogoCircleCorner = Instance.new("UICorner")
LogoCircleCorner.CornerRadius = UDim.new(1, 0)
LogoCircleCorner.Parent = LogoCircle

local LogoGradient = Instance.new("UIGradient")
LogoGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200))
}
LogoGradient.Parent = LogoCircle

-- Вращение логотипа
spawn(function()
    while LogoCircle.Parent do
        Tween(LogoGradient, {Rotation = 360}, 3, Enum.EasingStyle.Linear)
        task.wait(3)
        LogoGradient.Rotation = 0
    end
end)

-- Иконка ракеты
local RocketIcon = Instance.new("TextLabel")
RocketIcon.Size = UDim2.new(1, 0, 1, 0)
RocketIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
RocketIcon.AnchorPoint = Vector2.new(0.5, 0.5)
RocketIcon.BackgroundTransparency = 1
RocketIcon.Text = "🚀"
RocketIcon.TextSize = 60
RocketIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
RocketIcon.ZIndex = 2
RocketIcon.Parent = LogoContainer

-- Пульсация ракеты
spawn(function()
    while RocketIcon.Parent do
        Tween(RocketIcon, {TextSize = 70}, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        task.wait(1)
        Tween(RocketIcon, {TextSize = 60}, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        task.wait(1)
    end
end)

-- ═══════════════════════════════════════════
-- ЗАГОЛОВКИ
-- ═══════════════════════════════════════════

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 20, 0, 90)
Title.BackgroundTransparency = 1
Title.Text = "ROCKET PREDICT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = isMobile and 24 or 36
Title.Font = Enum.Font.GothamBold
Title.TextStrokeTransparency = 0.5
Title.TextStrokeColor3 = Color3.fromRGB(100, 200, 255)
Title.Parent = MainFrame

-- Градиент для заголовка
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 255))
}
TitleGradient.Parent = Title

-- Анимация градиента заголовка
spawn(function()
    while Title.Parent do
        Tween(TitleGradient, {Rotation = 360}, 5, Enum.EasingStyle.Linear)
        task.wait(5)
        TitleGradient.Rotation = 0
    end
end)

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -40, 0, 25)
Subtitle.Position = UDim2.new(0, 20, 0, 135)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "KEY SYSTEM / СИСТЕМА КЛЮЧЕЙ"
Subtitle.TextColor3 = Color3.fromRGB(150, 180, 255)
Subtitle.TextSize = isMobile and 11 or 14
Subtitle.Font = Enum.Font.GothamBold
Subtitle.Parent = MainFrame

-- Линия разделитель
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0, 500, 0, 2)
Divider.Position = UDim2.new(0.5, -250, 0, 170)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

local DividerGradient = Instance.new("UIGradient")
DividerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
DividerGradient.Parent = Divider

-- ═══════════════════════════════════════════
-- ОПИСАНИЕ
-- ═══════════════════════════════════════════

local DescriptionFrame = Instance.new("Frame")
DescriptionFrame.Size = UDim2.new(1, -60, 0, 70)
DescriptionFrame.Position = UDim2.new(0, 30, 0, 185)
DescriptionFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
DescriptionFrame.BackgroundTransparency = 0.5
DescriptionFrame.BorderSizePixel = 0
DescriptionFrame.Parent = MainFrame

local DescCorner = Instance.new("UICorner")
DescCorner.CornerRadius = UDim.new(0, 12)
DescCorner.Parent = DescriptionFrame

local Description = Instance.new("TextLabel")
Description.Size = UDim2.new(1, -20, 1, -20)
Description.Position = UDim2.new(0, 10, 0, 10)
Description.BackgroundTransparency = 1
Description.Text = "🔗 Чтобы получить скрипт, нажмите кнопку ниже\n🌐 To get the script, click the button below\n\n✨ Ссылка будет скопирована автоматически!"
Description.TextColor3 = Color3.fromRGB(200, 220, 255)
Description.TextSize = 13
Description.Font = Enum.Font.Gotham
Description.TextWrapped = true
Description.TextYAlignment = Enum.TextYAlignment.Top
Description.Parent = DescriptionFrame

-- ═══════════════════════════════════════════
-- КНОПКА ПОЛУЧЕНИЯ КЛЮЧА
-- ═══════════════════════════════════════════

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0, 490, 0, 55)
GetKeyButton.Position = UDim2.new(0, 30, 0, 270)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
GetKeyButton.BorderSizePixel = 0
GetKeyButton.Text = "🚀 ПОЛУЧИТЬ СКРИПТ / GET SCRIPT"
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.TextSize = isMobile and 16 or 20
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.AutoButtonColor = false
GetKeyButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 15)
ButtonCorner.Parent = GetKeyButton

local ButtonGradient = Instance.new("UIGradient")
ButtonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 100, 255))
}
ButtonGradient.Rotation = 45
ButtonGradient.Parent = GetKeyButton

-- Светящаяся обводка кнопки
local ButtonGlow = Instance.new("Frame")
ButtonGlow.Size = UDim2.new(1, 4, 1, 4)
ButtonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
ButtonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
ButtonGlow.BackgroundTransparency = 0.5
ButtonGlow.BorderSizePixel = 0
ButtonGlow.ZIndex = 0
ButtonGlow.Parent = GetKeyButton

local ButtonGlowCorner = Instance.new("UICorner")
ButtonGlowCorner.CornerRadius = UDim.new(0, 15)
ButtonGlowCorner.Parent = ButtonGlow

local ButtonGlowGradient = Instance.new("UIGradient")
ButtonGlowGradient.Color = ButtonGradient.Color
ButtonGlowGradient.Rotation = 45
ButtonGlowGradient.Parent = ButtonGlow

-- Анимация градиента кнопки
spawn(function()
    while GetKeyButton.Parent do
        Tween(ButtonGradient, {Rotation = 405}, 3, Enum.EasingStyle.Linear)
        Tween(ButtonGlowGradient, {Rotation = 405}, 3, Enum.EasingStyle.Linear)
        task.wait(3)
        ButtonGradient.Rotation = 45
        ButtonGlowGradient.Rotation = 45
    end
end)

-- ═══════════════════════════════════════════
-- СТАТУС
-- ═══════════════════════════════════════════

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -60, 0, 30)
StatusText.Position = UDim2.new(0, 30, 0, 340)
StatusText.BackgroundTransparency = 1
StatusText.Text = "⏳ Ожидание действия / Waiting for action..."
StatusText.TextColor3 = Color3.fromRGB(150, 180, 200)
StatusText.TextSize = 12
StatusText.Font = Enum.Font.GothamMedium
StatusText.Parent = MainFrame

-- ═══════════════════════════════════════════
-- КНОПКА ЗАКРЫТИЯ
-- ═══════════════════════════════════════════

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -45, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Светящаяся обводка
local CloseGlow = Instance.new("Frame")
CloseGlow.Size = UDim2.new(1, 4, 1, 4)
CloseGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
CloseGlow.AnchorPoint = Vector2.new(0.5, 0.5)
CloseGlow.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
CloseGlow.BackgroundTransparency = 0.5
CloseGlow.BorderSizePixel = 0
CloseGlow.ZIndex = 0
CloseGlow.Parent = CloseButton

local CloseGlowCorner = Instance.new("UICorner")
CloseGlowCorner.CornerRadius = UDim.new(1, 0)
CloseGlowCorner.Parent = CloseGlow

-- ═══════════════════════════════════════════
-- ЛОГИКА ПЕРЕКЛЮЧЕНИЯ УСТРОЙСТВ
-- ═══════════════════════════════════════════

local function selectDevice(device)
    deviceType = device

    -- Скрыть экран выбора устройства
    for _, child in ipairs(DeviceSelectFrame:GetDescendants()) do
        if child:IsA("GuiObject") then
            if child:IsA("TextLabel") or child:IsA("TextButton") then
                Tween(child, {TextTransparency = 1}, 0.3)
            end
            if child:IsA("Frame") or child:IsA("TextButton") then
                Tween(child, {BackgroundTransparency = 1}, 0.3)
            end
        end
    end

    task.wait(0.4)
    DeviceSelectFrame.Visible = false
    MainFrame.Visible = true

    -- Анимация появления главного окна
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)

    for _, child in ipairs(MainFrame:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child.TextTransparency = 1
        end
        if child:IsA("Frame") or child:IsA("TextButton") then
            child.BackgroundTransparency = 1
        end
    end

    Tween(MainFrame, {
        Size = isMobile and UDim2.new(0.95, 0, 0, 420) or UDim2.new(0, 550, 0, 400),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.6, Enum.EasingStyle.Back)

    task.wait(0.4)

    for _, child in ipairs(MainFrame:GetDescendants()) do
        if child:IsA("GuiObject") then
            local targetBgTrans = 1
            local targetTextTrans = 0

            if child.Name == "MainFrame" then
                targetBgTrans = 0
            elseif child.Name == "DescriptionFrame" then
                targetBgTrans = 0.5
            elseif child.Name == "GetKeyButton" or child.Name == "CloseButton" then
                targetBgTrans = 0
            elseif child.Name == "Divider" then
                targetBgTrans = 0
            elseif child:IsA("Frame") and child.Name:find("Glow") then
                targetBgTrans = 0.5
            end

            if child:IsA("TextLabel") or child:IsA("TextButton") then
                Tween(child, {TextTransparency = targetTextTrans}, 0.3)
            end
            if child:IsA("Frame") or child:IsA("TextButton") then
                Tween(child, {BackgroundTransparency = targetBgTrans}, 0.3)
            end

            task.wait(0.02)
        end
    end
end

-- Обработчики кнопок выбора устройства
PCDeviceButton.MouseButton1Click:Connect(function()
    Tween(PCDeviceButton, {Size = UDim2.new(0, isMobile and 260 or 220, 0, isMobile and 80 or 70)}, 0.1)
    task.wait(0.1)
    selectDevice("PC")
end)

MobileDeviceButton.MouseButton1Click:Connect(function()
    Tween(MobileDeviceButton, {Size = UDim2.new(0, isMobile and 260 or 220, 0, isMobile and 80 or 70)}, 0.1)
    task.wait(0.1)
    selectDevice("Mobile")
end)

-- ═══════════════════════════════════════════
-- АНИМАЦИЯ ПОЯВЛЕНИЯ
-- ═══════════════════════════════════════════

FullBackground.BackgroundTransparency = 1
DeviceSelectFrame.BackgroundTransparency = 1

for _, child in ipairs(DeviceSelectFrame:GetDescendants()) do
    if child:IsA("GuiObject") then
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            child.TextTransparency = 1
        end
        if child:IsA("Frame") or child:IsA("TextButton") then
            child.BackgroundTransparency = 1
        end
    end
end

-- Появление фона
Tween(FullBackground, {BackgroundTransparency = 0.3}, 0.5)

task.wait(0.3)

-- Появление экрана выбора устройства
for _, child in ipairs(DeviceSelectFrame:GetDescendants()) do
    if child:IsA("GuiObject") then
        local targetBg = 1
        if child:IsA("TextButton") then
            targetBg = 0
        elseif child.Name:find("Container") then
            targetBg = 1
        end

        if child:IsA("TextLabel") or child:IsA("TextButton") then
            Tween(child, {TextTransparency = 0}, 0.3)
        end
        if child:IsA("Frame") or child:IsA("TextButton") then
            Tween(child, {BackgroundTransparency = targetBg}, 0.3)
        end
        task.wait(0.02)
    end
end

-- ═══════════════════════════════════════════
-- ОБРАБОТЧИКИ СОБЫТИЙ
-- ═══════════════════════════════════════════

-- Кнопка получения ключа
GetKeyButton.MouseButton1Click:Connect(function()
    -- Анимация нажатия
    Tween(GetKeyButton, {Size = UDim2.new(0, 470, 0, 50)}, 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    Tween(GetKeyButton, {TextSize = 18}, 0.1)

    task.wait(0.1)

    Tween(GetKeyButton, {Size = UDim2.new(0, 490, 0, 55)}, 0.2, Enum.EasingStyle.Elastic)
    Tween(GetKeyButton, {TextSize = 20}, 0.2)

    -- Копирование ссылки
    local linkUrl = "https://go.linkify.ru/2Dbx"
    if copyToClipboard(linkUrl) then
        StatusText.Text = "✅ Ссылка скопирована! Откройте браузер / Link copied! Open browser"
        StatusText.TextColor3 = Color3.fromRGB(100, 255, 150)

        -- Эффект успеха
        for i = 1, 3 do
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, 10, 0, 10)
            particle.Position = UDim2.new(0.5, -5, 0.5, -5)
            particle.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
            particle.BorderSizePixel = 0
            particle.ZIndex = 10
            particle.Parent = GetKeyButton

            local particleCorner = Instance.new("UICorner")
            particleCorner.CornerRadius = UDim.new(1, 0)
            particleCorner.Parent = particle

            local angle = (i / 3) * 360
            local targetX = math.cos(math.rad(angle)) * 200
            local targetY = math.sin(math.rad(angle)) * 200

            Tween(particle, {
                Position = UDim2.new(0.5, targetX, 0.5, targetY),
                Size = UDim2.new(0, 30, 0, 30),
                BackgroundTransparency = 1
            }, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            task.delay(1, function()
                particle:Destroy()
            end)
        end
    else
        StatusText.Text = "⚠️ Скопируйте вручную: " .. linkUrl
        StatusText.TextColor3 = Color3.fromRGB(255, 200, 100)
    end
end)

-- Hover эффект
GetKeyButton.MouseEnter:Connect(function()
    Tween(GetKeyButton, {Size = UDim2.new(0, 500, 0, 58)}, 0.2, Enum.EasingStyle.Quad)
    Tween(ButtonGlow, {Size = UDim2.new(1, 10, 1, 10)}, 0.2)
    Tween(ButtonGlow, {BackgroundTransparency = 0.3}, 0.2)
end)

GetKeyButton.MouseLeave:Connect(function()
    Tween(GetKeyButton, {Size = UDim2.new(0, 490, 0, 55)}, 0.2, Enum.EasingStyle.Quad)
    Tween(ButtonGlow, {Size = UDim2.new(1, 4, 1, 4)}, 0.2)
    Tween(ButtonGlow, {BackgroundTransparency = 0.5}, 0.2)
end)

-- Кнопка закрытия
CloseButton.MouseButton1Click:Connect(function()
    Tween(CloseButton, {Rotation = 90, Size = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)

    task.wait(0.2)

    -- Исчезновение элементов
    for i = #MainFrame:GetDescendants(), 1, -1 do
        local child = MainFrame:GetDescendants()[i]
        if child:IsA("GuiObject") then
            if child:IsA("TextLabel") or child:IsA("TextButton") then
                Tween(child, {TextTransparency = 1}, 0.2)
            end
            if child:IsA("Frame") or child:IsA("TextButton") then
                Tween(child, {BackgroundTransparency = 1}, 0.2)
            end
            task.wait(0.01)
        end
    end

    Tween(MainFrame, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)

    Tween(FullBackground, {BackgroundTransparency = 1}, 0.5)

    task.wait(0.6)
    ScreenGui:Destroy()
end)

CloseButton.MouseEnter:Connect(function()
    Tween(CloseButton, {
        BackgroundColor3 = Color3.fromRGB(255, 100, 120),
        Size = UDim2.new(0, 40, 0, 40),
        Rotation = 90
    }, 0.2)
    Tween(CloseGlow, {Size = UDim2.new(1, 10, 1, 10)}, 0.2)
end)

CloseButton.MouseLeave:Connect(function()
    Tween(CloseButton, {
        BackgroundColor3 = Color3.fromRGB(255, 50, 80),
        Size = UDim2.new(0, 35, 0, 35),
        Rotation = 0
    }, 0.2)
    Tween(CloseGlow, {Size = UDim2.new(1, 4, 1, 4)}, 0.2)
end)

-- Драг функционал
local dragging = false
local dragInput, mousePos, framePos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - mousePos
        Tween(MainFrame, {
            Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        }, 0.1, Enum.EasingStyle.Linear)
    end
end)

-- ═══════════════════════════════════════════
-- ФИНАЛЬНЫЕ СООБЩЕНИЯ
-- ═══════════════════════════════════════════

print("╔════════════════════════════════════════╗")
print("║   🚀 ROCKET PREDICT KEY SYSTEM 🚀     ║")
print("║         Successfully Loaded!           ║")
print("╚════════════════════════════════════════╝")
print("🎨 Ultra Beautiful GUI Activated!")
print("✨ Premium animations & effects enabled!")
print("🔗 Link: https://go.linkify.ru/2Dbx")
