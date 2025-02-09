-- Made with Love & Care by dawninj21
-- Credits to: me (dawninja21, owner of femware v3)
-- Note: This is a beta version, so expect bugs and errors.
-- Note: Console chats all inputs, can be used for commands.
-- Note: Do not forget that this is a 'BETA' version as the script is not 100% finished, i'm constantly updating new features for y'all to enjoy.
-- Note: For any questions please contact me on discord: @python_1090


-- // GUI Settings:
_G.permadmin = true -- this will take a pad as soon as you join, set to true if you don't have perm (will skip servers with no pads when autocrashing)
_G.removeobbykill = true -- will auto remove the obbykill once you join a server
_G.autoantivamp = true -- will blacklist the crashing vampire gear when you join a server
_G.afkstatus = true -- self explanatory.
_G.whitelisted = {"agspureiam","dawninja21","ScriptingProgrammer","me_123eq","dawninja21alt"} -- basically grants them immunity to serverlocks and skips servers when autocrashing
_G.chatlogs = true -- will log chats to the bottom left of the screen
_G.autocrasher = true -- autocrasher script, make sure script is in autoexec and enable to true
_G.RenderingEnabled = nil -- This sets your rendering to false when autocrashing. Basically saves your CPU usage.
_G.UpdatedPlayerList = true -- Loads up a custom playerlist, this is a beta feature and will be updated in the future.
_G.promote = true -- will chat discord server when crashing

local function getCurrentLocalHour()
    return tonumber(os.date("%H"))
end

local function getCurrentMonth()
    return os.date("%m")
end

local function getPlayerInfo()
    local player = game.Players.LocalPlayer
    return player and player.Name or "Player", player and player.DisplayName or "Player"
end

local greetings = {
    morning = {
        "[Femware] Morning, hope you have a purrfect day, %s! uwu",
        "[Femware] Good morning, %s! Rise and shine, nya!",
        "[Femware] Morning, %s! Time to start your adventure! uwu",
        "[Femware] Good morning, %s! Let's make today pawsome! rawr",
        "[Femware] Rise and shine, %s, it's a new day! uwu",
        "[Femware] Wakey, wakey, %s! Time to conquer the day! nya~",
        "[Femware] Good morning, %s! Let's make magic happen today! uwu",
        "[Femware] Morning, %s! Hope you’re ready to sparkle! rawr",
        "[Femware] Rise and shine, superstar %s! uwu",
        "[Femware] Good morning, %s! Today’s gonna be meowtastic! nya",
    },
    afternoon = {
        "[Femware] Good afternoon, %s! Keep up the great work! uwu",
        "[Femware] Afternoon, %s! Ready for more fun? rawr",
        "[Femware] Good afternoon, %s! Let's keep the energy going! uwu",
        "[Femware] Afternoon, %s! Let's make the most of today! rawr",
        "[Femware] Hope you're having a fabulous afternoon, %s! uwu",
        "[Femware] Good afternoon, %s! Time to shine even brighter! nya",
        "[Femware] Afternoon, %s! Let’s power through together! uwu",
        "[Femware] Keep going, %s! You’re doing amazing! rawr",
        "[Femware] Good afternoon, %s! The day’s still young! nya~",
        "[Femware] Afternoon, %s! Let’s keep the vibes high! uwu",
    },
    night = {
        "[Femware] Good night, %s! Sleep tight, don't let the bedbugs bite! uwu",
        "[Femware] Night, %s! Time to unwind and relax! uwu",
        "[Femware] Sweet dreams, %s! Rest well for tomorrow! rawr",
        "[Femware] Good night, %s! See you in the morning! uwu",
        "[Femware] Nighty night, %s! Sleep well! uwu",
        "[Femware] Good night, %s! Time to recharge, nya~",
        "[Femware] Night, %s! Hope you have the coziest dreams! uwu",
        "[Femware] Sleep tight, %s! See you on the flip side! rawr",
        "[Femware] Good night, %s! Tomorrow’s a new adventure! uwu",
        "[Femware] Night, %s! Remember to dream big! nya~",
        "[Femware] Good evening, %s! The night is still young! uwu",
        "[Femware] Night owls unite, %s! Let’s make the most of it! rawr",
        "[Femware] Evening adventures await, %s! Are you ready? uwu",
        "[Femware] Good evening, %s! Let’s enjoy the calm of the night. nya~",
        "[Femware] The stars are out, %s! Let’s shine together! uwu",
        "[Femware] Nighttime is the right time, %s! Let’s go! rawr",
        "[Femware] Good evening, %s! Time to embrace the night vibes. uwu",
        "[Femware] The night is our canvas, %s! Let’s paint it! rawr",
        "[Femware] Evening vibes are the best vibes, %s! uwu",
        "[Femware] Good evening, %s! Let’s make the most of these hours! nya~",
    },
    special = {
        "[Femware] Happy Birthday, %s! Hope you have an amazing day! uwu",
        "[Femware] Congrats on your achievement, %s! You’re awesome! rawr",
        "[Femware] Celebrating your special day, %s! Enjoy every moment! uwu",
        "[Femware] Cheers to you, %s! Here’s to many more successes! nya~",
        "[Femware] Happy Anniversary, %s! Wishing you all the best! uwu",
        "[Femware] Fantastic job, %s! Keep up the great work! rawr",
        "[Femware] Here’s to celebrating you, %s! Have a fabulous day! uwu",
        "[Femware] You did it, %s! Celebrate and enjoy! nya~",
    },
    encouragement = {
        "[Femware] Keep going, %s! You’ve got this! uwu",
        "[Femware] Don’t give up, %s! Every step counts! rawr",
        "[Femware] Stay strong, %s! Your hard work is paying off! uwu",
        "[Femware] You’re doing amazing, %s! Keep pushing forward! nya~",
        "[Femware] Keep your chin up, %s! Great things are coming! uwu",
        "[Femware] You’re unstoppable, %s! Keep the momentum going! rawr",
        "[Femware] Believe in yourself, %s! You’re capable of great things! uwu",
        "[Femware] Stay positive, %s! You’re on the right path! nya~",
    },
    seasonal = {
        ["01"] = "[Femware] Happy New Year, %s! May 2024 be amazing for you! rawr",
        ["02"] = "[Femware] Winter is here, %s! Stay warm and cozy! rawr",
        ["03"] = "[Femware] Happy Spring, %s! Time to bloom and grow! uwu",
        ["04"] = "[Femware] Happy Spring, %s! Time to bloom and grow! uwu",
        ["05"] = "[Femware] Happy Spring, %s! Time to bloom and grow! uwu",
        ["06"] = "[Femware] Happy Summer, %s! Enjoy the sunshine! uwu",
        ["07"] = "[Femware] Happy Summer, %s! Enjoy the sunshine! uwu",
        ["08"] = "[Femware] Happy Summer, %s! Enjoy the sunshine! uwu",
        ["09"] = "[Femware] Autumn vibes, %s! Enjoy the fall colors! nya~",
        ["10"] = "[Femware] Happy Halloween, %s! Enjoy the spooky fun! uwu",
        ["10"] = "[Femware] Autumn vibes, %s! Enjoy the fall colors! nya~",
        ["11"] = "[Femware] Happy Thanksgiving, %s! Grateful for you! nya~",
        ["12"] = "[Femware] Merry Christmas, %s! Wishing you joy and cheer! uwu",
        ["12"] = "[Femware] Winter is here, %s! Stay warm and cozy! rawr",
    },
    fun = {
        "[Femware] Did you hear the joke, %s? It’s a good one! uwu",
        "[Femware] Feeling lucky today, %s? Let’s see some fun! rawr",
        "[Femware] Time for a fun challenge, %s! Are you up for it? uwu",
        "[Femware] Here’s a fun fact, %s! Did you know? nya~",
        "[Femware] Let’s have some fun, %s! What’s your plan? uwu",
        "[Femware] Ready for some laughs, %s? Let’s get started! rawr",
        "[Femware] It’s a fun day, %s! What’s the adventure? uwu",
        "[Femware] Enjoy the day, %s! Let’s make it awesome! nya~",
    },
    weeklyThemes = {
        ["Monday"] = "[Femware] Mindful Monday, %s! Start your week with a clear mind! uwu",
        ["Tuesday"] = "[Femware] Terrific Tuesday, %s! Let’s make it count! rawr",
        ["Wednesday"] = "[Femware] Wellness Wednesday, %s! Take care of yourself! nya~",
        ["Thursday"] = "[Femware] Throwback Thursday, %s! Let’s reminisce the good times! uwu",
        ["Friday"] = "[Femware] Fun Friday, %s! The weekend’s almost here! rawr",
        ["Saturday"] = "[Femware] Super Saturday, %s! Enjoy your day to the fullest! nya~",
        ["Sunday"] = "[Femware] Serene Sunday, %s! Relax and recharge! uwu",
    },
}

local function getGreeting()
    local currentHour = getCurrentLocalHour()
    local username, _ = getPlayerInfo()
    local timeOfDay

    if currentHour >= 5 and currentHour < 12 then
        timeOfDay = "morning"
    elseif currentHour >= 12 and currentHour < 17 then
        timeOfDay = "afternoon"
    else
        timeOfDay = "night"
    end

    local timeGreetings = greetings[timeOfDay] or {}
    if #timeGreetings == 0 then
        return "[Femware] Hello, %s! uwu"
    end

    local randomGreeting = timeGreetings[math.random(#timeGreetings)]
    return string.format(randomGreeting, username)
end

local function getCategoryMessage(category)
    local messages
    local randomMessage

    if category == "fun" then
        messages = greetings.fun
        randomMessage = messages[math.random(1, #messages)]
    elseif category == "seasonal" then
        local month = getCurrentMonth()
        randomMessage = greetings.seasonal[month] or "[Femware] Enjoy the day, %s! uwu"
    elseif category == "special" then
        randomMessage = greetings.special[math.random(1, #greetings.special)]
    elseif category == "encouragement" then
        randomMessage = greetings.encouragement[math.random(1, #greetings.encouragement)]
    elseif category == "weeklyThemes" then
        local dayOfWeek = os.date("%A")
        randomMessage = greetings.weeklyThemes[dayOfWeek] or "[Femware] Enjoy your day, %s! uwu"
    else
        randomMessage = getGreeting()
    end

    return randomMessage or "[Femware] Hello, %s! uwu"
end

local function say(message)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
end

local function getGreetingMessage()
    local success, result = pcall(function()
        local currentHour = getCurrentLocalHour()
        local username, _ = getPlayerInfo()
        local greeting

        if currentHour >= 5 and currentHour < 12 then
            greeting = getCategoryMessage("morning")
        elseif currentHour >= 12 and currentHour < 17 then
            greeting = getCategoryMessage("afternoon")
        else
            greeting = getCategoryMessage("night")
        end

        return string.format(greeting, username)
    end)

    if not success then
        print("Error getting greeting message:", result)
        return "[Femware] Hello, %s! uwu"
    else
        return result
    end
end

local function sendGreeting()
    local message = getGreetingMessage()
    say(message)
end

local function ownsHeadless()
    local player = game.Players.LocalPlayer
    for _, item in ipairs(player:WaitForChild("Inventory"):GetChildren()) do
        if item.Name == "Headless" then
            return true
        end
    end
    return false
end

local function getMilestoneMessage(executionCount)
    local milestoneMessage = ""
    if executionCount == 10 then
        milestoneMessage = "Wow, you're a regular!"
    elseif executionCount == 50 then
        milestoneMessage = "Incredible, you've run this script 50 times!"
    elseif executionCount == 100 then
        milestoneMessage = "You're amazing! 100 executions and counting!"
    elseif executionCount == 200 then
        milestoneMessage = "200 executions! You're a pro!"
    elseif executionCount == 500 then
        milestoneMessage = "500 executions! You're a legend!"
    elseif executionCount == 1000 then
        milestoneMessage = "1000 executions! You're unstoppable!"
    end
    return milestoneMessage
end

sendGreeting()

h = [[
Y̵̝̌̍O̵̪̹̐U̷͙͛ ̷͙̐͘D̸̦̞̃I̷͓͈͛͛E̶̹̩͐̀D̸̨̻̀̐

]]

local starttime = os.clock()
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local promoname = "/Q4WDbAZbKy"
local names = {
    "Sk1d_Dummy", "IpeedMyself", "ICryWhenIPoo", "Immigration", "Skid", 
    "ICryWhenIPee", "BrokenEnglish", "TranslateForMePls", "ImAnIdiot", 
    "PooPooHead", "IStillPeeTheBed", "ParentsDontLoveMe", "NoOneLikesMe", 
    "ConstantFailure", "BadAtEverything", "ForeverCringe", "CryBabyAlert", 
    "EpicDisaster", "SocialReject", "UselessHuman", "DailyFail", 
    "LaughingStock", "SelfLoathing", "EmbarrassingFailure", "SadLittlePerson", 
    "AlwaysWrong", "TotalNoob", "EndlessMistakes", "PatheticLife", 
    "LonelyAndLost", "TotalJoke", "SadFace1234", "CringeMaster", 
    "DoomedToFail", "HumiliationCentral"
}
local connections = {}
_G.timeout = {}
local audios = {"317646235", "4867685473"}
local facts = {
    "Does anyone even read these?", 
    "did you know my nickname is 'kyrocock', i blame obey", 
    "imagine scripting in a little kids game, pathetic.",
    "this script will have over 10k lines, when will the suffering end?",
    "i'm a hobbyist, not a sociopath. i just dont have time for socializing",
    "go make some friends, and i don't mean the dc bots!",
    "go outside? HELL NO!",
    "I didn't come this far only to come this far.",
    "your estimated wait time is 1.5(9)",
    "Look how far you've come.",
    "My accuracy is top-notch amirite?",
    "Males... females... if there's a hole, there's a way",
    "My builder loader stil doesn't work. Yes i am venting deal with it",
    "Live for today and let tomorrow come later.",
    "Why do you even play this game, kah died 8 years ago...",
    "Did you know there's a 1 in 8 billion chance youre reading this?",
    "Boom Headshot!",
    "\n\n\n\n"..h
}

local allowedtousescript = {"hawaiianbroski", "1x3x3x7x1x7", "Exprvssed", "0N0NYMOUS", "BANNter_Original", "Di33le2", "me_capybara", "Altsarecooleh", "unownreiko"}

_G.bh = false -- this is for the banhammer don't change it
_G.byened = false -- also for the banhammer, changing will break it
local whl = false -- autocrasher whitelisted check, dont change
getgenv().draw = false -- drawing lib
getgenv().remove = false -- drawing lib
_G.psize = "0.1" -- default part size
_G.simradius = true
_G.bullyaria = true
_G.crashed = false -- dont change

getgenv().blacklisted = {"5link9alt", "Huggiepillow", "krissykowcaine", "unownrelko"} -- blacklisted Players, will kick if they join

_G.players = {} -- table to store player in the server

if game.PlaceId == 112420803 or game.PlaceId == 115670532 or game.PlaceId == 333164326 or game.PlaceId == 15513703905 then
    repeat wait() until game.Players.LocalPlayer
    repeat task.wait() until game.Players.LocalPlayer.Character

    _G.musicids = {}

    local function space()
        rconsoleprint("")
        rconsoleprint("")
        rconsoleprint("-------------------------------------------------------------------------------------------------------")
        rconsoleprint("")
        rconsoleprint("")
    end

    
        
    _G.teleport = function()
        
        local servers = {}
                local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
                local contents = readfile("ServersHopped.txt")
                contents = contents:split("\n")
    
        
                while true do 
            spawn(function()
                
            req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", game.PlaceId)})
            body = game:GetService'HttpService':JSONDecode(req.Body)
            
            
		if body and body.data then
			for i, v in next, body.data do
				if type(v) == "table" and v.id ~= game.JobId and v.playing < 6 then
                    if not table.find(contents, v.id) then 
					table.insert(servers, v.id)
                    end
                
				end
			end
		end
		if #servers > 0 then
            
			game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
		else
            
			error("No servers found, reattempting..")
    
		end    
    end)
        wait(1)
    end        
    end
    
    
_G.prefix = ""


    coroutine.wrap(function() -- auto hopper incase server is full or crashed
        wait(5)
        if not game:IsLoaded() and _G.autohop then
            _G.teleport()
            end
        end)()
    


        


    if _G.autocrasher then 
        --rconsoleclear()
        --rconsoleerr("Running Femware's autocrasher, Welcome "..game.Players.LocalPlayer.Name.."\n")
       -- rconsoleerr("Displaying info above..\n")
        if not _G.RenderingEnabled then 
            coroutine.wrap(function()
                wait(9)
            game:GetService("RunService"):Set3dRenderingEnabled(false)
            end)()
                end
        
        local file = isfile("ServersHopped.txt")
        local file2 = isfile("ServersCrashed.txt")
        local file3 = isfile("ServersSkipped.txt")
        if file then 
            warn("file loaded")
        else
           -- rconsoleerr("Creating file ServersHopped.txt...\n")
            writefile("ServersHopped.txt", "i got muted in sc fun\n")
        end 

        if file2 then 
            warn("file2 loaded")
            else
                --rconsoleerr("Creating file ServesrCrashed.txt...\n")
                writefile("ServersCrashed.txt", "0\n")
            end 

            if file3 then 
                warn("file3 loaded")
                else
                   -- rconsoleerr("Creating file ServersSkipped.txt...\n")
                    writefile("ServersSkipped.txt", "0\n")
                end 
                
        


    
        spawn(function()
        loadstring(game:HttpGet(("https://pastebin.com/raw/yjFbhgVJ"), true))()
        end)
        spawn(function()
             
            wait(30)
            if _G.crashed == false then
           -- rconsoleerr("Something went wrong, hopping servers..\n")  
            appendfile("ServersHopped.txt", game.JobId.."\n")  
      _G.teleport()
            end
                end)

                

                coroutine.wrap(function()
                   
                    _G.padtake = game:GetService'RunService'.Stepped:Connect(function()
                        
                        pcall(function()
                            for i, v in pairs(game:GetService("Workspace").Terrain["_Game"].Admin.Pads:GetChildren()) do
                                if v:FindFirstChild("Head") and v.Name == 'Touch to get admin' then
                                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v.Head, 0)
                                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v.Head, 1) 
                                end
                            end
                        end)
                            
                    if not game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name) then 
                        game.Players.LocalPlayer.Character:Destroy()
                        rconsoleerr("Can't detect character, resetting player\n")
                        game.Players:chat("respawn me")
                      
                    else if game.Players.LocalPlayer.Character:FindFirstChild("HotPotato") or game.Players.LocalPlayer.Character:FindFirstChild("BlueBucket") or game.Players.LocalPlayer.Character:FindFirstChild("DisableBackpack") or game.Players.LocalPlayer.Character:FindFirstChild("ice") then
                        game.Players.LocalPlayer.Character:Destroy() 
                        rconsoleerr("Someone attempted to kick, resetting player\n")
                        repeat task.wait() until game.Players.LocalPlayer.Character
                    end 
                end
            end)
                
            end)()

        repeat task.wait()
        until game:GetService("Workspace").Terrain["_Game"].Admin.Pads
       -- rconsoleerr("Character Loaded (Debug)..\n")
    spawn(function()
    pcall(function()
    regen = game:GetService("Workspace").Terrain["_Game"].Admin:FindFirstChild("Regen")
    end)
end)

    _G.contents2 = readfile("ServersCrashed.txt"):split("\n")
        _G.contents3 = readfile("ServersSkipped.txt"):split("\n")

       -- rconsolename("Loaded Femware V2's Crasher                                                                         Servers Crashed: ".._G.contents2[1].."  .Servers Skipped: ".._G.contents3[1].."        Ping: "..tostring(game.Players.LocalPlayer:GetNetworkPing()))

if _G.permadmin == true then
    if game:GetService("Workspace").Terrain["_Game"].Admin:FindFirstChild("Regen") then
        print("")
    else if not game:GetService("Workspace").Terrain["_Game"].Admin.Pads:FindFirstChild("Touch to get admin") then
    --rconsoleerr("No regen and pads are taken, Hopping Servers..\n")     
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("gg/KwgMKap2", "All")   
    skipped = tonumber(_G.contents3[1]) + 1
    writefile("ServersSkipped.txt", tostring(skipped).."\n")    
    appendfile("ServersHopped.txt", game.JobId.."\n")     
    wait()
        _G.teleport()
    end
end
    pcall(function()
    fireclickdetector(game:GetService("Workspace").Terrain["_Game"].Admin.Regen.ClickDetector, 0)
    end)
local padcheck = true
while padcheck do 
    for i, v in pairs(game:GetService("Workspace").Terrain["_Game"].Admin.Pads:GetChildren()) do
        if v.Name == game.Players.LocalPlayer.Name.."'s admin" then 
            padcheck = false
        end 
    end
    wait()
end
--rconsoleerr("Gotten Admin\n")
local wlplayers = false
end
for _, v in pairs(game.Players:GetPlayers()) do
    if table.find(_G.whitelisted, v.Name) then 
        wlplayers = true
    end 
end 
--game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("night night", "All")
local ChatBar = game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar

local function cht(massage)
    ChatBar:SetTextFromInput(massage)
    game.Players:Chat(massage)
    ChatBar.Text = ""
end --this cht function is just like chat but its fixed



if wlplayers then 
    for _, v in pairs(game.Players:GetChildren()) do
        if table.find(_G.whitelisted, v.Name) then 
    game:GetService "Players":Chat(("h Whitelisted Player Detected: "..v.Name..", Hopping Servers.."))
  --  rconsoleerr("Whitelisted Player Detected: "..v.Name..", Hopping Servers..\n")

    appendfile("ServersHopped.txt", game.JobId.."\n")  
    skipped = tonumber(_G.contents3[1]) + 1
    writefile("ServersSkipped.txt", tostring(skipped).."\n")    
    task.wait(.1)
        end 
    end
else
    if _G.promote then
    --game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("gg/KwgMKap2", "All")
    end
    game.Players:Chat("reset all")
        task.wait()
for i=1,10 do
game.Players:Chat('crash')				
game.Players:Chat('unsize all all all')
game.Players:Chat('size all .3')
game.Players:Chat('size all .3')
game.Players:Chat('size all .3')
game.Players:Chat('rocket/all all all')
game.Players:Chat("dog all all all")
game.Players:Chat('size all 10')
game.Players:Chat('size all 10')
game.Players:Chat('size all 10')
game.Players:Chat('clone all all all')
end
for i=1,25 do
game.Players:Chat('m  🤦‍♀️🤦‍♀️                                                                                                                                 🤦‍♀️🤦‍♀️                                                                                                     ')			
game.Players:Chat('unsize all all all')
game.Players:Chat('size all .3')
game.Players:Chat('size all .3')
game.Players:Chat('size all .3')
game.Players:Chat('rocket/all all all')
game.Players:Chat("dog all all all")
game.Players:Chat('size all 10')
game.Players:Chat('size all 10')
game.Players:Chat('size all 10')
game.Players:Chat('clone all all all')
game.Players:Chat("tp all me")
end

        _G.padtake:Disconnect()
    
  local carfound = false      
  for _, v in pairs(game.Players:GetChildren()) do 
    if v.Backpack:FindFirstChild("DriveBloxUltimateCar") then 
        carfound = true 
    end 
end

if carfound then 
  --  rconsoleerr("Safejoin Detected, Attempting to recrash (safejoins are so pointless lmfao)\n\n")
else
--rconsoleerr("Successfully Crashed Server!\n")
end

_G.crashed = true
end


if not carfound then 
crashed = tonumber(_G.contents2[1]) + 1
    appendfile("ServersHopped.txt", game.JobId.."\n") 
    writefile("ServersCrashed.txt", tostring(crashed).."\n")   
end      
        

        
        _G.teleport()


return
end




    
  
    if _G.chatlogs then
        loadstring(game:HttpGet(("https://pastebin.com/raw/yjFbhgVJ"), true))()
    end


    
if _G.updatedPlayerList == true then
    coroutine.wrap(function()
        local function hasPerm(plr)
            local PermNBC = 66254
            local PermBC = 64354
            local UserID = plr.UserId
            if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermNBC), PermNBC)
                or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PermBC), PermBC) then
                return true
            else
                return false
            end
        end
        local function hasPersons(plr)
            local PersonNBC = 35748
            local PersonBC = 37127
            local UserID = plr.UserId
            if string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonNBC), PersonNBC)
                or string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. UserID .. "/items/GamePass/" .. PersonBC), PersonBC) then
                return true
            else
                return false
            end
        end
        local players = game:GetService("Players"):GetPlayers()
        game.StarterGui:SetCoreGuiEnabled("PlayerList", false)
        local PlayerList = game:GetService("CoreGui").PlayerList
        
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, (60 + 5) * 7)
        frame.Position = UDim2.new(1, -220, 0.5, -227)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        frame.Parent = PlayerList
        local function createBubble(parent)
            local bubble = Instance.new("Frame")
            bubble.Size = UDim2.new(1, 0, 0, 60)
            bubble.BackgroundTransparency = 1
            local cornerRadius = Instance.new("UICorner")
            cornerRadius.CornerRadius = UDim.new(0, 4)
            cornerRadius.Parent = bubble
            local displayNameLabel = Instance.new("TextLabel")
            displayNameLabel.Size = UDim2.new(1, -10, 0, 60 * 0.5)
            displayNameLabel.Position = UDim2.new(0, 5, 0, 1)
            displayNameLabel.BackgroundTransparency = 1
            displayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            displayNameLabel.TextSize = 16
            displayNameLabel.Font = Enum.Font.SourceSansBold
            displayNameLabel.Parent = bubble
            local usernameLabel = Instance.new("TextLabel")
            usernameLabel.Size = UDim2.new(1, -10, 0, 60 * 0.5)
            usernameLabel.Position = UDim2.new(0, 5, 0, 60 * 0.3)
            usernameLabel.BackgroundTransparency = 1
            usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            usernameLabel.TextSize = 14
            usernameLabel.Font = Enum.Font.SourceSans
            usernameLabel.Parent = bubble
            local thumbnailImage = Instance.new("ImageLabel")
            thumbnailImage.Size = UDim2.new(0, 30, 0, 30)
            thumbnailImage.Position = UDim2.new(0, 5, 0, 60 * 0.5 + 9)
            thumbnailImage.AnchorPoint = Vector2.new(0, 0.5)
            thumbnailImage.BackgroundTransparency = 1
            thumbnailImage.Parent = bubble
            bubble.Parent = parent
            return bubble, displayNameLabel, usernameLabel, thumbnailImage
        end
        local function updatePlayerList()
            for _, child in pairs(frame:GetChildren()) do
                child:Destroy()
            end
            local totalHeight = frame.Size.Y.Offset
            local availableHeight = math.min(totalHeight, (#players * (60 + 5)) - 5)
            local spacing = availableHeight / #players
            for i, player in pairs(game.Players:GetPlayers()) do
                local bubble, displayNameLabel, usernameLabel, thumbnailImage = createBubble(frame)
                bubble.BackgroundColor3 = Color3.fromRGB(20,20,20)
                bubble.BackgroundTransparency = .1
                if player.Name == game.Players.LocalPlayer.Name then
                    displayNameLabel.Text = player.DisplayName
                    displayNameLabel.TextColor3 = Color3.fromRGB(75,200,255)
                    usernameLabel.Text = "@" .. player.Name
                    usernameLabel.TextColor3 = Color3.fromRGB(100,200,255)
                else
                    displayNameLabel.Text = player.DisplayName;
                    usernameLabel.Text = "@" .. player.Name;
                end
                local yOffset = (i - 1) * (60 + 5) + -240
                bubble.Position = UDim2.new(0, 15, 0, yOffset)
                local thumbnailType = Enum.ThumbnailType.HeadShot
                local thumbnailSize = Enum.ThumbnailSize.Size420x420
                local thumbnailUrl = game:GetService("Players"):GetUserThumbnailAsync(player.UserId, thumbnailType, thumbnailSize)
                thumbnailImage.Image = thumbnailUrl
                thumbnailImage.Size = UDim2.new(0, 30, 0, 30)
                local aspectRatio = thumbnailImage.ImageRectSize.X / thumbnailImage.ImageRectSize.Y
                if thumbnailImage.Size.X.Offset > 30 or thumbnailImage.Size.Y.Offset > 30 then
                    if aspectRatio > 1 then
                        thumbnailImage.Size = UDim2.new(0, 30, 0, 30 / aspectRatio)
                    else
                        thumbnailImage.Size = UDim2.new(0, 30 * aspectRatio, 0, 30)
                    end
                end
                if hasPerm(player) then
                    local permissionLabel = Instance.new("TextLabel")
                    permissionLabel.Size = UDim2.new(0, 80, 0, 30)
                    permissionLabel.Position = UDim2.new(1, -130, 0, 31)
                    permissionLabel.BackgroundTransparency = 1
                    permissionLabel.Text = "Perm"
                    permissionLabel.TextColor3 = Color3.fromRGB(200, 50, 33)
                    permissionLabel.TextSize = 14
                    permissionLabel.Font = Enum.Font.SourceSans
                    permissionLabel.TextXAlignment = Enum.TextXAlignment.Right
                    permissionLabel.TextYAlignment = Enum.TextYAlignment.Center
                    permissionLabel.Parent = bubble
                end
                if hasPersons(player) then
                    local permissionLabelr = Instance.new("TextLabel")
                    permissionLabelr.Size = UDim2.new(0, 80, 0, 30)
                    permissionLabelr.Position = UDim2.new(1, -178, 0, 31)
                    permissionLabelr.BackgroundTransparency = 1
                    permissionLabelr.Text = "Person299"
                    permissionLabelr.TextColor3 = Color3.fromRGB(40, 151, 126)
                    permissionLabelr.TextSize = 14
                    permissionLabelr.Font = Enum.Font.SourceSans
                    permissionLabelr.TextXAlignment = Enum.TextXAlignment.Right
                    permissionLabelr.TextYAlignment = Enum.TextYAlignment.Center
                    permissionLabelr.Parent = bubble
                end
            end
        end
        
        local function slidePlayerList()
            isSlided = not isSlided
            local slidePosition = UDim2.new(1, -220, 0.5, -((60 + 5) * 7) / 2)
            local slideOutPosition = UDim2.new(1, 0, 0.5, -((60 + 5) * 7) / 2)
            local targetPosition = isSlided and slideOutPosition or slidePosition
            frame:TweenPosition(targetPosition, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.3, true)
        end
        
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Tab then
                slidePlayerList()
            end
        end)
        frame.Position = isSlided and UDim2.new(1, 0, 0.5, -((60 + 5) * 7) / 2) or UDim2.new(1, -220, 0.5, -((60 + 5) * 7) / 2)
        game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
        local function isLocalPlayerLeaving(player)
            if player == game.Players.LocalPlayer then
                return true
            else
                return false
            end
        end
        
        local Connections = {}
        local function isLocalPlayerLeaving(player)
            if player == game.Players.LocalPlayer then
                return true
            else
                return false
            end
        end
        local function removeFunction()
            for _, Connection in pairs(Connections) do
                Connection:Disconnect()
                break
            end
        end
        Connections[#Connections + 1] = game:GetService("Players").PlayerRemoving:Connect(function(player)
            if isLocalPlayerLeaving(player) then
                removeFunction()
                return
            end
            updatePlayerList()
        end)
        updatePlayerList()
    end)()
end     



    -- variables/tables:

    local Femware =
        [[
 ________ _______   _____ ______   ___       __   ________  ________  _______      
|\  _____\\  ___ \ |\   _ \  _   \|\  \     |\  \|\   __  \|\   __  \|\  ___ \     
\ \  \__/\ \   __/|\ \  \\\__\ \  \ \  \    \ \  \ \  \|\  \ \  \|\  \ \   __/|    
 \ \   __\\ \  \_|/_\ \  \\|__| \  \ \  \  __\ \  \ \   __  \ \   _  _\ \  \_|/__  
  \ \  \_| \ \  \_|\ \ \  \    \ \  \ \  \|\__\_\  \ \  \ \  \ \  \\  \\ \  \_|\ \ 
   \ \__\   \ \_______\ \__\    \ \__\ \____________\ \__\ \__\ \__\\ _\\ \_______\
    \|__|    \|_______|\|__|     \|__|\|____________|\|__|\|__|\|__|\|__|\|_______|
                                                                                                                                                                                                                                                     
 ]]


 







 














 


    local blg = {}
    local god = false
    local gr = "VampireVanquisher"
    local spam = false
    local paint1 = false
    local paint2 = false
    local paint3 = false
    local disco = false
    local paint4 = false
    local paint5 = false
    local paint6 = false
    local paint7 = false
    local paint8 = false
    local paint9 = false
    local paint10 = false
    local paint11 = false
    local spam = false
    local vis = false
    local paint12 = false
    local ff = false
    _G.antigears = false
    _G.antisize = true
    local msgdeleter = true
    local antilag = true
    local plrs = game:GetService("Players")
    local plr = plrs.LocalPlayer
    local Plrname = plr.Name
    local plrgui = plr.PlayerGui
    local name = plr.Name
    local cha = plr.Character
    local time = 0.00000000000000000000000000000000001
    local Folder = game:GetService("Workspace").Terrain["_Game"].Folder
    local uis = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local rs = game:GetService("ReplicatedStorage")
    local tp = game:GetService("TeleportService")
    local UIS = game:GetService("UserInputService")
local MouseDown = false
local mouse = game.Players.LocalPlayer:GetMouse()
_G.i = 1
local folder = game:GetService("Workspace").Terrain["_Game"].Folder
local parts = {}
    local ws = Folder.Parent.Workspace
    local hookmusic = false
    local red = false
    local blue = false
    local green = false
    local auto = true
    local cyan = false
    local black = false
    local magenta = false
    local brown = false
    local light_gray = false
    local dark_gray = false
    local light_blue = false
    local light_green = false
    local light_cyan = false
    local light_red = false
    local light_magenta = false
    local yellow = false
    local white = false
    local rainbow = false
    local hide = "                                                                  "
    local Admin = ws.Parent.Admin
    local foundregen = false
    local Pads = Admin.Pads
    local ad = ws["Admin Dividers"]
    local house = ws["Basic House"]
    local obby = ws.Obby
    local obbybox = ws["Obby Box"]
    local bricks = ws["Building Bricks"]
    local myjail = name .. "'s jail"
    local getplrs = plrs:GetChildren()
    local antiabuse = false
    local antijail = true
    _G.antifreeze = true
    local antikill = true
    local antifling = true
    local antipunish = true
    local antiblind = true
    local textcolor = false
    _G.takepads = false
    local takeallpads
    local hide = false
    local zero =
        "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    local padbanned = {}

    


    
    


    


    local regenpads = function()
        pcall(function()
    regen = game:GetService("Workspace").Terrain["_Game"].Admin:FindFirstChild("Regen")
    fireclickdetector(regen.ClickDetector, 0)
        end)
     end
    regenpads()

    

              
        
 




    local function addMusic(name, id)
        table.insert(_G.musicids, id)
    end

    addMusic("", 1837843587)
    addMusic("", 6797864253)
    addMusic("", 9048378262)
    addMusic("", 9046863253)
    addMusic("", 8494188412)
    addMusic("", 1847313950)

    local botname = "<Femware.txt>"
    local guiname = "FemwareV3"
    
    print("Amendment I: Congress shall make no law respecting an establishment of religion, or prohibiting the free exercise thereof; or abridging the freedom of speech, or of the press; or the right of the people peaceably to assemble, and to petition the Government for a redress of grievances.")
    
    print("Amendment II: A well regulated Militia, being necessary to the security of a free State, the right of the people to keep and bear Arms, shall not be infringed.")
    
    print("Amendment III: No Soldier shall, in time of peace be quartered in any house, without the consent of the Owner, nor in time of war, but in a manner to be prescribed by law.")
    
    print("Amendment IV: The right of the people to be secure in their persons, houses, papers, and effects, against unreasonable searches and seizures, shall not be violated, and no Warrants shall issue, but upon probable cause, supported by Oath or affirmation, and particularly describing the place to be searched, and the persons or things to be seized.")
    
    print("Amendment V: No person shall be held to answer for a capital, or otherwise infamous crime, unless on a presentment or indictment of a Grand Jury, except in cases arising in the land or naval forces, or in the Militia, when in actual service in time of War or public danger; nor shall any person be subject for the same offence to be twice put in jeopardy of life or limb; nor shall be compelled in any criminal case to be a witness against himself, nor be deprived of life, liberty, or property, without due process of law; nor shall private property be taken for public use, without just compensation.")
    
    if game.CoreGui:FindFirstChild(guiname) then
        game.CoreGui:FindFirstChild(guiname):Destroy()
    end

    local library =
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))()
    local venyx = library.new(guiname, 5013109572)
--TY Realest
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local guiname = CoreGui:WaitForChild("FemwareV3")

local ToggleKey = Enum.KeyCode.RightControl

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == ToggleKey then
        guiname.Enabled = not guiname.Enabled
    end
end)

guiname.Enabled = false  -- Ensure the GUI is initially hidden

	
--[[local Settings = {Prefix = "", ToggleGui = "RightControl"}
local UIS = game:GetService("UserInputService")
function ToggleGuis()
    for i,v in pairs (game.CoreGui:GetDescendants()) do
        if v.Name ~= "FemwareV3" then
            descendant.Visible = not descendant.Visible
        end
    end
end

UIS.InputBegan:Connect(function(INPUT)
    if INPUT.UserInputType == Enum.UserInputType.Keyboard and INPUT.KeyCode == Enum.KeyCode[Settings.ToggleGui] then
        ToggleGuis();
    end
end)
ToggleGuis()]]
	


   if _G.afkstatus then
    local UserInputService = game:GetService("UserInputService")
    local plr = game.Players.LocalPlayer

    local AFKStatus = "(Tabbed Out)\n" .. plr.DisplayName
    local afk = false

    UserInputService.WindowFocusReleased:Connect(function()
        game.Players:Chat("name me " .. AFKStatus)
        afk = true
    end)

    UserInputService.WindowFocused:Connect(function()
        game.Players:Chat("unname me")
        afk = false
    end)

    coroutine.wrap(function()
        while true do
            if afk then
                if not plr.Character:FindFirstChild(AFKStatus) then
                    game.Players:Chat("name me " .. AFKStatus)
                end
            else
                if plr.Character:FindFirstChild(AFKStatus) then
                    game.Players:Chat("unname me")
                end
            end
            wait(1)
        end
    end)()
end


    --[[coroutine.wrap(
        function()
            rconsoleclear()
            wait()
            rconsoleprint(Femware .. "\n\n\n")
            rconsolewarn("Loading Debug console.\n")
            
            
            rconsolename("Femware v.3 Console")
            hookfunction(
                print,
                function(a)
                    rconsoleprint(a .. "\n")
                end
            )
            hookfunction(
                error,
                function(a)
                    rconsoleerr(a .. "\n")
                end
            )
            hookfunction(
                warn,
                function(a)
                    rconsolewarn(a .. "\n")
                end
            )
            getgenv().info = function(a)
                rconsoleprint("[INFO] " .. a .. "\n\n")
            end

            rconsolewarn("Loading Venyx's UI Library\n")

            warn("Welcome to Femware V.3, " .. game.Players.LocalPlayer.Name)

           
            warn("Type cmds in console for commands")
            repeat
                wait()
            until game.Players.LocalPlayer.Character
            if not ws:FindFirstChild("Baseplate") then
                error("Baseplate was removed?")
            end
        end
    )()]]

    -- functions:
    local function tchat(msg)
        game.Players:chat(msg)
    end

    local function jot(p)
        if _G.popupmessages then 

            tchat("h/"..p)
        end 
    end



    if _G.permadmin then 

spawn(function()
pcall(function()
    regenpads()
    task.wait(.1)
        Pads = game:GetService("Workspace").Terrain["_Game"].Admin.Pads
        local MyPad
            for _, v in ipairs(Pads:GetChildren()) do 
                if v.Name == 'Touch to get admin' then 
                    MyPad = v.Head
                end 
            end 

            repeat task.wait()
            for _, v in pairs(plr.Character:GetChildren()) do 
            
                if v:IsA("Part") or v:IsA("BasePart") then
                    firetouchinterest(v, MyPad, 0)
                    firetouchinterest(v, MyPad, 1)
                end 
            end 
            until MyPad.Parent.Name == plr.Name.."'s admin"
            
        
  
        MyPad.Parent.Changed:Connect(function(a)
            pcall(function()
            repeat task.wait()
                for _, v in pairs(plr.Character:GetChildren()) do 
                    if v:IsA("Part") or v:IsA("BasePart") then 
                        firetouchinterest(v, MyPad, 0)
                        firetouchinterest(v, MyPad, 1)
                    end 
                end
            until MyPad.Parent.Name == plr.Name.."'s admin"
        end)
        end)


end)
end)     
end
  
    
   
    

    local function chat(msg)
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end

    local function color(Text)
        rconsoleerr("@@" .. Text .. "@@")
    end

    local function noti(Title, Text)
        game:GetService("StarterGui"):SetCore(
            "SendNotification",
            {
                Title = Title,
                Text = Text
            }
        )
    end

  
    local function clickiv()
        local iv = game:GetService("Players").LocalPlayer.Backpack:WaitForChild("IvoryPeriastron")
        iv.Parent = plr.Character
        repeat
            game:GetService("RunService").Heartbeat:wait()
        until iv:FindFirstChild("Remote")
        local Remote = iv:FindFirstChild("Remote")
        Remote:FireServer(Enum.KeyCode.E)
        Remote:FireServer(Enum.KeyCode.E)
        Remote:FireServer(Enum.KeyCode.E)
        Remote:FireServer(Enum.KeyCode.E)
        iv:Activate()
    end

 

    

    

    local function Femware()
        if _G.coverlogs then
            for i = 1, 100 do
                tchat(
                    "noob Femware.txt game:GetService('HttpService'):JSONDecode(.._G.#(1+0{data.http[math.random(1, #__G.idontgiveafuck)]..)"
                )
            end
        else
            lol = 20
        end
    end

    local function paint()
        pcall(
            function()
                if not plr.Character:FindFirstChild("PaintBucket") then
                    tchat("gear me 000000000000000000000000000000000000000000000000000018474459")
                    local paint = plr.Backpack:WaitForChild("PaintBucket")
                    paint.Parent = plr.Character
                    wait(.1)
                    if not plr.Character:FindFirstChild(paint) then
                        error("Paint Bucket was removed from player?")
                    end
                end
            end
        )
    end

 



local function skydive()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame =
        CFrame.new(
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.X,
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Y + 10000,
        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Z
    )
    wait()
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Anchored = true
end







    local function colour(part, c1, c2, c3)
        pcall(
            function()

                local args = {
                    [1] = "PaintPart",
                    [2] = {
                        ["Part"] = part,
                        ["Color"] = Color3.new(c1, c2, c3)
                    }
                }
                spawn(
                    function()
                        workspace[plr.Name]:WaitForChild("PaintBucket"):WaitForChild("Remotes").ServerControls:InvokeServer(
                            unpack(args)
                        )
                    end
                )
            end
        )
    end

    game.Players.LocalPlayer.Chatted:Connect(function(msg)
        if msg == (".pcolour") then
    while true do
        wait()
        for i,v in pairs(game:GetService("Workspace").Terrain["_Game"].Folder:GetChildren()) do
            if v:IsA("Part") then
                colour(v, math.random(), math.random(), math.random())
            end
        end
    end
end
end)

    local function black()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 0.0666667, 0.0666667, 0.0666667)
            end
        end
    end

    local function white()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 0.972549, 0.972549, 0.972549)
            end
        end
    end

    local function red()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 1, 0, 0)
            end
        end
    end

    local function blue()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 0.0352941, 0.537255, 0.811765)
            end
        end
    end

    local function green()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 0.121569, 0.501961, 0.113725)
            end
        end
    end

    local function orange()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 0.666667, 0.333333, 0)
            end
        end
    end

    local function yellow()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 1, 1, 0)
            end
        end
    end

    local function brown()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 0.486275, 0.360784, 0.27451)
            end
        end
    end


    local function purple()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 0.482353, 0, 0.482353)
            end
        end
    end

    local function pink()
        for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
            if v:IsA("Part") then
                colour(v, 1, 0.4, 0.8)
            end
        end
    end

    local function unpaint()
        pcall(
            function()
                if plr.Character:FindFirstChild("PaintBucket") then
                    plr.Character:FindFirstChild("PaintBucket"):Destroy()
                end
            end
        )
    end
    local p = ""

    

        spawn(function()
            pcall(function()
                repeat wait() until plr.Character
                repeat wait(.5) until ws.Obby
                wait(.7)
                pcall(function()
                    for i,v in pairs(workspace.Terrain._Game.Workspace.Obby:GetChildren()) do
                        v.TouchInterest:Destroy()
                    end
                end)
         
            end)
        end)
        
    

    local function rejoin()
        tchat(_G.prefix.."rj")
    end

   

    -- themes
    local themes = {
        Background = Color3.fromRGB(24, 24, 24),
        Glow = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(10, 10, 10),
        LightContrast = Color3.fromRGB(20, 20, 20),
        DarkContrast = Color3.fromRGB(14, 14, 14),
        TextColor = Color3.fromRGB(255, 255, 255)
    }

    -- first page
    local page = venyx:addPage("Main", 5012544693)
    local page2 = venyx:addPage("Misc", 5012544693)
    local page3 = venyx:addPage("Workspace", 5012544693)
    local page4 = venyx:addPage("Gears", 5012544693)
    local page5 = venyx:addPage("Visuals", 5012544693)
    local page9 = venyx:addPage("Console", 5012544693)

    local section1 = page:addSection("Anti Abuse")
    local section2 = page:addSection("Admin")
    local section3 = page2:addSection("Character")
    local sectionob = page2:addSection("Obby Kill")
    local section5 = page3:addSection("Move Parts")
    local sectionreturn = page3:addSection("Return Parts")
    local sectionflip = page3:addSection("Flip Parts")
    local sectionrmove = page3:addSection("Rmove Parts")
    local section4 = page2:addSection("Ags Crasher")
    local section6 = page4:addSection("Anti Gears")
    local section7 = page4:addSection("Custom Gears")
    local section8 = page4:addSection("Paint")
    local section9 = page9:addSection("Text Colour")
    local sectionauto = page2:addSection("Text Colour")
    local section10 = page5:addSection("Music")
    local section11 = page5:addSection("Ambients")
    local section12 = page5:addSection("Visualisers")

    local b = "[CMD] "


    --[[coroutine.wrap(
		function()
			while auto do
				res = rconsoleinput()
				if res == _G.prefix .. "cmds" then
                    error("\n\n[*]: No Prefix Needed\n\n")
                    error("CMDS:\n")
                    error(b .. "logservers")
                    info("Pretty self explanatory, will log all servers")
                    error(b .. "joinserver serverid")
                    info(
                        "Copy server id from logged servers and paste it after joinserver, will join the server obviously"
                    )
                    error(b .. "outfitlog player")
                    info("Will log players outfits")
                    error("part/1 - part/10 (Person299 required)")
                    info(b .. "will spawn a fuckton of parts ranging from different sizes")
                    error("blizzard player (Person299 required)")
                    info(b .. "use part cmd first, creates a blizzard made out of parts")
                    error(b .. "disable")
                    info("disable blizzard")
                    error(b .. "gayrate player")
                    info("Will chat a random gayrate percentage")
                    error(b .. "pwn player")
                    info("Will jail player and superexplode him")
                    error(b .. "break player")
                    info("Will break the player into many parts (Credits to ripend for this one)")
                    error(b .. "glitch player")
                    info("Will make the players character glitch")
                    error(b .. "slock player")
                    info(
                        "This will lock the player from your server, keeping them punished and blinded everytime they join"
                    )
                    error(b .. "unslock player")
                    info(
                        "removes player from serverlock"
                    )
                    
                    error(b .. "bl player")
                    info("blacklist player, will serverlock in every server")
                    error(b .. "wl player")
                    info("will manually wl player if your lazy ass cant copy his username onto the whitelist table")
                    error(b .. "infgod player")
                    info("Gives player infinite god and ff")
                    error(b .. "obkill player")
                    info("Grabs a part of the obby and kills the player with it lolol")
                    error(b .. "spam cmd")
                    info("Spams the written command")
                    error(b .. "unspam")

                    info("Disables spam")
                    error(b .. "headrise player")
                    info("makes the Player's head float")
                    error(b .. "skybox player")
                    info("makes a golden box above player")
                    error(b .. "headroot player")
                    info("will stick the players head into they're torso lel")
                    error(b .. "icetower player")
                    info("will freeze the player in a tower of ice")
                    error(b .. "amputate player")
                    info("will break the players avater")
                    error(b .. "banhammer")
                    info("will grant the player the banhammer (one time use) (POTATO KICK PATCHED, keeping it anyway lolz)")
                    error(b .. "timeout player time s/m")
                    info("puts the player in timeout (s for seconds, m for minutes)")
                    error(b .. "?hook")
                    info("hooks song id, gui one doesnt work and im not bothered to fix it")
                    error(b .. "?unhook")
                    info("unhooks song id")
                    error(b .. "zecoolgun")
                    info("cool gun i made")
                    error("smap name")
                    info("saves the map as the listed filename")
                    error("lmap name")
                    info("loads the saved map")
                    error("flmap name")
                    info("loads map faster but can be inaccurate")
                    error(b .. "btools")
                    info("grants client btools, use smap to save ur custom made map")
                    error("fixvel")
                    info("fixes maps velocity")
                    error(b .. "laser player")
                    info("kicks without freeze")
                    error(b .. "smite player ")
                    info("banhammer but it hits them?")
                    error(b .. "laser player")
                    info("fucks the player with lasers")
                    error(b .. "cray player")
                    info("fucks the player with lasers in a circle")
                    error(b .. "crail player")
                    info("fucks the player with railguns")
                    error(b .. "rcrail player")
                    info("crail but it makes the rails rainbow")
                    error(b .. "srail")
                    info("crail but a different version")
                    error(b .. "rsrail player")
                    info("srail but rainbow parts")
                    error(b .. "ssnek player")
                    info("fucks the player with idek")
                    error(b .. "nuke player")
                    info("fucks the player with airstrikes")
                    error(b .. "spike player")
                    info("hits the player with giant spikes")
                    error(b .. "blowup player")
                    info("rejoins the server")
                    error(b .. "missile player")
                    info("crail but with missile trackers")
                    error(b .. "rail player")
                    info("spams rails")
                    error(b .. "laser player")
                    info("spams lasers")
                    error(b .. "serverlock")
                    info("locks server, kicks anyone who joins")
                    error(b .. "pdraw 0.1/10")
                    info("lets you draw with parts")
                    error(b .. "rpdraw")
                    info("disables pdraw")
                    error(b .. "pdelete")
                    info("lets you delete parts")
                    error(b .. "sbuild name")
                    info("save builds with parts")
                    error(b .. "lbuild name (CURRENTLY NOT WORKING)")
                    info("loads a saved part build")
                    error(b .. "load assetid")
                    info("generates a model from Roblox Marketplace into kohls admin using parts, find the id on the model link (141865899 for a cool knuckles build)")
                    error(b .. "pclr")
                    info("removes transparent parts when building")
                    error(b .. "unload")
                    info("unloads build, note this is only if you haven't started building yet")
                    error(b .. "serverlock")
                    info("locks server")
                    error(b .. "unslock")
                    info("unlocks server")
                    error(b .. "pban")
                    info("bans player from pads")
                    error(b .. "unpban")
                    info("reverses pad ban")
                    error(b .. "pban?")
                    info("outputs list of padbanned players")
                    error(b .. "g/c")
                    info("loads up an fe cock using gears")
                    error(b .. "g/ gearid    /    mod number")
                    info("use g/ gearid first, then mod whatever number, this will load a change the gearpos making a 'modded' gear")
                        error(b .. "shuffle")
                        info("plays a random audio")
                        error(b .. "!playlist")
                    info("enables playlist, credits to soaryinglys")
                    error(b .. "!select songnumber (1-63)")
                    info("selects a random song from songIds")
                    error(b .. "!skip")
                    info("skips to next song")
                    error(b .. "slow xnumber/ speed xnumber")
                    info("very choppy because theres no way to make a slow and reverb lmao, note this is fe")
                    error(b .. "distort")
                    info("distorts sound")
                    error(b .. "stop")
                    info("stops music")
                    error(b .. "pause")
                    info("pauses music")
                    error(b .. "resume")
                    info("resumes music")
                    error(b .. "nomusic")
                    info("anti music, stops all music from playing")
                    error(b .. "resmusic")
                    info("disables anti music")
                    error(b .. "bbox")
                    info("gives golden boombox")
                    error(b .. "superbbox")
                    info("gives a lot of boomboxes in a circle")
                    error(b .. "play id")
                    info("plays song id on boomboxes")
                    error(b .. "cage player")
                    info("puts player in a cage")
                    error(b .. "gearbl player")
                    info("stops player from getting gears")
                    error(b .. "breakcam player")
                    info("breaks player's camera")
                    error(b .. "fixcam player")
                    info("fixes players camera")
                    error(b .. "svrbreakcam")
                    info("breaks everyones camera")
                    error(b .. "sclr")
                    info("clears server and fixes cameras")
                    error(b .. "rk player")
                    info("crashes player using rockets, depends on how good their device is")
                    error(b .. "dropk player")
                    info("funny troll")
                    error(b .. "void player")
                    info("puts player under the map")
                    error(b .. "purge player")
                    info("will stop the player from respawning by firing lasers")
                    error(b .. "movespawn player")
                    info("moves spawn points to player")
                    error(b .. "serverlag num")
                    info("temp lags the server by spamming cars, cars determined by num")
                    error(b .. "fmusic name")
                    info("will search the roblox API for any musics listed with specified name, eg fmusic mario")
                    error(b .. "fgear me name")
                    info("will search the roblox API for any gears listed with specified name, eg fgear me laser")
                    error(b .. "res player")
                    info("spam respawn and explode player, to annoy tf out of them")
                    error(b .. "unres")
                    info("disable duh")

                    error(b .. "gungame 1-100")
                    info("surround yourself with an armoury of guns, arrangement set based on number")
                    error(b .. "gunswitch")
                    info("selects a different gun")
                    error(b .. "shoot player")
                    info("will instantly shoot the player")
                    error(b .. "rapidfire player")
                    info("will rapidly shoot one gun at a time targetting the player")
                    error(b .. "/a")
                    info("grants attach tool, allows you to attach to any part including players (was mainly for testing purposes)")
                    error(b .. "attach player")
                    info("attaches to player duh")
                    error(b .. "dfcolour")
                    info("resets map paint to its default colour")
                    error(b .. "tase player")
                    info("tases player")
                    error(b .. "smack player")
                    info("smacks player with mackeral")
                    error(b .. "usetools")
                    info("uses all tools player has equipped")
                    error(b .. "l/bh")
                    info(":D")
                    error(b .. "freg")
                    info("looks for missing regen")
                    error(b .. "ping")
                    info("chats player ping")
                    error(b .. "silc")
                    info("silent crash the server")
                        error(b .. "rj")
                    info("rejoins the server")
                    
                else
                    tchat(res)
                    
                end
            end
            
        end
    )()]]



local admin = {prefix = "", version = "1.0"}
local commands = {}
local descriptions = {}
local http = game:GetService("HttpService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer

-- functions:
function addcommand(cmdName, cmdDescription, cmdFunction)
    commands[cmdName] = cmdName
    descriptions[cmdName] = cmdDescription
    plr.Chatted:Connect(
        function(msg)
            msg = msg:lower()
            args = msg:split(" ")
            if args[1] == admin.prefix .. cmdName then
                cmdFunction()
            elseif args[1] == "/e" and args[2] == admin.prefix .. cmdName then
                args[2] = args[3]
                cmdFunction()
            end
        end
    )
end

function newHumanoid()
    Instance.new("Humanoid", plr.Character)
end

function GetPlayer(target)
    local plrs = Players:GetPlayers()
    if target:lower() == "all" then
        return plrs
    elseif target:lower() == "others" then
        for index, plr in pairs(plrs) do
            if plr == game:service("Players").LocalPlayer then
                table.remove(plrs, index)
                return plrs
            end
        end
    elseif target:lower() == "me" then
        return {game:service("Players").LocalPlayer}
    elseif target:lower() == "bacons" then
        local baconPlayers = {}
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and (plr.Character:FindFirstChild('Pal Hair') or plr.Character:FindFirstChild('Kate Hair')) then
                table.insert(baconPlayers, plr)
            end
        end
        return baconPlayers
    else
        local plrTargets = {}
        for index, plr in pairs(plrs) do
            if plr.Name:sub(1, #target):lower() == target:lower() or plr.DisplayName:sub(1, #target):lower() == target:lower() then
                table.insert(plrTargets, plr)
            end
        end
        return plrTargets
    end
end

-- Example command to test
addcommand("whosabacon", "Test command description", function()
    local targetPlayers = GetPlayer("bacons")
    if targetPlayers then
        for _, p in pairs(targetPlayers) do
		wait(.5)
            chat(p.Name .. " Is A Bacon.")
		wait(.5)
        end
    else
        chat("No Bacons Found.")
    end
end)


--[[local admin = {prefix = "", version = "1.0"}
    local commands = {}
    local descriptions = {}
    local http = game:GetService("HttpService")
    -- functions:
    function addcommand(cmdName, cmdDescription, cmdFunction)
        commands[cmdName] = cmdName
        descriptions[cmdName] = cmdDescription
        plr.Chatted:Connect(
            function(msg)
                msg = msg:lower()
                args = msg:split(" ")
                if args[1] == admin.prefix .. cmdName then
                    cmdFunction()
                elseif args[1] == "/e" and args[2] == admin.prefix .. cmdName then
                    args[2] = args[3]
                    cmdFunction()
                end
            end
        )
    end

    function newHumanoid()
        Instance.new("Humanoid", plr.Character)
    end

    function GetPlayer(target)
        local plrs = game:service("Players"):GetPlayers()
        if target:lower() == "all" then
            return plrs
        elseif target:lower() == "others" then
            for index, plr in pairs(plrs) do
                if plr == game:service("Players").LocalPlayer then
                    table.remove(plrs, index)
                    return plrs
                end
            end
        elseif target:lower() == "me" then
            return {game:service("Players").LocalPlayer}
        else
            local plrTargets = {}
            for index, plr in pairs(plrs) do
                if plr.Name:sub(1, #target):lower() == target:lower() or plr.DisplayName:sub(1, #target):lower() == target:lower() then
                    table.insert(plrTargets, plr)
                end
            end
            return plrTargets
        end
    end]]



    --[[local admin = {prefix = "", version = "1.0"}
    local commands = {}
    local descriptions = {}
    local http = game:GetService("HttpService")
    -- functions:
    function addcommand(cmdName, cmdDescription, cmdFunction)
        commands[cmdName] = cmdName
        descriptions[cmdName] = cmdDescription
        plr.Chatted:Connect(
            function(msg)
                msg = msg:lower()
                args = msg:split(" ")
                if args[1] == admin.prefix .. cmdName then
                    cmdFunction()
                elseif args[1] == "/e" and args[2] == admin.prefix .. cmdName then
                    args[2] = args[3]
                    cmdFunction()
                end
            end
        )
    end

    function newHumanoid()
        Instance.new("Humanoid", plr.Character)
    end

    function GetPlayer(target)
        local plrs = game:service("Players"):GetPlayers()
        if target:lower() == "all" then
            return plrs
        elseif target:lower() == "others" then
            for index, plr in pairs(plrs) do
                if plr == game:service("Players").LocalPlayer then
                    table.remove(plrs, index)
                    return plrs
                end
            end
        elseif target:lower() == "me" then
            return {game:service("Players").LocalPlayer}
		 elseif target:lower() == "bacons" then
        local baconPlayers = {}
        for _, p in pairs(plrs) do
            if p.Character and (p.Character:FindFirstChild('Pal Hair') or p.Character:FindFirstChild('Kate Hair')) then
                table.insert(baconPlayers, p)
            end
        end
        return baconPlayers
			end
        else
            local plrTargets = {}
            for index, plr in pairs(plrs) do
                if plr.Name:sub(1, #target):lower() == target:lower() or plr.DisplayName:sub(1, #target):lower() == target:lower() then
                    table.insert(plrTargets, plr)
                end
            end
            return plrTargets
        end
    end]]
    --// commands
game.Players.LocalPlayer.Chatted:Connect(
    function(msg)
        local splitted = msg:split(" ")
        if splitted[1] == "calc" then --thanks knocks lol
            local num1 = splitted[2]
            local sign = splitted[3]
            local num2 = splitted[4]
            if sign == "+" then
                answer = num1 + num2
            elseif sign == "-" then
                answer = num1 - num2
            elseif sign == "x" or sign == "*" then
                answer = num1 * num2
            elseif sign == "/" then
                if num1 ~= 0 and num2 ~= 0 then
                    answer = num1 / num2
                end
            end
            chat(answer)
        end
    end
)



    addcommand("promote", "", function()
	tchat(".announce "..botname)
task.wait(3.5)
	tchat(".announce Can be found at")
task.wait(3.5)
	tchat(".announce MCWKQRkR")
task.wait()
	tchat(".announce MCWKQRkR")
task.wait()
	tchat(".announce MCWKQRkR")
task.wait()
	tchat(".announce MCWKQRkR")
end)

    addcommand("kill", "", function()
	for _Index, Target in pairs(GetPlayer(args[2])) do
	tchat("kill "..Target.Name)
			wait()
	tchat("pm/ "..Target.Name.." "..h)
			end		
			end)
    addcommand("shuffle", "", function()
        error("Selecting Random Id...")
                id = tostring(_G.musicids[math.random(1, #_G.musicids)])
                tchat("music " .. zero .. id)
                error("Playing Id: " .. id)
    end)



	
addcommand("fixfilter", "", function()
	tchat(".bypassmessage filtercheck")
		end)
	
addcommand("sznsword", "", function()
	tchat("gear me 54694329")
	tchat("gear me 40493542")
	tchat("gear me 42847923")
	tchat("gear me 48159731")
		wait(1)
	tchat("usetools")
	end)
 addcommand("pacertest", "", function()
        chat("The FitnessGram Pacer test is a multistage aerobic capacity test that progressively gets more difficult as it continues.")
	wait()
	chat("The 20 meter Pacer test will begin in 30 seconds. Line up at the start.")
	wait()
	chat("The running speed starts slowly, but gets faster each minute after you hear this signal *boop*.")
	wait()
	chat("A single lap should be completed each time you hear this sound *ding*.")
	wait()
	chat("Remember to run in a straight line, and run as long as possible. The second time you fail to complete a lap before the sound, your test is over.")
	wait()
	chat("The test will begin on the word start. On your mark, get ready, start.")
    end)
	
    addcommand("bbox", "", function()
        game.Players:chat("gear me 212641536")-- 1837881688
        plr.Backpack:WaitForChild("SuperFlyGoldBoombox").Parent = plr.Character
    end)

addcommand("antihat", "", task.spawn(function()
    while true do task.wait()
        for i,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Accessory") then
                if tostring(v.AccessoryType) == "Enum.AccessoryType.Unknown" then
                    v:Destroy()
                end
            end
        end
    end
end))

  addcommand("surprised?!", "", function()
    -- Function to send the hat command 105 times with a small delay
    local function giveHats()
        for i = 1, 105 do
            game.Players:Chat("hat me 18137588505")
            task.wait() -- Small delay between each command to avoid overwhelming the server
        end
    end

    -- Loop to repeat the hat-giving function 10 times with longer delays
    for j = 1, 3 do
        giveHats()
        task.wait(.35) -- Adjust this delay as needed to avoid rate limits
        tchat("clone me")
    end
end)

			
			
	addcommand("nslock", "", function()
    settings():GetService("NetworkSettings").IncomingReplicationLag = 9999
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
        -65.794754, 3.68363547, 28.9146214, 
        0.99453932, 1.33437101e-08, -0.104362428, 
        -7.38422301e-09, 1, 5.74901335e-08, 
        0.104362428, -5.64055647e-08, 0.99453932
    )
    task.wait(.15)
    for i = 1, 105 do
        game.Players:Chat("hat me 18137588505")
    end
    task.wait(.15)
    tchat("size me 3")
    task.wait(3)
    tchat("clone me")
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(
        -10.4413195, 3.67208648, 29.7288914, 
        0.999093175, -9.91803084e-09, 0.0425772481, 
        7.63916042e-09, 1, 5.36858984e-08, 
        -0.0425772481, -5.33119575e-08, 0.999093175
    )
    settings():GetService("NetworkSettings").IncomingReplicationLag = 0
end)

--[[addcommand("nslock","", Function()
settings():GetService("NetworkSettings").IncomingReplicationLag = 9999
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-65.794754, 3.68363547, 28.9146214, 0.99453932, 1.33437101e-08, -0.104362428, -7.38422301e-09, 1, 5.74901335e-08, 0.104362428, -5.64055647e-08, 0.99453932)
task.wait(.15)
for i = 1,105 do
game.Players:Chat("hat me 18137588505")
			end
			task.wait(.15)
			tchat("size me 3")
			wait()
			tchat("clone me")
			task.wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10.4413195, 3.67208648, 29.7288914, 0.999093175, -9.91803084e-09, 0.0425772481, 7.63916042e-09, 1, 5.36858984e-08, -0.0425772481, -5.33119575e-08, 0.999093175)
settings():GetService("NetworkSettings").IncomingReplicationLag = 0
		end)]]

addcommand(
        "crash",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
settings():GetService("NetworkSettings").IncomingReplicationLag = 9999
game.Players:Chat("respawn "..Target.Name)
wait(.2)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(455.448242, 3.63637614, 453.299042, 0.649438977, 6.72485001e-08, 0.760413706, -7.56329328e-08, 1, -2.38416611e-08, -0.760413706, -4.20286135e-08, 0.649438977)
task.wait(.15)
game.Players:Chat("blind "..Target.Name)
game.Players:Chat("tp "..Target.Name.." me")
task.wait(.15)
for i=1,3 do
for i=1,100 do
game.Players:Chat("hat "..Target.Name.." 18101265026")
end
task.wait(1)
end
task.wait(.25)
game.Players:Chat("size "..Target.Name.." nan")
				wait()
game.Players:Chat("clone "..Target.Name)
				wait()
game.Players:Chat("jail/ " .. Target.Name .. " " .. Target.Name .. " " ..Target.Name)
				wait()
settings():GetService("NetworkSettings").IncomingReplicationLag = 0
			end
end)

--[[addcommand(
        "neokick",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
        game.Players:Chat("ff "..Target.Name)
game.Players:Chat("freeze "..Target.Name)
game.Players:Chat("name "..Target.Name.." [Femware]\nLagging User...")
task.wait(0.4)
for i=1,10 do
if game.Players:FindFirstChild(Target.Name) then
for i=1,103 do
    game.Players:Chat("pm "..Target.Name.."
    













































⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪
⚪⚫⚪⚫⚫⚫⚪⚫⚪⚫⚪⚫⚪⚪⚫⚫⚫⚪⚫⚫⚫⚪⚪⚫⚪⚪⚫⚪⚫⚫⚫
⚪⚫⚪⚫⚪⚪⚪⚫⚪⚫⚪⚫⚪⚪⚪⚫⚪⚪⚫⚪⚫⚪⚫⚪⚫⚪⚫⚪⚫⚪⚪
⚪⚫⚫⚫⚫⚫⚪⚫⚪⚫⚪⚫⚪⚪⚪⚫⚪⚪⚫⚫⚪⚪⚫⚫⚫⚪⚫⚫⚫⚫⚫
⚪⚪⚪⚫⚪⚫⚪⚫⚫⚫⚪⚫⚫⚫⚪⚫⚪⚪⚫⚪⚫⚪⚫⚪⚫⚪⚪⚪⚫⚪⚫
⚪⚫⚫⚫⚪⚫⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪⚫⚫⚫⚪⚫
⚪⚪⚪⚪⚪⚪⚫⚫⚫⚪⚫⚫⚫⚪⚪⚫⚪⚪⚫⚫⚫⚪⚫⚪⚫⚪⚪⚪⚪⚪⚪
⚪⚪⚪⚪⚪⚪⚫⚪⚪⚪⚫⚪⚫⚪⚫⚪⚫⚪⚫⚫⚪⚪⚫⚫⚫⚪⚪⚪⚪⚪⚪
⚪⚪⚪⚪⚪⚪⚫⚪⚪⚪⚫⚫⚪⚪⚫⚫⚫⚪⚪⚪⚫⚪⚫⚪⚫⚪⚪⚪⚪⚪⚪
⚪⚪⚪⚪⚪⚪⚫⚫⚫⚪⚫⚪⚫⚪⚫⚪⚫⚪⚫⚫⚫⚪⚫⚪⚫⚪⚪⚪⚪⚪⚪





")
end
task.wait(5)
end
end

end
end)]]
	
addcommand(
        "pmkick",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
        game.Players:Chat("ff "..Target.Name)
game.Players:Chat("freeze "..Target.Name)
game.Players:Chat("name "..Target.Name.." [Femware.exe]\nLagging User...")
task.wait(0.4)
for i=1,10 do
if game.Players:FindFirstChild(Target.Name) then
for i=1,103 do
    game.Players:Chat("pm "..Target.Name.."ก็็็                                                                                                    ก็็็        ")							
    --game.Players:Chat("pm "..Target.Name.." 🤦‍♀️🤦‍♀️                                                                                                                                 🤦‍♀️🤦‍♀️                                                                                                     ")
end
task.wait(5)
end
end

end
end)
addcommand(
        "bring",
        "description here",
        function()
	for _Index, Target in pairs(GetPlayer(args[2])) do
				local playertarg = Target.Name
				tchat("tp "..playertarg.." me")
			end
	end)		
addcommand(
    "pmmute",
    "description here",
    function()
        for _Index, Target in pairs(GetPlayer(args[2])) do
            for i = 1, 103 do
                if game.Players:FindFirstChild(Target.Name) then
                    for j = 1, 127 do
tchat("pm/".. Target.Name .." \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou Are BlackListed! #SorryNotSorry\n\n🤑😎🥶🤣😭😇🤑😎🥶😭🤑😎😇🥶😭🤑😎🥶🤣😭🤑😎🤣🥶😭😇🤑😀\n🤑😎🥶🤣😭😇🤑😎🥶😭🤑😎😇🥶😭🤑😎🥶🤣😭🤑😎🤣🥶😭😇🤑😀\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃😜😀😝🤪😀😝😄😉😅🤪\n🤑😎🥶🤣😭😇🤑😎🥶😭🤑😎😇🥶😭🤑😎🥶🤣😭🤑😎🤣🥶😭😇🤑😀\n😇😝🤪😜😊🙃😇🙂🤣🤣😆😆😇😃😜😀😝🤪😀😝😄😉😅🤪\n🤑😎🥶🤣😭😇🤑😎🤣😭🤑😎🤣🥶😭😇🤑😀\n😇😝🤪😜😊😆🙂🤪🤣😜😅😀🙂😀😃🤪😜😁🤪😜😁🤪🤪\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")							
                        end
                    task.wait(5)
                end
            end
        end
    end
)

    addcommand("superbbox", "", function()
        -- for i = 1, 5 do
         for i = 1, 200 do
         game.Players:chat("gear me 212641536")-- 1837881688
         end 
         task.wait(.7)
         for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            coroutine.wrap(function()
                pcall(function()
                    v.Parent = game.Players.LocalPlayer.Character
                end)
            end)()
        end


 
                local cf = CFrame.new(Vector3.new(0,-4,0))
 
                 local segments = 100
 
                 
                 local radius = 20
                 local Positions = {}
                 local single = 360/segments
 
                 for i = 1, segments do
                     local angle = single*i
                     local cheating = cf * CFrame.Angles(0,math.rad(angle),0)
                     table.insert(Positions, cheating.Position + cheating.LookVector * radius)
                 end
                 --wait(.7)
                 for i,v in pairs(plr.Character:GetChildren()) do
                     if v:IsA("Tool") then
                     coroutine.wrap(function()
                         pcall(function()
                             v.GripPos = Positions[i]
                             task.wait()
                             v.Parent = plr.Character
                         end)
                     end)()
                 end
                 end
                 for i = 1, #Positions do 
                     table.remove(Positions,i)
                 end
                 
             
 
                 
     end)


        


    addcommand("play", "", function()
        id = args[2]
        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") then
            spawn(function()
            local args = {
                [1] = "PlaySong",
                [2] = id
            }
            
            v.Remote:FireServer(unpack(args))
            
            end)
        end
    end
end)


    addcommand("gkit", "", function()

        game.Players:chat("gear me 70476451")
        game.Players:chat("gear me 74385399")
        game.Players:chat("gear me 46360920")
        game.Players:chat("gear me 162857357")
        game.Players:chat("gear me 34898883")
        game.Players:chat("gear me 287426148")
        game.Players:chat("gear me 221241923")
    end)
    
  addcommand("cbomb", "", function()
    local function bombs()
        for i = 1, 105 do
            tchat("gear me 88146497")
        end
    end

    for j = 1, 5 do
        bombs()
        task.wait()  -- Assuming task.wait() is a function to wait for some time
    end
end)


 

        addcommand("fixvel",
		"fixes velocity",
		function()
			local Game_Folder = game:GetService("Workspace").Terrain["_Game"]
			local Workspace_Folder = Game_Folder.Workspace
			local Admin_Folder = Game_Folder.Admin
			workspace.Terrain._Game.Workspace.Baseplate.Velocity = Vector3.new(0,0,0)
			workspace.Terrain._Game.Workspace.Baseplate.RotVelocity = Vector3.new(0,0,0) 
			for i, v in pairs(game:GetService("Workspace").Terrain["_Game"].Workspace["Basic House"]:GetChildren()) do
				v.Velocity = Vector3.new(0, 0, 0)
				v.RotVelocity = Vector3.new(0, 0, 0)
			end
			for i, v in pairs(game:GetService("Workspace").Terrain["_Game"].Workspace["Obby"]:GetChildren()) do
				v.Velocity = Vector3.new(0, 0, 0)
				v.RotVelocity = Vector3.new(0, 0, 0)
			end
			for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Admin Dividers"]:GetChildren()) do
				v.Velocity = Vector3.new(0, 0, 0)
				v.RotVelocity = Vector3.new(0, 0, 0)
			end
			for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Obby Box"]:GetChildren()) do
				v.Velocity = Vector3.new(0, 0, 0)
				v.RotVelocity = Vector3.new(0, 0, 0)
			end
			for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Building Bricks"]:GetChildren()) do
				v.Velocity = Vector3.new(0, 0, 0)
				v.RotVelocity = Vector3.new(0, 0, 0)
			end
			Admin_Folder.Regen.Velocity = Vector3.new(0, 0, 0)
			Admin_Folder.Regen.RotVelocity = Vector3.new(0, 0, 0)
			for i, v in pairs(game:GetService("Workspace").Terrain["_Game"].Admin.Pads:GetDescendants()) do
				if v.Name == "Head" then
					v.Velocity = Vector3.new(0, 0, 0)
					v.RotVelocity = Vector3.new(0, 0, 0)
				end
			end
			error("Velocity has been fixed!")
		end)



        addcommand(
		"fixbp",
		"description here",
		function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-501, 0.100000001, 0))
			wait(.2)
			tchat("jail me")
			wait(.1)
            local bsworkspace = workspace.Terrain._Game.Workspace
			if bsworkspace:FindFirstChild("Baseplate").CFrame.Y > 0.2 or bsworkspace:FindFirstChild("Baseplate").CFrame.X ~= -501 then
				tchat("gear me 108158379")
				wait(1)
				clickiv()
				local target = bsworkspace.Baseplate
				function movepart()
					local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
					local looping = true
					spawn(function()
						while true do
							game:GetService('RunService').Heartbeat:Wait()
							game.Players.LocalPlayer.Character['Humanoid']:ChangeState(11)
							cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(game.Players.LocalPlayer.Character['Torso'].Size.X/2), 0, 0)
							if not looping then break end
						end
					end)
					spawn(function() while looping do wait(.1) tchat('unpunish me') end end)
					wait(0.25)
					looping = false
				end
				movepart()
				wait(1)
				clickiv()
				wait(1)
				tchat("respawn me")
			end
			tchat(_G.prefix.."fixp")
			tchat("Set base successfully")
			tchat("h \n\n\n\n\n\n\n\n\n---------------------------------------------------------------------------------")
			tchat("h \n\n\n\n\n\n\n\n\n\nTheme - Original ")
			tchat("unjail me")
			tchat("fix")
		end
	)



    

   
            for _, v in pairs(game.Players:GetPlayers()) do 
                if table.find(getgenv().blacklisted,v.Name) then 
                    print("Blacklisted player: "..v.Name.." Has Been Found! Server Locking Player..")
                    coroutine.wrap(function()
                        wait(1)
                        tchat(_G.prefix.."pmkick "..v.Name)
                    end)()
                     
                end 
            end 


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function applyRTX()
    local lighting = game:GetService("Lighting")
    
    -- Enable environmental properties for better visuals
    lighting.GlobalShadows = true
    lighting.Brightness = 2
    lighting.ClockTime = 14
    lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
    lighting.ColorShift_Bottom = Color3.fromRGB(255, 150, 100)

    -- Enabling BloomEffect
    local bloom = Instance.new("BloomEffect")
    bloom.Name = "RTXBloom"
    bloom.Intensity = 1.5
    bloom.Threshold = 0
    bloom.Size = 40
    bloom.Parent = lighting

    -- Adding ColorCorrection for enhanced colors
    local colorCorrection = Instance.new("ColorCorrectionEffect")
    colorCorrection.Name = "RTXColorCorrection"
    colorCorrection.Contrast = 1
    colorCorrection.Brightness = 0
    colorCorrection.TintColor = Color3.new(1, 1, 1) -- Resetting tint color to white
    colorCorrection.Parent = lighting

    -- Adding DepthOfField for a more cinematic look
    local depthOfField = Instance.new("DepthOfFieldEffect")
    depthOfField.Name = "RTXDepthOfField"
    depthOfField.InFocusRadius = 15
    depthOfField.NearIntensity = 0.5
    depthOfField.FarIntensity = 0.7
    depthOfField.FocusDistance = 50
    depthOfField.Parent = lighting

    -- Adding SunRays for realistic sun effects
    local sunRays = Instance.new("SunRaysEffect")
    sunRays.Name = "RTXSunRays"
    sunRays.Intensity = 0.3
    sunRays.Spread = 1
    sunRays.Parent = lighting

    -- Adding Blur for smoother edges
    local blur = Instance.new("BlurEffect")
    blur.Name = "RTXBlur"
    blur.Size = 4
    blur.Parent = lighting

    -- Adding Sky for enhanced visuals
    local sky = Instance.new("Sky")
    sky.Name = "RTXSky"
    sky.SkyboxBk = "rbxassetid://7018684000"
    sky.SkyboxDn = "rbxassetid://7018684000"
    sky.SkyboxFt = "rbxassetid://7018684000"
    sky.SkyboxLf = "rbxassetid://7018684000"
    sky.SkyboxRt = "rbxassetid://7018684000"
    sky.SkyboxUp = "rbxassetid://7018684000"
    sky.SunAngularSize = 15
    sky.SunTextureId = "rbxassetid://6196665100"
    sky.MoonAngularSize = 10
    sky.MoonTextureId = "rbxassetid://6196662840"
    sky.Parent = lighting

    print("Balanced RTX graphics settings applied.")
end

local function removeRTX()
    local lighting = game:GetService("Lighting")
    
    -- Remove all RTX effects
    for _, effect in ipairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("Sky") then
            effect:Destroy()
        end
    end

    -- Reset Lighting settings to default
    lighting.Brightness = 1
    lighting.GlobalShadows = false
    lighting.ClockTime = 14
    lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
    lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    lighting.Ambient = Color3.fromRGB(127, 127, 127)
    lighting.ShadowColor = Color3.fromRGB(0, 0, 0)

    print("RTX graphics settings removed.")
end

-- Listen for chat commands
Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower() == "rtx" then
        applyRTX()
    elseif msg:lower() == "nortx" then
        removeRTX()
    end
end)

print("RTX toggle script loaded.")

	

            addcommand("germanman",
		"a",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
                tchat("char "..Target.Name.." 3470687193")
                Target.CharacterAdded:Connect(function(c)
                    task.wait(.4)
                    if not c:FindFirstChild("DuffelBag") then
                        tchat("char "..Target.Name.." 3470687193")
                    end 
                end) 
            end 
        end)

           addcommand("smite",
		"a",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
            wait(.1)
                tchat(_G.prefix.."banhammer")
                wait(.6)
                for _, h in pairs(plr.Backpack:GetChildren()) do
                if h.Name == 'BanHammer V1.1' then
                h.Parent = plr.Character 
                end
                end
                repeat wait()
                    plr.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
                    mouse1click()
                until plr.Backpack:FindFirstChild("HotPotato")
         
                    for i = 1, 49 do
                        task.wait()
                        tchat("gear me 10468797")
                    end 

                for _, h in pairs(plr.Backpack:GetChildren()) do
                    if h.Name == 'BanHammer v1.1' then
                h.Parent = game.Workspace
                end
            end
                tchat("ungear me")
                
            end 
        end)
_G.svrbreakcam = nil
        addcommand("sclr",
		"a",
		function()
            if _G.svrbreakcam then 
                _G.svrbreakcam = nil 
            end
        tchat("unchar all")
        
        tchat("clr")
        tchat("fix")
        
        jot("Server has been cleared")
        end)


       
        
        addcommand("cage",
		"a",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
					_G.cagecheck = false
					tchat("gear me 00000000000000000082357101")
					if _G.cagecheck == false then
						_G.cagecheck = true
						repeat task.wait() until plr.Backpack:FindFirstChild('PortableJustice')
						plr.Backpack.PortableJustice.Parent = plr.Character
						repeat task.wait() until game.Workspace[plr.Name].PortableJustice:FindFirstChild('MouseClick')
						local oldpos = plr.Character.HumanoidRootPart.CFrame
						plr.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
						tchat('unff '..Target.Name)
						repeat 
							coroutine.wrap(function()
								game.Workspace[plr.Name].PortableJustice.MouseClick:FireServer(game.Workspace[Target.Name]) 
							end)()
							task.wait() 
						until Target.Character:FindFirstChild('DisableBackpack')
pcall(function()             
    game.Workspace[plr.Name]["PortableJustice"]:Destroy()
							_G.cagecheck = false
end)
						plr.Character:WaitForChild("HumanoidRootPart")
						plr.Character.HumanoidRootPart.CFrame = oldpos
					end

			end
		end
	)
  

    addcommand("gearbl",
		"a",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
					_G.cagecheck = false
					tchat("gear me 00000000000000000082357101")
					if _G.cagecheck == false then
						_G.cagecheck = true
						repeat task.wait() until plr.Backpack:FindFirstChild('PortableJustice')
						plr.Backpack.PortableJustice.Parent = plr.Character
						repeat task.wait() until game.Workspace[plr.Name].PortableJustice:FindFirstChild('MouseClick')
						local oldpos = plr.Character.HumanoidRootPart.CFrame
						plr.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
						tchat('unff '..Target.Name)
						repeat 
							coroutine.wrap(function()
								game.Workspace[plr.Name].PortableJustice.MouseClick:FireServer(game.Workspace[Target.Name]) 
							end)()
							task.wait() 
						until Target.Character:FindFirstChild('DisableBackpack')
						coroutine.wrap(function()
							tchat('reset me')
                            tchat('reset '..Target.Name)
							_G.cagecheck = false
                            Target.CharacterAdded:Wait()
                            tchat("pm/"..Target.Name.."/get gearbanned lol")
						end)()
						plr.CharacterAdded:wait()
						plr.Character:WaitForChild("HumanoidRootPart")
						plr.Character.HumanoidRootPart.CFrame = oldpos
					end

			end
		end
	)	



  



addcommand("distort",
    "a",
    function()
        for _, v in next, game.Workspace:GetDescendants() do 
            if v:IsA("Sound") and v.Parent == Folder then 
                
                for i = 1, 1000,1 do 
                    v.TimePosition = i 
                    task.wait(.1)
                end
            end 
        end
    end)

    
 addcommand("pbs",
    "a",
    function()
        for _, v in next, game.Workspace:GetDescendants() do 
            if v:IsA("Sound") and v.Parent == Folder then 
            
                    v.PlaybackSpeed = tonumber(args[2])
            end 
        end
    end)

    local RunService = game:GetService("RunService")
	
    addcommand("skip",
    "a",
    function()
        for _, v in next, game.Workspace:GetDescendants() do 
            if v:IsA("Sound") and v.Parent == Folder then 
            
                    v.TimePosition = tonumber(args[2])
            end 
        end
    end)

    local RunService = game:GetService("RunService")

    addcommand("speed",
        "a",
        function()
            local speed = args[2]:split("x")
            local speed = tonumber(speed[2])
            
            local increment = 0.01 * speed  -- Adjust this value as needed
            local startTime = os.clock()
    
            for _, v in next, game.Workspace:GetDescendants() do 
                if v:IsA("Sound") and v.Parent == Folder then 
                    for i = 0, v.TimeLength, increment do 
                        v.TimePosition = i 
    
                        local currentTime = os.clock()
                        local elapsedTime = currentTime - startTime
                        local targetTime = i / speed
    
                        if elapsedTime < targetTime then
                            local waitTime = targetTime - elapsedTime
                            wait(0.3)
                        end
                    end
                end 
            end
        end)


    

    addcommand("slow",
    "a",
    function()
        local speedStr = args[2]:match("x(%d+)")
        if not speedStr then
            print("Invalid speed format. Use 'slow x<number>'")
            return
        end

        local speed = tonumber(speedStr)
        if speed <= 0 then
            print("Invalid speed value. Speed must be a positive number.")
            return
        end


        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Sound") and v.Parent == Folder then
                local originalTimePosition = v.TimePosition
                local originalTimeLength = v.TimeLength
                local slowedTimePosition = 0
                
                while slowedTimePosition < originalTimeLength do
                    v.TimePosition = slowedTimePosition
                    slowedTimePosition = slowedTimePosition + 0.015 * speed
                    task.wait(0.015)
                end
                
                v.TimePosition = originalTimePosition -- Restore the original time position after slowing down
            end
        end
    end)



        addcommand("rk",
		"a",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				if Target.Name ~= game.Players.LocalPlayer.Name then
					for _, v in pairs(plr.Character:GetDescendants()) do 
                        if v:IsA("Part") or v:IsA("BasePart") then 
                            v.CanCollide = false
                        end 
                    end 
                    tchat("invis me")
                    task.wait(.1)
                    tchat("fly "..Target.Name)
                    task.wait(.3)
                    for _, v in pairs(Target.Character:GetDescendants()) do 
                        if v:IsA("Part") or v:IsA("BasePart") then 
                            v.CanCollide = false 
                        end 
                    end
                      
                    for i = 1, 120 do 
                        task.wait()
                        for i = 1, 25 do 
                        tchat("rocket/me,"..Target.Name.."/me,"..Target.Name.."/me,"..Target.Name)
                        plr.Character:WaitForChild("HumanoidRootPart").CFrame = Target.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0) - Target.Character:WaitForChild("HumanoidRootPart").CFrame.LookVector * 2.5
                    end 
                    end
                    tchat("reset me")
                end 
			end
		end
	)


   

    
    addcommand("dropk",
    "a",
    function()
        for _Index, Target in pairs(GetPlayer(args[2])) do
        plrpos = plr.Character.HumanoidRootPart.CFrame 
        tchat("fly me")
        tchat("music 879817365")
        coroutine.wrap(function()
            task.wait(1.5)
            tchat("music")
        end)()
        task.wait(.6)
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(-45, 24, 10)
        task.wait(.5)
        tchat("tp "..Target.Name.." me")
        coroutine.wrap(function()
        task.wait(.6)
        plr.Character.HumanoidRootPart.CFrame = plrpos 
        tchat("unfly me")

        end)()
        local dead = false
        local io = 1
        while io < 200 do 
            task.wait()
            io = io + 1
            if Target.Character.Humanoid.Health == 0 then
                dead = true 
            end 
        end 
        if dead == false then 
            tchat("h/You thought you would get away with it..")
            task.wait(1)
            tchat("void "..Target.Name)
            task.wait(0.6)
            tchat("smack "..Target.Name)
            Target.CharacterAdded:Wait()
            tchat("removehats "..Target.Name)
            tchat("music 1838278111")
            tchat("hat "..Target.Name.." 4272833564")
            tchat("h/Please welcome our clown, "..Target.Name)
        end

        end 
    end)


    addcommand("void",
    "a",
    function()
        for _Index, Target in pairs(GetPlayer(args[2])) do
    
        plrpos = plr.Character.HumanoidRootPart.CFrame 
        tchat("fly me")
        task.wait(.5)
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(-61, -52, -4)
        task.wait(.3)
        tchat("tp "..Target.Name.." me")
        tchat("unfly "..Target.Name)
        task.wait(.5)
        plr.Character.HumanoidRootPart.CFrame = plrpos 
        tchat("unfly me")
        end
    end)


    --safejoin








           addcommand("crail",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				local amount = 0
				local playertarg = Target.Name
				repeat
					amount = 0
					tchat("gear me "..string.rep("0", math.random(50, 100)).."79446473")
					for i, v in pairs(plr.Backpack:GetChildren()) do
						if v.Name == "Railgun" then
							amount = amount +1
						end
					end
					game:GetService("RunService").Heartbeat:wait()
				until amount >= 100
				task.wait(.2)
				local tppos = true
				local grav = game.Workspace.Gravity
				tchat("invis me")
				tchat("ungod "..playertarg)
				tchat("speed "..playertarg.." 0")
				tchat("unff "..playertarg)
				wait(.2)
				spawn(function()
					while tppos == true do
						plr.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 10, 0))		
						for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.CanCollide = false
							end
						end	
						game.Workspace.Gravity = 0
						if tppos == false then break end
						game:GetService("RunService").Heartbeat:wait()
					end
				end)
				local cf = CFrame.new(Vector3.new(0,4,0))
				local segments = 100
				local radius = 25
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(0,math.rad(angle),0)
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
				wait(1)
				for i,v in pairs(plr.Backpack:GetChildren()) do
					coroutine.wrap(function()
						pcall(function()
							v.Parent = plr.Character
							v.GripPos = Positions[i]
						end)
					end)()
				end
				wait(1)
				for i,v in pairs(plr.Character:GetChildren()) do
					if v:IsA("Tool") then 
						local player = game.Players.LocalPlayer
						local Mouse = player:GetMouse()
						local num = math.random(1,6)
						local te = Target.Character
						local partcheck = {te:FindFirstChild("Right Leg"), te:FindFirstChild("Left Leg"), te:FindFirstChild("Head") ,te:FindFirstChild("Left Arm") ,te:FindFirstChild("Right Arm"), te:FindFirstChild("HumanoidRootPart"), te:FindFirstChild("Torso")}
						local target = partcheck[math.random(1, #partcheck)]
						local args = {
							[1] = te.HumanoidRootPart.Position 
						}

						v.Click:FireServer(unpack(args))
					end
				end
				wait(.1)
				tppos = false
				wait(.1)
				tchat("unname "..playertarg)
				tchat("vis me")
				tchat("ungear me")
				game.Workspace.Gravity = grav
			end
		end)

        addcommand("missile",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				local amount = 0
				local playertarg = Target.Name
				repeat
					amount = 0
					tchat("gear me "..string.rep("0", math.random(50, 100)).."67747912")
					for i, v in pairs(plr.Backpack:GetChildren()) do
						if v.Name == "LockonLauncher" then
							amount = amount +1
						end
					end
					game:GetService("RunService").Heartbeat:wait()
				until amount >= 100
				task.wait(.2)
				local tppos = true
				local grav = game.Workspace.Gravity
				tchat("invis me")
				tchat("ungod "..playertarg)
				tchat("speed "..playertarg.." 0")
				tchat("unff "..playertarg)
				wait(.2)
				spawn(function()
					while tppos == true do
						plr.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 10, 0))		
						for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.CanCollide = false
							end
						end	
						game.Workspace.Gravity = 0
						if tppos == false then break end
						game:GetService("RunService").Heartbeat:wait()
					end
				end)
				local cf = CFrame.new(Vector3.new(0,4,0))
				local segments = 100
				local radius = 25
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(0,math.rad(angle),0)
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
				wait(1)
				for i,v in pairs(plr.Backpack:GetChildren()) do
					coroutine.wrap(function()
						pcall(function()
							v.Parent = plr.Character
							v.GripPos = Positions[i]
						end)
					end)()
				end
				wait(1)
				for i,v in pairs(plr.Character:GetChildren()) do
					if v:IsA("Tool") then 
						local player = game.Players.LocalPlayer
						local Mouse = player:GetMouse()
						local num = math.random(1,6)
						local te = Target.Character
						local partcheck = {te:FindFirstChild("Right Leg"), te:FindFirstChild("Left Leg"), te:FindFirstChild("Head") ,te:FindFirstChild("Left Arm") ,te:FindFirstChild("Right Arm"), te:FindFirstChild("HumanoidRootPart"), te:FindFirstChild("Torso")}
						local target = partcheck[math.random(1, #partcheck)]
						local args = {
                            [1] = te.HumanoidRootPart.Position
                        }
                        game:GetService("Players").LocalPlayer.Character.LockonLauncher.Remote:FireServer(unpack(args))
                        
					end
				end
				wait(.1)
				tppos = false
				wait(.1)
				tchat("unname "..playertarg)
				tchat("vis me")
				tchat("ungear me")
				game.Workspace.Gravity = grav
			end
		end)

        local players = game.Players

        addcommand("serverlag",
		"desc",
		function()
                for i = 1, tonumber(args[2]) do 
                    task.wait()
                    for i = 1, 10 do
                    game.Players:Chat("gear me 000000000000000000000000000000000000000000000000000253519495")
                    end
                end
        end)


	addcommand("rcrail",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				tchat("ungear me")
				task.wait(.2)
				local amount = 0
				local playertarg = Target.Name
				repeat
					amount = 0
					tchat("gear me "..string.rep("0", math.random(50, 100)).."79446473")
					for i, v in pairs(players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == "Railgun" then
							amount = amount +1
						end
					end
					game:GetService("RunService").Heartbeat:wait()
				until amount >= 100
				task.wait(.2)
				local tppos = true
				local grav = game.Workspace.Gravity
				tchat("invis me")
				tchat("ungod "..playertarg)
				tchat("speed "..playertarg.." 0")
				tchat("unff "..playertarg)
				wait(.2)
				spawn(function()
					while tppos == true do
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 10, 0))		
						for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.CanCollide = false
							end
						end	
						game.Workspace.Gravity = 0
						if tppos == false then break end
						game:GetService("RunService").Heartbeat:wait()
					end
				end)
				local cf = CFrame.new(Vector3.new(0,4,0))
				local segments = 100
				local radius = 25
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(0,math.rad(angle),0)
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					coroutine.wrap(function()
						pcall(function()
							v.Parent = game.Players.LocalPlayer.Character
							v.GripPos = Positions[i]
						end)
					end)()
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then 
						local player = game.Players.LocalPlayer
						local Mouse = player:GetMouse()
						local num = math.random(1,6)
						local te = Target.Character
						local partcheck = {te:FindFirstChild("Right Leg"), te:FindFirstChild("Left Leg"), te:FindFirstChild("Head") ,te:FindFirstChild("Left Arm") ,te:FindFirstChild("Right Arm"), te:FindFirstChild("HumanoidRootPart"), te:FindFirstChild("Torso")}
						local target = partcheck[math.random(1, #partcheck)]
						local args = {
							[1] = te.HumanoidRootPart.Position 
						}

						v.Click:FireServer(unpack(args))
					end
				end
				tchat("gear me 000000000000000000000000000000000000000000000000000018474459")
				task.wait(.3)
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.PaintBucket)
				task.wait(.3)
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
				_G.crail = true
				wait(.2)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do task.wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(game.Workspace:GetDescendants()) do
							coroutine.wrap(function()
								if v.Name == "Rail" or v.Name == "Effect" then
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
								end
							end)()
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
					game.Workspace.Gravity = grav
				end
				task.wait(.1)
				tppos = false
				wait(.1)
				tchat("unname "..playertarg)
				tchat("vis me")
				game.Workspace.Gravity = grav
			end
		end)

        addcommand("blowup",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				tchat("ungod "..Target.Name)
				tchat("unff "..Target.Name)
				tchat("speed "..Target.Name.." 0")
				for i = 1, 30 do
					tchat("gear me 00000000000000000000000000000000000000000000000000190094159")
				end
				wait(1.1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					pcall(function()
						v.Parent = game.Players.LocalPlayer.Character
						player = game.Players.LocalPlayer
						local Mouse = game.Players.LocalPlayer:GetMouse()
						num = math.random(1,6)
						local te = Target.Character
						if num == 1 then
							target = te:FindFirstChild("Left Leg")
						elseif num == 2 then
							target = te:FindFirstChild("Right Leg")
						elseif num == 3 then
							target = te:FindFirstChild("Head")
						elseif num == 4 then
							target = te:FindFirstChild("Left Arm")
						elseif num == 5 then
							target = te:FindFirstChild("Right Arm")
						elseif num == 6 then
							target = te:FindFirstChild("HumanoidRootPart")
						end
						-- Script generated by SimpleSpy - credits to exx#9394

						local args = {
							[1] = "Activate",
							[2] = target.Position
						}


						game:GetService("Players").LocalPlayer.Character.ModernRocketLauncher.Remote:FireServer(unpack(args))
						game:GetService("RunService").Heartbeat:wait() 
						game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
					end)
				end
			end
		end)

        

	addcommand("rsrail",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				tchat("ungear me")
				task.wait(.1)
				local amount = 0
				local playertarg = Target.Name
				repeat
					amount = 0
					tchat("gear me "..string.rep("0", math.random(50, 100)).."79446473")
					for i, v in pairs(players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == "Railgun" then
							amount = amount +1
						end
					end
					game:GetService("RunService").Heartbeat:wait()
				until amount >= 100
				task.wait(.2)
				local tppos = true
				local grav = game.Workspace.Gravity
				tchat("invis me")
				tchat("ungod "..playertarg)
				tchat("speed "..playertarg.." 0")
				tchat("unff "..playertarg)
				wait(.2)
				spawn(function()
					while tppos == true do
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 10, 0))		
						for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.CanCollide = false
							end
						end	
						game.Workspace.Gravity = 0
						if tppos == false then break end
						game:GetService("RunService").Heartbeat:wait()
					end
				end)
				local cf = CFrame.new(Vector3.new(0,4,0))
				local segments = 100
				local radius = 15
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(math.random(1, 20),math.rad(angle),math.random(1, 20))
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					coroutine.wrap(function()
						pcall(function()
							v.Parent = game.Players.LocalPlayer.Character
							v.GripPos = Positions[i]
						end)
					end)()
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then 
						local player = game.Players.LocalPlayer
						local Mouse = player:GetMouse()
						local num = math.random(1,6)
						local te = Target.Character
						local partcheck = {te:FindFirstChild("Right Leg"), te:FindFirstChild("Left Leg"), te:FindFirstChild("Head") ,te:FindFirstChild("Left Arm") ,te:FindFirstChild("Right Arm"), te:FindFirstChild("HumanoidRootPart"), te:FindFirstChild("Torso")}
						local target = partcheck[math.random(1, #partcheck)]
						local args = {
							[1] = te.HumanoidRootPart.Position 
						}

						v.Click:FireServer(unpack(args))
					end
				end
				tchat("gear me 000000000000000000000000000000000000000000000000000018474459")
				task.wait(.3)
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.PaintBucket)
				task.wait(.3)
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 10, 0)
					end
				end
				_G.crail = true
				wait(.2)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do task.wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(game.Workspace:GetDescendants()) do
							coroutine.wrap(function()
								if v.Name == "Rail" or v.Name == "Effect" then
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
								end
							end)()
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
					game.Workspace.Gravity = grav
				end
				task.wait(.1)
				tppos = false
				wait(.1)
				tchat("unname "..playertarg)
				tchat("vis me")
				game.Workspace.Gravity = grav
			end
		end)

        addcommand("fmusic",
		"desc",
		function()
            local geared
            if args[5] then 
            geared = args[2],args[3],args[4],args[5]
            else if args[4] then 
            geared = args[2],args[3],args[4]
            else if args[3] then 
            geared = args[2],args[3]
            else if args[2] then 
            geared = args[2]
            end 
        end 
    end 
end
            local url = "https://search.roblox.com/catalog/json?CatalogContext=2&AssetTypeID=3&PageNumber=1&limit=10&Category=9&SortType=0&keyword="..args[2].."/"
			local returned = http:JSONDecode(game:HttpGet(url))
			if not returned then
				error("Catalog Audio API didn't return anything.")
			end
           local music = returned[1]
            if not music or not music.AssetId then
				error("No Audio found for that search")
			end

	
				tchat("music "..tostring(music.AssetId))
        end)

        addcommand("wl",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
                 
                 appendfile("Whitelisted.txt",Target.Name.."\n")
                 table.insert(_G.whitelisted,Target.Name)
                 tchat("pm/"..Target.Name.."/You've been added to my whitelist")
                 task.wait(2)
                tchat("reset " .. Target.Name)
                Target.CharacterAdded:Connect(function(a)
                        a:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(
                            function()
                                tchat("god " .. Target.Name)
                                if character:WaitForChild("Humanoid").Health == 0 then
                                    tchat("reset " .. Target.Name)
                                    task.wait(.2)
                                    tchat("god " .. Target.Name)
                                end
                            end
                        )
                    end
                )
                end 
            end) 

        
            local wl = isfile("Whitelisted.txt")
            if not wl then 
               writefile("Whitelisted.txt", "shedletsky\n")
            else
              wl = readfile("Whitelisted.txt"):split("\n")
              for i = 1,#wl do 
                table.insert(_G.whitelisted,wl[i])
              end 
            end



        addcommand("bl",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
                 
                 appendfile("Blacklisted.txt",Target.Name.."\n")
                 table.insert(getgenv().blacklisted,Target.Name)
                 tchat("pm/"..Target.Name.."/Good job, you've earned a spot in my blacklist")
                 wait(.5)
		tchat("antihat")
		wait()
		tchat(".softlock "..Target.Name)
		wait()
                 tchat("crash "..Target.Name)
                end 
            end)

        
            local blacklist = isfile("Blacklisted.txt")
            if not blacklist then 
               writefile("Blacklisted.txt","agspureiam\n")
            else
              blacklist = readfile("Blacklisted.txt"):split("\n")
              for i = 1,#blacklist do 
                table.insert(getgenv().blacklisted,blacklist[i])
              end 
            end




            addcommand("!playlist","desc", function()
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!delaudio" then
                        game.Players:Chat("h/ n\n\n\n\n\n\n\n\n\nAudioDeleted\n\n\n\n\n\n\n\n")
                    end
                end)
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!vibes" then
                        game.Players:Chat("time -")
                        game.Players:Chat("ambient 0 0 0")
                        game.Players:Chat("outdoorambient 0 0 0")
                        game.Players:Chat("colorshiftbottom 255 192 203")
                        game.Players:Chat("colorshifttop 255 192 203")
                        game.Players:Chat("fogend 2000")
                        game.Players:Chat("fogstart 10")
                        game.Players:Chat("fogcolor 255 100 255")
                        game.Players:Chat("glow all 160 20 150")
                    end
                end)
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!iceblue" then
                        game.Players:Chat("time 12:00")
                        game.Players:Chat("ambient 100 100 100") 
                        game.Players:Chat("outdoorambient 50 50 50") 
                        game.Players:Chat("colorshiftbottom 173 216 230")
                        game.Players:Chat("colorshifttop 173 216 230")
                        game.Players:Chat("fogend 500")
                        game.Players:Chat("fogstart 100")
                        game.Players:Chat("fogcolor 173 216 230") 
                        game.Players:Chat("glow all 160 20 150")
                    end
                end)
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!dusk" then
                        game.Players:Chat("time 18:00")
                        game.Players:Chat("ambient 80 80 80")
                        game.Players:Chat("outdoorambient 40 40 40")
                        game.Players:Chat("colorshiftbottom 150 204 155")
                        game.Players:Chat("colorshifttop 150 204 155")
                        game.Players:Chat("fogend 800")
                        game.Players:Chat("fogstart 200")
                        game.Players:Chat("fogcolor 150 204 155")
                        game.Players:Chat("glow all 200 150 50")
                    end
                end)
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!mood" then
                        game.Players:Chat("time 20:00")
                        game.Players:Chat("ambient 30 30 40")
                        game.Players:Chat("outdoorambient 20 20 30")
                        game.Players:Chat("colorshiftbottom 60 50 70")
                        game.Players:Chat("colorshifttop 60 50 70")
                        game.Players:Chat("fogend 1000")
                        game.Players:Chat("fogstart 50")
                        game.Players:Chat("fogcolor 30 20 40")
                        game.Players:Chat("glow all 50 30 80")
                    end
                end)
                
                local songIds = {
                    {9043892984, 200, "dele mami"},
                    {9043878179, 200, "Kikbak ft Styliztik & Kaisha"},
                    {1840040963, 200, "Rhythm"},
                    {1841443579, 200, "tripping on love"},
                    {7029017448, 206, "play it cool - terry zchong"},
                    {1846808350, 200, "get up and boogy"},
                    {7023741506, 200, "Elypsis - i miss you"},
                    {1848220276, 200, "different than normal"},
                    {9042523170, 200, "come closer -- reginald keith"},
                    {9043876028, 200, "flexxin on the gram"},
                    {9043893928, 200, "sin remordimientos"},
                    {9043870264, 200, "shumba - real friend"},
                    {6901063458, 200, "rihanna SOS"},
                    {7024035759, 250, "dexter king - get to know you"},
                    {1835662728, 200, "unknown"},
                    {29040163991, 200, "Soviet Anthem"},
                    {1836807218, 200, "soarcrash"},
                    {183736729, 201, "Hound Dogs of Love"},
                    {1840003540, 200, "Tell it to yourself"},
                    {1838488910, 230, "Take the Road"},
                    {1837871444, 230, "Your love is Anarchy"},
                    {1843324953, 235, "Night out"},
                    {1840047556, 235, "So bad - Juice music"},
                    {1838569831, 235, "Never gonna give you up"},
                    {1837258874, 131, "la cucaracha😃😜😀"},
                    {1843434135, 235, "Twisted Love"},
                    {1837881688, 185, "Shattered Heart"},
                    {1837848096, 220, "Feels good to Cry"},
                    {9042524725, 33, "Space"},
                    {9045373969, 235, "A lo Caliche"},
                    {9047105584, 235, "On the Verge"},
                    {1836736337, 235, "Just Wanna Dance"},
                    {1836736337, 140, "Fur immer deutsch<3"},
                    {1836736337, 80, "Wandering"},
                    {1845932062, 234, "Vuelve A Mi A"},
                    {1836743584, 235, "You Aint Hot"},
                    {1840041842, 190, "Till the Mornin"},
                    {6708444383, 190, "beats"},
                    {6924735395, 150, "Every time"},
                    {13530438299, 140, "Beats"},
                    {6942391979, 170, "ariashot"},
                    {6913550990, 200, "FNAF"},
                    {1846458016, 200, "no more"},
                    {6924735395, 200, "For me"},
                    {1838457617, 200, "Clair De Lune"},
                    {6872126938, 200, "Young - Vacations"},
                    {6823597327, 200, "Brooklyn Blood Pop"},
                    {9047050075, 200, "Lofi Hiphop"},
                    {9043887091, 200, "Lofi Chill"},
                    {1839707719, 200, "Sweet Dance Song"},
                    {1837870681, 200, "Autumn Leaves"},
                    {5410082534, 150, "dubstep"},
                    {5410082097, 200, "Bad Computer"},
                    {5410080857, 200, "F.O.O.L & Midranger - Neon"},
                    {5410084346, 240, "Pixel Terror - Amnesia"},
                    {1837843587, 220, "a Bit of Rock"},
                    {6828176320, 200, "Rolling Stones - Paint it Black"},
                    {6772846771, 230, "Thats a bop"},
                    {6806140478, 150, "Sad N**ga Hours"},
                    {6953866301, 140, "MONTAGEM - EMPINA NA ONDA"},
                    {6788646778, 200, "Hella Sketchy - Rare Gem"},
                    {7006487793, 200, "Saw you at the Party"},
                    {6973084731, 230, "Britney Speirs - Till the World Ends"},
                    {6925558165, 200, "Situation Critical - Platinum Blonde"},
                }
                
                local function sendPlaylistReminder()
                    task.wait(3)
                    while true do
                        game.Players:Chat("m/ \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nSoar's Playlist❤️\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                        wait(math.random(60, 140))
                    end
                end
                
                local soundFolder = workspace:FindFirstChild("Game")
                if soundFolder then
                    local sounds = soundFolder:GetDescendants()
                    for _, sound in ipairs(sounds) do
                        if sound:IsA("Sound") and not sound.PlayOnRemove then
                            sound.PlayOnRemove = true
                        end
                    end
                end
                
                
                spawn(sendPlaylistReminder)
                
                
                local function shuffleSongIds()
                    local currentIndex = #songIds
                    while currentIndex > 1 do
                        local randomIndex = math.random(1, currentIndex)
                        songIds[currentIndex], songIds[randomIndex] = songIds[randomIndex], songIds[currentIndex]
                        currentIndex = currentIndex - 1
                    end
                end
                
                local audioEnabled = true
                local audioObjects = {}  -- To store references to audio objects
                
                local function enableAudio()
                    if not audioEnabled then
                        audioEnabled = true
                        game.Players:Chat("h/ n\n\n\n\n\n\n\n\n\nAudio enabled\n\n\n\n\n\n\n\n")
                        for _, audioObj in ipairs(audioObjects) do
                            audioObj.Volume = 1
                        end
                    end
                end
                
                local isPaused = false
                local wasPaused = false
                
                local function pauseAudio()
                    while isPaused do
                        for _, sound in pairs(workspace.Terrain._Game.Folder:GetDescendants()) do
                            if sound:IsA("Sound") and sound.Playing then
                                sound.Playing = false
                            end
                        end
                
                        if not wasPaused then
                            game.Players:Chat("h/ n\n\n\n\n\n\n\n\n\nPaused\n\n\n\n\n\n\n\n")
                            wasPaused = true
                        end
                        wait()
                    end
                    wasPaused = false
                end
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if string.sub(msg:lower(), 1, 10) == "!pdelaudio" then 
                        isPaused = true
                        pauseAudio()
                    elseif string.sub(msg:lower(), 1, 11) == "!ploadaudio" then
                        isPaused = false
                        for _, sound in pairs(workspace.Terrain._Game.Folder:GetDescendants()) do
                            if sound:IsA("Sound") and not sound.Playing then
                                sound.Playing = true
                            end
                        end
                        game.Players:Chat("h/ n\n\n\n\n\n\n\n\n\nPlaying\n\n\n\n\n\n\n\n")
                    end
                end)


            local songperms = {}

            game.Players.LocalPlayer.Chatted:Connect(function(msg)
                if msg:sub(1,10) == "!songperms" then 
                    msg = msg:split(" ")
                    for _, v in next, game.Players:GetPlayers() do 
                        if string.match(v.Name:lower():sub(1,4), msg[2]:lower():sub(1,4)) then 
                            table.insert(songperms, v.Name)
                            v.Chatted:Connect(function(m)
                                if m:sub(1,1) == '!' and table.find(songperms, v.Name) then -- not bothered to list all the commands
                                   game.Players:chat(m)
                                end 
                            end) 
                        end 
                    end 
                end 
            end)

            game.Players.LocalPlayer.Chatted:Connect(function(msg)
                if msg:sub(1,12) == "!removeperms" then 
                    msg = msg:split(" ")
                    for _, v in next, game.Players:GetPlayers() do 
                        if string.match(v.Name:lower():sub(1,4), msg[2]:lower():sub(1,4)) then 
                            for i in #songperms do 
                                if songperms[i] == v.Name then 
                                    table.remove(songperms,i)
                                end
                                end 
                        end 
                    end 
                end 
            end)
                 
            local function selectAudio(audio)
                
                    local currentSong = songIds[audio]
                    local currentSongId = currentSong[1]
                    local currentSongDuration = currentSong[2]
                    local currentSongName = currentSong[3]
                
                    game.Players:Chat('music ' .. tostring(currentSongId))
                
                    game.Players:Chat("h \n\n\n\n\n\n\n\n\n\n\nNow playing: \n" .. currentSongName .. "\n\n\n\n\n\n\n\n\n\n\n")
                
                    local elapsedTime = 0
                    while elapsedTime < currentSongDuration do
                        wait(1)
                        elapsedTime = elapsedTime + 1
                    end
                
                    playNextSong()
                end 

                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if string.sub(msg:lower(), 1, 7) == "!select" then 
                        s = msg:split(" ")
                        selectAudio(tonumber(s[2]))
                    end 
                end)


                
                
                local function disableAudio()
                    if audioEnabled then
                        audioEnabled = false
                        for _, sound in pairs(workspace:GetDescendants()) do
                            if sound:IsA("Sound") or sound:IsA("SoundGroup") then
                                table.insert(audioObjects, sound)  --idek
                                sound.Volume = 0
                            end
                        end
                        game.Players:Chat("h/ n\n\n\n\n\n\n\n\n\nAudio disabled\n\n\n\n\n\n\n\n")
                    end
                end
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!delaudio" then
                        disableAudio()
                    elseif msg == "!loadaudio" then
                        enableAudio()
                    end
                end)
                
                -- Hook into the creation of new audio objects and disable them if audio is disabled
                workspace.DescendantAdded:Connect(function(obj)
                    if not audioEnabled and (obj:IsA("Sound") or obj:IsA("SoundGroup")) then
                        table.insert(audioObjects, obj)  -- Store references to new audio objects
                        obj.Volume = 0
                    end
                end)
                
                local currentIndex = 0
                
                
                local function playNextSong()
                  
                    currentIndex = currentIndex + 1
                
                    
                    if currentIndex > #songIds then
                        currentIndex = 1
                        shuffleSongIds()
                    end
                
                    local currentSong = songIds[currentIndex]
                    local currentSongId = currentSong[1]
                    local currentSongDuration = currentSong[2]
                    local currentSongName = currentSong[3]
                
                    game.Players:Chat('music ' .. tostring(currentSongId))
                
                    game.Players:Chat("h \n\n\n\n\n\n\n\n\n\n\nNow playing: \n" .. currentSongName .. "\n\n\n\n\n\n\n\n\n\n\n")
                
                    local elapsedTime = 0
                    while elapsedTime < currentSongDuration do
                        wait(1)
                        elapsedTime = elapsedTime + 1
                    end
                
                    playNextSong()
                end


                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!skip" then
                        playNextSong()
                    end
                end)
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!clean" then
                       game.Players:Chat('fix')
                       game.Players:Chat('removejails')
                       game.Players:Chat('removeclones')
                       game.Players:Chat('ungear me                                                               others fuck')
                       end
                end)
                
                game.Players.LocalPlayer.Chatted:Connect(function(msg)
                    if msg == "!soarcrash" then
                        game.Players:Chat('h/ SoarCrash')
                game.Players:Chat("music 1836807218")
                game.Players:Chat('h/ SoarCrash')
                game.Players:Chat('respawn all all all//')
                wait(0.30)
                for i=1,10 do
                for i=1,99 do
                    game.Players:Chat("shield/all all all youknowsoar")
                    game.Players:Chat('dog all all all justsoar')
                    game.Players:Chat('rocket/all/all/all doingsoarstuff')
                    game.Players:Chat('tp all me')
                    game.Players:Chat('clone all all all')
                    end
                wait(.5)
                for i=1,10 do
                wait(.5)
                game.Players:Chat('clone all all all')
                game.Players:Chat('tp all me')
                game.Players:Chat("shield/all all all fuckin soar is cool")                                                                                                        
                
                for i=1,10 do
                for i=1,99 do
                    game.Players:Chat("shield/all all all soarfuckedthis")
                    game.Players:Chat('dog all all all ordidshe')
                    game.Players:Chat('rocket/all/all/all urgamesweak')
                end
                wait(.5)
                for i=1,10 do
                wait(.5)
                game.Players:Chat("shield/all all all fuckin noobs")
                game.Players:Chat('tp all me')
                game.Players:Chat('clone all all all')
                end
                end
                end
                end
                
                   end
                end)
                
                game.Players:Chat("m/ \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n❤️Now playing from Joey's Playlist❤️\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                
                wait(5)
                
                
                shuffleSongIds()
                
                
                playNextSong()
            end)


--[[addcommand("!playlist2", "desc", function()
    local songIds = {      
        {14884817551, 'jugsta', 'lose yourself'},
        {14884818429, 'jugsta', 'fade away'},
        {14884821038, 'jugsta', 'when im gone'},
        {14884821394, 'jugsta', 'spacin'},
        {14884822465, 'jugsta', 'japan'},
        {14884822914, 'jugsta', 'batman'},
        {14884824647, 'jugsta', 'lies'},
        {15689441013, 'jugsta', 'rampage'},
        {15689441541, 'jugsta', 'ball'},
        {15689442404, 'jugsta', 'dejavus'},
        {15689442645, 'jugsta', 'hatin'},
        {15689442874, 'jugsta', 'ouuu'},
        {15689449215, 'jugsta', 'rockstar'},
        {15689450026, 'jugsta', 'spooky scary skeletons'},
        {15689450321, 'jugsta', 'company'},
        {15689451790, 'jugsta', 'part of me'},
        {15689453751, 'jugsta', 'rampage (sped up)'},
        {16662831606, 'jugsta', 'rampage (other version)'},
        {15689453973, 'jugsta', 'manifest'},
        {15689455568, 'jugsta', 'deja vus 2'},
        {16190758325, 'jugsta', 'cash up'},
        {16190761193, 'jugsta', 'treasury'},
        {16662830706, 'jugsta', 'raining tacos (jugcore cover)'},
        {16662827317, 'jugsta', 'runaway'},
        {17422074348, 'jugsta', 'rampage (ai version)'},
        {14884816847, 'CyPhrix', 'Overthrone'},
        {14884817162, 'CyPhrix', 'Angel Hour'},
        {14884817806, 'CyPhrix', 'Downsample'},
        {14884818123, 'CyPhrix', 'Low Crash'},
        {14884818781, 'CyPhrix', 'Ninovium'},
        {14884819243, 'CyPhrix', 'Fratricide'},
        {14884819670, 'CyPhrix', 'Wobble'},
        {14884820231, 'CyPhrix', 'Stylus'},
        {14884820670, 'CyPhrix', 'Night Voyagers'},
        {14884822175, 'CyPhrix', 'MisunderstoodLife'},
        {14884822656, 'CyPhrix', 'StartUpSequenceCPRX'},
        {14884823178, 'CyPhrix', 'Three Dimensions'},
        {14884823527, 'CyPhrix', 'Outcome'},
        {14884823796, 'CyPhrix', 'XRAY'},
        {14884821842, 'nMisaki', 'Rain'},
        {15689439126, 'nMisaki', 'Help Me'},
        {15689439895, 'nMisaki', 'New Year'},
        {15689440220, 'nMisaki', 'Stussy (sped up)'},
        {15689441943, 'nMisaki', 'All Back'},
        {15689443891, 'nMisaki', 'just dance'},
        {15689446286, 'nMisaki', 'You Won't Find'},
        {15689447739, 'nMisaki', 'In Cosmos'},
        {15689448876, 'nMisaki', 'Angel'},
        {15689450516, 'nMisaki', 'Catching A Vibe'},
        {15689454417, 'nMisaki', 'Dream Girl'},
        {15689454823, 'nMisaki', 'Stussy'},
        {15689455025, 'nMisaki', 'Only Up'},
        {15689455911, 'nMisaki', 'what about me'},
        {15689456690, 'nMisaki', 'Still Luvv'},
        {15689457918, 'nMisaki', 'Dream Girl (sped up)'},
        {16190783444, 'nMisaki', 'Dubidubidu (Techno Remix)'},
        {16190759269, 'nMisaki', 'feat. kovalenkotroon - Cupcake'},
        {16662834857, 'nMisaki', 'let me rethink everything i\'ve done'},
        {16662831303, 'nmisaki', 'so espected'},
        {16662828917, 'nMisaki, ITZTHATPLAYER', 'Just Meet Her'},
        {16662828462, 'nMisaki', 'need you so much (ultra speed up)'},
        {16662827998, 'nMisaki', 'valentines day'},
        {16662833837, 'nMisaki, zangel', 'stupidd (phonk remix)'},
        {17422075331, 'nMisaki', 'u love me too'},
        {17422115184, 'nMisaki, zangel', 'hateonme'},
        {17422126596, 'nMisaki, zangel', 'seas'},
        {17422134302, 'nMisaki', 'Evil Around Me'},
        {17422156350, 'nMisaki', 'friends'},
        {14366983305, '7SAKU7', 'SMOKI'},
        {11496564854, '7SAKU7', 'VVS'},
        {11496566119, '7SAKU7', 'CHILL'},
        {11496567470, '7SAKU7', 'old kilku miesięcy'},
        {13629053065, '7SAKU7', 'SYF'},
        {13629054031, '7SAKU7', 'Cold'},
        {14366938134, '7SAKU7', 'ZAZA'},
        {14366981014, '7SAKU7', 'PRZYJAŹŃ'},
        {14366982317, '7SAKU7', 'GTA'},
        {14366981280, '7SAKU7', 'SMOKI (Nightcore)'},
        {14366981664, '7SAKU7', 'GTA (Nightcore)'},
        {14366982638, '7SAKU7', 'ZAZA (Nightcore)'},
        {14366983007, '7SAKU7', 'PRZYJAŹŃ (Nightcore)'},
        {14884824216, '7SAKU7', 'OFFROAD'},
        {15689440774, '7SAKU7', 'TOP'},
        {15689446286, '7SAKU7', 'WHEELIE'},
        {15689447525, '7SAKU7', 'WALTER 3'},
        {16190784229, '7SAKU7', 'BAŃKA'},
        {16190780842, '7SAKU7', 'BAŃKA (Nightcore)'},
        {17422156009, '7SAKU7', 'MUZYKA'},
        {14366983688, 'DubloX', 'Diss na Hagi Łagi (Nightcore)'},
        {14366981962, 'DubloX', 'Diss na Hagi Lagi (Normal)'},
        {13629050392, 'alajsonn', 'Kitty'},
        {13629053495, 'alajsonn', 'Samoloty z Papieru'},
        {13629054638, 'Mascu', 'Feelings'},
        {11265137944, 'Sirfake', 'Slayers Hatred'},
        {11265140685, 'Sirfake', 'Untitled'},
        {11265145737, 'Sirfake', 'Blaze You'},
        {11265148479, 'Sirfake', 'Amogus'},
        {11265157079, 'Sirfake', 'Advance Slayer'},
        {11265169150, 'Sirfake', 'Fallout'},
        {11265150566, 'Juicy Gius', 'We\'ll See Again'},
        {11265152752, 'Juicy Gius', 'I Made This At Noon'},
        {11265154131, 'Juicy Gius', 'Nas - Skit'},
        {11265155652, 'Juicy Gius', 'Day Or Night'},
        {11265159494, 'Juicy Gius', 'Best Time (To My Girlfriend)'},
        {11265164947, 'Bagieta', 'Chipsy'},
        {11265166921, 'Bagieta', 'Pierniki'},
        {11265173310, 'Bagieta', 'Biszkopty'},
        {11496561844, 'FNA Ttjee', 'Fresh New Age'},
        {11496563535, 'FNA Ttjee', 'Fugaz Fogo'},
        {11496565605, 'FNA Ttjee', 'Volcano'},
        {11496569072, 'FNA Ttjee', 'Big Burning Flames'},
        {11496571729, 'FNA Ttjee', 'Fumofumo'},
        {11496573930, 'FNA Ttjee', 'Stop These Haters'},
        {11496576856, 'FNA Ttjee', 'Fume It'},
        {11496579308, 'FNA Ttjee', 'Fire Taste'},
        {11496581930, 'FNA Ttjee', 'Franz Ferdinand'},
        {11496583957, 'FNA Ttjee', 'The Night'},
        {11496586611, 'FNA Ttjee', 'Hot Summer Days'},
        {11496589677, 'FNA Ttjee', 'Lost Love'},
        {11496592780, 'FNA Ttjee', 'To The Max'},
        {14884815292, 'MajBit', 'BarbaricLand'},
        {14884815897, 'MajBit', 'Violence'},
        {14884816179, 'MajBit', 'Never Gonna Get It'},
        {14884816498, 'MajBit', 'Can\'t Believe'},
        {14884815424, 'nMisaki, Juicy Gius, MajBit', 'Autumn Of My Dreams'},
        {14884816689, 'MajBit', 'In Fire'},
        {14884816291, 'MajBit', 'Out There'},
        {14884817057, 'MajBit', 'Why This Happened'},
        {14884817245, 'MajBit', 'YodoVikings'},
        {14884817433, 'MajBit', 'PastTime'},
        {14884817622, 'MajBit', 'Naw Happenin\''},
        {14884817827, 'MajBit', 'I Do What I Can'},
        {14884818030, 'MajBit', 'I\'m A Bad Guy'},
        {14884818272, 'MajBit', 'Takin What\'s Mine'},
        {14884818493, 'MajBit', 'Don\'t Care'},
        {14884818699, 'MajBit', 'Give Up The Game'},
        {14884818864, 'MajBit', 'There For You'},
        {14884819091, 'MajBit', 'Get Off My Way'},
        {14884819252, 'MajBit', 'Bring The Heat'},
        {14884819391, 'MajBit', 'Just So Much Fun'},
        {14884819571, 'MajBit', 'Totally Not Good'},
        {14884819767, 'MajBit', 'Not My Life'},
        {14884820027, 'MajBit', 'No Free Rides'},
        {14884820224, 'MajBit', 'The Worst'},
        {14884820425, 'MajBit', 'Nefarious'},
        {14884820595, 'MajBit', 'Like A Dog'},
        {14884820768, 'MajBit', 'This Is So Bad'},
        {14884820964, 'MajBit', 'Quit Playin'},
        {14884821152, 'MajBit', 'Take My Love'},
        {14884821332, 'MajBit', 'Totally Ruined'},
        {14884821539, 'MajBit', 'Got No Life'},
        {14884821716, 'MajBit', 'This Is The Worst'},
        {14884821919, 'MajBit', 'No Fun At All'},
        {14884822095, 'MajBit', 'You Ruined Everything'},
        {14884822297, 'MajBit', 'A Bad Song'},
        {14884822482, 'MajBit', 'Totally Lame'},
        {14884822683, 'MajBit', 'Worst Day Ever'},
        {14884822887, 'MajBit', 'Nothing Good'}
    }
    
    local currentIndex = 1
    local isShuffled = false
    local isPlaying = false
    local stopRequested = false

    -- Shuffle the playlist
    local function shufflePlaylist()
        for i = #songIds, 2, -1 do
            local j = math.random(i)
            songIds[i], songIds[j] = songIds[j], songIds[i]
        end
    end

    -- Play the current song
    local function playCurrentSong()
        if not stopRequested then
            local song = songIds[currentIndex]
            local songId, creator, title = song[1], song[2], song[3]
            play(songId)
            say('Now playing: ' .. creator .. ' - ' .. title .. ' (' .. currentIndex .. '/' .. #songIds .. ')')
        end
    end

    -- Stop playing
    local function stopPlaying()
        stop()
        isPlaying = false
        stopRequested = false
    end

    -- Go to the next song
    local function nextSong()
        currentIndex = currentIndex + 1
        if currentIndex > #songIds then
            currentIndex = 1
        end
        playCurrentSong()
    end

    -- Shuffle command
    addcommand("!shuffle", "desc", function()
        if not isShuffled then
            shufflePlaylist()
            isShuffled = true
            say('Playlist shuffled.')
        else
            say('Playlist is already shuffled.')
        end
    end)

    -- Stop command
    addcommand("!stop", "desc", function()
        if isPlaying then
            stopRequested = true
            stopPlaying()
            say('Playback stopped.')
        else
            say('No song is currently playing.')
        end
    end)

    -- Play command
    addcommand("!play", "desc", function()
        if not isPlaying then
            isPlaying = true
            playCurrentSong()
        else
            say('A song is already playing.')
        end
    end)

    -- Next song command
    addcommand("!next", "desc", function()
        if isPlaying then
            nextSong()
            say('Playing next song.')
        else
            say('No song is currently playing.')
        end
    end)

    -- Initial shuffle and play
    shufflePlaylist()
    isShuffled = true
    isPlaying = true
    playCurrentSong()
end)]]


	addcommand("srail",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				local amount = 0
				local playertarg = Target.Name
				repeat
					amount = 0
					tchat("gear me "..string.rep("0", math.random(50, 100)).."79446473")
					for i, v in pairs(players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == "Railgun" then
							amount = amount +1
						end
					end
					game:GetService("RunService").Heartbeat:wait()
				until amount >= 100
				task.wait(.2)
				local tppos = true
				local grav = game.Workspace.Gravity
				tchat("invis me")
				tchat("ungod "..playertarg)
				tchat("speed "..playertarg.." 0")
				tchat("unff "..playertarg)
				wait(.2)
				spawn(function()
					while tppos == true do
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 10, 0))		
						for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.CanCollide = false
							end
						end	
						game.Workspace.Gravity = 0
						if tppos == false then break end
						game:GetService("RunService").Heartbeat:wait()
					end
				end)
				local cf = CFrame.new(Vector3.new(0,4,0))
				local segments = 100
				local radius = 15
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(math.random(1, 20),math.rad(angle),math.random(1, 20))
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					coroutine.wrap(function()
						pcall(function()
							v.Parent = game.Players.LocalPlayer.Character
							v.GripPos = Positions[i]
						end)
					end)()
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then 
						local player = game.Players.LocalPlayer
						local Mouse = player:GetMouse()
						local num = math.random(1,6)
						local te = Target.Character
						local partcheck = {te:FindFirstChild("Right Leg"), te:FindFirstChild("Left Leg"), te:FindFirstChild("Head") ,te:FindFirstChild("Left Arm") ,te:FindFirstChild("Right Arm"), te:FindFirstChild("HumanoidRootPart"), te:FindFirstChild("Torso")}
						local target = partcheck[math.random(1, #partcheck)]
						local args = {
							[1] = te.HumanoidRootPart.Position 
						}

						v.Click:FireServer(unpack(args))
					end
				end
				wait(.1)
				tppos = false
				wait(.1)
				tchat("unname "..playertarg)
				tchat("vis me")
				tchat("ungear me")
				game.Workspace.Gravity = grav
			end
		end)
        
        


    local gearmods = {
        laser = {139578207}
    }



        getgenv().giantcock = false








    addcommand("g/c", -- cock script
		"desc",
		function()
            
repeat task.wait(.1)
    hasenoughcocks = false

    gearid = '356212933'
    toolname = 'SteampunkSteamGun'
    
    if getgenv().giantcock == false then
        getgenv().cockamount = 180 -- need to keep it to scale ofc
    else
        getgenv().cockamount = 450
    end
    


    for i = 1, math.ceil(cockamount/3) do 
    task.wait()
    game.Players:Chat("gear me "..gearid)
    end
    
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
    if i >= cockamount then
    hasenoughcocks = true
    end
    end
    
    until hasenoughcocks == true
    

    
   repeat     task.wait()
        game.Players:Chat("gear me 34399428")
   until plr.Backpack:FindFirstChild("ConfettiCannon")

    
    
    loop = cockamount / 7 -- amount of guns used on each angle, dont need to change
    
    
    local ballradius = 1
    local cockradius = 0.7

   -- jesus christ

    local lp = game.Players.LocalPlayer
    local Position = lp.Character.HumanoidRootPart.CFrame

    
    for i = 1, loop do
    tool = lp.Backpack:FindFirstChild(toolname)
    tool.GripPos = Vector3.new((ballradius * math.cos(i) + 0),(ballradius * math.sin(i) + 2), tool.Handle.Position.Z + -21)
    tool.Parent = lp.Character
    end
    
    for i = 1, loop do
    tool = lp.Backpack:FindFirstChild(toolname)
    tool.GripPos = Vector3.new((ballradius * math.cos(i) + 3),(ballradius * math.sin(i) + 2), tool.Handle.Position.Z + -21)
    tool.Parent = lp.Character
    end
    
    for i = 1, loop do
    tool = lp.Backpack:FindFirstChild(toolname)
    tool.GripPos = Vector3.new((ballradius * math.cos(i) + 1.5),(cockradius * math.sin(i) + 2), tool.Handle.Position.Z + -21)
    tool.Parent = lp.Character
    end
    
    
    for i = 1, loop do
    tool = lp.Backpack:FindFirstChild(toolname)
    tool.GripPos = Vector3.new((cockradius * math.cos(i) + 1.5),(cockradius * math.sin(i) + 2), tool.Handle.Position.Z + -18)
    tool.Parent = lp.Character
    tool.Handle.Velocity = Vector3.new(1000, 1000, 10000)
    end
    
    for i = 1, loop do
    tool = lp.Backpack:FindFirstChild(toolname)
    tool.GripPos = Vector3.new((cockradius * math.cos(i) + 1.5),(cockradius * math.sin(i) + 2), tool.Handle.Position.Z + -15)
    tool.Parent = lp.Character
    tool.Handle.Velocity = Vector3.new(1000, 1000, 10000)
    end

    for i = 1, loop do
        tool = lp.Backpack:FindFirstChild(toolname)
        tool.GripPos = Vector3.new((cockradius * math.cos(i) + 1.5),(cockradius * math.sin(i) + 2), tool.Handle.Position.Z + -12)
        tool.Parent = lp.Character
        tool.Handle.Velocity = Vector3.new(1000, 1000, 10000)
        end

        tool = lp.Backpack:FindFirstChild("ConfettiCannon")
        tool.GripPos = Vector3.new((1 * math.cos(1) + 1),(cockradius * math.sin(1) + 1.7), tool.Handle.Position.Z + 12.5)
        tool.Parent = lp.Character
        tool.Handle.Velocity = Vector3.new(1000, 1000, 10000)







    
    
    
    
end)   




	

    addcommand("laser",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				for i = 1, 270 do
					tchat("gear me 00000000000000000000000000000000000000000000000000139578207")
				end
				wait(1.1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					pcall(function()
						v.Parent = game.Players.LocalPlayer.Character
						player = game.Players.LocalPlayer
						local Mouse = game.Players.LocalPlayer:GetMouse()
						num = math.random(1,6)
						local te = Target.Character
						if num == 1 then
							target = te:FindFirstChild("Left Leg")
						elseif num == 2 then
							target = te:FindFirstChild("Right Leg")
						elseif num == 3 then
							target = te:FindFirstChild("Head")
						elseif num == 4 then
							target = te:FindFirstChild("Left Arm")
						elseif num == 5 then
							target = te:FindFirstChild("Right Arm")
						elseif num == 6 then
							target = te:FindFirstChild("HumanoidRootPart")
						end
						-- Script generated by SimpleSpy - credits to exx#9394

						args = {
							[1] = target.Position --[[Vector3]]
						}

						game:GetService("Players").LocalPlayer.Character.TriLaserGun.Click:FireServer(unpack(args))
						game:GetService("RunService").Heartbeat:wait()
						game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
					end)
				end
			end
		end)	

        getgenv().laser = true
        getgenv().gungame = 'TriLaserGun'


        addcommand("osclose",
		"desc",
		function()

            for i = 1, 10 do 
                game.Players:Chat("gear me 92628079")
                end
            
                repeat task.wait() until plr.Backpack:FindFirstChild("OrinthianSwordAndShield")

                for i, v in pairs(plr.Backpack:GetChildren()) do 
                    if v.Name == 'OrinthianSwordAndShield' then 
                        v.Parent = plr.Character 
                    end 
                end 
                repeat task.wait() until plr.Character:FindFirstChild("OrinthianSwordAndShield")
                spawn(function()
                for i, v in pairs(plr.Character:GetChildren()) do 
                    if v.Name == 'OrinthianSwordAndShield' then 
                        v:Activate()
                    end 
                end 
            end) 
                for i = 1, 10 do 
                    tchat("size me .3")
                end 
            end)


            addcommand("glag",
		"desc",
		function()
            for i = 1, tonumber(args[2]) do 
                game.Players:Chat("gear me 92628079")
                end

            end)




        addcommand("gunswitch",
		"desc",
		function()
            if getgenv().laser == true then 
            getgenv().laser = false
            getgenv().gungame = 'Railgun'
            else 
                getgenv().laser = true 
        getgenv().gungame = 'TriLaserGun'
            end 
        end)

        addcommand("gungame",
		"desc",
		function()
            local segment = tonumber(args[2])
            amount = 100
            loop = 10
repeat task.wait()
    if getgenv().laser == true then
				for i = 1, 100 do 
					tchat("gear me 139578207")
                end
            else
                for i = 1, 100 do 
					tchat("gear me 079446473")
                end
            end
                task.wait(.5)

        until #plr.Backpack:GetChildren() >= amount

					task.wait(1)
   for i = 1, loop do 
      
                 cf = CFrame.new(Vector3.new(0,-i+3,0))
                 print(segment)
				local segments = segment
				local radius = 5
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(0,math.rad(angle),0)
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
                if i == 1 then 
                    coroutine.wrap(function()
                        tchat("music 3666863095")
                        task.wait(1)
                        tchat("music")
            
                    end)()
                end

                if i == loop then 
                    coroutine.wrap(function()
                        ids = {3418223760,4481540947}
                        if getgenv().laser == true then
                        tchat("music "..ids[1])
                        task.wait(.7)
                        tchat("music")
                        else 
                            tchat("music "..ids[2])
                        task.wait(.5)
                        tchat("music")
                        end
            
                    end)()
                end
				
                for i = 1, amount/loop do
                  v = plr.Backpack:FindFirstChild(getgenv().gungame)
						pcall(function()
							v.Parent = plr.Character
							v.GripPos = Positions[i]
						end)
                end
                for i = 1, #Positions do 
                    table.remove(Positions, i)
                end 
                task.wait(.2)


    end
            wait(1)
				
		end)

        addcommand("res",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
               getgenv().ress = true 
                while task.wait(.1) do
                    if getgenv().ress == true then 
                    tchat("explode "..Target.Name..", "..Target.Name..", "..Target.Name) 
                    task.wait(.1)
                    tchat("respawn "..Target.Name..", "..Target.Name..", "..Target.Name)
                    else break end 
                end


            end 
        end)

        addcommand("unres",
		"desc",
		function()
            getgenv().ress = false 
        end)

        addcommand("shoot",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do

                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then 
                        spawn(function()
			
						local args = {
							[1] = Target.Character.HumanoidRootPart.Position 
						}

						v.Click:FireServer(unpack(args))
                    end)
					end
				end
            end
            end)

            addcommand("rapidfire",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
  
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then 
                        spawn(function()
			   for i = 1, 3 do 
						local args = {
							[1] = Target.Character.HumanoidRootPart.Position 
						}

						v.Click:FireServer(unpack(args))
                    end
                    end)
                    task.wait()
					end
				end
            end
            end)

	addcommand("cray",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				local amount = 0
				local playertarg = Target.Name
				repeat
					amount = 0
					tchat("gear me "..string.rep("0", math.random(50, 100)).."139578207")
					for i, v in pairs(players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == "TriLaserGun" then
							amount = amount +1
						end
					end
					game:GetService("RunService").Heartbeat:wait()
				until amount >= 100
				wait(.1)
				local tppos = true
				local grav = game.Workspace.Gravity
				tchat("invis me")
				tchat("ungod "..playertarg)
				tchat("speed "..playertarg.." 0")
				tchat("unff "..playertarg)
				wait(.2)
				spawn(function()
					while tppos == true do
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 10, 0))		
						for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.CanCollide = false
							end
						end	
						game.Workspace.Gravity = 0
						if tppos == false then break end
						game:GetService("RunService").Heartbeat:wait()
					end
				end)
				local cf = CFrame.new(Vector3.new(0,4,0))
				local segments = 100
				local radius = 25
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(0,math.rad(angle),0)
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					coroutine.wrap(function()
						pcall(function()
							v.Parent = game.Players.LocalPlayer.Character
							v.GripPos = Positions[i]
						end)
					end)()
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then 
						local player = game.Players.LocalPlayer
						local Mouse = player:GetMouse()
						local num = math.random(1,6)
						local te = Target.Character
						local partcheck = {te:FindFirstChild("Right Leg"), te:FindFirstChild("Left Leg"), te:FindFirstChild("Head") ,te:FindFirstChild("Left Arm") ,te:FindFirstChild("Right Arm"), te:FindFirstChild("HumanoidRootPart"), te:FindFirstChild("Torso")}
						local target = partcheck[math.random(1, #partcheck)]
						local args = {
							[1] = te.HumanoidRootPart.Position 
						}

						v.Click:FireServer(unpack(args))
					end
				end
				wait(.1)
				tppos = false
				wait(.1)
				tchat("unname "..playertarg)
				tchat("vis me")
				tchat("ungear me")
				game.Workspace.Gravity = grav
			end
		end)


        addcommand("movespawn",
		"desc",
		function()
            for _Index, Target in pairs(GetPlayer(args[2])) do




        function movepart(target)
            local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
            local looping = true
            spawn(function()
                while true do
                    game:GetService("RunService").Heartbeat:Wait()
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                    cf.CFrame = target.CFrame * CFrame.new(-1 * (target.Size.X / 2) - (game.Players.LocalPlayer.Character.Torso.Size.X / 2), 0, 0)
                    if not looping then
                        break
                    end
                end
            end)
            spawn(function()
                while looping do
                    wait(0.1)
                    game.Players:Chat("unpunish me")
                end
            end)
            wait(0.3)
            looping = false
            tchat("tp me "..Target.Name)
            task.wait(.4)
            tchat("respawn me")
            task.wait(.3)
        end

        movepart(workspace.Terrain._Game.Workspace.Spawn1)
        task.wait(1)
        movepart(workspace.Terrain._Game.Workspace.Spawn2)
        task.wait(1)
        movepart(workspace.Terrain._Game.Workspace.Spawn3)



        game.Players:Chat("invis me")
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = 0.3
    end
end)







        addcommand("/a",
		"desc",
		function()
            local btool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
local SelectionBox = Instance.new("SelectionBox", game.Workspace)
local hammer = Instance.new("Part")
hammer.Parent = btool
hammer.Name = "Handle"
hammer.CanCollide = false
hammer.Anchored = false

SelectionBox.Name = "oof"
SelectionBox.LineThickness = 0.05
SelectionBox.Adornee = nil
SelectionBox.Color3 = Color3.fromRGB(0, 0, 255)
SelectionBox.Visible = false
btool.Name = "Attach Tool"
btool.RequiresHandle = false
local IsEquipped = false
local Mouse = game.Players.LocalPlayer:GetMouse()

btool.Equipped:Connect(function()
    IsEquipped = true
    SelectionBox.Visible = true
    SelectionBox.Adornee = nil
end)

btool.Unequipped:Connect(function()
    IsEquipped = false
    SelectionBox.Visible = false
    SelectionBox.Adornee = nil
end)

btool.Activated:Connect(function()
    if IsEquipped then
        btool.Parent = game.Chat
        local ex = Instance.new("Explosion")
        ex.BlastRadius = 0
        ex.Position = Mouse.Target.Position
        ex.Parent = game.Workspace

        local target = Mouse.Target

        function movepart()
            local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
            local looping = true
            spawn(function()
                while true do
                    game:GetService("RunService").Heartbeat:Wait()
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                    cf.CFrame = target.CFrame * CFrame.new(-1 * (target.Size.X / 2) - (game.Players.LocalPlayer.Character.Torso.Size.X / 2), 0, 0)
                    if not looping then
                        break
                    end
                end
            end)
            spawn(function()
                while looping do
                    wait(0.1)
                    game.Players:Chat("unpunish me")
                end
            end)
            wait(0.25)
            looping = false
        end

        movepart()
        game.Chat["Attach Tool"].Parent = game.Players.LocalPlayer.Backpack
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame

        spawn(function()
            wait(3)
            if game.Chat:FindFirstChild("Attach Tool") then
                game.Chat["Attach Tool"]:Destroy()
            end
        end)

        game.Players:Chat("invis me")
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = 0.3
    end
end)

while true do
    SelectionBox.Adornee = Mouse.Target or nil
    wait(0.1)
end


        end)

        addcommand("fgear",
        "desc",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                
                if args[4] and args[4] ~= "" then  
                _G.gear = args[3].."%"..args[4] 
                else 
                    _G.gear = args[3]
                end 
                local gearapi = "https://catalog.roblox.com/v1/search/items?category=Accessories&limit=120&subcategory=Gear&includeNotForSale=true&keyword=".._G.gear.."&limit=120"
                local nm = {}
                for i = 1, 100 do 
                    table.insert(nm,i)
                end

                response = http:JSONDecode(game:HttpGet(gearapi))
                    for i = 1, 200 do 
                        task.wait(.1)
                    tchat("gear "..Target.Name.." "..response.data[i].id)
                end
                    

            end 
        end)
                



	addcommand("ssnek",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				local amount = 0
				local playertarg = Target.Name
				repeat
					amount = 0
					tchat("gear me "..string.rep("0", math.random(50, 100)).."113299620")
					for i, v in pairs(players.LocalPlayer.Backpack:GetChildren()) do
						if v.Name == "Snake Sniper" then
							amount = amount +1
						end
					end
					game:GetService("RunService").Heartbeat:wait()
				until amount >= 100
				task.wait(.2)
				local tppos = true
				local grav = game.Workspace.Gravity
				tchat("invis me")
				tchat("speed "..playertarg.." 0")
				tchat("god "..Target.Name)
				wait(.2)
				spawn(function()
					while tppos == true do
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0, 10, 0))		
						for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
							if v:IsA("Part") then
								v.CanCollide = false
							end
						end	
						game.Workspace.Gravity = 0
						if tppos == false then break end
						game:GetService("RunService").Heartbeat:wait()
					end
				end)
				local cf = CFrame.new(Vector3.new(0,4,0))
				local segments = 100
				local radius = 18
				local Positions = {}
				local single = 360/segments

				for i = 1, segments do
					local angle = single*i
					local cheating = cf * CFrame.Angles(math.random(1, 10),math.rad(angle),math.random(1, 10))
					table.insert(Positions, cheating.Position + cheating.LookVector * radius)
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					coroutine.wrap(function()
						pcall(function()
							v.Parent = game.Players.LocalPlayer.Character
							v.GripPos = Positions[i]
						end)
					end)()
				end
				wait(1)
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("Tool") then 
						local player = game.Players.LocalPlayer
						local Mouse = player:GetMouse()
						local num = math.random(1,6)
						local te = Target.Character
						local partcheck = {te:FindFirstChild("Right Leg"), te:FindFirstChild("Left Leg"), te:FindFirstChild("Head") ,te:FindFirstChild("Left Arm") ,te:FindFirstChild("Right Arm"), te:FindFirstChild("HumanoidRootPart"), te:FindFirstChild("Torso")}
						local target = partcheck[math.random(1, #partcheck)]
						local args = {
							[1] = te.HumanoidRootPart.Position 
						}

						-- Script generated by SimpleSpy - credits to exx#9394
						v.MousePos:FireServer(unpack(args))	
						v.MouseDown:FireServer()
						v.MouseUp:FireServer()
					end
				end
				wait(.1)
				tppos = false
				wait(.1)
				tchat("unname "..playertarg)
				tchat("vis me")
				tchat("ungear me")
				tchat("speed "..playertarg.." 16")
				game.Workspace.Gravity = grav
			end
		end)
	
        addcommand("dfcolour",
		"desc",
		function()
            colorAPI = {}

colorAPI.color = function(Part, color)
	local thread = coroutine.create(function() -- x3.5 speed boost
		local Arguments =
        {
            ["Part"] = Part,
            ["Color"] = color
        }
        game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name].PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", Arguments)
	end)
	coroutine.resume(thread)
end

colorAPI.transformToColor3 = function(col)
    local r = col.r
    local g = col.g
    local b = col.b
    return Color3.new(r,g,b);
end

-- colorAPI.Color3 = function(brickColor)
--     return colorAPI.transformToColor3(BrickColor.new(brickColor))
-- end

colorAPI.colorObbyBox = function(color) -- Default is "Teal"
	for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Obby Box"]:GetChildren()) do
		colorAPI.color(v, color) -- colorAPI.transformToColor3(BrickColor.new("Bright red"))
	end
end

colorAPI.colorObbyBricks = function(color)-- Default is "Really red"
	  for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Obby"]:GetChildren()) do
		colorAPI.color(v, color)
	end
end

colorAPI.colorAdminDivs = function(color)-- Default is "Dark stone grey"
	for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Admin Dividers"]:GetChildren()) do
		colorAPI.color(v, color)
	end
end

colorAPI.colorPads = function(color)-- Default is "Bright green"
	for i,v in pairs(game.Workspace.Terrain["_Game"].Admin["Pads"]:GetChildren()) do
		colorAPI.color(v.Head, color)
	end
end

colorAPI.colorHouse = function(arg)
	  local wallsC = arg.wallsC
	  local baseC = arg.baseC
	  local roofC = arg.roofC
	  local WANDDC = arg.WANDDC
	  local stairsC = arg.stairsC
	  local floorC = arg.floorC
	  local rooftsC = arg.rooftsC
	  local chiC = arg.chiC
	  
	  -------------------------------------------------------------------- House (really messy ik) --------------------------------------------------------------------
	  
		for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Basic House"]:GetChildren()) do
			coroutine.wrap(function()
					if v.Name == "SmoothBlockModel103" or v.Name == "SmoothBlockModel105" or v.Name == "SmoothBlockModel106" or v.Name == "SmoothBlockModel108" or v.Name == "SmoothBlockModel11" or v.Name == "SmoothBlockModel113" or v.Name == "SmoothBlockModel114" or v.Name == "SmoothBlockModel115" or v.Name == "SmoothBlockModel116" or v.Name == "SmoothBlockModel118" or v.Name == "SmoothBlockModel122" or v.Name == "SmoothBlockModel126" or v.Name == "SmoothBlockModel129" or v.Name == "SmoothBlockModel13" or v.Name == "SmoothBlockModel130" or v.Name == "SmoothBlockModel131" or v.Name == "SmoothBlockModel132" or v.Name == "SmoothBlockModel134" or v.Name == "SmoothBlockModel135" or v.Name == "SmoothBlockModel14" or v.Name == "SmoothBlockModel140" or v.Name == "SmoothBlockModel142" or v.Name == "SmoothBlockModel147" or v.Name == "SmoothBlockModel15" or v.Name == "SmoothBlockModel154" or v.Name == "SmoothBlockModel155" or v.Name == "SmoothBlockModel164" or v.Name == "SmoothBlockModel166" or v.Name == "SmoothBlockModel173" or v.Name == "SmoothBlockModel176" or v.Name == "SmoothBlockModel179" or v.Name == "SmoothBlockModel185" or v.Name == "SmoothBlockModel186" or v.Name == "SmoothBlockModel190" or v.Name == "SmoothBlockModel191" or v.Name == "SmoothBlockModel196" or v.Name == "SmoothBlockModel197" or v.Name == "SmoothBlockModel198" or v.Name == "SmoothBlockModel20" or v.Name == "SmoothBlockModel201" or v.Name == "SmoothBlockModel203" or v.Name == "SmoothBlockModel205" or v.Name == "SmoothBlockModel207" or v.Name == "SmoothBlockModel208" or v.Name == "SmoothBlockModel209" or v.Name == "SmoothBlockModel210" or v.Name == "SmoothBlockModel211" or v.Name == "SmoothBlockModel213" or v.Name == "SmoothBlockModel218" or v.Name == "SmoothBlockModel22" or v.Name == "SmoothBlockModel223" or v.Name == "SmoothBlockModel224" or v.Name == "SmoothBlockModel226" or v.Name == "SmoothBlockModel26" or v.Name == "SmoothBlockModel29" or v.Name == "SmoothBlockModel30" or v.Name == "SmoothBlockModel31" or v.Name == "SmoothBlockModel36" or v.Name == "SmoothBlockModel37" or v.Name == "SmoothBlockModel38" or v.Name == "SmoothBlockModel39" or v.Name == "SmoothBlockModel41" or v.Name == "SmoothBlockModel48" or v.Name == "SmoothBlockModel49" or v.Name == "SmoothBlockModel51" or v.Name == "SmoothBlockModel56" or v.Name == "SmoothBlockModel67" or v.Name == "SmoothBlockModel68" or v.Name == "SmoothBlockModel69" or v.Name == "SmoothBlockModel70" or v.Name == "SmoothBlockModel72" or v.Name == "SmoothBlockModel75" or v.Name == "SmoothBlockModel8" or v.Name == "SmoothBlockModel81" or v.Name == "SmoothBlockModel85" or v.Name == "SmoothBlockModel93" or v.Name == "SmoothBlockModel98" then
						colorAPI.color(v, wallsC) -- Default is "Brick yellow"
					end -- House walls
				
					if v.Name == "SmoothBlockModel40" then
						colorAPI.color(v, baseC) -- Default is "Bright green"
					end -- House grass base
				
					if v.Name == "SmoothBlockModel100" or v.Name == "SmoothBlockModel102" or v.Name == "SmoothBlockModel104" or v.Name == "SmoothBlockModel107" or v.Name == "SmoothBlockModel109" or v.Name == "SmoothBlockModel110" or v.Name == "SmoothBlockModel111" or v.Name == "SmoothBlockModel119" or v.Name == "SmoothBlockModel12" or v.Name == "SmoothBlockModel120" or v.Name == "SmoothBlockModel123" or v.Name == "SmoothBlockModel124" or v.Name == "SmoothBlockModel125" or v.Name == "SmoothBlockModel127" or v.Name == "SmoothBlockModel128" or v.Name == "SmoothBlockModel133" or v.Name == "SmoothBlockModel136" or v.Name == "SmoothBlockModel137" or v.Name == "SmoothBlockModel138" or v.Name == "SmoothBlockModel139" or v.Name == "SmoothBlockModel141" or v.Name == "SmoothBlockModel143" or v.Name == "SmoothBlockModel149" or v.Name == "SmoothBlockModel151" or v.Name == "SmoothBlockModel152" or v.Name == "SmoothBlockModel153" or v.Name == "SmoothBlockModel156" or v.Name == "SmoothBlockModel157" or v.Name == "SmoothBlockModel158" or v.Name == "SmoothBlockModel16" or v.Name == "SmoothBlockModel163" or v.Name == "SmoothBlockModel167" or v.Name == "SmoothBlockModel168" or v.Name == "SmoothBlockModel169" or v.Name == "SmoothBlockModel17" or v.Name == "SmoothBlockModel170" or v.Name == "SmoothBlockModel172" or v.Name == "SmoothBlockModel177" or v.Name == "SmoothBlockModel18" or v.Name == "SmoothBlockModel180" or v.Name == "SmoothBlockModel184" or v.Name == "SmoothBlockModel187" or v.Name == "SmoothBlockModel188" or v.Name == "SmoothBlockModel189" or v.Name == "SmoothBlockModel19" or v.Name == "SmoothBlockModel193" or v.Name == "SmoothBlockModel2" or v.Name == "SmoothBlockModel200" or v.Name == "SmoothBlockModel202" or v.Name == "SmoothBlockModel21" or v.Name == "SmoothBlockModel214" or v.Name == "SmoothBlockModel215" or v.Name == "SmoothBlockModel216" or v.Name == "SmoothBlockModel219" or v.Name == "SmoothBlockModel220" or v.Name == "SmoothBlockModel221" or v.Name == "SmoothBlockModel222" or v.Name == "SmoothBlockModel225" or v.Name == "SmoothBlockModel227" or v.Name == "SmoothBlockModel229" or v.Name == "SmoothBlockModel23" or v.Name == "SmoothBlockModel230" or v.Name == "SmoothBlockModel231" or v.Name == "SmoothBlockModel25" or v.Name == "SmoothBlockModel28" or v.Name == "SmoothBlockModel32" or v.Name == "SmoothBlockModel33" or v.Name == "SmoothBlockModel34" or v.Name == "SmoothBlockModel42" or v.Name == "SmoothBlockModel44" or v.Name == "SmoothBlockModel47" or v.Name == "SmoothBlockModel54" or v.Name == "SmoothBlockModel55" or v.Name == "SmoothBlockModel58" or v.Name == "SmoothBlockModel59" or v.Name == "SmoothBlockModel6" or v.Name == "SmoothBlockModel61" or v.Name == "SmoothBlockModel62" or v.Name == "SmoothBlockModel63" or v.Name == "SmoothBlockModel74" or v.Name == "SmoothBlockModel76" or v.Name == "SmoothBlockModel77" or v.Name == "SmoothBlockModel78" or v.Name == "SmoothBlockModel79" or v.Name == "SmoothBlockModel80" or v.Name == "SmoothBlockModel84" or v.Name == "SmoothBlockModel86" or v.Name == "SmoothBlockModel87" or v.Name == "SmoothBlockModel88" or v.Name == "SmoothBlockModel90" or v.Name == "SmoothBlockModel91" or v.Name == "SmoothBlockModel92" or v.Name == "SmoothBlockModel94" or v.Name == "SmoothBlockModel95" or v.Name == "SmoothBlockModel96" then
						colorAPI.color(v, roofC) -- Default is "Bright red"
					end -- House roof
				
					if v.Name == "SmoothBlockModel10" or v.Name == "SmoothBlockModel101" or v.Name == "SmoothBlockModel117" or v.Name == "SmoothBlockModel121" or v.Name == "SmoothBlockModel144" or v.Name == "SmoothBlockModel145" or v.Name == "SmoothBlockModel146" or v.Name == "SmoothBlockModel148" or v.Name == "SmoothBlockModel150" or v.Name == "SmoothBlockModel159" or v.Name == "SmoothBlockModel161" or v.Name == "SmoothBlockModel171" or v.Name == "SmoothBlockModel174" or v.Name == "SmoothBlockModel175" or v.Name == "SmoothBlockModel181" or v.Name == "SmoothBlockModel182" or v.Name == "SmoothBlockModel183" or v.Name == "SmoothBlockModel192" or v.Name == "SmoothBlockModel194" or v.Name == "SmoothBlockModel195" or v.Name == "SmoothBlockModel199" or v.Name == "SmoothBlockModel204" or v.Name == "SmoothBlockModel206" or v.Name == "SmoothBlockModel212" or v.Name == "SmoothBlockModel217" or v.Name == "SmoothBlockModel228" or v.Name == "SmoothBlockModel24" or v.Name == "SmoothBlockModel27" or v.Name == "SmoothBlockModel35" or v.Name == "SmoothBlockModel4" or v.Name == "SmoothBlockModel43" or v.Name == "SmoothBlockModel45" or v.Name == "SmoothBlockModel46" or v.Name == "SmoothBlockModel50" or v.Name == "SmoothBlockModel53" or v.Name == "SmoothBlockModel57" or v.Name == "SmoothBlockModel60" or v.Name == "SmoothBlockModel64" or v.Name == "SmoothBlockModel65" or v.Name == "SmoothBlockModel66" or v.Name == "SmoothBlockModel7" or v.Name == "SmoothBlockModel71" or v.Name == "SmoothBlockModel73" or v.Name == "SmoothBlockModel82" or v.Name == "SmoothBlockModel83" or v.Name == "SmoothBlockModel89" or v.Name == "SmoothBlockModel99" then
						colorAPI.color(v, WANDDC) -- Default is "Dark orange"
					end -- House windows and door outlines
				
					if v.Name == "SmoothBlockModel1" or v.Name == "SmoothBlockModel3" or v.Name == "SmoothBlockModel5" or v.Name == "SmoothBlockModel9" then
						colorAPI.color(v, stairsC) -- Default is "Dark stone grey"
					end -- House Stairs
				
					if v.Name == "SmoothBlockModel112" then
						colorAPI.color(v, floorC) -- Default is "Medium blue"
					end -- House floor
				
					if v.Name == "SmoothBlockModel52" or v.Name == "SmoothBlockModel97" then
						colorAPI.color(v, rooftsC) -- Default is "Reddish brown"
					end -- House roof thingys
				
					if v.Name == "SmoothBlockModel160" or v.Name == "SmoothBlockModel162" or v.Name == "SmoothBlockModel165" or v.Name == "SmoothBlockModel178" then
						colorAPI.color(v, chiC) -- Default is "Sand red"
					end -- Chi top part
			end)()
		end
end

colorAPI.colorBuildingBricks = function(arg)
		local DarkStoneGrey = arg.DarkStoneGrey
		local DeepBlue = arg.DeepBlue
		local NY = arg.NY
		local IW = arg.IW
		local LimeGreen = arg.LimeGreen
		local MSG = arg.MSG
		local RB = arg.RB
		local RR = arg.RR
		local TP = arg.TP
		
		-------------------------------------------------------------------- Building Bricks --------------------------------------------------------------------
	  
		for i,v in pairs(game.Workspace.Terrain["_Game"].Workspace["Building Bricks"]:GetChildren()) do
			coroutine.wrap(function()
				if v.Name == "Part29" or v.Name == "Part31" or v.Name == "Part55" then
					colorAPI.color(v, DarkStoneGrey) -- Default is "Dark stone grey"
				end
				
				if v.Name == "Part11" or v.Name == "Part18" or v.Name == "Part25" or v.Name == "Part3" or v.Name == "Part43" then
					colorAPI.color(v, DeepBlue) -- Default is "Deep blue"
				end
				
				if v.Name == "Part12" or v.Name == "Part15" or v.Name == "Part24" or v.Name == "Part44" or v.Name == "Part6" then
					colorAPI.color(v, NY) -- Default is "New Yeller"
				end
				
				if v.Name == "Part13" or v.Name == "Part21" or v.Name == "Part23" or v.Name == "Part7" then
					colorAPI.color(v, IW) -- Default is "Institutional white"
				end
				
				if v.Name == "Part17" or v.Name == "Part26" or v.Name == "Part38" or v.Name == "Part9" or v.Name == "Part5" then
					colorAPI.color(v, LimeGreen) -- Default is "Lime green"
				end
				
				if v.Name == "Part30" or v.Name == "Part32" or v.Name == "Part33" or v.Name == "Part34" or v.Name == "Part35" or v.Name == "Part36" or v.Name == "Part39" or v.Name == "Part40" or v.Name == "Part41" or v.Name == "Part42" or v.Name == "Part46" or v.Name == "Part47" or v.Name == "Part48" or v.Name == "Part49" or v.Name == "Part50" or v.Name == "Part51" or v.Name == "Part52" or v.Name == "Part53" or v.Name == "Part54" or v.Name == "Part56" or v.Name == "Part57" or v.Name == "Part58" or v.Name == "Part59" or v.Name == "Part60" or v.Name == "Part61" then
					colorAPI.color(v, MSG) -- Default is "Medium Stone grey"
				end
				
				if v.Name == "Part14" or v.Name == "Part19" or v.Name == "Part2" or v.Name == "Part27" then
					colorAPI.color(v, RB) -- Default is "Really black"
				end
				
				if v.Name == "Part1" or v.Name == "Part10" or v.Name == "Part16" or v.Name == "Part22" or v.Name == "Part37" then
					colorAPI.color(v, RR) -- Default is "Really red"
				end
				
				if v.Name == "Part20" or v.Name == "Part28" or v.Name == "Part4" or v.Name == "Part45" or v.Name == "Part8" then
					colorAPI.color(v, TP) -- Default is "Toothpaste"
				end
			end)()
		end
end

--[[

fixed library lol

spawn(function()
	colorAPI.colorObbyBox(colorAPI.transformToColor3(BrickColor.new("Teal")))
end)

spawn(function()
	colorAPI.colorObbyBricks(colorAPI.transformToColor3(BrickColor.new("Really red")))
end)

spawn(function()
	colorAPI.colorAdminDivs(colorAPI.transformToColor3(BrickColor.new("Dark stone grey")))
end)

spawn(function()
	colorAPI.colorPads(colorAPI.transformToColor3(BrickColor.new("Bright green")))
end)

spawn(function()
	colorAPI.colorBuildingBricks({
		DarkStoneGrey = colorAPI.transformToColor3(BrickColor.new("Dark stone grey")),
		DeepBlue = colorAPI.transformToColor3(BrickColor.new("Deep blue")),
		NY = colorAPI.transformToColor3(BrickColor.new("New Yeller")),
		IW = colorAPI.transformToColor3(BrickColor.new("Institutional white")),
		LimeGreen = colorAPI.transformToColor3(BrickColor.new("Lime green")),
		MSG = colorAPI.transformToColor3(BrickColor.new("Medium Stone grey")),
		RB = colorAPI.transformToColor3(BrickColor.new("Really black")),
		TP = colorAPI.transformToColor3(BrickColor.new("Toothpaste")),
		RR = colorAPI.transformToColor3(BrickColor.new("Really red"))
	})
end)

spawn(function()
	colorAPI.colorHouse({
		wallsC = colorAPI.transformToColor3(BrickColor.new("Brick yellow")),
		baseC = colorAPI.transformToColor3(BrickColor.new("Bright green")),
		roofC = colorAPI.transformToColor3(BrickColor.new("Bright red")),
		WANDDC = colorAPI.transformToColor3(BrickColor.new("Dark orange")),
		stairsC = colorAPI.transformToColor3(BrickColor.new("Dark stone grey")),
		floorC = colorAPI.transformToColor3(BrickColor.new("Medium blue")),
		rooftsC = colorAPI.transformToColor3(BrickColor.new("Reddish brown")),
		chiC = colorAPI.transformToColor3(BrickColor.new("Sand red"))
	})
end)

]]--

-------------------------------------------------------------------- BASIC API STUFF HERE --------------------------------------------------------------------

game:GetService("Players"):Chat("gear me 00000000000000000018474459")
		repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChild('PaintBucket')
		game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.PaintBucket)
		wait(0.50)
		coroutine.wrap(function()
			colorAPI.colorHouse({
				wallsC = colorAPI.transformToColor3(BrickColor.new("Brick yellow")),
				baseC = colorAPI.transformToColor3(BrickColor.new("Bright green")),
				roofC = colorAPI.transformToColor3(BrickColor.new("Bright red")),
				WANDDC = colorAPI.transformToColor3(BrickColor.new("Dark orange")),
				stairsC = colorAPI.transformToColor3(BrickColor.new("Dark stone grey")),
				floorC = colorAPI.transformToColor3(BrickColor.new("Medium blue")),
				rooftsC = colorAPI.transformToColor3(BrickColor.new("Reddish brown")),
				chiC = colorAPI.transformToColor3(BrickColor.new("Sand red"))
			})
		end)()
    spawn(function()
	colorAPI.colorBuildingBricks({
		DarkStoneGrey = colorAPI.transformToColor3(BrickColor.new("Dark stone grey")),
		DeepBlue = colorAPI.transformToColor3(BrickColor.new("Deep blue")),
		NY = colorAPI.transformToColor3(BrickColor.new("New Yeller")),
		IW = colorAPI.transformToColor3(BrickColor.new("Institutional white")),
		LimeGreen = colorAPI.transformToColor3(BrickColor.new("Lime green")),
		MSG = colorAPI.transformToColor3(BrickColor.new("Medium Stone grey")),
		RB = colorAPI.transformToColor3(BrickColor.new("Really black")),
		TP = colorAPI.transformToColor3(BrickColor.new("Toothpaste")),
		RR = colorAPI.transformToColor3(BrickColor.new("Really red"))
	})
end)
		colorAPI.color(game.Workspace.Terrain["_Game"].Workspace["Baseplate"], colorAPI.transformToColor3(BrickColor.new("Bright green")))
		spawn(function()
			colorAPI.colorObbyBox(colorAPI.transformToColor3(BrickColor.new("Teal")))
		end)
		spawn(function()
			colorAPI.colorObbyBricks(colorAPI.transformToColor3(BrickColor.new("Really red")))
		end)
		spawn(function()
			colorAPI.colorAdminDivs(colorAPI.transformToColor3(BrickColor.new("Dark stone grey")))
		end)
		spawn(function()
			colorAPI.colorPads(colorAPI.transformToColor3(BrickColor.new("Bright green")))
		end)
wait(0.6)
game.Players:Chat("ungear 000000000000000000000000000000000000000000000000000000000 me "..math.random(99999))
--nil
    end)
            

	addcommand("rail",
		"desc",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				tchat("ungod "..Target.Name)
				tchat("unff "..Target.Name)
				tchat("speed "..Target.Name.." 0")
				for i = 1, 220 do
					tchat("gear me 0000000000000000000000000000000000000000000000000079446473")
				end
				wait(1.1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					pcall(function()
						v.Parent = game.Players.LocalPlayer.Character
						player = game.Players.LocalPlayer
						local Mouse = game.Players.LocalPlayer:GetMouse()
						num = math.random(1,6)
						local te = Target.Character
						if num == 1 then
							target = te:FindFirstChild("Left Leg")
						elseif num == 2 then
							target = te:FindFirstChild("Right Leg")
						elseif num == 3 then
							target = te:FindFirstChild("Head")
						elseif num == 4 then
							target = te:FindFirstChild("Left Arm")
						elseif num == 5 then
							target = te:FindFirstChild("Right Arm")
						elseif num == 6 then
							target = te:FindFirstChild("HumanoidRootPart")
						end
						-- Script generated by SimpleSpy - credits to exx#9394

						args = {
							[1] = target.Position --[[Vector3]]
						}

						game:GetService("Players").LocalPlayer.Character.Railgun.Click:FireServer(unpack(args))
						game:GetService("RunService").Heartbeat:wait() 
						game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
					end)
				end
			end
		end)		


	addcommand("nuke",
		"k",
		function()
			for _Index, Target in pairs(GetPlayer(args[2])) do
				for i = 1, 220 do
					tchat("gear me 0000000000000000000000000000000000000000000000000088885539")
				end
				wait(1.1)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					pcall(function()
						v.Parent = game.Players.LocalPlayer.Character
						player = game.Players.LocalPlayer
						local Mouse = game.Players.LocalPlayer:GetMouse()
						num = math.random(1,6)
						local te = Target.Character
						if num == 1 then
							target = te:FindFirstChild("Left Leg")
						elseif num == 2 then
							target = te:FindFirstChild("Right Leg")
						elseif num == 3 then
							target = te:FindFirstChild("Head")
						elseif num == 4 then
							target = te:FindFirstChild("Left Arm")
						elseif num == 5 then
							target = te:FindFirstChild("Right Arm")
						elseif num == 6 then
							target = te:FindFirstChild("HumanoidRootPart")
						end

						args = {
							[1] = target.Position --[[Vector3]]
						}

						game:GetService("Players").LocalPlayer.Character["Tactical Airstrike"].OnMouseClick:FireServer(unpack(args))
						game:GetService("RunService").Heartbeat:wait() 
						game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
					end)
				end
			end
		end)


	addcommand("spike",
		"k",
		function()
			for i = 1, 220 do
				tchat("gear me 00000000000000000000000000000000000261439002")
			end
			wait(2)
			for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				pcall(function()
					v.Parent = game.Players.LocalPlayer.Character
					task.wait()
					player = game.Players.LocalPlayer
					local Mouse = game.Players.LocalPlayer:GetMouse()

					args = {
						[1] = Enum.KeyCode.Q
					}

					game:GetService("Players").LocalPlayer.Character.WintersGreatSword.Remote:FireServer(unpack(args))
					task.wait(0.1)
					game.Players.LocalPlayer.Character.Humanoid:UnequipTools(v)
				end)
			end
			--	end
		end)

    addcommand(
        "gayrate",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                local A_1 = Target.Name .. " is " .. math.random(1, 100) .. "% gay"
                local A_2 = "All"
                local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
                Event:FireServer(A_1, A_2)
            end
        end
    )

 

   
        addcommand(
		"smap",
		"description here",
		function()
			local colors = {}
			if args[2] then
				file = args[2]
			end
			file = file .. ".json"
			function formatcf(part: Part)
				return part.CFrame * CFrame.new(-1 * (part.Size.X / 2) - (game.Players.LocalPlayer.Character["Torso"].Size.X / 2), 0, 0)
			end
			tchat("punish others")
			task.wait(.2)
			local http = game:GetService("HttpService")
			for i, v in next, game:GetService("Workspace"):GetDescendants() do
				if v:IsA("Part") or v.Name:lower():match("spawn") then
					colors[v:GetFullName()] = tostring(formatcf(v))
				end
			end
			writefile(file, http:JSONEncode(colors))
			chat("Saved map successfully as "..file)
			tchat("unpunish others")
		end)

        addcommand(
		"sbuild",
		"description here",
		function()
			local colors = {}
			if args[2] then
				file = args[2]
			end
			file = file .. ".json"
			task.wait(.2)
			local http = game:GetService("HttpService")
            table.insert(colors,"Number Of Parts : ".._G.i)
			for i, v in next, Folder:GetChildren() do
				if v:IsA("Part") then
					table.insert(colors, v.Name.. " : "..tostring(v.CFrame.X)..", "..tostring(v.CFrame.Y)..", "..tostring(v.CFrame.Z))
				end
			end
			writefile(file, http:JSONEncode(colors))
			error("Saved build successfully as "..file)
		end)

        addcommand(
		"lbuild",
		"",
		function()
			if args[2] then
				file = args[2]:lower()
			end
			file = file .. ".json"
			if not isfile(file) then
				return error("No file found as - "..file)
			end
			if isfile(file) then
				error("Loading build file - "..file)
			end
            tchat("clr")
			local http = game:GetService("HttpService")
			local colors = http:JSONDecode(readfile(file))
			local xop = true
            if not colors[1]:match("Number") then 
                chat("cannot locate 'Number Of Parts' in table")
            else
            
            nparts = colors[1]:split(": ")
            nparts = nparts[2]
            if tonumber(nparts) > 500 then 
                chat(file.." contains more then 500 parts, are you sure you want to load?")
                op = plr.Chatted:Connect(function(m)
                    if m == 'yes' then 
                        xop = false
                        op:Disconnect()
                    end 
                end)
                while xop do 
                    wait(.1)
                end 
                tchat("respawn me")
                wait(.3)
            end 
                
                 
            chat("Loading "..nparts.." Parts..")
            local pcheck = false
            spawn(function()
                task.wait(.1)
            for i = 1,tonumber(nparts),1 do
            task.wait()
                tchat("part/3/0.1/3  "..i)
                warn("loaded parts "..tostring(i).. " / "..nparts)
            end 
        end)
            local ss = 1
            Folder.ChildAdded:Connect(function(v)
                if v.Name == 'Part' then 
                    v.Name = 'part'..tostring(ss)
                    ss = ss + 1
                end 
            end )


                setsimulationradius(999.999,999.999)
                local LocalPlayer = game:GetService("Players").LocalPlayer
                LocalPlayer.MaximumSimulationRadius = math.huge
                sethiddenproperty(LocalPlayer, "SimulationRadius", 999.999)

           
        
            for i = 1, #colors do 
                if colors[i]:match("part") then 
                    pname = colors[i]:split(" : ")
                    pos = pname[2]:split(", ")
                    pname = tostring(pname[1])

                    x,y,z = tonumber(pos[1]),tonumber(pos[2]),tonumber(pos[3])
                    if Folder:FindFirstChild(pname) then 
                        if Folder[pname].CFrame.X ~= x then 
                            repeat task.wait()
                                Folder[pname].CFrame = CFrame.new(x,y,z)
                                plr.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
                            until Folder[pname].CFrame == CFrame.new(x,y,z)

                        end
                    end


                end
            end 
        end
        end)

        addcommand(
		"pause",
		"pauses sound",
		function()
            for i, v in pairs(Folder:GetDescendants()) do
                if v:IsA("Sound") then
                    v:Pause()
                end
    end  
end)

addcommand(
		"stop",
		"stop sound",
		function()
            for i, v in pairs(Folder:GetDescendants()) do
                if v:IsA("Sound") then
                    v:Stop()
                end
    end  
end)

addcommand(
		"resume",
		"resumes sound",
		function()
            for i, v in pairs(Folder:GetDescendants()) do
                if v:IsA("Sound") then
                    v:Resume()
                end
    end  
end)
local antimusic 
addcommand(
		"nomusic",
		"resumes sound",
		function()
            antimusic = true
            tchat("music")
            Folder.ChildAdded:Connect(function(s)
                if s:IsA("Sound") and antimusic then
                    tchat("stop")
                end 
            end) 
            local boxcmd = plr.Chatted:Connect(function(cmd)
                if cmd:sub(1, 5) == 'music' then 
                    id = cmd:split(" ")
                    local args = {
                        [1] = "PlaySong",
                        [2] = tonumber(id[2])
                    }
                    plr.Character.SuperFlyGoldBoombox.Remote:FireServer(unpack(args))
                end 
            end)                    
end)

addcommand(
		"resmusic",
		"resumes sound",
		function()
            antimusic = false
            boxcmd:Disconnect()
end)
    
addcommand(
    "loadmap",
    "slower mover, this is more likely to be 100% accurate ",
    function()
        if args[2] then
            file = args[2]:lower()
        end
        file = file .. ".json"
        if not isfile(file) then
            return chat("No file found as - "..file)
        end
        if isfile(file) then
            chat(botname.."Loading build file - "..file)
        end
        local http = game:GetService("HttpService")
        local colors = http:JSONDecode(readfile(file))
        function stringtocf(str)
            return CFrame.new(table.unpack(str:gsub(" ", ""):split(",")))
        end
        function formatcf(part: Part)
            return part.CFrame * CFrame.new(-1 * (part.Size.X / 2) - (game.Players.LocalPlayer.Character["Torso"].Size.X / 2), 0, 0)
        end
        function checkcf(c1, c2, threshhold)
            local split1 = c1:gsub(" ", ""):split(",")
            local split2 = c2:gsub(" ", ""):split(",")
            local tor = false
            if math.abs(tonumber(split2[1]) - tonumber(split1[1])) > threshhold then
                tor = true
            end
            if math.abs(tonumber(split2[2]) - tonumber(split1[2])) > threshhold then
                tor = true
            end
            if math.abs(tonumber(split2[3]) - tonumber(split1[3])) > threshhold then
                tor = true
            end
            return tor
        end
        for i, v in next, game:GetService("Workspace"):GetDescendants() do
            --task.spawn(function()
            local color = colors[v:GetFullName()]
            if color and not v.Name:lower():match("head") then
                if tostring(formatcf(v)) ~= color then
                    local checked = checkcf(tostring(formatcf(v)), color, 0.27) -- 0.26
                    if checked then
                        local cfm = stringtocf(color)
                        local checker = false
                        local function takepartto(partt)
                            repeat
                                wait()
                            until checker == false
                            checker = true
                            for i, v in pairs(game.Workspace:GetDescendants()) do
                                if v.Name == "TestMYBOX" then
                                    v:Destroy()
                                else
                                    continue
                                end
                            end
                            --local ChatBar = game.Players.LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
                            local function randomsim()
                                local tablesim = {"|", "<", ".", ">", "/", "?", ";", ":", "@", "'", "~", "#", "]", "}", "[", "{", "=", "+", "-", "_", ")", "(", "*", "&", "^", "%", "$", "!"}
                                return tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]
                            end
                            local selectionbox = Instance.new('SelectionBox')
                            selectionbox.LineThickness = .03
                            selectionbox.Parent = workspace.CurrentCamera
                            selectionbox.Adornee = partt
                            selectionbox.Name = "TestMYBOX"
                            selectionbox.Color3 = Color3.new(255, 0, 0)
                            local function waitforivory()
                                repeat
                                    wait()
                                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("IvoryPeriastron") then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.IvoryPeriastron)

                                    end
                                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("IvoryPeriastron") then

                                    else
                                        tchat("gear me 000000000000000000108158379")
                                        wait(.1)
                                    end
                                    wait()
                                until game:GetService("Players").LocalPlayer.Character:FindFirstChild("IvoryPeriastron")
                                wait(.1)
                            end
                            
                            local function clickiv()
                                local iv = game:GetService("Players").LocalPlayer.Character:FindFirstChild("IvoryPeriastron")
                                repeat
                                    game:GetService("RunService").Heartbeat:wait()
                                until iv:FindFirstChild("Remote")
                                local Remote = iv:FindFirstChild("Remote")
                                Remote:FireServer(Enum.KeyCode.E)
                            end

                            local part2 = partt
                            local position = cfm
                            local spos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            for i, v in pairs(game.Workspace:GetDescendants()) do
                                if v ~= partt and v:IsA("Part") then
                                    v.CanCollide = false
                                end
                            end
                            game.Workspace.Gravity = 0
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                            wait(.1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                            wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                            wait()
                            waitforivory()
                            task.wait(.1)
                            local tempting = true
                            task.spawn(function()
                                while tempting == true do
                                    game.Workspace.Gravity = 0
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                    task.wait()
                                    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                                end
                            end)
                            wait(.1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                            task.wait(.01)
                            repeat
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                task.wait(.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                task.wait(.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                wait(.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                wait(.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                            until game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == position
                            wait(.1)
                            if game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == position then
                                clickiv()
                                game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                                tempting = false
                            end
                            wait(.1)
                            if part2.Name == "Part" then
                                tchat(_G.prefix.."fix")
                            end
                            local target = part2
                            repeat
                                game:GetService("RunService").Heartbeat:wait()
                            until game.Workspace.Camera:FindFirstChild("FakeCharacter")
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                            local me = game.Players.LocalPlayer
                            local function movepart()
                                if me.Character then
                                    local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
                                    _G.looping = true
                                    task.spawn(function()
                                        while true do
                                            pcall(function()
                                                game:GetService('RunService').Heartbeat:Wait()
                                                game.Players.LocalPlayer.Character['Humanoid']:ChangeState(11)
                                                cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(me.Character['Torso'].Size.X/2), 0, 0)
                                            end)
                                            if _G.looping == false or _G.fix == true then break end
                                        end
                                    end)
                                    spawn(function() while _G.looping == true do task.wait(.2) tchat("unpunish me") end end)
                                    wait(0.1)
                                    _G.looping = false
                                    --	end
                                end
                            end
                            task.wait(.1)
                            _G.checking = true
                            _G.securecheck = false
                            task.spawn(function()
                                while _G.checking == true do
                                    game:GetService('RunService').Heartbeat:Wait()
                                    if game.Players.LocalPlayer.Character:FindFirstChild("ice") or game.Lighting:FindFirstChild(game.Players.LocalPlayer.Name) then
                                        _G.securecheck = true
                                        tchat("unpunish me")
                                        task.wait()
                                        tchat("thaw me")
                                    end
                                end
                            end)
                            repeat
                                movepart()
                            until game.Players.LocalPlayer.Character.Torso:FindFirstChild("Weld")
                            for i, v in pairs(game.Players.LocalPlayer.Character.Torso:GetChildren()) do
                                if v:IsA("Weld") and v.Part1 ~= part2 then
                                    v:Destroy()
                                end
                            end
                            task.wait(.1)
                            if _G.securecheck == true then
                                waitforivory()
                                task.wait(.1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                                wait(.01)
                                repeat
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                    task.wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                    task.wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                    task.wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                    task.wait(.1)
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                                until game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == position
                                wait(.1)
                                if game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == position then
                                    clickiv()
                                    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                                    tempting = false
                                end
                                repeat
                                    movepart()
                                until game.Players.LocalPlayer.Character.Torso:FindFirstChild("Weld")
                            end
                            task.wait(.1)
                            clickiv()
                            _G.checking = false
                            task.wait(.2)
                            selectionbox.Color3 = Color3.new(0, 255, 0)
                            repeat
                                game:GetService("RunService").Heartbeat:wait()
                            until game.workspace:FindFirstChild("Pulse")
                            for i, v in pairs(game.Workspace:GetDescendants()) do
                                if v:IsA("Part") then
                                    v.CanCollide = true
                                end
                            end
                            task.wait(.2)
                            tchat("respawn me "..randomsim())
                            repeat
                                game:GetService("RunService").Heartbeat:wait()
                            until(game.Workspace:FindFirstChild(me.Name))
                            task.wait(.1)
                            if _G.cleared then 
                                _G.cleared = false
                            end
                            partt = nil
                            game.Workspace.Gravity = 196.2
                            wait()
                            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
                            checker = false
                        end

                        takepartto(v)
                        repeat
                            task.wait()
                        until checker == false
                        task.wait(0.1) -- 0.2
                    end
                end
            end
            --end)
        end
    end)

addcommand(
    "flmap",
    "faster mover, can at times be in-accurate",
    function()
        if args[2] then
            file = args[2]:lower()
        end
        file = file .. ".json"
        if not isfile(file) then
            return chat("No file found as - "..file)
        end
        if isfile(file) then
            chat("Loading build file - "..file)
        end
        local http = game:GetService("HttpService")
        local colors = http:JSONDecode(readfile(file))
        function stringtocf(str)
            return CFrame.new(table.unpack(str:gsub(" ", ""):split(",")))
        end
        function formatcf(part: Part)
            return part.CFrame * CFrame.new(-1 * (part.Size.X / 2) - (game.Players.LocalPlayer.Character["Torso"].Size.X / 2), 0, 0)
        end
        function checkcf(c1, c2, threshhold)
            local split1 = c1:gsub(" ", ""):split(",")
            local split2 = c2:gsub(" ", ""):split(",")
            local tor = false
            if math.abs(tonumber(split2[1]) - tonumber(split1[1])) > threshhold then
                tor = true
            end
            if math.abs(tonumber(split2[2]) - tonumber(split1[2])) > threshhold then
                tor = true
            end
            if math.abs(tonumber(split2[3]) - tonumber(split1[3])) > threshhold then
                tor = true
            end
            return tor
        end
        for i, v in next, game:GetService("Workspace"):GetDescendants() do
            --task.spawn(function()
            local color = colors[v:GetFullName()]
            if color and not v.Name:lower():match("head") then
                if tostring(formatcf(v)) ~= color then
                    local checked = checkcf(tostring(formatcf(v)), color, 0.27) -- 0.26
                    if checked then
                        local cfm = stringtocf(color)
                        local checker = false
                        local function takepartto(partt)
                            if not game.Workspace:FindFirstChild(partt) and _G.looping == true then
                                _G.looping = false
                                print("Error")
                            end
                            repeat
                                wait()
                            until checker == false
                            checker = true
                            for i, v in pairs(game.Workspace:GetDescendants()) do
                                if v.Name == "TestMYBOX" then
                                    v:Destroy()
                                else
                                    continue
                                end
                            end
                            local function randomsim()
                                local tablesim = {"|", "<", ".", ">", "/", "?", ";", ":", "@", "'", "~", "#", "]", "}", "[", "{", "=", "+", "-", "_", ")", "(", "*", "&", "^", "%", "$", "!"}
                                return tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]..tablesim[math.random(1, #tablesim)]
                            end
                            local selectionbox = Instance.new('SelectionBox')
                            selectionbox.LineThickness = .03
                            selectionbox.Parent = workspace.CurrentCamera
                            selectionbox.Adornee = partt
                            selectionbox.Name = "TestMYBOX"
                            selectionbox.Color3 = Color3.new(255, 0, 0)
                            local function waitforivory()
                                repeat
                                    task.wait(.1)
                                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("IvoryPeriastron") then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.IvoryPeriastron)

                                    end
                                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("IvoryPeriastron") then

                                    else
                                        tchat("gear me 000000000000000000108158379")
                                    end

                                until game:GetService("Players").LocalPlayer.Character:FindFirstChild("IvoryPeriastron")
                            end
                            --tchat("health me nan")
                            local function clickiv()
                                local iv = game:GetService("Players").LocalPlayer.Character:FindFirstChild("IvoryPeriastron")
                                repeat
                                    game:GetService("RunService").Heartbeat:wait()
                                until iv:FindFirstChild("Remote")
                                local Remote = iv:FindFirstChild("Remote")
                                Remote:FireServer(Enum.KeyCode.E)
                            end

                            local part2 = partt
                            local position = cfm
                            local spos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            for i, v in pairs(game.Workspace:GetDescendants()) do
                                if v ~= partt and v:IsA("Part") then
                                    v.CanCollide = false
                                end
                            end
                            game.Workspace.Gravity = 0
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                            task.wait(.1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                            task.wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                            task.wait()
                            waitforivory()
                            task.wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
                            wait(.1)
                            clickiv()
                            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
                            if part2.Name == "Part" then
                                tchat(_G.prefix.."fix")
                            end
                            local target = part2
                            repeat
                                game:GetService("RunService").Heartbeat:wait()
                            until game.Workspace.Camera:FindFirstChild("FakeCharacter")
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                            local me = game.Players.LocalPlayer
                            local function movepart()
                                if me.Character then
                                    local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
                                    _G.looping = true
                                    spawn(function()
                                        while true do
                                            game:GetService('RunService').Heartbeat:Wait()
                                            game.Players.LocalPlayer.Character['Humanoid']:ChangeState(11)
                                            cf.CFrame = target.CFrame * CFrame.new(-1*(target.Size.X/2)-(me.Character['Torso'].Size.X/2), 0, 0)
                                            if _G.looping == false or _G.fix == true then break end
                                        end
                                    end)
                                    spawn(function() while _G.looping == true do task.wait(.2) tchat("unpunish me") end end)
                                    wait()
                                    _G.looping = false
                                    --	end
                                end
                            end
                            repeat
                                movepart()
                            until game.Players.LocalPlayer.Character.Torso:FindFirstChild("Weld")
                            --	task.wait(.2)
                            for i, v in pairs(game.Players.LocalPlayer.Character.Torso:GetChildren()) do
                                if v:IsA("Weld") and v.Part1 ~= part2 then
                                    v:Destroy()
                                end
                            end
                            task.wait()
                            clickiv()
                            task.wait()
                            selectionbox.Color3 = Color3.new(0, 255, 0)
                            repeat
                                game:GetService("RunService").Heartbeat:wait()
                            until game.workspace:FindFirstChild("Pulse")
                            for i, v in pairs(game.Workspace:GetDescendants()) do
                                if v:IsA("Part") then
                                    v.CanCollide = true
                                end
                            end
                            task.wait()
                            tchat("respawn me "..randomsim())
                            repeat
                                game:GetService("RunService").Heartbeat:wait()
                            until(game.Workspace:FindFirstChild(me.Name))
                            task.wait(.2)
                            partt = nil
                            game.Workspace.Gravity = 196.2
                            wait()
                            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
                            checker = false
                        end

                        takepartto(v)
                        repeat
                            task.wait()
                        until checker == false
                        task.wait(0.1) -- 0.2
                    end
                end
            end
            --end)
        end
    end)


    addcommand(
        "slock",
        "description here",
        function()
            jot("Server has been locked")
            error("Server lock activated")
            for _, v in pairs(game.Players:GetPlayers()) do 
            for i = 1, #_G.whitelisted do 
                if v.Name == _G.whitelisted[i] then
                    tchat("pm/"..v.Name.."/[Femware.txt] You are whitelisted from serverlock, you must be really cool")
                end 
            end
        end
            _G.slock = true
            game.Players.PlayerAdded:Connect(function(p)
                local wl = false
                if _G.slock then 
                    for i = 1, #_G.whitelisted do
                        if p.Name == _G.whitelisted[i] then 
                        wl = true
                        end 
                    end
                    if wl then 
                    repeat wait() until p.Character
                    jot("Whitedlisted player, "..p.Name.." Has Joined!")
                    tchat("tp "..p.Name.." me")
                    wl = false
                    else 
                    jot(p.Name.." tried to join the server")
                    repeat wait() until p.Character
                    tchat("pm/"..p.Name.."/This Server is locked")
                    wait()
                    tchat(_G.prefix.."slock "..p.Name.." Serverlock Enabled")
                    end
                end 
            end) 
     end)

     

        addcommand(
        "fixcam",
        "description here",
        function()
            task.spawn(function()
                error("Camera  has been fixed")
                local lp = game.Players.LocalPlayer
                local ui = game:GetService("UserInputService")
                local l__ContextActionService__7 = game:GetService("ContextActionService");
                local l__RunService__1 = game:GetService('RunService')
                l__ContextActionService__7:UnbindAction("ShoulderCameraSprint");
                l__RunService__1:UnbindFromRenderStep("ShoulderCameraUpdate");
                l__ContextActionService__7:UnbindAction("ShoulderCameraZoom");
                while true do
                    repeat game:GetService'RunService'.Heartbeat:Wait() until game.Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable
                    l__RunService__1:UnbindFromRenderStep("ShoulderCameraUpdate");
                    l__ContextActionService__7:UnbindAction("ShoulderCameraZoom");
                    l__ContextActionService__7:UnbindAction("ShoulderCameraSprint");
                    local wepsys = game:GetService("ReplicatedStorage"):FindFirstChild('WeaponsSystem')
                    if not wepsys then return end
                    for i,v in pairs(wepsys:GetDescendants()) do
                        if v:IsA("Script") then
                        v.Disabled = true
                        end
                        v:Destroy()
                    end
                    local wep = lp.PlayerGui:FindFirstChild("ClientWeaponsScript")
                    local gui = lp.PlayerGui:FindFirstChild("WeaponsSystemGui")
                    local sc = lp.PlayerScripts:FindFirstChild("ClientWeaponsScript")
                    if wep then wep.Disabled = true wep:Destroy() end
                    if gui then gui:Destroy() end
                    if sc then
                        sc.Disabled = true
                        sc:Destroy()
                    end
                    ui.MouseIconEnabled = true
                    game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                    game.Workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
                    lp.Character.Humanoid.AutoRotate = true
                end
            end)
        end)

        addcommand(
        "unslock",
        "description here",
        function()
            jot("Server has been unlocked")
            error("Server lock De-activated")
            _G.slock = false
        end)

            addcommand(
        "bangun",
        "description here",
        function()    
            if _G.coolammo then 
                _G.coolammo:Disconnect()
            end
            tchat("gear me 17237675")
            local deb = true
_G.banammo = game.Workspace.ChildAdded:Connect(function(b)
    if b.Name == 'Bullet' then
        b.Touched:Connect(function(hum)
            if game.Players:FindFirstChild(hum.Parent.Name) and deb and hum.Parent.Name ~= plr.Name then
                coroutine.wrap(function()
                    deb = false
                    wait(.3)
                    deb = true
                end)()
                spawn(function()
                tchat("music 2323663829")
                wait(.5)
                tchat("music")
                end)
                tchat("pmkick "..hum.Parent.Name)
                jot("Hello there people\n\n\n\n\n\n\nDon't worry, it only kicks though bangun sounds cooler ;)")
            end 
        end)
    end 
end)
end)

addcommand(
        "zecoolgun",
        "description here",
        function()    
            tchat("gear me 17237675")
            if _G.banammo then 
                _G.banammo:Disconnect()
            end
            local deb = true
_G.coolammo = game.Workspace.ChildAdded:Connect(function(b)
    if b.Name == 'Bullet' then
        b.Touched:Connect(function(hum)
            if game.Players:FindFirstChild(hum.Parent.Name) and deb and hum.Parent.Name ~= plr.Name then
                coroutine.wrap(function()
                    deb = false
                    wait(.3)
                    deb = true
                end)()
                spawn(function()
                tchat("music 2323663829")
                wait(.5)
                tchat("music")
                end)
                tchat("setgrav "..hum.Parent.Name.." nan")
                tchat("pm/"..hum.Parent.Name.."/"..facts[math.random(1,#facts)])
            end 
        end)
    end 
end)
end)

    addcommand(
        "banhammer",
        "description here",
        function()
            tchat("gear me 10468797")
            jot("\n\n\nThe banhammer has been summoned!\nUse it wisely!")
            coroutine.wrap(function()
            wait()
            
            tchat("music "..audios[math.random(1,2)])
            wait(3)
            tchat("music")
            end)()


            
    
                            local hammer = plr.Backpack:WaitForChild("BanHammer V1.1", 3)
                            if hammer then
                                local deb = false
                                hammer.Handle.Touched:Connect(
                                    function(part)
                                        local hum =
                                            part.Parent:FindFirstChild("Humanoid") or part.Parent.Parent:FindFirstChild("Humanoid")
                                        if hum and hum.Health ~= 0 and not deb then
                                            deb = true
                                            coroutine.wrap(
                                                function()
                                                    task.wait(4)
                                                    deb = false
                                                end
                                            )()
                                            local lp = game.Players:GetPlayerFromCharacter(hum.Parent)
                                            if lp.Name == 'Altsarecooleh' then
                                                jot("[Femware.txt] Using my own weapons against me?")
                                            
                                            else if lp and lp ~= game.Players.LocalPlayer then
                                                _G.bh = true
                                                coroutine.wrap(function()
                                                    tchat("music 147722910")
                                                wait(0.3)
                                                tchat("music")
                                                end)()
                                                wait(.3)
                                                tchat(_G.prefix.."kick " .. lp.Name)
                                                    jot("\n\n"..lp.Name.." touched the banhammer LOL")
                                                game.Players.ChildAdded:Connect(function(p)
                                                    if p.Name == lp.Name then 
                                                        _G.bh = true
                                                        jot(lp.Name.." thought he could rejoin LOL")
                                                        error("[*] Banned player, "..lp.Name.." tried rejoining..")
                                                        repeat wait() until p.Character
                                                        tchat(_G.prefix.."kick "..p.Name)
                                                    end 
                                                end)

                                            end
    
                                            end
                                        end
                                    end
                                )
                            end
                        
        end)

    addcommand(
        "headrise",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                tchat("size " .. Target.Name .. " .3")
                tchat("bighead " .. Target.Name)
                wait()
                tchat("size " .. Target.Name .. " 10")
                wait()
                tchat("thaw " .. Target.Name)
                wait()
                tchat("unsize " .. Target.Name)
                Femware()
            end
        end
    )

    addcommand(
        "skybox",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                tchat("size " .. Target.Name .. " .3")
                tchat("freeze " .. Target.Name)
                tchat("size " .. Target.Name .. " 10")
                tchat("goldify " .. Target.Name)
                tchat("clone " .. Target.Name)
                tchat("reset " .. Target.Name)
                wait(.1)
                Femware()
            end
        end
    )

    addcommand(
        "icetower",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                for i = 1, 30 do
                    tchat("size " .. Target.Name .. " .6")
                    tchat("seizure " .. Target.Name)
                    tchat("freeze " .. Target.Name)
                    tchat("unsize " .. Target.Name)
                end
                Femware()
            end
        end
    )

    addcommand(
        "headroot",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                tchat("size " .. Target.Name .. " 10")
                tchat("freeze " .. Target.Name)
                tchat("bighead " .. Target.Name)
                tchat("size " .. Target.Name .. " .3")
                tchat("thaw " .. Target.Name)
                tchat("unsize " .. Target.Name)
                Femware()
            end
        end
    )



    addcommand(
        "pdraw",
        "description here",
        function()
            getgenv().draw = true
            getgenv().remove = false
            _G.psize = args[2]
        end)

        addcommand(
        "pdelete",
        "description here",
        function()
            getgenv().draw = false
            getgenv().remove = true
        end)


        addcommand(
        "rpdraw",
        "description here",
        function()
            getgenv().draw = false
            getgenv().remove = false
        end)

    addcommand(
        "amputate",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                tchat("size " .. Target.Name .. " 10")
                wait(.3)
                tchat("freeze " .. Target.Name)
                wait(.3)
                tchat("trip " .. Target.Name)
                wait(.3)
                tchat("unsize " .. Target.Name)
                wait(.3)
                tchat("paint " .. Target.Name .. " red")
                wait(.1)
                Femware()
            end
        end
    )

    

    UIS.InputBegan:Connect(function(a)
        if a.UserInputType == Enum.UserInputType.MouseButton1 and getgenv().draw or getgenv().remove then
            MouseDown = true 
        end
    end)
    UIS.InputEnded:Connect(function(a)
        if a.UserInputType == Enum.UserInputType.MouseButton1 and getgenv().draw or getgenv().remove then
            MouseDown = false
        end
    end)



    spawn(function()
    while task.wait() do
        if MouseDown == true and getgenv().draw then
            if mouse.Target ~= nil then
                task.wait()
                game.Players:Chat("part/3/".._G.psize.."/3")
                     
                     
                 
            end
        else if MouseDown == true and getgenv().delete then 
            if mouse.Target ~= 'Part' then
                mouse.Target:Destroy()
            end 
        end
        end
    end
    end)
    
    coroutine.wrap(function()
        while task.wait() do
            pcall(function()
            for _, v in pairs(rs:GetChildren()) do 
                if v.Name:sub(1,4) == 'part' then
                    nm = v.Name 
                    nm = nm:split("__")
                    if table.find(parts, nm[1]) then
                        if not Folder:FindFirstChild(nm[1]) then 
                        for i = 1, #parts do 
                            if parts[i] == nm[1] then 
                                table.remove(parts,i)
                                return
                            end 
                        end
                        else
                        nmv = nm[2]
                        nmv = nmv:split(", ")
                        x = tonumber(nmv[1])
                        y = tonumber(nmv[2])
                        z = tonumber(nmv[3])
                        Folder:FindFirstChild(nm[1]).CFrame = CFrame.new(x,y,z)
                        end
                        
                end 
            end 
        end
            end)
        
        end
    end)()
    
    Folder.ChildAdded:Connect(function(a)
                 if a:IsA("Part") and getgenv().draw then
                     a.Name = "part"..tostring(_G.i)
                     b = Instance.new("Part", game.ReplicatedStorage)
                     b.Name = a.Name.."__"..tostring(mouse.Hit)
                     _G.i = _G.i + 1 
                     table.insert(parts,a.Name)
             end
    end)

    addcommand(
        "obkill",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                local obbykill = ws["Obby"]:FindFirstChild("Jump")
                repeat
                    wait()
                until game.Players.LocalPlayer.Character

                local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local looping = true

                spawn(
                    function()
                        while true do
                            game:GetService("RunService").Heartbeat:Wait()
                            game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                            cf.CFrame =
                                obbykill.CFrame *
                                CFrame.new(
                                    -1 * (obbykill.Size.X / 2) -
                                        (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                    0,
                                    0
                                )

                            if not looping then
                                break
                            end
                        end
                    end
                )
                spawn(
                    function()
                        while looping do
                            wait(.1)
                            tchat("unpunish me")
                        end
                    end
                )
                wait(0.3)
                looping = false
                tchat("invis me")
                wait(.12)
                for i = 1, 5 do
                    wait()
                    tchat("tp me " .. Target.Name)
                end
                wait(.35)
                tchat("skydive me")
                wait(.35)
                tchat("respawn me")
            end
        end
    )

    addcommand(
        "infgod",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                tchat("pm " .. Target.Name .. " You have been granted the Power of a God.")
                wait(5)
                tchat("reset " .. Target.Name)
                Target.CharacterAdded:Connect(
                    function(character)
                        tchat("god " .. Target.Name)
                        tchat("ff " .. Target.Name)
                        character.ChildRemoved:Connect(
                            function(child)
                                if child.Name == "ForceField" then
                                    tchat("ff " .. Target.Name)
                                end
                            end
                        )
                        character:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(
                            function()
                                tchat("god " .. Target.Name)
                                if character:WaitForChild("Humanoid").Health == 0 then
                                    tchat("reset " .. Target.Name)
                                end
                            end
                        )
                    end
                )
            end
        end
    )

    plr.Chatted:Connect(
        function(msg)
            msg = msg:split(" ")
            if msg[1] == _G.prefix .. "joinserver" then
                id = msg[2]
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, id, plr)
            end
        end
    )

    plr.Chatted:connect(
        function(msg)
            msg = msg:split(" ")
            if msg[1] == _G.prefix .. "pwn" then
                local victim = msg[2]
                tchat("jail " .. victim)
                wait(.1)
                for i = 1, 50 do
                    tchat(":explode " .. victim)
                end
                wait(2.5)
                tchat("unjail " .. victim)
            end
        end
    )

    plr.Chatted:connect(
        function(msg)
            msgh = msg:split(" ")
            if msgh[1] == _G.prefix .. "spam" then  
                command = msg:split("spam ")
                spam = game:GetService("RunService").Heartbeat:Connect(function()
                    tchat(command[2])
                end)
            end
        end
    )

    plr.Chatted:connect(
        function(msg)
            if msg == _G.prefix .. "unspam" then
                spam:Disconnect()
            end
        end
    )

    plr.Chatted:connect(
        function(msg)
            msg = msg:split(" ")
            if msg[1] == _G.prefix .. "glitch" then
                local victim = msg[2]
                tchat(":setgrav " .. victim .. " -1000")
                tchat("seizure " .. victim)
                Femware()
            end
        end
    )

    plr.Chatted:connect(
        function(msg)
            msg = msg:split(" ")
            if msg[1] == _G.prefix .. "break" then
                local victim = msg[2]
                tchat("freeze " .. victim)
                for i = 1, 100 do
                    tchat("dog " .. victim)
                end
                wait(.4)
                for i = 1, 100 do
                    tchat("dog " .. victim)
                end
                wait(.1)
                tchat("goldify " .. victim)
                wait(.2)
                tchat("thaw " .. victim)
                wait(.2)
                tchat("explode " .. victim)
                Femware()
            end
        end
    )

    addcommand("svrbreakcam", "description here", function()


_G.svrbreakcam = true
            tchat("name all ‎")
            local function hidden()
                 for i = 1, 15 do 
                    tchat("noob zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz")
                  end 
            end 
            hidden()

            for _, v in pairs(game.Players:GetChildren())  do
                _G.plus = v.CharacterAdded:Connect(function()
                    pcall(function()
                    if _G.svrbreakcam then
                    tchat("name "..v.Name.." ‎")
                    hidden()
                    end
                end)
                end) 
            end 

            _G.plus2 = game.Players.PlayerAdded:Connect(function(plr)
                repeat wait() until plr.Character
                pcall(function()
                    if _G.svrbreakcam then
                    tchat("name "..plr.Name.." ‎")
                    hidden()
                    end
                end)
                _G.plus3 = plr.CharacterAdded:Connect(function()
                    pcall(function()
                        if _G.svrbreakcam then
                        tchat("name "..plr.Name.." ‎")
                        hidden()
                        end
                    end)
                end) 
            end)
                
            end)
            _G.brokencams = {}

            addcommand("fixcam", "description here", function()
                for _Index, Target in pairs(GetPlayer(args[2])) do
                    for i = 1, #_G.brokencams do 
                        if _G.brokencams[i] == Target.Name then 
                            table.remove(_G.brokencams, i)
                        end 
                     
                end 
                tchat("reset "..Target.Name)
                end
                end)

    addcommand("breakcam", "description here", function()
    
        for _Index, Target in pairs(GetPlayer(args[2])) do
            table.insert(_G.brokencams, Target.Name)
            task.wait()
            tchat("name "..Target.Name.." "..Target.DisplayName)
            task.wait()
            for i = 1, 20 do 
                tchat("noob zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz")
            end 
            Target.CharacterAdded:Connect(function()
                for i = 1, #_G.brokencams do 
                    if _G.brokencams[i] == Target.Name then 
                        tchat("name "..Target.Name.." "..Target.DisplayName)
                        for i = 1, 15 do 
                            tchat("noob zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz")
                        end 
                    end 
                end 
            end)
        end
        end)
   

    

    addcommand("blizzard", "description here", function()
        for _Index, Target in pairs(GetPlayer(args[2])) do 
    if not sethiddenproperty then
                game.Players:Chat("synapse")
            else
                sethiddenproperty(game.Players.LocalPlayer,"MaximumSimulationRadius",math.huge)
                game:GetService("Workspace").Terrain["_Game"].Folder:WaitForChild("Part")
                getgenv().mob = true
                while getgenv().mob == true do
                    wait()
                    local Position = Target.Character:WaitForChild("HumanoidRootPart").CFrame
                    for _,v in pairs(Folder:GetChildren()) do
                        if v.Name == 'Part' then
                            v.CFrame = Position + Vector3.new(math.random(-10,10),math.random(-5,10),math.random(-10,10))
    
                        end
                    end
                end
            end
    end
end)

    addcommand("tase", "description here", function()
        for _Index, Target in pairs(GetPlayer(args[2])) do 
            tchat("gear me 82357123")
            tool = 'Taser'
                plr.Backpack:WaitForChild(tool) .Parent = plr.Character
                                plr.Character:WaitForChild(tool):Activate()
                              for i = 1, 10 do 
                                task.wait(.1)
                                plr.Character:WaitForChild(tool):Activate()
                                for i = 1, 10 do
                                for _, v in pairs(Target.Character:GetChildren()) do
                                    if v:IsA("Part") then
                                firetouchinterest(v, plr.Character:FindFirstChild(tool).Handle, 0)
                                firetouchinterest(v, plr.Character:FindFirstChild(tool).Handle, 1)
                                     
                                end
                            end
                            end
                        end
                            
                                tchat("ungear me")
    
        
                
                end
        end)

        addcommand("smack", "description here", function()
            for _Index, Target in pairs(GetPlayer(args[2])) do 
                tchat("gear me 46360920")
                tool = 'Mackerel'
                plr.Backpack:WaitForChild(tool) .Parent = plr.Character
                                plr.Character:WaitForChild(tool):Activate()
                              for i = 1, 10 do 
                                task.wait(.3)
                                plr.Character:WaitForChild(tool):Activate()
                                for _, v in pairs(Target.Character:GetChildren()) do
                                    if v:IsA("Part") then
                                firetouchinterest(v, plr.Character:FindFirstChild(tool).Handle, 0)
                                firetouchinterest(v, plr.Character:FindFirstChild(tool).Handle, 1)
                                     
                                end
                            end
                        end
                            
                                tchat("ungear me")
    
        
                
                end
            end)





    addcommand("orb", "description here", function()
        for _Index, Target in pairs(GetPlayer(args[2])) do 

			local unanchoredparts = {}
			local movers = {}
			for index, part in pairs(workspace:GetDescendants()) do
				if part:IsA("Part") and part.Anchored == false and part:IsDescendantOf(Target.Character) == false then
					table.insert(unanchoredparts, part)
					part.Massless = true
					part.CanCollide = false
					if part:FindFirstChildOfClass("BodyPosition") ~= nil then
						part:FindFirstChildOfClass("BodyPosition"):Destroy()
					end
				end
			end
			for index, part in pairs(unanchoredparts) do
				local mover = Instance.new("BodyPosition", part)
				table.insert(movers, mover)
				mover.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			end
			repeat
				for index, mover in pairs(movers) do
					mover.Position = Target.Character:FindFirstChild("HumanoidRootPart").CFrame:PointToWorldSpace(Vector3.new(0, 0, 5))
				end
				wait(0.5)
			until Target.Character:FindFirstChild("Humanoid").Health <= 0
			for _, mover in pairs(movers) do
				mover:Destroy()
			end
        end



        end)

    

        

           
        

        addcommand("disable",
		"stops part scripts",
		function()
            getgenv().mob = false
            plr.Character.Humanoid.Health = nil
            wait(.2)
                        tchat("reset me")
        end)
        

        addcommand("off",
		"removes anti kick",
		function()
            error("Disabled anti kick")
				_G.antikick = false
                _G.aty:Disconnect()
		end)

        addcommand("usetools",
		"usetools xd",
		function()
			local Backpack = game.Players.LocalPlayer:FindFirstChildOfClass("Backpack")
			for _, v in ipairs(Backpack:GetChildren()) do
				v.Parent = game.Players.LocalPlayer.Character
				v:Activate()
			end
		end
	)

    addcommand("?hide",
    "usetools xd",
    function()
                    _G.hide = true
                    coroutine.wrap(
                        function()
                            if not plr.Character then
                                error("Character Does not exist?")
                            else
                                _G.mypos = plr.Character.HumanoidRootPart.CFrame
                                wait()
                                plr.Character:Remove()
                                error("Character Has been Destroyed, Protected from commands")
                            end
                            plr.CharacterAdded:Connect(
                                function(character)
                                    if _G.hide then
                                        character:Destroy()
                                    end
                                end
                            )
                        end
                    )()
            end
        )

        addcommand("?unhide",
        "usetools xd",
        function()
            _G.hide = false
            tchat("respawn me")
            plr.CharacterAdded:Wait(.1)
            plr.Character:WaitForChild("HumanoidRootPart").CFrame = _G.mypos
        end)
    
local a = [[













































̡͜Z̴͘͜͢͝A̷̛͜͟͝Ļ́͝҉G̵͟͞Ǫ̴̛́͢!҉̴͘͜҉

]]

local b = [[




̸̀͟͟͝T͏̧͡͏h̵̨̢̛͜i҉̡͢͞s̢͝ ̶̨̡̀͠i͟͝͡s̶̵̢̀͜ ̴̛͘͏t̸́͘h́͡͝è̕͢͡͏ ̵̷͝ę́͜ǹ̵̵̢̛d̶̡̕͝
]]

local c = [[
















































T̶̢hę̸̷ ͡h̨̧o҉̛u͜r̨̨ ҉͜i̕͞͞s ne͝͠͏a͜͝r̡͢

]]



plr.Chatted:Connect(function(m)
    if m == _G.prefix..'zawa' then
            game.Players:Chat("gear me 10468797")
            game.Players:Chat("h/"..c)
            wait()
            game.Players:Chat("shiny me")
            game.Players:Chat("unhat me")
            wait()
            game.Players:Chat("name me "..a)
            wait()
            game.Players:Chat("speed me 60")
            coroutine.wrap(function()
            game.Players:Chat("music 695296619")
            wait(2)
            workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
            game.Players:Chat("music 000000000000000000000000001837301451")
            end)()
            
            local hammer = plr.Backpack:WaitForChild("BanHammer V1.1", 3)

						if hammer then
							local deb = false
							hammer.Handle.Touched:Connect(
								function(part)
									local hum = part.Parent:FindFirstChild("Humanoid") or part.Parent.Parent:FindFirstChild("Humanoid")
									if hum and hum.Health ~= 0 and not deb then
										deb = true
										coroutine.wrap(
											function()
												task.wait(1.2)
												deb = false
											end
										)()
										local lp = game.Players:GetPlayerFromCharacter(hum.Parent)
										if lp and lp ~= game.Players.LocalPlayer then
											wait()
											  coroutine.wrap(function()
											--game.Players:Chat("music 4895128830")
											wait(2)
											--game.Players:Chat("music")
											   end)()
											wait()
											game.Players:Chat("setgrav " .. lp.Name .." inf")
											    for i = 1, 3 do
												game.Players:Chat("pm/"..lp.Name.." "..b)
											   end
							            end
								    end
							end)
					    end
        end
end)



    






    

    addcommand(
        "rj",
        "rejoins the fucking server",function()
        tp:TeleportToPlaceInstance(game.PlaceId,game.JobId,plr)
        end)

    local slocked = {}
    addcommand(
        "slock",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                table.insert(slocked,Target.Name)
                tchat("punish " .. Target.Name)
                tchat("blind " .. Target.Name)
                tchat("pm " .. Target.Name .. " You have been Server Locked by " .. plr.Name .. ".")
                wait()
                game.Workspace.ChildAdded:Connect(
                    function(child)
                        for _, v in next, slocked do
                        if child.Name == Target.Name and Target.Name == v then
                            tchat("punish " .. Target.Name)
                            tchat("blind " .. Target.Name)
                        end
                    end
                    end
                )
                game.Players.PlayerAdded:Connect(
                    function(player)
                        for _, v in next, slocked do
                        if player.Name == Target.Name and Target.Name == v then
                            tchat("pm " .. Target.Name .. " You have been Server Locked by " .. plr.Name)
                            tchat("punish " .. Target.Name)
                            tchat("blind " .. Target.Name)
                        end
                        end
                    end
                )
            end
        end
    )

    addcommand(
        "unslock",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                for i = 1, #slocked do 
                    if Target.Name == slocked[i] then 
                        table.remove(slocked, i)
                    end 
                end
            end
        end
    )

    addcommand(
        "house",
        "description here",
        function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-29.809, 8.229, 72.000)
		end
	)






    -- lets test it out :)
         
          









    addcommand(
        "freg",
        "description here",
        function()
			error("Attempting to find vertical regen...")
			error("Checking saved coords first...")
			local root = game.Players.LocalPlayer.Character.HumanoidRootPart
			wait(1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, 1000000, 1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-200000, 50000, 3500000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-7, 534009, 95));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, 1000003, -1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1101734, 33651680, -33531784));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, -1000003, -1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, -1000000, -3));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(3, -1000000, 1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, -3, -1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-1000000, -3, 1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, 3, 1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-7, 200009, 95));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, 1000003, 1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(1000000, -1000003, 1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(454545, 150000, -678678));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(306712, 420552, 398158));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-1000000, 1000003, 1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-1000000, 1000003, -1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-1000000, -1000003, -1000000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-397746, 503, -168829));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-674082.8125,-698538.6875,-286853.125));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(45400, -49860, 56673));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-559702.25,-724234.1875,-563028.25));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-504678,-470264.90625,-387767.9375));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-397745.9375,499.0865173339844,-168829.078125));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(56470, -48312, 28578));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-9, 60008, 89));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-123317.0625, 119352.671875, 911237));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(75304, -49638, 47300));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(34120, -48830, 30233));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(279584.8125,-47841.0234375,410623.0625));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-225255.265625,-146865.9375,51726.44140625));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(77822, -49751, 79116));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(42682, -29202, 29886));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(54933, -500353, 85934));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(51052, -49558, 34068));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-23529.498046875,-21270.994140625,-17196.0078125));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(57099.02734375,-40034.640625,708909.75));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(562191.25,-39999.55078125,110908.984375));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(777584.875,52895.4140625,3576.002685546875));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(777584.875,52895.4140625,3576.002685546875));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(824511,1000000,24944.01953125));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(782629, 385179, 234698));wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-251773, 1000003, 382563));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(653864.8125,247022.828125,149027.078125));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-500000, 300000, 500000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-300000, 300000, 300000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(300000, 300000, 300000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(300000, 300000, -300000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-300000, 300000, -300000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-500000, 300000, 500000));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-7, 12009, 95));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(734399, 560502, 2776));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-360263, 421796, 716100));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(999982, 3143, 999997));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(696973, 999997, -1000001));wait(.15)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(100000, 10000, 100000));wait(.15)
			wait(.15)
			tchat(_G.prefix.."house")
			tchat(_G.prefix.."house")
			error("Still looking for regen...")
			wait(.3)
			repeat 
				wait()
				root.CFrame = CFrame.new(-7.165, root.Position.Y+2000 , 94.743)
			until workspace.Terrain._Game.Admin:FindFirstChild("Regen")
			root.CFrame = workspace.Terrain._Game.Admin:FindFirstChild("Regen").CFrame + Vector3.new(0,3,0)
			if workspace.Terrain._Game.Admin:FindFirstChild("Regen") then
				fireclickdetector(game:GetService("Workspace").Terrain["_Game"].Admin.Regen.ClickDetector, 0)
				error("Found regen!")
				GraphicalEffects.CrystalRing("Eggplant", 5)
			end
		end)

    addcommand(
        "unslock",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                error("[*]")
                table.remove(slocked,Target.Name)
        end
            
        end)

        
         spawn(function()
            repeat task.wait() until plr.Character
            plr.Character.ChildAdded:Connect(function(r)
                if r.Name == 'Rocket' then 
                    --tchat("unrocket/me")
                    r.CanCollide = false
                end 
            end)
        
    end)

        plr.CharacterAdded:Connect(function(c)
            c.ChildAdded:Connect(function(l)
            if l.Name == 'Rocket' then 
                --tchat("unrocket/me")
                l.CanCollide = false
            end
            end)   
        end)

        
        for _, v in pairs(game.Players:GetPlayers()) do
            if table.find(_G.whitelisted, v.Name) then
                v.CharacterAdded:Connect(function(a)
                    a:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(function()
                        tchat("god " .. v.Name)
                        if a:WaitForChild("Humanoid").Health == 0 then
                            tchat("reset " .. v.Name)
                            task.wait(0.2)
                            tchat("god " .. v.Name)
                        end
                    end)
                end)
            end
        end
    
    game.Players.PlayerAdded:Connect(
        function(pr)
        if table.find(_G.whitelisted, pr.Name) then
            pr.CharacterAdded:Connect(function(a)
                a:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(
                    function()
                        tchat("god " .. pr.Name)
                        if character:WaitForChild("Humanoid").Health == 0 then
                            tchat("reset " .. pr.Name)
                            task.wait(.2)
                            tchat("god " .. pr.Name)
                        end
                    end
                )
            end
        )
    end
                if pr.Name == 'jhjssikeksms' and _G.bullyaria then 
                    repeat task.wait() until pr.Character
                    --tchat("music 1839334310")
			tchat("music "..zero.."9040180676")
			wait()
			tchat("skip 1")
			wait()
			--tchat("jail/jhjssikeksms")
			wait()
			--tchat(".ewj0ro")
			wait(5)
			--tchat(".serverhop")
        wait(.4)
--tchat("tp emriyaI me")
--tchat("breakcam emr")



pr.CharacterAdded:Connect(function(c)
    if _G.bullyaria then
    local name = names[math.random(1,#names)]
    if name == 'jhjssikeksms' then
        game.Players:Chat("name jhjssikeksms "..name)
        wait(1)
    game.Players:Chat("h/Hello there, Skid")
    wait(1)
    game.Players:Chat("explode jhjssikeksms")
    else
    game.Players:Chat("h/Hello there, "..name)
    game.Players:Chat("name jhjssikeksms "..name)
    end
    c.ChildRemoved:Connect(function(a)
        if a.Name == name then 
            game.Players:Chat("name jhjssikeksms "..name)
        end 
    end)
end
end)
wait(1)
tchat("reset jhjssikeksms")
end
                for i = 1, #getgenv().blacklisted do
                    if pr.Name == getgenv().blacklisted[i] then
                        error("Blacklisted player: "..pr.Name.." Has joined, locking player")
                        tchat(_G.prefix.."pmkick "..pr.Name)
                    end
                end
                for i = 1, #_G.whitelisted do
                    if pr.Name == _G.whitelisted[i] then
                        error("Whitelisted player: "..pr.Name.." Has joined")
                        jot("Whitelisted player: "..pr.Name.." Has joined")
                        pr.CharacterAdded:Wait()
                        tchat("tp "..pr.Name.." me")
                    end
                end
        end
    )


    addcommand(
        "outfitlog",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                id = Target.UserId
                url = httprequest({Url = "https://avatar.roblox.com/v1/users/" .. id .. "/outfits?itemsPerPage=20"})
                outfits = http:JSONDecode(url.Body)
                chat("\n" .. Target.Name .. "'s Outfits:\n")
                for i, v in pairs(outfits.data) do
			wait(1)
                    chat(i .. ") Outfit Name: " .. v.name)
			wait(1)
                end
                chat("\nTotal: " .. outfits.total)
            end
        end
    )

    addcommand(
        "info",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                id = Target.UserId
                friends = httprequest({Url = "https://friends.roblox.com/v1/users/" .. id .. "/friends/count"})
                followers = httprequest({Url = "https://friends.roblox.com/v1/users/" .. id .. "/followers/count"})
                name = httprequest({Url = "https://users.roblox.com/v1/users/" .. id})
                previousnames =
                httprequest(
                    {Url = "https://users.roblox.com/v1/users/" .. id .. "/username-history?limit=10&sortOrder=Asc"}
                )


                friends = http:JSONDecode(friends.Body)
                followers = http:JSONDecode(followers.Body)
                name = http:JSONDecode(name.Body)
                previousnames = http:JSONDecode(previousnames.Body)
                status = http:JSONDecode(status.Body)

                error("Username: " .. name.name)
                error("\nDisplayName: " .. name.displayName)
                error("\nDescription: " .. name.description)
                error("\nStatus: " .. status.status)
                error("\nuserId: " .. name.id)
                error("\nFriend Count: " .. friends.count)
                error("\nAccount Created: " .. name.created)
                for i, v in pairs(previousnames.data) do
                    error("\nPrevious Names: " .. v.name)
                    total = i
                end
            end
        end
    )

    plr.Chatted:Connect(
        function(msg)
            if msg == _G.prefix .. "logservers" then
                url =
                httprequest(
                    {
                        Url = "https://games.roblox.com/v1/games/" ..
                            game.PlaceId .. "/servers/Public?limit=10&sortOrder=Asc"
                    }
                )
                response = http:JSONDecode(url.Body)
                for i, server in pairs(response.data) do
                    if server.id == game.JobId then
                        error("\n" .. i .. ") Server You're currently in!\n")
                        error("Server Id: " .. server.id)
                        error("Server Ping: " .. server.ping)
                        error("Server Fps: " .. server.fps)
                        error("Players Playing: " .. server.playing .. "\n")
                        error("---------------------------------------------------------------------------------\n")
                    else
                        error("\n" .. i .. ") Found Server!\n")
                        error("Server Id: " .. server.id)
                        error("Server Ping: " .. server.ping)
                        error("Server Fps: " .. server.fps)
                        error("Players Playing: " .. server.playing .. "\n")
                        error("---------------------------------------------------------------------------------\n")
                    end
                end
            end
        end
    )

    addcommand(
        "pban",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                table.insert(padbanned,Target.Name)
                error((Target.Name.." has been added to the pad-banned table"))
            end 
        end)

       

        addcommand(
        "unpban",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                for i = 1, #padbanned do 
                    if padbanned[i] == Target.Name then 
                        table.remove(padbanned,i)
                    end 
                end
                error((Target.Name.." has been removed from the pad-banned table"))
            end 
        end)

        addcommand(
        "timeout",
        "description here",
        function()
            for _Index, Target in pairs(GetPlayer(args[2])) do
                table.insert(_G.timeout,Target.Name)
                print(args[3])
                if string.match(args[3],"m") then
                 _G.timed = args[3]:split("m")   
                else
                 _G.timed = args[3]:split("s") 
                end

                local timed = tonumber(_G.timed[1])

                if string.match(args[3],"m") then
                    timed = timed*60
                end 
                function out()
                    tchat("cage "..Target.DisplayName)
                    tchat("name "..Target.Name.." (Time-Out)\n"..Target.DisplayName)
                    
                end 
                out()
                tchat("h/You are under time-out, Please reflect on your behaviour while you do so")
                spawn(function()
                    wait(3)
                    tchat("h/Say /timeout to view your remaining time..")
                end)
                local extratime = 0.01
                local a = Target.CharacterAdded:Connect(function()
                    if table.find(_G.timeout,Target.Name) then
                        pcall(function()
                        out()
                        
                    end)
                end
                end) 
                local b = Target.Chatted:Connect(function(msg)
                    if msg == '/timeout' and table.find(_G.timeout,Target.Name) then 
                        chat("Your remaining time is "..tostring(timed).." seconds..")
                    end 
                end)
                for i = 1, timed do 
                    wait(1)
                    timed = timed - 1

                end 
                a:Disconnect()
                b:Disconnect()
                for i = 1, #_G.timeout do 
                    if _G.timeout[i] == Target.Name then 
                table.remove(_G.timeout,i)
                    end 
                end
                wait(.1)
                tchat("reset "..Target.Name)
                tchat("h/Your time-out is over, "..Target.Name)

                
            end
        end)

        coroutine.wrap(function()
            local deb = true
    for _, v in pairs(Pads:GetChildren()) do
    if v:FindFirstChild("Head") then
    v.Head.Touched:Connect(function(p)
        if table.find(padbanned, p.Parent.Name) and deb then
            coroutine.wrap(function()
                deb = false
                task.wait(.2)
                deb = true
            end)()
            regenpads()
            tchat("respawn "..p.Parent.Name)
            wait(.1)
            tchat("pm/"..p.Parent.Name.." your banned from pads LOL")
        end 
    end) 
end
end
end)()

    

    section1:addToggle(
        "Anti Kill",
        nil,
        function(value)
            if value == true then
                antikill = true
                error("Anti kill enabled")
                coroutine.wrap(
                    function()
                        while antikill do
                            task.wait(time)
                            if plr.Character:WaitForChild("Humanoid").Health == 0 then
                                tchat("reset me")
                                wait(.17)
                            end
                        end
                    end
                )()
            else
                antikill = false
                error("Anti kill Disabled")
            end
        end
    )

    section1:addToggle(
        "Anti Jail",
        nil,
        function(value)
            if value == true then
                antijail = true
                error("Anti jail enabled")
                coroutine.wrap(
                    function()
                        while antijail do
                            Folder:WaitForChild(myjail)
                            Folder[myjail]:destroy()
                            tchat("unjail me")
                            task.wait(time)
                        end
                    end
                )()
            else
                antijail = false
                error("Anti jail disabled")
            end
        end
    )

    section1:addToggle(
        "Anti Freeze",
        nil,
        function(value)
            if value == true then
                _G.antifreeze = true
                error("Anti freeze enabled")
                plr.Character.ChildAdded:Connect(
                    function(v)
                        if _G.antifreeze == true then

                            if v.Name == "ice" then
                                tchat("unfreeze me")
                                task.wait(time)
                            end
                        end
                    end
                )
            else
                _G.antifreeze = false
                error("Anti freeze disabled")
            end
        end
    )

    section1:addToggle(
        "Anti Punish",
        nil,
        function(value)
            if value == true then
                antipunish = true
                error("Anti punish enabled")
                game.Lighting.ChildAdded:Connect(
                    function(child)
                        if antipunish then
                            if child.Name == plr.Name then
                                game.Lighting:FindFirstChild(plr.Name).Parent = game.Workspace
                                tchat("unpunish me")
                                task.wait(time)
                            end
                        end
                    end
                )
            else
                antipunish = false
                error("anti punish disabled")
            end
        end
    )

    section1:addToggle(
        "Anti Blind",
        nil,
        function(value)
            if value == true then
                antiblind = true
                wait()
                error("Anti blind Enabled")
                game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(
                    function(child)
                        if antiblind then
                            if child.Name == "EFFECTGUIBLIND" then
                                while child do
                                    child:remove()
                                    wait(time)
                                end
                            end
                        end
                    end
                )
            else
                antiblind = false
                error("Disabled Anti Blind")
            end
        end
    )

    section1:addToggle(
        "Anti Screen Guis",
        true,
        function(value)
            if value == true then
                guis = true
                wait()
                error("Anti Screen Guis enabled, Blind, m and h will be instantly destroyed")
                game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(
                    function(child)
                        if child.Name ~= "ScrollGui" and child.Name ~= "CommandsGui" then
                            if guis then
                                while child do
                                    child:remove()
                                    wait(time)
                                end
                            end
                        end
                    end
                )
            else
                guis = false
                error("Disabled anti Screen Guis")
            end
        end
    )

    section1:addToggle(
        "Anti Fling/Speed",
        nil,
        function(value)
            if value == true then
                antifling = true
                error("Enabled anti fling/speed, will reset character if high velocity has been detected")
                coroutine.wrap(
                    function()
                        while antifling do
                            task.wait()
                            local root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                            if root.Velocity.X > 25 or root.Velocity.X < -25 then
                                error("Velocity is too high! Resetting character")
                                tchat("reset me")
                                wait(.3)
                            end
                        end
                    end
                )()
            else
                antifling = false
                error("Disabled anti fling/speed")
            end
        end
    )

    for _,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("Part") then 
            v.Locked = false
        end 
    end

    section1:addToggle(
        "Anti Lag",
        nil,
        function(value)
            if value == true then
                error("Anti Lag enabled, Smoke and Bonfire will instantly be removed")
                antilag = true
                plr.Character.Torso.ChildAdded:Connect(
                    function(child)
                        if antilag then
                            if child.Name == "Smoke" or child.Name == "Fire" then
                                error("Detected " .. child.Name .. ", Successfully removed")
                                child:Destroy()
                                tchat("unsmoke me")
                                tchat("unfire me")
                            end
                        end
                    end
                )
            else
                antilag = false
                error("Anti lag has been disabled")
            end
        end
    )

    section2:addButton(
        "Reset Admin Pads",
        function()
            error("Admin Pads have been reset!")
            regenpads()
        end
    )

    section2:addButton(
        "Bring Pads",
        function()
            wait(.2)
            task.wait(time)
            error("Pads have been brought to localPlayer")
            for i, v in pairs(Pads:GetChildren()) do
                v.Head.CanCollide = false
                v.Head.CFrame = plr.Character.HumanoidRootPart.CFrame
                for _, p in pairs(plr.Character:GetChildren()) do
                    if p:IsA("Part") then
                        p.CanCollide = false
                    end
                end
            end
        end
    )

    section2:addToggle(
        "Take All Pads",
        nil,
        function(value)
            if value == true then
                error("Taken all pads lolol no more admin")
                takeallpads = true
                for i, v in pairs(Pads:GetChildren()) do
                    if v:FindFirstChild("Head") then
                    firetouchinterest(plr.Character:WaitForChild("Head"), v.Head, 0)
                    firetouchinterest(plr.Character:WaitForChild("Head"), v.Head, 1) 
                    end
                end
                wait(.01)
                for i, v in pairs(Pads:GetChildren()) do
                   if v:FindFirstChild("Head") then
                    v:GetPropertyChangedSignal("Name"):Connect(
                        function()
                            if takeallpads then
                                spawn(
                                    function()
                                        firetouchinterest(plr.Character:WaitForChild("Head"), v.Head, 0)
                                        firetouchinterest(plr.Character:WaitForChild("Head"), v.Head, 1)
                                    end
                                )
                            end
                        end
                    )
                   end
                end
            else
                takeallpads = false
                error("Disabled Take all pads")
                wait(1)
                for i = 1, 10 do
                    wait()
                    regen()
                end
            end
        end
    )




 


        section3:addToggle(
            "Hide Character",
            nil,
            function(value)
                if value == true then
                    hide = true
                    coroutine.wrap(
                        function()
                            if not plr.Character then
                                error("Character Does not exist?")
                            else
                                plr.Character:Remove()
                                error("Character Has been Destroyed, Protected from commands")
                            end
                            plr.CharacterAdded:Connect(
                                function(character)
                                    if hide then
                                        character:Destroy()
                                    end
                                end
                            )
                        end
                    )()
                else
                    hide = false
                    error("Respawning Character...")
                end
            end
        )

        section3:addToggle(
            "Inf God",
            nil,
            function(value)
                if value == true then
                    error("Enabled Auto God")
                    god = true
                    tchat("god me")
                    plr.Character:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(
                        function()
                            if god then
                                if character.Humanoid.Health < math.huge then
                                    tchat("god me")
                                end
                            end
                        end
                    )
                else
                    error("Disabled Auto God")
                    god = false
                end
            end
        )

        section3:addToggle(
            "Inf Forcefield",
            nil,
            function(value)
                if value == true then
                    error("Enabled Auto Forcefield")
                    ff = true
                    tchat("ff me")
                    plr.Character.ChildRemoved:Connect(
                        function(child)
                            if ff then
                                if child.Name == "ForceField" then
                                    tchat("ff me")
                                end
                            end
                        end
                    )
                else
                    error("Disabled Auto Forcefield")
                    ff = false
                end
            end
        )

        section3:addButton(
            "Skydive",
            function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame =
                CFrame.new(
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.X,
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Y + 1000,
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Z
            )
            wait()
            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Anchored = true
            end
        )

        section3:addButton(
            "Unanchor",
            function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        )


        addcommand("btools",
		"toggles anti kick",
		function()
            local tool1 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
            local tool2 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
            local tool3 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
            local tool4 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
            local tool5 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
            tool1.BinType = "Clone"
            tool2.BinType = "GameTool"
            tool3.BinType = "Hammer"
            tool4.BinType = "Script"
            tool5.BinType = "Grab"
        end)

        addcommand("setsp",
		"toggles anti kick",
		function()
            if rs:FindFirstChild("spawnpoint") then
                rs.spawnpoint:Destroy()
                wait()
            end
            local spawnpoint = Instance.new("Part", rs)
            spawnpoint.Name = "spawnpoint"
            spawnpoint.CFrame = plr.Character.HumanoidRootPart.CFrame
            error("Set spawnpoint to " .. tostring(spawnpoint.CFrame))
            plr.CharacterAdded:Connect(
                function(character)
                    if rs:FindFirstChild("spawnpoint") then
                        character:WaitForChild("HumanoidRootPart").CFrame = rs:FindFirstChild("spawnpoint").CFrame
                    end
                end
            )
        end)

        _G.buildermode = false

        addcommand("pclr",
		"model to persons part loader",
		function()
            for _, v in pairs(game.Workspace:GetChildren()) do 
                if v.Name == 'PlacementHolder' then 
                    v:destroy()
                end 
            end 
            _G.buildermode = false
        end)
        plr.CharacterAdded:Connect(function(c)
            if _G.buildermode then 
                paint()
            end 
            c.ChildRemoved:Connect(function(f)
                if f:IsA("Tool")  and _G.buildermode then
                    task.wait() 
                    paint()
                end 
            end)
        end)
    

        addcommand("tknives",
		"model to persons part loader",
		function()
            tchat("gear me 208659586")
            tchat("gear me 1215515248")
            tchat("gear me 110789105")
        end)

        addcommand("frame", "", function()
            tchat("load 32668711")
        end)

   --[[addcommand("load",
		"model to persons part loader",
		function()
			if args[2] then
				_G.filePath = tonumber(args[2])
			end
			--isPlacing = true
            _G.buildermode = true
            local function splitPart(part)
                local currentSize = part.Size
                local splits = Vector3.new(
                    math.ceil(currentSize.X / 10),
                    math.ceil(currentSize.Y / 10),
                    math.ceil(currentSize.Z / 10)
                )
                local splitCount = splits.X * splits.Y * splits.Z
                local originalCFrame = part.CFrame
                local newParts = {}
                local offsetX = currentSize.X / splits.X
                local offsetY = currentSize.Y / splits.Y
                local offsetZ = currentSize.Z / splits.Z
                local startOffset = CFrame.new(
                    (-currentSize.X / 2) + (offsetX / 2),
                    (-currentSize.Y / 2) + (offsetY / 2),
                    (-currentSize.Z / 2) + (offsetZ / 2)
                )
                for x = 1, splits.X do
                    for y = 1, splits.Y do
                        for z = 1, splits.Z do
                            local splitPart = part:Clone()
                            local newSizeX = math.min(offsetX, currentSize.X - (x - 1) * offsetX)
                            local newSizeY = math.min(offsetY, currentSize.Y - (y - 1) * offsetY)
                            local newSizeZ = math.min(offsetZ, currentSize.Z - (z - 1) * offsetZ)
                            splitPart.Size = Vector3.new(newSizeX, newSizeY, newSizeZ)
                            local positionOffset = startOffset * CFrame.new((x - 1) * offsetX, (y - 1) * offsetY, (z - 1) * offsetZ)
                            splitPart.CFrame = originalCFrame * positionOffset
                            splitPart.Parent = workspace
                            table.insert(newParts, splitPart)
                        end
                    end
                end
                part:Destroy()
                return newParts, splitCount
            end


            


			local parts = {}
			local function loadModel(modelId)
				local success, model = pcall(function()
					return game:GetObjects("rbxassetid://" .. modelId)[1]
				end)
				if success and model then
					print("Loading model ID: " .. modelId)

                    local lowestPart = nil
				local lowestY = math.huge

            for _, part in ipairs(model:GetDescendants()) do
                    if part:IsA("Part") or part:IsA("BasePart") then
                        local partName, sizeX, sizeY, sizeZ = part.Name, part.Size.X, part.Size.Y, part.Size.Z
                        if partName and sizeX and sizeY and sizeZ then
            local posY = part.Position.Y
            if posY < lowestY then
                lowestY = posY
                lowestPart = part
                end
            end
        end
    end
			
local pdown = true 
fgh = mouse.Button1Down:Connect(function()
    pdown = false 
    fgh:Disconnect()
  
    mtyu:Disconnect()
    for _, v in pairs(game.Workspace:GetChildren()) do 
        if v.Name == 'PlacementHolder' then 
            v.Transparency = 1
        end 
    end
end)

 ty = plr.Chatted:Connect(function(c)
    if c == 'unload' then 
        pdown = false 
    fgh:Disconnect()
  
    mtyu:Disconnect()
    ty:Disconnect()
    return tchat("pclr")
    end
 end)
    

			       
   
                    
                     
               



                    
			mtyu = mouse.Move:Connect(function()
                task.wait(.3)
                for _, v in pairs(game.Workspace:GetChildren()) do 
                    if v.Name == 'PlacementHolder' then 
                        v:remove()
                    end 
                end
                    for _, object in ipairs(model:GetDescendants()) do
						if object:IsA("Part") or object:IsA("BasePart") then
							local partName, sizeX, sizeY, sizeZ = object.Name, object.Size.X, object.Size.Y, object.Size.Z
							if partName and sizeX and sizeY and sizeZ then
								local part = Instance.new("Part")
								part.Size = Vector3.new(sizeX, sizeY, sizeZ)
								part.Velocity = Vector3.new(34, 54, 0)
								part.Anchored = true
                                part.CFrame = object.CFrame
								part.Parent = game.Workspace
								part.Transparency = 0.5
								part.Name = "PlacementHolder"
                                part.Color = object.Color
								table.insert(parts, part)
                                
							end
						end
					end
                end)

                while pdown do 
                    task.wait(.3)
                model.PrimaryPart = lowestPart
                model:PivotTo(CFrame.new(mouse.Hit.p))
                end
                

                    

            
        
    

					return parts
				else
					print("Failed to load model ID: " .. modelId)
					return nil
				end
			end

            

        
   

            tchat("reset me")
            colorAPI = {}
            colorAPI.color = function(Part, color)
                local thread = coroutine.create(function()
                    local Arguments =
                        {
                            ["Part"] = Part,
                            ["Color"] = color
                        }
                    game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name].PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", Arguments)
                end)
                coroutine.resume(thread)
            end
            function newpart(x,y,z, pos, c) 
                pcall(function()
                setsimulationradius(999.999,999.999)
                end)
                local LocalPlayer = game:GetService("Players").LocalPlayer
                LocalPlayer.MaximumSimulationRadius = math.huge
                sethiddenproperty(LocalPlayer, "SimulationRadius", 999.999)
                   
                local part;
                if x > 10 then x = 10 end
                if y > 10 then y = 10 end
                if z > 10 then z = 10 end
                game.Players:Chat("part/"..x.."/"..y.."/"..z)
                local con69;
                con69 = Folder.ChildAdded:Connect(function(c)
                if c.Name == "Part" and c.Size == Vector3.new(x,y,z) then 
                pcall(function() con69:Disconnect() end)
                part = c;
                end
                end)

                

                
                
                repeat task.wait() until part
                part.Name = "newpart"
                if c then
                    part.Color = c;
                    colorAPI.color(part, c)
                end
                local tpd = false 
                local initp = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0.01, 0)
                if isnetworkowner ~= nil then    
                if not isnetworkowner(part) then
                repeat methods:tp(part.CFrame); task.wait() until isnetworkowner(part)
                tpd = true
                end
            end
                part.CFrame = pos;
                task.spawn(function() 
                while task.wait() do
                if dead then break end
                if breakbuilds then break end
                part.Velocity = Vector3.new(30, 4, 0);
                part.CFrame = pos
                end
                end)
                if tpd then methods:tp(initp) end
                task.spawn(function() 
                task.wait(.5)
                part.Anchored = true
                end)
                return part
        end
			
        
			

			local function placeModel(parts)
				if isPlacing then
					repeat
						task.wait()
					until isPlacing == false
					for _, partx in ipairs(parts) do
						tchat("part/" .. partx.Size.X .. "/" .. partx.Size.Y .. "/" .. partx.Size.Z)
						game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.huge
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 999.999)
						local modelPart = workspace.Terrain._Game.Folder:FindFirstChild("Part")
						if modelPart then
							modelPart.CFrame = partx.CFrame
							modelPart.Velocity = Vector3.new(34, 54, 0)
							modelPart.Anchored = true
						end
					end
					
				end
			end

			local parts = loadModel(_G.filePath)
			
           task.wait(1)
           for i,v in pairs(game.Workspace:GetChildren()) do 
            if v.Name == 'PlacementHolder' then 
                task.wait()
                    --local currentDescendant = i
                        if v.Size.X > 10 or v.Size.Y > 10 or v.Size.Z > 10 then
                            local newParts, splitCount = splitPart(v)
                            for _, newPart in ipairs(newParts) do
                                newpart(newPart.Size.X, newPart.Size.Y, newPart.Size.Z, newPart.CFrame, newPart.Color)
                                newPart:Destroy()
                            end
                            --    DisplayText("[Vecko]: ", "Part was split into "..splitCount.." smaller parts.")
                        else
                            newpart(v.Size.X, v.Size.Y, v.Size.Z, v.CFrame, v.Color)
                            v:Destroy()
                        end
                    
    end
end
tchat("pclr")


		end
	)]]

 



       addcommand("load",
		"model to persons part loader",
		function()
			if args[2] then
				_G.filePath = tonumber(args[2])
			end
			--isPlacing = true
            _G.buildermode = true
            local function splitPart(part)
                local currentSize = part.Size
                local splits = Vector3.new(
                    math.ceil(currentSize.X / 10),
                    math.ceil(currentSize.Y / 10),
                    math.ceil(currentSize.Z / 10)
                )
                local splitCount = splits.X * splits.Y * splits.Z
                local originalCFrame = part.CFrame
                local newParts = {}
                local offsetX = currentSize.X / splits.X
                local offsetY = currentSize.Y / splits.Y
                local offsetZ = currentSize.Z / splits.Z
                local startOffset = CFrame.new(
                    (-currentSize.X / 2) + (offsetX / 2),
                    (-currentSize.Y / 2) + (offsetY / 2),
                    (-currentSize.Z / 2) + (offsetZ / 2)
                )
                for x = 1, splits.X do
                    for y = 1, splits.Y do
                        for z = 1, splits.Z do
                            local splitPart = part:Clone()
                            local newSizeX = math.min(offsetX, currentSize.X - (x - 1) * offsetX)
                            local newSizeY = math.min(offsetY, currentSize.Y - (y - 1) * offsetY)
                            local newSizeZ = math.min(offsetZ, currentSize.Z - (z - 1) * offsetZ)
                            splitPart.Size = Vector3.new(newSizeX, newSizeY, newSizeZ)
                            local positionOffset = startOffset * CFrame.new((x - 1) * offsetX, (y - 1) * offsetY, (z - 1) * offsetZ)
                            splitPart.CFrame = originalCFrame * positionOffset
                            splitPart.Parent = workspace
                            table.insert(newParts, splitPart)
                        end
                    end
                end
                part:Destroy()
                return newParts, splitCount
            end


            


			local parts = {}
			local function loadModel(modelId)
				local success, model = pcall(function()
					return game:GetObjects("rbxassetid://" .. modelId)[1]
				end)
				if success and model then
					print("Loading model ID: " .. modelId)

                    local lowestPart = nil
				local lowestY = math.huge

            for _, part in ipairs(model:GetDescendants()) do
                    if part:IsA("Part") or part:IsA("BasePart") then
                        local partName, sizeX, sizeY, sizeZ = part.Name, part.Size.X, part.Size.Y, part.Size.Z
                        if partName and sizeX and sizeY and sizeZ then
            local posY = part.Position.Y
            if posY < lowestY then
                lowestY = posY
                lowestPart = part
                end
            end
        end
    end
			
local pdown = true 
fgh = mouse.Button1Down:Connect(function()
    pdown = false 
    fgh:Disconnect()
  
    mtyu:Disconnect()
    for _, v in pairs(game.Workspace:GetChildren()) do 
        if v.Name == 'PlacementHolder' then 
            v.Transparency = 1
        end 
    end
end)

 ty = plr.Chatted:Connect(function(c)
    if c == 'unload' then 
        pdown = false 
    fgh:Disconnect()
  
    mtyu:Disconnect()
    ty:Disconnect()
    return tchat("pclr")
    end
 end)
    

			       
   
                    
                     
               



                    
			mtyu = mouse.Move:Connect(function()
                task.wait(.3)
                for _, v in pairs(game.Workspace:GetChildren()) do 
                    if v.Name == 'PlacementHolder' then 
                        v:remove()
                    end 
                end
                    for _, object in ipairs(model:GetDescendants()) do
						if object:IsA("Part") or object:IsA("BasePart") then
							local partName, sizeX, sizeY, sizeZ = object.Name, object.Size.X, object.Size.Y, object.Size.Z
							if partName and sizeX and sizeY and sizeZ then
								local part = Instance.new("Part")
								part.Size = Vector3.new(sizeX, sizeY, sizeZ)
								part.Velocity = Vector3.new(34, 54, 0)
								part.Anchored = true
                                part.CFrame = object.CFrame
								part.Parent = game.Workspace
								part.Transparency = 0.5
								part.Name = "PlacementHolder"
                                part.Color = object.Color
								table.insert(parts, part)
                                
							end
						end
					end
                end)

                while pdown do 
                    task.wait(.3)
                model.PrimaryPart = lowestPart
                model:PivotTo(CFrame.new(mouse.Hit.p))
                end
                

                    

            
        
    

					return parts
				else
					print("Failed to load model ID: " .. modelId)
					return nil
				end
			end

            

        
   

            tchat("reset me")
            colorAPI = {}
            colorAPI.color = function(Part, color)
                local thread = coroutine.create(function()
                    local Arguments =
                        {
                            ["Part"] = Part,
                            ["Color"] = color
                        }
                    game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name].PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", Arguments)
                end)
                coroutine.resume(thread)
            end
            function newpart(x,y,z, pos, c) 
                pcall(function()
                setsimulationradius(999.999,999.999)
                end)
                local LocalPlayer = game:GetService("Players").LocalPlayer
                LocalPlayer.MaximumSimulationRadius = math.huge
                sethiddenproperty(LocalPlayer, "SimulationRadius", 999.999)
                   
                local part;
                if x > 10 then x = 10 end
                if y > 10 then y = 10 end
                if z > 10 then z = 10 end
                game.Players:Chat("part/"..x.."/"..y.."/"..z)
                local con69;
                con69 = Folder.ChildAdded:Connect(function(c)
                if c.Name == "Part" and c.Size == Vector3.new(x,y,z) then 
                pcall(function() con69:Disconnect() end)
                part = c;
                end
                end)

                

                
                
                repeat task.wait() until part
                part.Name = "newpart"
                if c then
                    part.Color = c;
                    colorAPI.color(part, c)
                end
                local tpd = false 
                local initp = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0.01, 0)
                if isnetworkowner ~= nil then    
                if not isnetworkowner(part) then
                repeat methods:tp(part.CFrame); task.wait() until isnetworkowner(part)
                tpd = true
                end
            end
                part.CFrame = pos;
                task.spawn(function() 
                while task.wait() do
                if dead then break end
                if breakbuilds then break end
                part.Velocity = Vector3.new(30, 4, 0);
                part.CFrame = pos
                end
                end)
                if tpd then methods:tp(initp) end
                task.spawn(function() 
                task.wait(.5)
                part.Anchored = true
                end)
                return part
        end
			
        
			

			local function placeModel(parts)
				if isPlacing then
					repeat
						task.wait()
					until isPlacing == false
					for _, partx in ipairs(parts) do
						tchat("part/" .. partx.Size.X .. "/" .. partx.Size.Y .. "/" .. partx.Size.Z)
						game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.huge
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 999.999)
						local modelPart = workspace.Terrain._Game.Folder:FindFirstChild("Part")
						if modelPart then
							modelPart.CFrame = partx.CFrame
							modelPart.Velocity = Vector3.new(34, 54, 0)
							modelPart.Anchored = true
						end
					end
					
				end
			end

			local parts = loadModel(_G.filePath)
			
           task.wait(1)
           for i,v in pairs(game.Workspace:GetChildren()) do 
            if v.Name == 'PlacementHolder' then 
                task.wait()
                    --local currentDescendant = i
                        if v.Size.X > 10 or v.Size.Y > 10 or v.Size.Z > 10 then
                            local newParts, splitCount = splitPart(v)
                            for _, newPart in ipairs(newParts) do
                                newpart(newPart.Size.X, newPart.Size.Y, newPart.Size.Z, newPart.CFrame, newPart.Color)
                                newPart:Destroy()
                            end
                            --    DisplayText("[Vecko]: ", "Part was split into "..splitCount.." smaller parts.")
                        else
                            newpart(v.Size.X, v.Size.Y, v.Size.Z, v.CFrame, v.Color)
                            v:Destroy()
                        end
                    
    end
end
tchat("pclr")


		end
	)


    

        addcommand("rsp",
		"toggles anti kick",
		function()
            rs:FindFirstChild("spawnpoint"):remove()
        end)

        section3:addButton(
            "SetSpawnPoint",
            function()
                if rs:FindFirstChild("spawnpoint") then
                    rs.spawnpoint:Destroy()
                    wait()
                end
                local spawnpoint = Instance.new("Part", rs)
                spawnpoint.Name = "spawnpoint"
                spawnpoint.CFrame = plr.Character.HumanoidRootPart.CFrame
                error("Set spawnpoint to " .. tostring(spawnpoint.CFrame))
                plr.CharacterAdded:Connect(
                    function(character)
                        if rs:FindFirstChild("spawnpoint") then
                            character:WaitForChild("HumanoidRootPart").CFrame = rs:FindFirstChild("spawnpoint").CFrame
                        end
                    end
                )
            end
        )

        addcommand("pbans?",
		"toggles anti kick",
		function()
        error("Pad-banned players:")
        for i = 1, #padbanned do 
           print(padbanned[i])
        end
            end
        )

        section3:addButton(
            "Inf Jump",
            function()
                game:GetService("UserInputService").JumpRequest:connect(
                    function()
                        game:GetService "Players".LocalPlayer.Character:FindFirstChildOfClass "Humanoid":ChangeState(
                            "Jumping"
                        )
                    end
                )
            end
        )

        section3:addButton(
            "Server Hop",
            function()
                    _G.teleport()
            end
        )

        section3:addButton(
            "Rejoin",
            function()
                error("Rejoining Server..")
                space()
                rejoin()
            end
        )

        sectionob:addButton(
            "Remove ObbyKill",
            function()
                removeobbykill()
                error("Removed Obby Kill")
            end
        )

        section4:addButton(
            "Vamp Crash Server",
            function()
                tchat("gear me 94794847")
                tchat("music "..zero.."1289224027")
            repeat task.wait()
            until plr.Backpack:FindFirstChild(gr)
                        plr.Character.Humanoid:EquipTool(plr.Backpack[gr])
                        _G.check = true
                        while _G.check == true do task.wait()
                            if plr.Character:FindFirstChild("VampireVanquisher") then
                                _G.check = false
                                tchat("size all .3")
                                tchat("size all .3")
                                tchat("size all .3")
                                tchat("clone all")
                            end
                        end
                    
                wait(1)
                if not plr.Character:FindFirstChild(gr) then
                    error("Vamp Crash Failed, someone is using anti crash")
                else
                    appendfile("ServersHopped.txt", game.JobId.."\n") 
                    error("Successfully Crashed Server!")
                    _G.teleport()
                end
            end
        )

        

        section4:addButton(
            "Freeze Crash Server",
            function()
                spawn(function()
                while wait(.1) do
                for i = 1, 10 do
                    
                    for i = 1, 3 do
                        game:GetService "Players":Chat(("size all 0.3"))
                    end
                    game:GetService "Players":Chat(("freeze all"))
                    for i = 1, 3 do
                        game:GetService "Players":Chat(("size all 10"))
                    end
                    game:GetService "Players":Chat(("clone all"))
                end
            end
        end)
        appendfile("ServersHopped.txt", game.JobId.."\n") 
                error("Successfully Crashed Server!")
                wait(.7)
                _G.teleport()
            end
        )

        

    

        section4:addToggle(
            "Anti Crash",
            nil,
            function(value)
                if value == true then
                    autoanticrash = true
                    z = game.Players.ChildAdded:Connect(function()
                        while autoanticrash do 
                            task.wait()
                            tchat("speed all nan")
                        end 
                    end)
                else
                    z:Disconnect()
                    autoanticrash = false
                    tchat("respawn all")
                end
            end
        )

        sectionauto:addButton(
            "Auto Crash",
            function()
                warn("This command will work once then crash has been fixed")
            end
        )

        local alreadymoved = false
        for _, v in pairs(ws["Obby Box"]:GetDescendants()) do 
            if v:IsA("Part") then 
                v.CanCollide = false 
            end 
        end
        section5:addButton(
            "Move ObbyBox",
            function()
                for i, v in pairs(ws["Obby Box"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    RunService.Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("skydive me")
                            tchat("skydive me")
                            tchat("skydive me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Obby Box has already been moved!")
                else
                    error("Successfully moved Obby Box!")
                end
            end
        )

        section5:addButton(
            "Move Obby",
            function()
                
                for i, v in pairs(ws["Obby"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    wait()
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("skydive me")
                        tchat("skydive me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Obby has already been moved!")
                else
                    error("Successfully moved Obby!")
                end
            end
        )

        section5:addButton(
            "Move Pads",
            function()
                for i, v in pairs(Pads:GetChildren()) do
                    v = v.Head
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("skydive me")
                            tchat("skydive me")
                            tchat("skydive me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Pads have already been moved!")
                else
                    error("Successfully moved Pads!")
                end
            end
        )

        section5:addButton(
            "Move Admin Dividers",
            function()
                for i, v in pairs(ws["Admin Dividers"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("skydive me")
                            tchat("skydive me")
                            tchat("skydive me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Admin Dividers have already been moved!")
                else
                    error("Successfully moved Admin Dividers")
                end
            end
        )

        section5:addButton(
            "Move Regen",
            function()
                if Admin.Regen.CFrame.Y < 500 then
                    repeat
                        wait()
                    until game.Players.LocalPlayer.Character and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local looping = true
                    spawn(
                        function()
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                cf.CFrame =
                                    Admin.Regen.CFrame *
                                    CFrame.new(
                                        -1 * (Admin.Regen.Size.X / 2) -
                                            (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                        0,
                                        0
                                    )
                                if not looping then
                                    break
                                end
                            end
                        end
                    )
                    spawn(
                        function()
                            while looping do
                                wait(.1)
                                tchat("unpunish me")
                            end
                        end
                    )
                    wait(0.3)
                    looping = false
                    for i = 1, 5 do
                        tchat("skydive me")
                        tchat("skydive me")
                        tchat("skydive me")
                    end
                    wait(0.2)
                    tchat("respawn me")
                    wait(0.2)
                else
                    alreadymoved = true
                end
                if alreadymoved == true then
                    error("Regen has already been moved")
                else
                    error("Successfully moved Regen!")
                end
            end
        )

        section5:addButton(
            "Move Building Bricks",
            function()
                for i, v in pairs(ws["Building Bricks"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("skydive me")
                            tchat("skydive me")
                            tchat("skydive me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Building Bricks have already been moved!")
                else
                    error("Successfully moved Building Bricks!")
                end
            end
        )

        section5:addButton(
            "Move House",
            function()
                for i, v in pairs(ws["Basic House"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("skydive me")
                            tchat("skydive me")
                            tchat("skydive me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Basic House has already been moved!")
                else
                    error("Successfully moved Basic House!")
                end
            end
        )

        section5:addButton(
            "Move Baseplate",
            function()
                if ws.Baseplate.CFrame.Y < 500 then
                    repeat
                        wait()
                    until game.Players.LocalPlayer.Character and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local looping = true
                    spawn(
                        function()
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                cf.CFrame =
                                    ws.Baseplate.CFrame *
                                    CFrame.new(
                                        -1 * (ws.Baseplate.Size.X / 2) -
                                            (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                        0,
                                        0
                                    )
                                if not looping then
                                    break
                                end
                            end
                        end
                    )
                    spawn(
                        function()
                            while looping do
                                wait(.1)
                                tchat("unpunish me")
                            end
                        end
                    )
                    wait(0.3)
                    looping = false
                    for i = 1, 5 do
                        tchat("skydive me")
                        tchat("skydive me")
                        tchat("skydive me")
                    end
                    wait(0.2)
                    tchat("respawn me")
                    wait(0.2)
                else
                    alreadymoved = true
                end
                if alreadymoved == true then
                    error("Baseplate has already been moved")
                else
                    error("Successfully moved Baseplate")
                end
            end
        )


        

        sectionreturn:addButton(
            "Return ObbyBox",
            function()
                for i, v in pairs(ws["Obby Box"]:GetChildren()) do
                    if v.CFrame.Y > 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("unskydive me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Obby Box has already been returned!")
                else
                    error("Successfully returned Obby Box!")
                end
            end
        )

        sectionreturn:addButton(
            "Return Obby",
            function()
                for i, v in pairs(ws["Obby"]:GetChildren()) do
                    if v.CFrame.Y > 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("unskydive me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Obby has already been returned!")
                else
                    error("Successfully returned Obby!")
                end
            end
        )

        sectionreturn:addButton(
            "Return Pads",
            function()
                    skydive()
                    wait(.5)
                    returnpads()
                    if alreadymoved == true then
                        error("Pads have already been returned!")
                    else
                        error("Successfully returned Pads!")
                    end
            end)

        sectionreturn:addButton(
            "Return Regen",
            function()
                skydive()
                wait(.5)
                returnregen()

                if alreadymoved == true then
                    error("Regen has already been returned!")
                else
                    error("Successfully returned Regen!")
                end
            end
        )

        sectionreturn:addButton(
            "Return Admin Dividers",
            function()
                for i, v in pairs(ws["Admin Dividers"]:GetChildren()) do
                    if v.CFrame.Y > 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("unskydive me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Admin Dividers have already been returned!")
                else
                    error("Successfully returned Admin Dividers!")
                end
            end
        )

        sectionreturn:addButton(
            "Return Building Bricks",
            function()
                for i, v in pairs(ws["Building Bricks"]:GetChildren()) do
                    if v.CFrame.Y > 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("unskydive me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Building Bricks have already been returned!")
                else
                    error("Successfully returned Building Bricks!")
                end
            end
        )

        sectionreturn:addButton(
            "Return Basic House",
            function()
                for i, v in pairs(ws["Basic House"]:GetChildren()) do
                    if v.CFrame.Y > 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("unskydive me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Basic House has already been returned!")
                else
                    error("Successfully returned Basic House!")
                end
            end
        )

        --getgenv().antidog = RunService.RenderStepped:Connect(function()
            pcall(function()
               for _, v in pairs(plr.Character:GetChildren()) do 
                if v.Name:lower() == 'addon' then 
                    v:remove()
                
                end 
            end
            end)
       -- end)

        sectionreturn:addButton(
            "Return Baseplate",
            function()
                if ws.Baseplate.CFrame.Y > 500 then
                    repeat
                        wait()
                    until game.Players.LocalPlayer.Character and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                    local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local looping = true

                    spawn(
                        function()
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                cf.CFrame =
                                    ws.Baseplate.CFrame *
                                    CFrame.new(
                                        -1 * (ws.Baseplate.Size.X / 2) -
                                            (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                        0,
                                        0
                                    )
                                if not looping then
                                    break
                                end
                            end
                        end
                    )
                    spawn(
                        function()
                            while looping do
                                wait(.1)
                                tchat("unpunish me")
                            end
                        end
                    )
                    wait(0.3)
                    looping = false
                    tchat("unskydive me")
                    wait(0.2)
                    tchat("respawn me")
                    wait(0.2)
                else
                    alreadymoved = true
                end

                if alreadymoved == true then
                    error("Baseplate has already been returned!")
                else
                    error("Successfully returned Baseplate!")
                end
            end
        )





        sectionflip:addButton(
            "Flip ObbyBox",
            function()
                for i, v in pairs(ws["Obby Box"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("seizure me")
                            tchat("seizure me")
                            tchat("seizure me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Obby Box has already been Flipped!")
                else
                    error("Successfully Flipped Obby Box!")
                end
            end
        )

        sectionflip:addButton(
            "Flip Obby",
            function()
                removeobbykill()
                for i, v in pairs(ws["Obby"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    wait()
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("seizure me")
                        tchat("seizure me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Obby has already been Flipped!")
                else
                    error("Successfully Flipped Obby!")
                end
            end
        )

        sectionflip:addButton(
            "Flip Pads",
            function()
                for i, v in pairs(Pads:GetChildren()) do
                    if v.Head.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.Head.CFrame *
                                        CFrame.new(
                                            -1 * (v.Head.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("seizure me")
                            tchat("seizure me")
                            tchat("seizure me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Pads have already been Flipped!")
                else
                    error("Successfully Flipped Pads")
                end
            end
        )

        sectionflip:addButton(
            "Flip Admin Dividers",
            function()
                for i, v in pairs(ws["Admin Dividers"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("seizure me")
                            tchat("seizure me")
                            tchat("seizure me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Admin Dividers have already been Flipped!")
                else
                    error("Successfully Flipped Admin Dividers")
                end
            end
        )

        sectionflip:addButton(
            "Flip Regen",
            function()
                if Admin.Regen.CFrame.Y < 500 then
                    repeat
                        wait()
                    until game.Players.LocalPlayer.Character and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local looping = true
                    spawn(
                        function()
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                cf.CFrame =
                                    Admin.Regen.CFrame *
                                    CFrame.new(
                                        -1 * (Admin.Regen.Size.X / 2) -
                                            (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                        0,
                                        0
                                    )
                                if not looping then
                                    break
                                end
                            end
                        end
                    )
                    spawn(
                        function()
                            while looping do
                                wait(.1)
                                tchat("unpunish me")
                            end
                        end
                    )
                    wait(0.3)
                    looping = false
                    for i = 1, 5 do
                        tchat("seizure me")
                        tchat("seizure me")
                        tchat("seizure me")
                    end
                    wait(0.2)
                    tchat("respawn me")
                    wait(0.2)
                else
                    alreadymoved = true
                end
                if alreadymoved == true then
                    error("Regen has already been Flipped")
                else
                    error("Successfully Flipped Regen!")
                end
            end
        )

        sectionflip:addButton(
            "Flip Building Bricks",
            function()
                for i, v in pairs(ws["Building Bricks"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("seizure me")
                            tchat("seizure me")
                            tchat("seizure me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Building Bricks have already been Flipped!")
                else
                    error("Successfully Flipped Building Bricks!")
                end
            end
        )

        sectionflip:addButton(
            "Flip House",
            function()
                for i, v in pairs(ws["Basic House"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        for i = 1, 5 do
                            tchat("seizure me")
                            tchat("seizure me")
                            tchat("seizure me")
                        end
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
                if alreadymoved == true then
                    error("Basic House has already been Flipped")
                else
                    error("Successfully Flipped Basic House!")
                end
            end
        )



        sectionflip:addButton(
            "Flip Baseplate",
            function()
                if ws.Baseplate.CFrame.Y < 500 then
                    repeat
                        wait()
                    until game.Players.LocalPlayer.Character and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local looping = true
                    spawn(
                        function()
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                cf.CFrame =
                                    ws.Baseplate.CFrame *
                                    CFrame.new(
                                        -1 * (ws.Baseplate.Size.X / 2) -
                                            (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                        0,
                                        0
                                    )
                                if not looping then
                                    break
                                end
                            end
                        end
                    )
                    spawn(
                        function()
                            while looping do
                                wait(.1)
                                tchat("unpunish me")
                            end
                        end
                    )
                    wait(0.3)
                    looping = false
                    for i = 1, 5 do
                        tchat("seizure me")
                        tchat("seizure me")
                        tchat("seizure me")
                    end
                    wait(0.2)
                    tchat("respawn me")
                    wait(0.2)
                else
                    alreadymoved = true
                end
                if alreadymoved == true then
                    error("Baseplate has already been flipped")
                else
                    error("Successfully flipped Baseplate")
                end
            end
        )



        sectionrmove:addButton(
            "Rmove ObbyBox",
            function()
                for i, v in pairs(ws["Obby Box"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("trip me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
            end
        )

        sectionrmove:addButton(
            "Rmove Obby",
            function()
                removeobbykill()
                for i, v in pairs(ws["Obby"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    wait()
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("trip me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
            end
        )

        addcommand("g/load",
		"",
		function()
			if args[2] then
            local id 
            id = args[2]
                game.Players:Chat("gear me 00000000000000000000000000000000000000000000000000"..id)

            repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
   
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool").Name

            local args = {15}
               for i2=1,args[1] do
                   for i=1,args[1] do
                    game.Players:Chat("gear me 00000000000000000000000000000000000000000000000000"..id)
                       repeat task.wait() until game.Players.LocalPlayer.Backpack:FindFirstChild(tool)
                       game.Players.LocalPlayer.Backpack:FindFirstChild(tool).GripPos=(CFrame.Angles(0,0,math.rad(i2*(-360/args[1])))*CFrame.new(math.cos(i*(-100/args[1]))*1,0,math.sin(i*(args[1]/1))*6)).p
                       game.Players.LocalPlayer.Backpack:FindFirstChild(tool).Parent = game.Players.LocalPlayer.Character
                   end
               end
           
           
           
           
           wait(0.1)-- Lower the HipHeight value to make it go down.
           Connections.cannonthing = game:GetService("UserInputService").InputBegan:Connect(function(inputa,gp)
               if gp then
                   return
               end
               if inputa.UserInputType == Enum.UserInputType.MouseButton1 then
                   for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                       if v:IsA("Tool") then
                           v.Click:FireServer((v.Handle.CFrame*CFrame.new(0,0,0)).p)
                       end
                   end
                end
            end)
               
           end
        end)



        addcommand("g/",
		"",
		function()
			if args[2] then
            local id 
            id = args[2]
            
                game.Players:Chat("gear me 00000000000000000000000000000000000000000000000000"..id)

            repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
   
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool").Name
 

            getgenv().mod = nil 

            plr.Chatted:Connect(function(m)
                m = m:split(" ")
                if m[1] == 'mod' then 
                    getgenv().mod = tonumber(m[2])
                end 
            end) 
            repeat wait() until getgenv().mod
            local args = {15}
               for i2=1,args[1] do
                   for i=1,args[1] do
                    game.Players:Chat("gear me 00000000000000000000000000000000000000000000000000"..id)
                       repeat task.wait() until game.Players.LocalPlayer.Backpack:FindFirstChild(tool)
                       game.Players.LocalPlayer.Backpack:FindFirstChild(tool).GripPos=(CFrame.Angles(0,0,math.rad(i2*(-360/args[1])))*CFrame.new(math.cos(i*(-100/args[1]))*1,0,math.sin(i*(args[1]/1))*getgenv().mod)).p
                       game.Players.LocalPlayer.Backpack:FindFirstChild(tool).Parent = game.Players.LocalPlayer.Character
                   end
               end
           
           
           
           
           wait(0.1)-- Lower the HipHeight value to make it go down.
           Connections.cannonthing = game:GetService("UserInputService").InputBegan:Connect(function(inputa,gp)
               if gp then
                   return
               end
               if inputa.UserInputType == Enum.UserInputType.MouseButton1 then
                   for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                       if v:IsA("Tool") then
                           v.Click:FireServer((v.Handle.CFrame*CFrame.new(0,0,0)).p)
                       end
                   end
                end
            end)
               
           end
        end)


        addcommand("g/p",
		"",
		function()
			if args[2] then
            local id 
            id = args[2]
            
                game.Players:Chat("gear me 00000000000000000000000000000000000000000000000000"..id)

            repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
   
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool").Name
 

            getgenv().mod = nil 

            plr.Chatted:Connect(function(m)
                m = m:split(" ")
                if m[1] == 'mod' then 
                    getgenv().mod = tonumber(m[2])
                end 
            end) 
            repeat wait() until getgenv().mod
            local args = {15}
               for i2=1,args[1] do
                   for i=1,args[1] do
                    game.Players:Chat("gear me 00000000000000000000000000000000000000000000000000"..id)
                       repeat task.wait() until game.Players.LocalPlayer.Backpack:FindFirstChild(tool)
                       game.Players.LocalPlayer.Backpack:FindFirstChild(tool).GripPos=(CFrame.Angles(0,0,math.rad(i2*(-360/args[1])))*CFrame.new(math.cos(i*(-100/args[1]))*1,0,math.sin(i*(args[1]/1))*getgenv().mod)).p + Vector3.new(0,-2,0)
                       game.Players.LocalPlayer.Backpack:FindFirstChild(tool).Parent = game.Players.LocalPlayer.Character
                   end
               end
           
           
           
           
           wait(0.1)-- Lower the HipHeight value to make it go down.
           Connections.cannonthing = game:GetService("UserInputService").InputBegan:Connect(function(inputa,gp)
               if gp then
                   return
               end
               if inputa.UserInputType == Enum.UserInputType.MouseButton1 then
                   for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                       if v:IsA("Tool") then
                           v.Click:FireServer((v.Handle.CFrame*CFrame.new(0,0,0)).p)
                       end
                   end
                end
            end)
               
           end
        end)


        sectionrmove:addButton(
            "Rmove Pads",
            function()
                for i, v in pairs(Pads:GetChildren()) do
                    if v.Head.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.Head.CFrame *
                                        CFrame.new(
                                            -1 * (v.Head.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("trip me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
            end
        )

        sectionrmove:addButton(
            "Rmove Admin Dividers",
            function()
                for i, v in pairs(ws["Admin Dividers"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("trip me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
            end
        )

        sectionrmove:addButton(
            "Rmove Regen",
            function()
                if Admin.Regen.CFrame.Y < 500 then
                    repeat
                        wait()
                    until game.Players.LocalPlayer.Character and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local looping = true
                    spawn(
                        function()
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                cf.CFrame =
                                    Admin.Regen.CFrame *
                                    CFrame.new(
                                        -1 * (Admin.Regen.Size.X / 2) -
                                            (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                        0,
                                        0
                                    )
                                if not looping then
                                    break
                                end
                            end
                        end
                    )
                    spawn(
                        function()
                            while looping do
                                wait(.1)
                                tchat("unpunish me")
                            end
                        end
                    )
                    wait(0.3)
                    looping = false
                    tchat("trip me")
                    wait(0.2)
                    tchat("respawn me")
                    wait(0.2)
                else
                    alreadymoved = true
                end
            end
        )

        

        sectionrmove:addButton(
            "Rmove Building Bricks",
            function()
                for i, v in pairs(ws["Building Bricks"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("trip me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
            end
        )

        sectionrmove:addButton(
            "Rmove House",
            function()
                for i, v in pairs(ws["Basic House"]:GetChildren()) do
                    if v.CFrame.Y < 500 then
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character and
                            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

                        local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        local looping = true

                        spawn(
                            function()
                                while true do
                                    game:GetService("RunService").Heartbeat:Wait()
                                    game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                    cf.CFrame =
                                        v.CFrame *
                                        CFrame.new(
                                            -1 * (v.Size.X / 2) -
                                                (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                            0,
                                            0
                                        )
                                    if not looping then
                                        break
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while looping do
                                    wait(.1)
                                    tchat("unpunish me")
                                end
                            end
                        )
                        wait(0.3)
                        looping = false
                        tchat("trip me")
                        wait(0.2)
                        tchat("respawn me")
                        wait(0.2)
                    else
                        alreadymoved = true
                    end
                end
            end
        )

        sectionrmove:addButton(
            "Rmove Baseplate",
            function()
                if ws.Baseplate.CFrame.Y < 500 then
                    repeat
                        wait()
                    until game.Players.LocalPlayer.Character and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local looping = true
                    spawn(
                        function()
                            while true do
                                game:GetService("RunService").Heartbeat:Wait()
                                game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                                cf.CFrame =
                                    ws.Baseplate.CFrame *
                                    CFrame.new(
                                        -1 * (ws.Baseplate.Size.X / 2) -
                                            (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                        0,
                                        0
                                    )
                                if not looping then
                                    break
                                end
                            end
                        end
                    )
                    spawn(
                        function()
                            while looping do
                                wait(.1)
                                tchat("unpunish me")
                            end
                        end
                    )
                    wait(0.3)
                    looping = false
                    tchat("trip me")
                    wait(0.2)
                    tchat("respawn me")
                    wait(0.2)
                else
                    alreadymoved = true
                end
            end
        )

        local function obbykill()
            local obbykill = ws["Obby"]:FindFirstChild("Jump")
            removeobbykill()
            repeat
                wait()
            until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

            local cf = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local looping = true

            spawn(
                function()
                    while true do
                        game:GetService("RunService").Heartbeat:Wait()
                        game.Players.LocalPlayer.Character["Humanoid"]:ChangeState(11)
                        cf.CFrame =
                            obbykill.CFrame *
                            CFrame.new(
                                -1 * (obbykill.Size.X / 2) - (game.Players.LocalPlayer.Character["Torso"].Size.X / 2),
                                0,
                                0
                            )

                        if not looping then
                            break
                        end
                    end
                end
            )
            spawn(
                function()
                    while looping do
                        wait(.1)
                        tchat("unpunish me")
                    end
                end
            )
            wait(0.3)
            looping = false
            tchat("invis me")
            while obkill do
                for i, v in pairs(getplrs) do
                    wait(.12)
                    tchat("tp me " .. v.Name)
                end
            end
        end

        plr.CharacterAdded:Connect(
            function(character)

                if obkill then
                    obkill = false
                    wait(.2)
                    tchat("respawn me")
                    wait(.3)
                    obkill = true
                    obbykill()
                end
            end
        )
        
        game.Workspace.FallenPartsDestroyHeight = -math.huge

        section5:addToggle(
            "Obby Kill",
            nil,
            function(value)
                if value == true then
                    obkill = true
                    obbykill()
                else
                    obkill = false
                    wait(.5)
                    tchat("seizure me")
                    wait(0.3)
                    tchat("respawn me")
                    wait()
                    Femware()
                end
            end
        )

        section6:addToggle(
            "Anti Gears",
            nil,
            function(value)
                if value == true then
                    error("Anti Gears Enabled")
                    chat(botname .. " Anti Gears Has Been Enabled")
                    tchat("ungear all")
                    _G.antigears = true
                    for _, v in pairs(game.Players:GetChildren()) do
                        v.Backpack.ChildAdded:Connect(
                            function(child)
                                if _G.antigears then
                                    tchat("ungear " .. v.Name)
                                    warn(v.Name .. " Equipped " .. child.Name)
                                end
                            end)
                    end
                else
                    _G.antigears = false
                    error("Anti Gears Disabled")
                    chat(botname .. " Anti Gears Has Been Disabled")
                end
            end
        )




        coroutine.wrap(
            function()
                local deb = true
                if _G.autoantivamp then
                RunService.RenderStepped:Connect(function()
                    pcall(function()
                        for _, v in pairs(game.Players:GetPlayers()) do 
                        if (v.Backpack:FindFirstChild(gr) or v.Character:FindFirstChild(gr)) and v.Name ~= plr.Name and deb then
                        tchat("respawn " .. v.Name)
                        --coroutine.wrap(function()
                            --deb = false
                        --task.wait()
                        --deb = true
                        --end )()
                        
                    end
                    end
                end)
                    
                end)
            end
            end
        )()


            for _, v in pairs(getplrs) do
            v.Chatted:Connect(function(msg)
                    if msg == "/c system" then
                        tchat("h/" .. v.Name .. " is using /c system lol")
                    end
                    if msg:sub(1, 9) == "size all " then
                        if _G.antisize then
                            tchat("setgrav all nan")
                            chat("h/" .. v.Name .. " tried to modify everyones size lol")
                        end
                    end
                    if msg:sub(1, 8) == "size me " then
                        if _G.antisize then
                            tchat("setgrav " .. v.Name .. " nan")
                            chat("h/" .. v.Name .. " tried to modify their size lol")
                        end
                    end
                end)
            end

        plrs.PlayerAdded:Connect(
            function(player)
                player.Chatted:Connect(
                    function(msg)
                        player:WaitForChild("Backpack").ChildAdded:Connect(
                            function(child)
                                if _G.antigears then
                                    tchat("ungear " .. player.Name)
                                    tchat("h/" ..player.Name .. " Equipped " .. child.Name" lol")
                                end
                                if child.Name == gr then
                                    if _G.autoantivamp and player.Name ~= plr.Name then
                                        tchat("ungear " .. player.Name)
                                        tchat("punish " .. player.Name)
                                        tchat("h/" .. player.Name .. " tried to use vamp, ungeared and punished player lol")
                                    end
                                end
                            end
                        )

                        if msg == "/c system" then
                            tchat("h/".. player.Name .. " is using /c system lol")
                        end
                        if msg:sub(1, 9) == "size all " then
                            if _G.antisize then
                                tchat("setgrav all nan")
                                tchat("h".. player.Name .. " tried to modify everyones size lol")
                            end
                        end
                        if msg:sub(1, 8) == "size me " then
                            if _G.antisize then
                                tchat("setgrav " .. player.Name .. " nan")
                                tchat("h/".. player.Name .. " tried to modify their size lol")
                            end
                        end
                    end
                )
            end
        )

        section7:addButton(
            "Furry Hammer",
            function()
                tchat("gear me 10468797")
                local hammer = plr.Backpack:WaitForChild("BanHammer V1.1", 3)
                if hammer then
                    local deb = false
                    hammer.Handle.Touched:Connect(
                        function(part)
                            local hum =
                                part.Parent:FindFirstChild("Humanoid") or part.Parent.Parent:FindFirstChild("Humanoid")
                            if hum and hum.Health ~= 0 and not deb then
                                deb = true
                                coroutine.wrap(
                                    function()
                                        task.wait(4)
                                        deb = false
                                    end
                                )()
                                local lp = plrs:GetPlayerFromCharacter(hum.Parent)
                                if lp and lp ~= plr then
                                    tchat("unhat " .. lp.Name)
                                    wait()
                                    tchat("hat " .. lp.Name .. " 5591339422")
                                    tchat("hat " .. lp.Name .. " 5891839311")
                                    tchat("hat " .. lp.Name .. " 4545294236")
                                    tchat("shirt " .. lp.Name .. " 1757993679")
                                    tchat("pants " .. lp.Name .. " 3711166798")
                                    tchat("name " .. lp.Name .. " furry")
                                    tchat("music "..zero.."8679659744")
                                    wait(.6)
                                    tchat("music")
                                else if lp.Name == 'Exprvssed' and not plr.Character:FindFirstChild("BanHammer V1.1") then
                                    jot("Using my own weapons against me?")
                                end
                            end
                            end
                        end
                    )
                end
            end
        )

        local Mouse = plr:GetMouse()
        local laser = false
        local explosive = false

        section7:addToggle(
		"Spam A/C",
		nil,
		function(value)
			if value == true then
				tablez = true
				coroutine.wrap(
					function()
						while tablez do
							wait(.5)
							tchat(
								"gear me "..zero.."119101643"
							)
						end
					end
				)()
				wait(1)

				while tablez do
					plr.Backpack:FindFirstChild("AC")
					local args = {
						[1] = "Click",
						[2] = true,
						[3] = Vector3.new(Mouse.Hit.x, Mouse.Hit.y, Mouse.Hit.z)
					}
					while wait() do
						for i, v in pairs(plr.Backpack:GetChildren()) do
							if v.Name == "AC" then
								v.Parent = plr.Character
								mouse1click()
								wait(2.2)
								plr.Character:FindFirstChild("AC"):remove()
							end
						end
					end
				end
			else
				tablez = false
				tchat("reset me")
			end
		end
	)

        section7:addToggle(
            "Spam Laser",
            nil,
            function(value)
                if value == true then
                    laser = true
                    coroutine.wrap(
                        function()
                            while laser do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."130113146"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while laser do
                        plr.Backpack:FindFirstChild("HyperlaserGun").Parent = plr.Character
                        local args = {
                            [1] = "Click",
                            [2] = true,
                            [3] = Vector3.new(Mouse.Hit.x, Mouse.Hit.y, Mouse.Hit.z)
                        }
                        spawn(
                            function()
                                workspace[plr.Name]:WaitForChild("HyperlaserGun").ServerControl:InvokeServer(
                                    unpack(args)
                                )
                            end
                        )
                        wait(.14)
                        plr.Character:FindFirstChild("HyperlaserGun"):remove()
                    end
                else
                    laser = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Rocket",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."90718505"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("ExponentialRocketLauncher").Parent = plr.Character
                        local args = {
                            [1] = CFrame.new(Mouse.Hit.x, Mouse.Hit.y, Mouse.Hit.z)
                        }
                        spawn(
                            function()
                                workspace[plr.Name].ExponentialRocketLauncher.ClickyClick:FireServer(unpack(args))
                            end
                        )
                        wait(.14)
                        plr.Character:FindFirstChild("ExponentialRocketLauncher"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Sun",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."83021250"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("TheFierySun").Parent = plr.Character
                        plr.Character:WaitForChild("TheFierySun")
                       mouse1click()
                        
                        wait(.5)
                        plr.Character:FindFirstChild("TheFierySun"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Spray Can",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                task.wait()
                                tchat(
                                    "gear me "..zero.."273795078"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("Descendants-GraffittiSprayCan").Parent = plr.Character
                        plr.Character:WaitForChild("Descendants-GraffittiSprayCan")
                       mouse1click()
                        
                        wait(.1)
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Fist",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                task.wait()
                                tchat(
                                    "gear me "..zero.."90718686"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("ConjurorsFist").Parent = plr.Character
                        plr.Character:WaitForChild("ConjurorsFist")
                       mouse1click()
                        
                        wait(.1)
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Sea Crossbow",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."236438668"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("SeaThemedCrossbow").Parent = plr.Character
                        plr.Character:WaitForChild("SeaThemedCrossbow")
                       mouse1click()
                        
                        wait(.1)
                        plr.Character:FindFirstChild("SeaThemedCrossbow"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Periastron",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."159229806"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("RainbowPeriastron").Parent = plr.Character
                        local args = {
                            [1] = Enum.KeyCode.Q
                        }
                        
                        game:GetService("Players").LocalPlayer.Character.RainbowPeriastron.Remote:FireServer(unpack(args))
                        
                        wait(.14)
                        plr.Character:FindFirstChild("RainbowPeriastron"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Ivory",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."108158379"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("IvoryPeriastron").Parent = plr.Character
                        local args = {
                            [1] = Enum.KeyCode.Q
                        }
                        
                        game:GetService("Players").LocalPlayer.Character.IvoryPeriastron.Remote:FireServer(unpack(args))                        
                        
                        wait(.14)
                        plr.Character:FindFirstChild("IvoryPeriastron"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Amethyst ",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."93136802"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("AmethystPeriastron").Parent = plr.Character
                        local args = {
                            [1] = Enum.KeyCode.E
                        }
                        
                        game:GetService("Players").LocalPlayer.Character.AmethystPeriastron.Remote:FireServer(unpack(args))                        
                        
                        wait(.14)
                        plr.Character:FindFirstChild("AmethystPeriastron"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Grimgold",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."73829193"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("GrimgoldPeriastron").Parent = plr.Character
                        local args = {
                            [1] = Enum.KeyCode.Q
                        }
                        
                        game:GetService("Players").LocalPlayer.Character.GrimgoldPeriastron.Remote:FireServer(unpack(args))                        
                        
                        wait(.14)
                        plr.Character:FindFirstChild("GrimgoldPeriastron"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        section7:addToggle(
            "Spam Crimson",
            nil,
            function(value)
                if value == true then
                    rocket = true
                    coroutine.wrap(
                        function()
                            while rocket do
                                wait(.1)
                                tchat(
                                    "gear me "..zero.."99119240"
                                )
                            end
                        end
                    )()
                    wait(1)

                    while rocket do
                        plr.Backpack:FindFirstChild("CrimsonPeriastron").Parent = plr.Character
                        local args = {
                            [1] = Enum.KeyCode.Q
                        }
                        
                        game:GetService("Players").LocalPlayer.Character.CrimsonPeriastron.Remote:FireServer(unpack(args))                        
                        
                        wait(.14)
                        plr.Character:FindFirstChild("CrimsonPeriastron"):remove()
                    end
                else
                    rocket = false
                    tchat("reset me")
                end
            end
        )

        

        section7:addButton(
            "Campfire Haven",
            function()
                local campfires = 500 -- change this to however many campfires you want

                for i = 1, campfires do
                    tchat("gear me 123234510")
                end
                wait(1)

                for i, v in pairs(plr.Backpack:GetChildren()) do
                    if v.Name == "InstantCampfire" then
                        v.Parent = plr.Character
                    end
                end
                for i = 1, campfires do
                    local args = {
                        [1] = CFrame.new(-128.666061, 3.79952192, -12.1145515, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                    }

                    spawn(
                        function()
                            workspace[plr.Name].InstantCampfire.CampfireEvent:FireServer(unpack(args))
                        end
                    )
                end
            end
        )

        section7:addButton(
            "Mine Spam",
            function()
                local Remote = 500 -- change this to however many campfires you want
                coroutine.wrap(
                    function()
                        for i = 1, Remote do
                            wait(.1)
                            tchat("gear me 33383241")
                        end
                    end
                )()

                while wait() do
                    for i, v in pairs(plr.Backpack:GetChildren()) do
                        if v.Name == "RemoteMine" then
                            v.Parent = plr.Character
                            mouse1click()
                        end
                    end
                end
            end
        )

        section7:addButton(
            "All Periastrons",
            function()
                tchat("ungear me")
                wait(.3)
                tchat("gear me 120307951")
                tchat("gear me 69499437")
                tchat("gear me 93136802")
                tchat("gear me 159229806")
                tchat("gear me 80661504")
                tchat("gear me 108158379")
                tchat("gear me 73829193")
                tchat("gear me 233520257")
                tchat("gear me 139577901")
                tchat("gear me 2544549379")
                tchat("gear me 99119240")
                wait(.8)
                for i, v in pairs(game.Players.LocalPlayer.Backpack:getChildren()) do
                    if v:IsA("Tool") then
                        v.Parent = game.Players.LocalPlayer.Character
                    end
                end
            end
        )

        section8:addButton(
            "Rainbow Map",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do task.wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(game.Workspace:GetDescendants()) do
                            if v:IsA("Part") then
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
                        end
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
				end
                end)

                section8:addButton(
            "Rainbow Parts",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do task.wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(Folder:GetChildren()) do
                            if v:IsA("Part") then
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
                        end
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
				end
                end)

        section8:addButton(
            "Rainbow Building Bricks",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do task.wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(ws["Building Bricks"]:GetChildren()) do
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
				end
                end)



        

        section8:addButton(
            "Rainbow Obby",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true and plr.Character:FindFirstChild("PaintBucket") do
					for i = 0,1,0.001*speed do wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(ws["Obby"]:GetChildren()) do
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(.1)

				end
                end)

                section8:addButton(
            "Rainbow Obby Box",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(ws["Obby Box"]:GetChildren()) do
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
				end
                end)

                section8:addButton(
            "Rainbow Admin Dividers",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(ws["Admin Dividers"]:GetChildren()) do
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
                				end
                end)

        section8:addButton(
            "Rainbow Pads",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(Pads:GetDescendants()) do
                            if v:IsA("Part") then
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
                        end
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false

				end
                end)


                spawn(function()
        section8:addButton(
            "Rainbow Regen",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = regen,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
			
				end
                end)
        
            end)
        section8:addButton(
            "Rainbow Baseplate",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = ws["Baseplate"],
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
	
				end
                end)
        
        section8:addButton(
            "Rainbow House",
            function()
                paint()
                
                wait(.6)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v.Name == "PaintBucket" then
						v.GripPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					end
				end
                _G.crail = true
				wait(.6)
				local speed = 32
				while _G.crail == true do
					for i = 0,1,0.001*speed do wait()
						local clr = Color3.fromHSV(i,1,1)
						--local padss = ws.Terrain["_Game"]:GetDescendants()
						for i, v in pairs(house:GetChildren()) do
							coroutine.wrap(function()
									local v1 =
										{
											["Part"] = v,
											["Color"] = clr
										}
									game:GetService("Players").LocalPlayer.Character.PaintBucket:WaitForChild("Remotes").ServerControls:InvokeServer("PaintPart", v1)
							end)()
						end
						wait(1 / 12) -- recolor the map x times a second lol.
					end
					task.wait(1)
					_G.crail = false
				end
                end)
        

        section8:addToggle(
            "Rainbow Building Bricks",
            nil,
            function(value)
                if value == true then
                    paint1 = true
                    paint()
                    error("Rainbow Building Bricks set to true")
                    coroutine.wrap(
                        function()
                            while paint1 do
                                wait()
                                for _, v in pairs(ws["Building Bricks"]:GetChildren()) do
                                    colour(v, math.random(), math.random(), math.random())
                                end
                            end
                        end
                    )()
                else
                    paint1 = false
                    error("Rainbow Building Bricks set to false")
                    unpaint()
                end
            end
        )

        




        section8:addToggle(
            "Rainbow Obby",
            nil,
            function(value)
                if value == true then
                    paint2 = true
                    paint()
                    error("Rainbow Obby set to true")
                    coroutine.wrap(
                        function()
                            while paint2 do
                                wait()
                                for _, v in pairs(ws["Obby"]:GetChildren()) do
                                    colour(v, math.random(), math.random(), math.random())
                                end
                            end
                        end
                    )()
                else
                    paint2 = false
                    error("Rainbow Obby set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow Obby Box",
            nil,
            function(value)
                if value == true then
                    paint3 = true
                    paint()
                    error("Rainbow Obby Box set to true")
                    coroutine.wrap(
                        function()
                            while paint3 do
                                wait()
                                for _, v in pairs(ws["Obby Box"]:GetChildren()) do
                                    colour(v, math.random(), math.random(), math.random())
                                end
                            end
                        end
                    )()
                else
                    paint3 = false
                    error("Rainbow Obby Box set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow Admin Dividers",
            nil,
            function(value)
                if value == true then
                    paint4 = true
                    paint()
                    error("Rainbow Admin Dividers set to true")
                    coroutine.wrap(
                        function()
                            while paint4 do
                                wait()
                                for _, v in pairs(ws["Admin Dividers"]:GetChildren()) do
                                    colour(v, math.random(), math.random(), math.random())
                                end
                            end
                        end
                    )()
                else
                    paint4 = false
                    error("Rainbow Admin Dividers set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow Pads",
            nil,
            function(value)
                if value == true then
                    paint5 = true
                    paint()
                    error("Rainbow Pads set to true")
                    coroutine.wrap(
                        function()
                            while paint5 do
                                wait()
                                for _, v in pairs(Pads:GetChildren()) do
                                    colour(v.Head, math.random(), math.random(), math.random())
                                end
                            end
                        end
                    )()
                else
                    paint5 = false
                    error("Rainbow Pads set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow Regen",
            nil,
            function(value)
                if value == true then
                    paint6 = true
                    paint()
                    error("Rainbow Regen set to true")
                    coroutine.wrap(
                        function()
                            while paint6 do
                                wait()
                                colour(Admin.Regen, math.random(), math.random(), math.random())
                            end
                        end
                    )()
                else
                    paint6 = false
                    error("Rainbow Regen set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow Baseplate",
            nil,
            function(value)
                if value == true then
                    paint7 = true
                    paint()
                    error("Rainbow Baseplate set to true")
                    coroutine.wrap(
                        function()
                            while paint7 do
                                wait()
                                colour(ws.baseplate, math.random(), math.random(), math.random())
                            end
                        end
                    )()
                else
                    paint7 = false
                    error("Rainbow Baseplate set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow House",
            nil,
            function(value)
                if value == true then
                    paint8 = true
                    paint()
                    error("Rainbow House set to true")
                    coroutine.wrap(
                        function()
                            while paint8 do
                                wait()
                                for i, v in pairs(house:GetChildren()) do
                                    colour(v, math.random(), math.random(), math.random())
                                end
                            end
                        end
                    )()
                else
                    paint8 = false
                    error("Rainbow House set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow Map",
            nil,
            function(value)
                if value == true then
                    paint9 = true
                    paint()
                    error("Rainbow Map set to true")
                    coroutine.wrap(
                        function()
                            while paint9 do
                                wait()
                                for i, v in pairs(game.Workspace.Terrain["_Game"]:GetDescendants()) do
                                    if v:IsA("Part") then
                                        colour(v, math.random(), math.random(), math.random())
                                    end
                                end
                            end
                        end
                    )()
                else
                    paint9 = false
                    error("Rainbow Map set to false")
                    unpaint()
                end
            end
        )

        section8:addButton(
            "Colour Map Black",
            function()
                paint()
                error("Map Colour set to black")
                black()
            end
        )

        section8:addButton(
            "Colour Map White",
            function()
                paint()
                error("Map Colour set to white")
                white()
            end
        )

        section8:addButton(
            "Colour Map Red",
            function()
                paint()
                error("Map Colour set to red")
                red()
            end
        )

        section8:addButton(
            "Colour Map Blue",
            function()
                paint()
                error("Map colour set to blue")
                blue()
            end
        )

        section8:addButton(
            "Colour Map Green",
            function()
                paint()
                error("Map colour set to green")
                green()
            end
        )

        section8:addButton(
            "Colour Map Orange",
            function()
                paint()
                error("Map colour set to orange")
                orange()
            end
        )

        section8:addButton(
            "Colour Map Yellow",
            function()
                paint()
                error("Map colour set to yellow")
                yellow()
            end
        )

        section8:addButton(
            "Colour Map Purple",
            function()
                paint()
                error("map colour set to purple")
                purple()
            end
        )

        section8:addButton(
            "Colour Map Pink",
            function()
                paint()
                error("map colour set to pink")
                pink()
            end
        )

        section8:addButton(
            "Colour Map Brown",
            function()
                paint()
                error("map colour set to brown")
                brown()
            end
        )

        section8:addToggle(
            "Spam Color Map",
            nil,
            function(value)
                if value == true then
                    error("Spam Colouring Map")
                    paint10 = true
                    paint()
                    coroutine.wrap(
                        function()
                            while wait(.2) do
                                black()
                                wait(.2)
                                white()
                                wait(.2)
                                red()
                                wait(.2)
                                orange()
                                wait(.2)
                                blue()
                                wait(.2)
                                pink()
                                wait(.2)
                                yellow()
                                wait(.2)
                                purple()
                                wait(.2)
                                brown()
                            end
                        end
                    )()
                else
                    paint10 = false
                    unpaint()
                    error("Map Colour Spam Disabled")
                end
            end
        )

        section8:addToggle(
            "Spam Rainbow Parts",
            nil,
            function(value)
                if value == true then
                    error("Rainbow")
                    paint11 = true
                    paint()
                    coroutine.wrap(
                        function()
                            if not Folder:FindFirstChild("Part") then
                                error("Part does not exist")
                            else
                                error("Rainbow Parts set to true")
                                while paint11 do
                                    wait()
                                    for i, v in pairs(Folder:GetChildren()) do
                                        if v:IsA("Part") then
                                            colour(v, math.random(), math.random(), math.random())
                                        end
                                    end
                                end
                            end
                        end
                    )()
                else
                    paint11 = false
                    error("Rainbow Parts set to false")
                    unpaint()
                end
            end
        )

        section8:addToggle(
            "Rainbow Players",
            nil,
            function(value)
                if value == true then
                    paint12 = true
                    paint()
                    error("Rainbow Players set to true")
                    coroutine.wrap(
                        function()
                            while paint12 do
                                wait()
                                for i, v in pairs(getplrs) do
                                    for _, p in pairs(v.Character:GetChildren()) do
                                        if p:IsA("Part") then
                                            colour(p, math.random(), math.random(), math.random())
                                        end
                                    end
                                end
                            end
                        end
                    )()
                else
                    paint12 = false
                    error("Rainbow Players set to false")
                    unpaint()
                end
            end
        )

        section9:addButton(
            "Clear Console",
            function()
                rconsoleclear()
                error(Femware)
            end
        )

        section9:addButton(
            "Text Color Red",
            function()
                red = false
                blue = false
                green = false
                cyan = false
                black = false
                magenta = false
                brown = false
                light_gray = false
                dark_gray = false
                light_blue = false
                light_green = false
                light_cyan = false
                light_red = false
                light_magenta = false
                yellow = false
                white = false
                wait()
                red = true
                coroutine.wrap(
                    function()
                        while red do
                            wait()
                            color("RED")
                        end
                    end
                )()
            end
        )

        section9:addButton(
            "Text Color Blue",
            function()
                red = false
                blue = false
                green = false
                cyan = false
                black = false
                magenta = false
                brown = false
                light_gray = false
                dark_gray = false
                light_blue = false
                light_green = false
                light_cyan = false
                light_red = false
                light_magenta = false
                yellow = false
                white = false
                wait()
                blue = true
                coroutine.wrap(
                    function()
                        while blue do
                            wait()
                            color("BLUE")
                        end
                    end
                )()
            end
        )

        addcommand("?unhook",
		"toggles anti kick",
		function()
            hookmusic = false
            _G.pol:Disconnect()
            _G.mku:Disconnect()
        end)
        

        addcommand("?hook",
		"toggles anti kick",
		function()

            if not Folder:FindFirstChild("Sound") then
                error("No sounds are playing")
            else
                hookmusic = true
                error("Music Id Has been Hooked, Only your id will be played")
                local id = Folder:FindFirstChild("Sound").SoundId
                error("Sound Id: "..id)
                _G.pol = Folder.ChildRemoved:Connect(function(c)
                    if c.Name == 'Sound' and c.SoundId == id and hookmusic then 
                        if _G.mku then 
                            _G.mku:Disconnect()
                        end
                        str = tostring(id):split("=")
                        tchat("music 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"..str[2])
                        if str[2] == '6953866301' then 
                            task.wait(.4)
                            tchat("skip 10")
                        end 
                        _G.mku = Folder:WaitForChild("Sound"):GetPropertyChangedSignal("Playing"):Connect(
                    function()
                        tchat("resume")
                    end
                )
                    end 
                end)
                
            end
        end)

        section10:addToggle(
            "Hook Music Id",
            nil,
            function(value)
                if value then
                    if not Folder:FindFirstChild("Sound") then
                        error("No sounds are playing")
                    else
                        hookmusic = true
                        error("Music Id Has been Hooked, Only your id will be played")
                        id = Folder:FindFirstChild("Sound").SoundId
                        error("Sound Id: "..id)
                        Folder.ChildRemoved:Connect(function(c)
                            if c.Name == 'Sound' then 
                                str = tostring(id):split("=")
                                tchat("music "..str[2])
                            end 
                        end)
                        Folder:WaitForChild("Sound"):GetPropertyChangedSignal("SoundId"):Connect(
                            function()
                                str = tostring(id):split("=")
                                tchat("music "..str[2])
                                if str[2] == '6953866301' then 
                                    tchat("skip 6")
                                end 
                            end
                        )
                    end
                else
                    hookmusic = false
                    error("Unhooked Music Id, other songs shall be played now")
                end
            end
        )

        section10:addButton(
            "Copy Music Id",
            function()
                if not Folder:FindFirstChild("Sound") then
                    error("No sounds are playing")
                else
                    copied_id = tostring(Folder:FindFirstChild("Sound").SoundId):split("=")
                    copied_id = copied_id[2]
                    warn("Successfully copied Id: " .. copied_id .. ", id has been set to clipboard")
                    setclipboard(copied_id)
                end
            end
        )

        section10:addButton(
            "Shuffle Random Id",
            function()
                error("Selecting Random Id...")
                wait(.4)
                id = tostring(_G.musicids[math.random(1, #_G.musicids)])
                tchat("music " .. zero .. id)
                error("Playing Id: " .. id)
            end
        )

        section10:addButton(
            "Copy Vis",
            function()
                local vis = game.Lighting
                warn("Copied Lighting Settings!")
                error("FogColor: " .. tostring(vis.FogColor))
                error("ColorShiftBottom: " .. tostring(vis.ColorShift_Bottom))
                error("ColorShiftTop: " .. tostring(vis.ColorShift_Top))
            end
        )

        section10:addButton(
            "Random FogColor",
            function()
                tchat("fogend 100")
                fogcolor = math.random(1, 1000) .. " " .. math.random(1, 1000) .. " " .. math.random(1, 1000)
                colorshifttop = math.random(1, 1000) .. " " .. math.random(1, 1000) .. " " .. math.random(1, 1000)
                colorshiftbottom = math.random(1, 1000) .. " " .. math.random(1, 1000) .. " " .. math.random(1, 1000)
                tchat("fogcolor " .. fogcolor)
                warn("fogcolor set to " .. fogcolor)

                tchat("colorshifttop " .. colorshifttop)
                warn("colorshifttop set to " .. colorshifttop)

                tchat("colorshiftbottom " .. colorshiftbottom)
                warn("colorshiftbottom set to " .. colorshiftbottom)
            end
        )

        section10:addButton(
            "Enable Vis",
            function()
                if not Folder:FindFirstChild("Sound") then
                    error("Play music first ya retard")
                else
                    
                    _G.vison = RunService.Stepped:Connect(function()

                        loudness = Game.Workspace.Terrain._Game.Folder:WaitForChild("Sound").PlaybackLoudness
                        fog = loudness / 4
                        basefog = 250
                        fogend = basefog - fog
                        tchat("fogend " .. fogend)
                    end)

                end
            end
        )

        section10:addButton(
            "Disable Vis",
            function()
                if _G.hype then 
                    _G.hype = false
                end
                _G.vison:Disconnect()
                if _G.vison2 then 
                    _G.vison2:Disconnect()
                end
                wait(.3)
                tchat("fix")
                tchat("?unhook")
            end
        )

        section10:addToggle(
            "Fog Disco",
            nil,
            function(v)
                if v then
                    disco = true
                    warn("Enabled Fog Disco")
                    tchat("fogend 100")
                    while disco do
                        wait(.00001)
                        tchat(
                            "fogcolor " ..
                                math.random(1, 999) .. " " .. math.random(1, 999) .. " " .. math.random(1, 999)
                        )
                        tchat(
                            "colorshifttop " ..
                                math.random(1, 999) .. " " .. math.random(1, 999) .. " " .. math.random(1, 999)
                        )
                        tchat(
                            "colorshiftbottom " ..
                                math.random(1, 999) .. " " .. math.random(1, 999) .. " " .. math.random(1, 999)
                        )
                    end
                else
                    disco = false
                end
            end
        )

        section11:addButton(
            "Sunset",
            function()
                tchat("fix")
                wait()
                tchat("time 6.20")
                tchat("colorshifttop 600 400 0")
                tchat("colorshiftbottom 600 400 0")
            end
        )

        section11:addButton(
            "Sunset2",
            function()
                tchat("fix")
                wait()
                tchat("time 17")
                tchat("colorshifttop 600 400 0")
                tchat("colorshiftbottom 600 400 0")
            end
        )

        section11:addButton(
            "Day Cycle",
            function()
                tchat("fix")
                for i = 1, 100 do
                    wait()
                    tchat("time " .. i)
                end
            end
        )

        section11:addButton(
            "Sinister Fog",
            function()
                tchat("fix")
                wait()
                tchat("time 0")
                tchat("fogend 25")
                tchat("fogcolor 0 0 0")
                tchat("outdoorambient 255 0 0")
            end
        )

        section11:addButton(
            "Pitch Black",
            function()
                tchat("fix")
                wait()
                tchat("time 0")
                tchat("colorshifttop 100000000 1000000000 10000000000000")
                tchat("colorshiftbottom 100000000 1000000000 10000000000000")
            end
        )

        section11:addButton(
            "Hide And Seek",
            function()
                tchat("fix")
                wait()
                tchat("time 0")
                tchat("fogcolor 0 0 0")
                tchat("fogend 25")
                tchat("fogstart 25")
            end
        )

        section12:addButton(
            "Lofi Visualiser",
            function()
                error("Playing Megalovania")
                tchat("fogcolor 60 300 703")
                tchat("music 9047105108")
                tchat("fogend 300")
                tchat("time 1")
                vis = true
            end
        )

        section12:addButton(
            "Dead Weight Visualiser",
            function()
                error("Playing Dead Weight Visualiser")
                tchat("fogcolor 127 0 255")
                tchat("music 4657857001")
                tchat("fogend 100")
                tchat("time 1")
                vis = true
            end
        )

        section12:addButton(
            "Yarichin Visualiser",
            function()
                error("Playing Yarichin Visualiser")
                tchat("fogcolor 127 0 255")
                tchat("music 6368104715")
                tchat("fogend 100")
                tchat("time 1")
                vis = true
            end
        )

        section12:addButton(
            "Everything Black Visualiser",
            function()
                error("Playing Everything Black Visualiser")
                tchat("time 1")
                tchat("fogend 200")
                tchat("fogcolor 1 1 1")
                tchat("colorshiftbottom 1 1 1")
                tchat("colorshifttop 1 1 1")
                tchat("music 00000000000000000000000000000000000000000001317469859")
                vis = true
            end
        )

        section12:addButton(
            "Hype Visualiser",
            function()
                _G.hype = true
                error("Playing Hype Visualiser")
                tchat("music "..zero.."6913550990")
                tchat("time -4")
                tchat("fogcolor -400 -0 -400")
                tchat("fogend 100")
                tchat("outdoorambient 400 0 400")
                tchat("colorshifttop 400 0 400")
                tchat("fogstart 1000000000000000")
                tchat("colorshiftbottom 400 0 400")
                wait(.5)
                tchat("?hook")
            end
        )

        section12:addButton(
            "Buttercup Visualiser",
            function()
                error("Playing Buttercup Visualiser")
                tchat("music 0000000000000000000000000000002325704183")
                tchat("time -4")
                tchat("fogcolor -400 -0 -400")
                tchat("fogend 400")
                tchat("outdoorambient 400 0 400")
                tchat("colorshifttop 400 0 400")
                tchat("colorshiftbottom 400 0 400")
                vis = true
            end
        )
        _G.runcmds = nil
        plr.Chatted:Connect(function(msg)
            if msg == "run/" then 
                _G.runcmds = true
            end
        end)

        plr.Chatted:Connect(function(msg)
            if msg == "c/" then 
                _G.runcmds = false

            end
        end)

        plr.Chatted:Connect(function(msg)
            if _G.runcmds then 
                loadstring(msg)()
            end
        end)


        section12:addButton(
            "Play Date Visualiser",
            function()
                error("Playing Play Date Visualiser")
                tchat("music 6823597327")
                wait(.2)
                tchat("fogcolor 100 200 400")
                tchat("colorshifttop 600 10 600")
                tchat("fogend 400")
                vis = true
            end
        )

        section12:addButton(
            "Umbrella Visualiser",
            function()
                error("Playing Umbrella Visualiser")
                tchat(
                    "music 00000000000000000000000000000000000000000000000000000000000000000000000000001841647093"
                )
                tchat("fogcolor 10 200 400")
                tchat("colorshifttop 400 0 600")
                tchat("fogend 400")
                vis = true
            end
        )

        -- second page
        local theme = venyx:addPage("Theme", 5012544693)
        local colors = theme:addSection("Colors")

        for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
            colors:addColorPicker(
                theme,
                color,
                function(color3)
                    venyx:setTheme(theme, color3)
                end
            )
        end

        RunService.RenderStepped:Connect(function() 
        for _, v in pairs(game.Workspace:GetDescendants()) do 
            if v.Name == 'Rocket' and v.Parent.Name ~= 'Server' and v.Parent.Name ~= 'Explosion' then 
                v.CanCollide = false 
                v.Name = 'ROcketANTIlolz'
            end 
        end 
    end)


        game.Players.LocalPlayer.Chatted:Connect(
            function(msg)
                if msg == "load/1" then
                    tchat("face me 255827175")
                    tchat("unhat me")
                    tchat("unshirt me")
                    wait(.5)
                    tchat("hat me 7285007069")
                    tchat("hat me 6683948892")
                    tchat("hat me 4375946079")
                    tchat("hat me 4472201333")
                    tchat("name me The Black Swordsman")
                    tchat("shirt me 7286102858")
                    tchat("pants me 7286165918")
                    tchat("hat me 6777876655")
                    tchat("hat me 4602495526")
                    tchat("music 1117427131")
                    wait(.4)
                end
                if msg == "load/2" then
                    tchat("face me 21311601")
                    wait(.4)
                    tchat("unhat me")
                    wait(.2)
                    tchat("name me Guts")
                    wait()
                    tchat("shirt me 6840717420")
                    wait()
                    tchat("pants me 6840719233")
                    wait()
                    tchat("hat me 6777876655")
                    wait()
                    tchat("hat me 7335591152")
                    wait()
                    tchat("music 2809513162")
                    wait()
                    tchat("hat me 6594948658")
                    wait()
                    tchat("hat me 4820288389")
                end
                if msg == "load/3" then
                    tchat("unhat me")
                    wait(.5)
                    tchat("name me Berserker")
                    wait()
                    tchat("shirt me 7691872685")
                    wait()
                    tchat("pants me 7691875360")
                    wait()
                    tchat("hat me 4684072652")
                    wait()
                    tchat("hat me 7285007069")
                    wait()
                    tchat("music 665017009")
                    wait()
                    tchat("hat me 7438746960")
                end
                if msg == "load/4" then
                    tchat("unhat me")
                    wait(.5)
                    tchat("name me The White Hawk")
                    wait()
                    tchat("shirt me 2504977469")
                    wait()
                    tchat("pants me 2504977617")
                    wait()
                    tchat("hat me 1320947582")
                    wait()
                    tchat("hat me 4603629636")
                    wait()
                    tchat("hat me 4603630740")
                    wait()
                    tchat("hat me 4602492814")
                    wait()
                    tchat("hat me 5064670525")
                    wait()
                    tchat("hat me 4750976169")
                    wait()
                    tchat("hat me 4603629636")
                    wait()
                    tchat("hat me 1320947582")
                    wait()
                    tchat("hat me 4603629636")
                    wait()
                    tchat("music 1117428072")
                    wait()
                    tchat("hat me 6594948658")
                end
		if msg == "!jesus" then
	       tchat("char me 3372184799")
		end
		if msg == "globalrtx" then
 		tchat("brightness 2")
		wait()
        	tchat("time 14")
        	tchat("ambient 127 127 127")
		wait()
        	tchat("outdoorambient 127 127 127")
		wait()
       	 	tchat("colorshiftbottom 255 150 100")
		wait()
       		tchat("colorshifttop 255 255 255")
		end

		if msg == "/batman" then
		tchat("char me 34156111")
		wait()
		tchat("hat me 16034683797")
		wait()
		tchat("pants me 689429239")
		wait()
		tchat("shirt me 11893142791")
		wait()
		tchat("name me Batman")
		wait()
		tchat("music 130773257")
		wait(1.7)
		tchat("music ")
		end

		if msg == "bye!" then
		tchat("/e wave")
		tchat(".synthesize seeyuh")
		wait(2)
		game.Players.LocalPlayer:Kick("Aren't you a cool guy lol")
		end

            end
        )

        plr.CharacterAdded:Connect(
            function(character)
                if hide then
                    character:Destroy()
                end
                if rs:FindFirstChild("spawnpoint") then
                    character:WaitForChild("HumanoidRootPart").CFrame = rs:FindFirstChild("spawnpoint").CFrame
                end
                if obkill then
                    obkill = false
                    wait(.2)
                    tchat("respawn me")
                    wait(.3)
                    obkill = true
                    obbykill()
                end
                if god then
                    tchat("god me")
                    character:WaitForChild("Humanoid"):GetPropertyChangedSignal("Health"):Connect(
                        function()
                            if god then
                                if character.Humanoid.Health < math.huge then
                                    tchat("god me")
                                end
                            end
                        end
                    )
                end

                if ff then
                    tchat("ff me")
                    plr.Character.ChildRemoved:Connect(
                        function(child)
                            if ff then
                                if child.Name == "ForceField" then
                                    tchat("ff me")
                                end
                            end
                        end
                    )
                end
                    character.ChildAdded:Connect(
                        function(v)
                            if _G.antifreeze then
                                if v.Name == "ice" then
                                    tchat("thaw me")
                                    task.wait(time)
                                end
                            end
                        end
                    )
            end
        )


        unlog = [[
	 n\n\n\n\n\n\n\n\n\n\n\n\n\n
        n̷o̷ ̸l̶o̶g̵s̴ ̷h̶e̷r̴e̸ ̵m̸a̴t̸e̶
        n\n\n\n\n\n\n\n\n\n\n\n\n\n

        ]]

   for _, v in pairs(game.Players:GetPlayers()) do 
    if v.Name == 'emriyaI' and _G.bullyaria then 
        repeat task.wait() until v.Character
        tchat("music 1839334310")
        wait(.4)

        
        tchat("tp emriyaI me")
        tchat("breakcam em")
        
        v.CharacterAdded:Connect(function(c)
            if _G.bullyaria then
            local name = names[math.random(1,#names)]
            if name == 'velincy' then
                game.Players:Chat("name emriyaI "..name)
                wait(1)
            game.Players:Chat("h/Hello there, velincy")
            wait(1)
            game.Players:Chat("explode emriyaI")
            else
            game.Players:Chat("h/Hello there, "..name)
            game.Players:Chat("name emriyaI "..name)
            end
            c.ChildRemoved:Connect(function(a)
                if a.Name == name then 
                    game.Players:Chat("name emriyaI "..name)
                end 
            end)
        end
        end)
        wait(1)
        tchat("reset emriyaI")

    end
end

addcommand(".spamlogs","", function()
    for i = 1, 105 do
        tchat("ff "..unlog)
    end
end)

addcommand("ping", -- dont like the name "punish2"
"desc",
function()

        chat("Ping is "..tostring(plr:GetNetworkPing()*1000):split(".")[1].." ms")
end)

addcommand("hh", -- dont like the name "punish2"
"desc",
function()

    plr.Character.Humanoid.HipHeight = tonumber(args[2])
end)

addcommand("attach", -- dont like the name "punish2"
"desc",
function()
    for _Index, Target in pairs(GetPlayer(args[2])) do
        local target = Target.Character.HumanoidRootPart

            local cf = game.Players.LocalPlayer.Character.HumanoidRootPart
            local looping = true
            spawn(function()
                while true do
                    game:GetService("RunService").Heartbeat:Wait()
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                    cf.CFrame = target.CFrame * CFrame.new(-1 * (target.Size.X / 2) - (game.Players.LocalPlayer.Character.Torso.Size.X / 2), 0, 0)
                    if not looping then
                        break
                    end
                end
            end)
            spawn(function()
                while looping do
                    wait(0.1)
                    game.Players:Chat("unpunish me")
                end
            end)
            wait(0.25)
            looping = false
            tchat("invis me")
        end 
    end)

     -- credits to ii's admin
    function checkIsCrashed()
        local Ping1 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
            task.wait(1)
            local Ping2 = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        
            if Ping1 == Ping2 then 
                return true 
            else 
                return false
             end
    end

    local askagain = true 
coroutine.wrap(function()
    while task.wait(.1) do 
        
          if checkIsCrashed() == true and askagain then 
                 print("[*] Possible server crash detected, would you like to hop servers? Y/N")
                 f = rconsoleinput()
                 if f:lower() == 'n' then 
                    spawn(function()
                        askagain = false 
                        task.wait(30)
                        askagain = true 
                        print("[*] Remaining in Server: "..JobId)
                    end) 
                else if f:lower() == 'y' then 
                    _G.teleport()
                end 
            end 
        end 
    end 
end)()
                 

addcommand("purge", -- dont like the name "punish2"
"desc",
function()
    for _Index, Target in pairs(GetPlayer(args[2])) do
        local plr = game.Players.LocalPlayer -- already a set variable in my script but for tech
        local pos
        pos = plr.Character.HumanoidRootPart.CFrame

        getgenv().slockplr = nil -- A new little thing i added, this makes it so that it punishes on rejoin

        tchat("respawn "..Target.Name)
        tchat("fly me")
        Target.CharacterAdded:Wait()
        tchat("speed "..Target.Name.." 0")
        tchat("invis me")
        plr.Character.HumanoidRootPart.CFrame = Target.Character:WaitForChild("HumanoidRootPart").CFrame + Vector3.new(0, 4, 10)
        
            tchat("gear me 139578207")



                local tool = plr.Backpack:WaitForChild("TriLaserGun") 
                tool.Parent = plr.Character

                local Mouse = game.Players.LocalPlayer:GetMouse() -- ???? lol?

                for i = 1, 3 do
                args = {
                    [1] = Target.Character.HumanoidRootPart.Position --[[Vector3]]
                }
                
                tool.Click:FireServer(unpack(args))
                task.wait() -- firing all at once is pointless, best to rapid fire one gun
               end
                tool:remove()

            


    

spawn(function()
    task.wait(.1)
                for i = 1, 4 do -- looped just to make sure yk
                        
                    tchat(":punish "..Target.Name)
                    task.wait(.1)    
                end
            end)
            task.wait(.1)
            plr.Character.HumanoidRootPart.CFrame = pos 
                task.wait(.1)
                    
                    tchat("reset me")
                    

                      err = Target.CharacterAdded:Connect(function()
                        error("Perm Punish Unsuccessful, reattemting..") -- this logs to my console though you may wanna change it to whatever suits you
                        task.wait()
                        tchat("purge "..Target.Name)
                        err:Disconnect()
                      end)

                      if getgenv().slockplr then 
                        sl = game.Players.PlayerAdded:Connect(function(p)
                            if p.Name == Target.Name then 
                                tchat("purge "..Target.Name)
                                sl:Disconnect()
                            end 
                        end)
                    end
                                
                     




    end
end)


addcommand("unpurge", 
"desc",
function()
    getgenv().err:Disconnect()
    tchat("respawn others")
end)   

addcommand("delchars", 
"desc",
function()

        local plr = game.Players.LocalPlayer -- already a set variable in my script but for tech
        local plrs = {}
        for _, v in pairs(getplrs) do 
            if v.Name ~= plr.Name then 
        table.insert(plrs, v)
            end
        end
     

        tchat("respawn all")
        plr.CharacterAdded:Wait()
        tchat("speed others 0")
        tchat("fly me")
        tchat("invis me")
        plr.Character:WaitForChild("HumanoidRootPart").CFrame = plr.Character:WaitForChild("HumanoidRootPart").CFrame + Vector3.new(0, 4, 10)
        for i = 1, #getplrs-1 do
            tchat("gear me 139578207")
        end

task.wait(.4)
for i, v in pairs(plr.Backpack:GetChildren()) do 
    pcall(function()
task.wait(.2)
                v.Parent = plr.Character

                args = {
                    [1] = plrs[i].Character:WaitForChild("HumanoidRootPart").Position --[[Vector3]]
                }
                
                v.Click:FireServer(unpack(args))
            end)
                task.wait(.1) -- firing all at once is pointless, best to rapid fire one gun
                v:remove()
        end

        tchat("reset me")

            


    
task.wait(.3)
spawn(function()
    task.wait(.1)
    for i = 1, 4 do -- looped just to make sure yk
                        
        tchat(":punish others")
        task.wait(.1)    
     end
end)

                    
                for _, v in pairs(getplrs) do 
                    if v ~= plr then 
                      getgenv().err = v.CharacterAdded:Connect(function()
                          tchat("purge "..v.Name)
                          getgenv().err:Disconnect()

                      end)
                    end 
                end
                                
                     


end)





plr.Chatted:Connect(function(msg)
    if msg == 'silc' then 
        task.wait()
            for i = 1, 15 do
                game.Players:Chat("gear me 94794847")
                task.wait(0.05)
            end

            game.Players:Chat("usetools")
            task.wait(0.3)
            game.Players:Chat("explode all")
        end
    end)




coroutine.wrap(function()
    local PlayerInstance;
    local fenv = getfenv()
    
    local sethiidenprop = fenv.sethiddenproperty or sethiddenproperty or fenv.set_hidden_property or fenv.set_hidden_prop or fenv.sethiddenprop
    local ssr = fenv.setsimulationradius or setsimulationradius or fenv.set_simulation_radius or fenv.set_sim_radius or fenv.setsimradius or fenv.setsimrad or fenv.set_sim_rad
    end)
    
    
    -- Configure network services
    settings().Physics.AllowSleep = false -- Keep the current physics system from sleeping. (Non-moving parts lose ownership.)
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled -- Keep the physics from throttling.
    
    
    
    
    -- Start network runtime
    RunService.RenderStepped:Connect(function()
        
        pcall(function()
            -- Claim ownership for me
            plr.MaximumSimulationRadius = math.huge
            ssr(999.999,999.999)
            sethiddenprop(plr,"MaximumSimulationRadius",math.huge)
            sethiddenprop(plr, "SimulationRadius", math.huge)
            ssr(999.999,999.999)
        end)
            for i,v in next, plr.Character:GetDescendants() do
        
                if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
                v.Velocity = Vector3.new(-30,0,0)
                end
                end
        
        end)
        -- Revoke ownership from others
        
    







local isTimeCycleActive = false
local timeCycleCoroutine

local function tchat(message)
    game.Players:Chat(message)  -- Send chat message
end

local function simulate24HourCycle()
    local totalHours = 24
    local incrementMinutes = 3
    local waitTime = 1.5  -- Time to wait between each chat message in seconds

    while isTimeCycleActive do
        for hour = 0, totalHours - 1 do
            for minute = 0, 59, incrementMinutes do
                if not isTimeCycleActive then
                    return
                end
                -- Format the time
                local formattedTime = string.format("%02d:%02d:00", hour, minute)
                -- Send the chat message
                tchat("time " .. formattedTime)
                -- Wait for the specified time before sending the next message
                wait(waitTime)
            end
        end
    end
end

local function onChatMessage(player, message)
    if message == "timecycle" then
        if not isTimeCycleActive then
            isTimeCycleActive = true
            timeCycleCoroutine = coroutine.create(simulate24HourCycle)
            coroutine.resume(timeCycleCoroutine)
        end
    elseif message == "notimecycle" then
        isTimeCycleActive = false
        if timeCycleCoroutine then
            coroutine.close(timeCycleCoroutine)
        end
    end
end

-- Connect the chat function to the player's chat messages
game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onChatMessage(player, message)
    end)
end)

-- For existing players in the game
for _, player in pairs(game.Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        onChatMessage(player, message)
    end)
end

















--[[local function simulate24HourCycle()
    local totalCycleTime = 5 * 60  -- Total time for the cycle in seconds (5 minutes)
    local iterations = 24 * 60  -- Total number of iterations for the cycle (24 hours)
    local timeIncrement = totalCycleTime / iterations  -- Calculate the time increment for each iteration
    local chatFrequency = math.floor(iterations / totalCycleTime)  -- Calculate the chat frequency

    for hour = 0, 23 do
        for minute = 0, 59 do
            -- Format the time
            local formattedTime = string.format("%02d:%02d:00", hour, minute)
            print("Current time:", formattedTime)
		wait(4)
 		

            -- Send chat message
            if (hour * 60 + minute) % chatFrequency == 0 then
                 game.Players:chat("time " .. formattedTime)
            end

            wait(timeIncrement)  -- Wait for the time increment
        end
    end

    print("Simulation complete.")
end

simulate24HourCycle()]]

            
            
        
local starttime2 = os.clock()
local diff_seconds = starttime2 - starttime1
local formatted_time = string.format("%.1f", diff_seconds)
tchat("h/hello there \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" .. botname .. " Loadtime: " .. formatted_time .. " seconds")


        end -- For the game-id check




    
    

    
