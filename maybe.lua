---@diagnostic disable: undefined-global
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()

local ok = loadstring(game:HttpGet('https://raw.githubusercontent.com/Belkworks/quick/master/init.lua'))();
local s = ok.Service;
local workspace = s.Workspace;
local replicatedStorage = s.ReplicatedStorage;
local currentCamera = workspace.CurrentCamera;
local players = s.Players;
local virtualUser = s.VirtualUser;
local tweenService = s.TweenService;
local runService = s.RunService;
local stepped = runService.Stepped;


local window = library:CreateWindow("Giant Simulator") -- Creates the main window of the script
 

local farmingtab = window:CreateFolder("Main")

local client = players.LocalPlayer;

local character = client.Character or client.CharacterAdded:Wait();
client.CharacterAdded:Connect(function(char)
    character = char;
end);

if getconnections then
    for i = 1, #getconnections(client.Idled) do
        getconnections(client.Idled)[i]:Disable();
    end;
else
    client.Idled:Connect(function()
       virtualUser:Button2Down(Vector2.new(), currentCamera.CFrame);
       wait(1);
       virtualUser:Button2Up(Vector2.new(), currentCamera.CFrame);
    end);
end;


local function tween(obj, time, ...)
    local tween = tweenService:Create(obj, TweenInfo.new(time), ...);
    tween:Play();
    tween.Completed:Connect(function() tween:Destroy() end);
	return tween;
end;

local function getNodeFolder()
    for _, f in next, workspace.Scene:GetChildren() do
        if type(tonumber(f.Name)) == 'number' then
            return f;
        end;
    end;
end;

local function getANode()
    local d = math.huge;
    local e = math.huge;
    for _, v in next, getNodeFolder():GetChildren() do
        if (v:FindFirstChild('Prefab') and #v.Prefab:GetChildren() > 0) then
            local magnitude = client:DistanceFromCharacter(v.Position);
            
            if (magnitude <= d) then
                d = magnitude;
                e = v;
            end;
        end;
    end;
    return e;
end;

--Autoswing toggle

farmingtab:Toggle("AutoSwing", function(value)
    getgenv().autoSwingState = value;
end)

pcall(function() 
    if getgenv().mainLoop then
        getgenv().mainLoop:Disconnect();
    end;
end);
getgenv().mainLoop = stepped:Connect(function()
    if autoSwingState then
        task.spawn(function()
            replicatedStorage.Aero.AeroRemoteServices.GameService.WeaponAttackStart:FireServer();
            wait(0.65);
            replicatedStorage.Aero.AeroRemoteServices.GameService.WeaponAnimComplete:FireServer();
        end);
    end;
end)



--calls the autoswing method when autoswing is enabled


--orb autofarm start here
farmingtab:Toggle("Orb Farm",function(value)
 getgenv().orbfarmcheck = value;
end)

pcall(function() 
    if getgenv().mainLoop then
        getgenv().mainLoop:Disconnect();
    end;
end);
getgenv().mainLoop = stepped:Connect(function()
    if not orbfarmcheck then return end;
    if orbfarmcheck then
        local node = getANode();
        if node then
            tween(character.HumanoidRootPart, client:DistanceFromCharacter(node.Position) / 100000, { CFrame = node.CFrame + Vector3.new(math.random(2, 5), 1, 0) }, Enum.EasingStyle.Linear);
        end;
    end;
end)

farmingtab:Toggle("(Rebirths) Mass Upgrade",function(value)
	getgenv().massupgradecheck = value;
end)

pcall(function() 
    if getgenv().mainLoop then
        getgenv().mainLoop:Disconnect();
    end;
end);
getgenv().mainLoop = stepped:Connect(function()
    if massupgradecheck == false then return end;
    if massupgradecheck == true then
        game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.GameService.MassUpgradeSkills:InvokeServer()
	print(massupgradecheck);
	wait(1);
    end;
end)



--helps with repeating methods for toggles and other stuff (makes a loop)


--end of orb autofarm
farmingtab:DestroyGui()
