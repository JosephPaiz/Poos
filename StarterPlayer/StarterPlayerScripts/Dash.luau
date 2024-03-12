local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local UIS = game:GetService("UserInputService")
local DashCD = false

local AnimTable = {
	ForwardDash = humanoid:WaitForChild("Animator"):LoadAnimation(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Animation"):WaitForChild("Dash"):WaitForChild("ForwardDash")),
	BackwardDash = humanoid:WaitForChild("Animator"):LoadAnimation(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Animation"):WaitForChild("Dash"):WaitForChild("BackwardDas")),
	LeftDash = humanoid:WaitForChild("Animator"):LoadAnimation(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Animation"):WaitForChild("Dash"):WaitForChild("LeftDash")),
	RightDash = humanoid:WaitForChild("Animator"):LoadAnimation(game.ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Animation"):WaitForChild("Dash"):WaitForChild("RightDash")),
}

UIS.InputBegan:Connect(function(Input, isTyping)
	if isTyping then end
	if Input.KeyCode == Enum.KeyCode.Q and DashCD == false then
		DashCD = true
		local Velocity = Instance.new("LinearVelocity", character:FindFirstChild("HumanoidRootPart"))
		local Attachment = Instance.new("Attachment", character:FindFirstChild("HumanoidRootPart"))
		Velocity.MaxForce = math.huge
		Velocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
		Velocity.Attachment0 = Attachment
		Velocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		Attachment.WorldPosition = character:FindFirstChild("HumanoidRootPart").AssemblyCenterOfMass
		--Front dash
		if UIS:IsKeyDown(Enum.KeyCode.W) then
			--print("Presiono la teclas w con la q")
			AnimTable.ForwardDash:Play()
			Velocity.VectorVelocity = Vector3.new(0,0,-65)
			AnimTable.ForwardDash.Stopped:Wait()
			--Right dash
		elseif UIS:IsKeyDown(Enum.KeyCode.D) then
			AnimTable.RightDash:Play()
			Velocity.VectorVelocity = Vector3.new(65,0,0)
			AnimTable.RightDash.Stopped:Wait()
			--Left dash
		elseif UIS:IsKeyDown(Enum.KeyCode.A) then
			AnimTable.LeftDash:Play()
			Velocity.VectorVelocity = Vector3.new(-65,0,0)
			AnimTable.LeftDash.Stopped:Wait()
			--Back dash
		elseif UIS:IsKeyDown(Enum.KeyCode.S) then
			AnimTable.BackwardDash:Play()
			Velocity.VectorVelocity = Vector3.new(0,0,65)
			AnimTable.BackwardDash.Stopped:Wait()
		end
		
		Velocity:Destroy()
		Attachment:Destroy()
		
		task.wait(3)
		
		DashCD = false
		
	end
end)