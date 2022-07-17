local QBCore = exports['qb-core']:GetCoreObject()

local InMenu = false

local function DiscordLog(message)
    local embed = {
        {
            ["color"] = 04255, 
            ["title"] = "CloudDevelopment Police Garage",
            ["description"] = message,
            ["url"] = "https://discord.gg/e4AYS3VE",
            ["footer"] = {
            ["text"] = "By CloudDevelopment",
            ["icon_url"] = Config.LogsImage
        },
            ["thumbnail"] = {
                ["url"] = Config.LogsImage,
            },
    }
}
    PerformHttpRequest(Config.WebHook, function(err, text, headers) end, 'POST', json.encode({username = 'CL-PoliceGarage', embeds = embed, avatar_url = Config.LogsImage}), { ['Content-Type'] = 'application/json' })
end

QBCore.Functions.CreateCallback('CL-PoliceGarage:CheckIfActive', function(source, cb)
    local src = source

    if not InMenu then
        TriggerEvent("CL-PoliceGarage:server:SetActive", true)
        cb(true)
    else
        cb(false)
        TriggerClientEvent("QBCore:Notify", src, "Someone Is In The Menu Please Wait !", "error")
    end
end)

RegisterNetEvent('CL-PoliceGarage:server:SetActive', function(status)
    if status ~= nil then
        InMenu = status
        TriggerClientEvent('CL-PoliceGarage:client:SetActive', -1, InMenu)
    else
        TriggerClientEvent('CL-PoliceGarage:client:SetActive', -1, InMenu)
    end
end)

RegisterServerEvent("CL-PoliceGarage:AddVehicleSQL", function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.license,
        Player.PlayerData.citizenid,
        vehicle,
        hash,
        json.encode(mods),
        plate,
        0
    })
end)

RegisterServerEvent('CL-PoliceGarage:TakeMoney', function(paymenttype, price, vehiclename, vehicle)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local Steamname = GetPlayerName(src)
    if Player.Functions.GetMoney(paymenttype) >= price then
        TriggerClientEvent("CL-PoliceGarage:SpawnVehicle", src, vehicle)  
        Player.Functions.RemoveMoney(paymenttype, price)
        TriggerClientEvent('QBCore:Notify', src, 'Vehicle Successfully Bought', "success")    
        DiscordLog('New Vehicle Bought By: **'..Steamname..'** ID: **' ..source.. '** Bought: **' ..vehiclename.. '** For: **' ..price.. '$**') 
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end    
end)

QBCore.Commands.Add('prepair', 'Repair Your Police Vehicle (Can Be Used Only In The Police Station)', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == 'police' then
        TriggerClientEvent("CL-PoliceGarage:CheckZone", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You are not a police officer.', "error")              
    end
end)