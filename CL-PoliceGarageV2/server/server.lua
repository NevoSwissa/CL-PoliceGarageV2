local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("CL-PoliceGarageV2:AddData", function(type, vehicle, hash, plate, job)
    local src = source
    if Config.BanWhenExploit and not Player.PlayerData.job.name == job then ExploitBan(src, 'Banned for exploiting') end
    if type == "vehiclepurchased" then
        local Player = QBCore.Functions.GetPlayer(src)
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle,
            hash,
            '{}',
            plate,
            0
        })
    else
        ExploitBan(src, 'Banned for exploiting')
    end
end)

RegisterServerEvent('CL-PoliceGarageV2:RentVehicle', function(paymenttype, finalPrice, vehiclename, vehicle, time, coordsinfo, job, station)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Config.BanWhenExploit and not Player.PlayerData.job.name == job then ExploitBan(src, 'Banned for exploiting') end
    if Player.Functions.GetMoney(paymenttype) >= finalPrice then
        TriggerClientEvent("CL-PoliceGarageV2:SpawnRentedVehicle", src, vehicle, vehiclename, finalPrice, time, os.time(), coordsinfo['VehicleSpawn'], paymenttype, job, station)  
        Player.Functions.RemoveMoney(paymenttype, finalPrice)
        TriggerClientEvent('QBCore:Notify', src, vehiclename .. Config.Locals["Notifications"]["SuccessfullyRented"] .. time .. " minutes", "success")  
        if Config.UseLogs then TriggerEvent("qb-log:server:CreateLog", "default", GetCurrentResourceName(), "blue", 'New vehicle rented by: **'..GetPlayerName(src)..'** Player ID: **' ..src.. '** Rented: **' ..vehiclename.. '** For: **' ..finalPrice.. '$**'..' Rented for: **'..time .. '** minutes', false) end
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Locals["Notifications"]["NoMoney"], "error")              
    end    
end)

RegisterServerEvent('CL-PoliceGarageV2:BuyVehicle', function(paymenttype, price, vehiclename, vehicle, coordsinfo, job, station, useownable, trunkitems, extras)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Config.BanWhenExploit and not Player.PlayerData.job.name == job then ExploitBan(src, 'Banned for exploiting') end
    if Player.Functions.GetMoney(paymenttype) >= price then
        TriggerClientEvent("CL-PoliceGarageV2:SpawnPurchasedVehicle", src, vehicle, coordsinfo['VehicleSpawn'], coordsinfo['CheckRadius'], job, useownable, trunkitems, extras)  
        Player.Functions.RemoveMoney(paymenttype, price)
        TriggerClientEvent('QBCore:Notify', src, vehiclename .. Config.Locals["Notifications"]["SuccessfullyBought"] .. station .. " garage", "success")  
        if Config.UseLogs then TriggerEvent("qb-log:server:CreateLog", "default", GetCurrentResourceName(), "blue", 'New vehicle purchased by: **'..GetPlayerName(src)..'** Player ID: **' ..src.. '** Bought: **' ..vehiclename.. '** For: **' ..price.. '$**'..' Station rented at: **'..station..'**', false) end
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Locals["Notifications"]["NoMoney"], "error")              
    end    
end)

RegisterServerEvent('CL-PoliceGarageV2:RefundRent', function(paymenttype, refund, clientsource, job)
	local src = source
	local Player = QBCore.Functions.GetPlayer(clientsource)
    if Config.BanWhenExploit and not Player.PlayerData.job.name == job then ExploitBan(src, 'Banned for exploiting') end
    if clientsource == src then
        Player.Functions.AddMoney(paymenttype, refund)
    else
        ExploitBan(src, 'Banned for exploiting')
    end
end)

QBCore.Functions.CreateCallback('CL-PoliceGarageV2:GetRealTime', function(source, cb)
    cb(os.time())
end)

function ExploitBan(id, reason)
	MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
		GetPlayerName(id),
		QBCore.Functions.GetIdentifier(id, 'license'),
		QBCore.Functions.GetIdentifier(id, 'discord'),
		QBCore.Functions.GetIdentifier(id, 'ip'),
		reason,
		2147483647,
		GetCurrentResourceName()
	})
	TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(id), GetCurrentResourceName(), reason), true)
	DropPlayer(id, 'You were permanently banned by the server for: ' .. reason)
end