local skyId = "237553381"
local musicId = "1837324424"

local lighting = game:GetService("Lighting")
lighting:ClearAllChildren()

local sky = Instance.new("Sky", lighting)
sky.SkyboxBk = "rbxassetid://" .. skyId
sky.SkyboxDn = "rbxassetid://" .. skyId
sky.SkyboxFt = "rbxassetid://" .. skyId
sky.SkyboxLf = "rbxassetid://" .. skyId
sky.SkyboxRt = "rbxassetid://" .. skyId
sky.SkyboxUp = "rbxassetid://" .. skyId

local soundService = game:GetService("SoundService")

local existingSound = soundService:FindFirstChild("yolkidddMusic")
if existingSound then
	if existingSound.IsPlaying then
		existingSound:Stop()
	end
	existingSound:Destroy()
end

local newSound = Instance.new("Sound")
newSound.Name = "yolkidddMusic"
newSound.SoundId = "rbxassetid://" .. musicId
newSound.Volume = 1
newSound.Looped = true
newSound.PlaybackSpeed = 0.2
newSound.Parent = soundService
newSound:Play()

local faces = {
    Enum.NormalId.Top,
    Enum.NormalId.Bottom,
    Enum.NormalId.Front,
    Enum.NormalId.Back,
    Enum.NormalId.Left,
    Enum.NormalId.Right
}

for _, part in pairs(workspace:GetDescendants()) do
    if part:IsA("BasePart") then
        for _, face in pairs(faces) do
            local decal = Instance.new("Decal")
            decal.Texture = "rbxassetid://" .. skyId
            decal.Face = face
            decal.Parent = part
        end
    end
end

local function applyEffects(player)
	local function onChar(char)
		local head = char:WaitForChild("Head", 5)
		if head then
			if head:FindFirstChild("yolkidddTag") then
				head.yolkidddTag:Destroy()
			end
			if head:FindFirstChild("yolkidddParticles") then
				head.yolkidddParticles:Destroy()
			end

			local billboard = Instance.new("BillboardGui", head)
			billboard.Name = "yolkidddTag"
			billboard.Size = UDim2.new(0, 200, 0, 50)
			billboard.StudsOffset = Vector3.new(0, 2, 0)
			billboard.AlwaysOnTop = true

			local textLabel = Instance.new("TextLabel", billboard)
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Text = "y0lkiddd"
			textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
			textLabel.TextStrokeTransparency = 0
			textLabel.Font = Enum.Font.Arcade
			textLabel.TextScaled = true

			local emitter = Instance.new("ParticleEmitter", head)
			emitter.Name = "yolkidddParticles"
			emitter.Texture = "rbxassetid://" .. skyId
			emitter.Rate = 15
			emitter.Speed = NumberRange.new(2, 6)
			emitter.Lifetime = NumberRange.new(1.5, 2.5)
			emitter.Size = NumberSequence.new(1)
			emitter.Transparency = NumberSequence.new(0)
			emitter.VelocitySpread = 180
			emitter.LightEmission = 0.7
			emitter.Acceleration = Vector3.new(0, 5, 0)
		end
	end

	if player.Character then
		onChar(player.Character)
	end

	player.CharacterAdded:Connect(onChar)
end

for _, player in pairs(game.Players:GetPlayers()) do
	applyEffects(player)
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		applyEffects(player)
	end)

end)

