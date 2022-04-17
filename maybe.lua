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


local window = library:CreateWindow("Giant Simulator V2") -- Creates the main window of the script
 

local farmingtab = window:CreateFolder("Auto Farm")

local client = players.LocalPlayer;

_G.MainColor = Color3.fromRGB(27, 27, 27)
_G.SecondaryColor = Color3.fromRGB(27, 27, 27)
_G.TertiaryColor = Color3.fromRGB(27, 27, 27)
_G.SliderColor = Color3.fromRGB(27, 27, 27)
_G.PointerColor = Color3.fromRGB(43, 115, 240)
_G.ArrowColor = Color3.fromRGB(43, 115, 240)
_G.ButtonColor = Color3.fromRGB(27, 27, 27)
_G.ToggleColor = Color3.fromRGB(43, 115, 240)

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

getgenv().mainLoop = stepped:Connect(function()
    if not orbfarmcheck then return end;
    if orbfarmcheck then
        local node = getANode();
        if node then
            tween(character.HumanoidRootPart, client:DistanceFromCharacter(node.Position) / 100000, { CFrame = node.CFrame + Vector3.new(math.random(2, 5), 1, 0) }, Enum.EasingStyle.Linear);
        end;
    end;
end)

farmingtab:Toggle("Orb Farm2", function(value)
    getgenv().orbfarm2check = value;
end)

local plyr = game.Players.LocalPlayer


getgenv().mainLoop = stepped:Connect(function()
    if not orbfarm2check then return end;
    if orbfarm2check then
        local node = getANode();
        if node then
            if node.CFrame then
                character.HumanoidRootPart.CFrame = node.CFrame
                game.Players.LocalPlayer.Character.Humanoid.Jump = true
            end;
        end;
    end;
end)

farmingtab:Toggle("Candy Box Farm", function(value)
    getgenv().candyboxcheck = value;
end)

getgenv().mainLoop = stepped:Connect(function()
    if plyr.Character and gnomecheck == true then
        if game:GetService("Workspace").Ephemeral.CandyBox.CandyBox then
        plyr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Ephemeral.CandyBox.CandyBox.Base.CFrame
        end
    end
end)



farmingtab:Label("Boss Farms",{
    TextSize = 20; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(27, 27, 27); -- Self Explaining
    
})

farmingtab:Toggle("Slum Boss", function(value)
    getgenv().slumbossfarmcheck = value;
end)

getgenv().mainLoop = stepped:Connect(function()
    if plyr.Character and slumbossfarmcheck == true then
        if game:GetService("Workspace").NPC.SlumBoss.SlumBoss.HumanoidRootPart then
        plyr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPC.SlumBoss.SlumBoss.HumanoidRootPart.CFrame;
        end
    end
end)

farmingtab:Toggle("Borock Boss", function(value)
    getgenv().borockbossfarmcheck = value;
end)

getgenv().mainLoop = stepped:Connect(function()
    if plyr.Character and borockbossfarmcheck == true then
        if game:GetService("Workspace").NPC.Boss.Borock.HumanoidRootPart then
        plyr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPC.Boss.Borock.HumanoidRootPart.CFrame;
        end
    end
end)

farmingtab:Toggle("DemonKing Boss", function(value)
    getgenv().demonkingbosscheck = value;
end)

getgenv().mainLoop = stepped:Connect(function()
    if plyr.Character and demonkingbosscheck == true then
        if game:GetService("Workspace").NPC.DemonKing.DemonKing.HumanoidRootPart then
        plyr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPC.DemonKing.DemonKing.HumanoidRootPart.CFrame;
        end
    end
end)

farmingtab:Toggle("Gnome Boss", function(value)
    getgenv().gnomecheck = value;
end)

getgenv().mainLoop = stepped:Connect(function()
    if plyr.Character and gnomecheck == true then
        if game:GetService("Workspace").NPC.Gnomes.Gnome.HumanoidRootPart then
        plyr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").NPC.Gnomes.Gnome.HumanoidRootPart.CFrame;
        end
    end
end)

farmingtab:Label("Misc",{
    TextSize = 20; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(27, 27, 27); -- Self Explaining
})

farmingtab:Toggle("(Rebirths) Mass Upgrade",function(value)
	getgenv().massupgradecheck = value;
end)

getgenv().mainLoop = stepped:Connect(function()
    if massupgradecheck == true then
        game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.GameService.MassUpgradeSkills:InvokeServer()
	    wait(2);
    end;
end)

farmingtab:Toggle("Auto Quest",function(value)
    getgenv().autoquestcheck = value;
end)

pcall(function() 
    if getgenv().mainLoop then
        getgenv().mainLoop:Disconnect();
    end;
end);
getgenv().mainLoop = stepped:Connect(function()
    while autoquestcheck == true do
        game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.GameService.StartQuestRequest:InvokeServer();
        wait(1.5);
        game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.GameService.EndQuestRequest:InvokeServer();
    end;
end)

