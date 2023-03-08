local QBCore = exports['qb-core']:GetCoreObject()

local PolicePeds = {}

local PlayerRentedVehicle = {}

local LocationBlips = {}

local PlayerJob = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    Blips()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerJob = {}
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    Blips()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        Blips()
    end
end)

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function Blips()
    for k, v in pairs(Config.Locations['Stations']) do
        local blip = LocationBlips[k]
        if Config.UseBlips then
            if PlayerJob.name == v.JobRequired then
                if not blip then
                    if v.UseTarget then
                        blip = AddBlipForCoord(v.GeneralInformation['TargetInformation']['Coords'].x, v.GeneralInformation['TargetInformation']['Coords'].y, v.GeneralInformation['TargetInformation']['Coords'].z)
                    else
                        blip = AddBlipForCoord(v.GeneralInformation['MarkerInformation']['Coords'].x, v.GeneralInformation['MarkerInformation']['Coords'].y, v.GeneralInformation['MarkerInformation']['Coords'].z)
                    end
                    SetBlipDisplay(blip, 4)
                    SetBlipAsShortRange(blip, true)
                    LocationBlips[k] = blip
                end
                SetBlipSprite(blip, v.GeneralInformation['Blip']['BlipId'])
                SetBlipScale(blip, v.GeneralInformation['Blip']['BlipScale'])
                SetBlipColour(blip, v.GeneralInformation['Blip']['BlipColour'])
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.GeneralInformation['Blip']['Title'])
                EndTextCommandSetBlipName(blip)
            elseif blip then
                RemoveBlip(blip)
                LocationBlips[k] = nil
            end
        elseif blip then
            RemoveBlip(blip)
            LocationBlips[k] = nil
        end
    end
end

CreateThread(function()
    for k, v in pairs(Config.Locations['Stations']) do
        if v.UseTarget then
            RequestModel(v.GeneralInformation['TargetInformation']['Ped'])
            while not HasModelLoaded(v.GeneralInformation['TargetInformation']['Ped']) do
                Wait(0)
            end
            PolicePeds[k] = CreatePed(0, v.GeneralInformation['TargetInformation']['Ped'], v.GeneralInformation['TargetInformation']['Coords'].x, v.GeneralInformation['TargetInformation']['Coords'].y, v.GeneralInformation['TargetInformation']['Coords'].z, v.GeneralInformation['TargetInformation']['Coords'].w, true, false)
            TaskLookAtEntity(PolicePeds[k], PlayerPedId(), -1)
            FreezeEntityPosition(PolicePeds[k], true)
            SetEntityInvincible(PolicePeds[k], true)
            SetBlockingOfNonTemporaryEvents(PolicePeds[k], true)
            TaskStartScenarioInPlace(PolicePeds[k], v.GeneralInformation['TargetInformation']['Scenario'], 0, true)
            exports[Config.Target]:AddEntityZone("cl_policegaragev2_interactped"..k, PolicePeds[k], {
                name = "cl_policegaragev2_interactped"..k,
            }, {
              options = {
                    { 
                        event = "CL-PoliceGarageV2:OpenMainMenu",
                        icon = Config.Locals['Targets']['GarageTarget']['Icon'],
                        label = Config.Locals['Targets']['GarageTarget']['Label'] .. k,
                        job = v.RequiredJob,
                        userent = v.UseRent,
                        rentvehicles = v.VehiclesInformation['RentVehicles'],
                        purchasevehicles = v.VehiclesInformation['PurchaseVehicles'],
                        coordsinfo = v.VehiclesInformation['SpawnCoords'],
                        station = k,
                        canInteract = function()
                            if PlayerJob.name == v.JobRequired then
                                return true
                            end
                            return false
                        end,
                    },
                },
                distance = Config.Locals['Targets']['GarageTarget']['Distance'],
            })
        else
            while true do
                local playerPos = GetEntityCoords(PlayerPedId())
                local distance = #(playerPos - v.GeneralInformation['MarkerInformation']['Coords'])
                if PlayerJob.name == v.JobRequired then
                    if distance < 10 then
                        DrawMarker(v.GeneralInformation['MarkerInformation']['MarkerType'], v.GeneralInformation['MarkerInformation']['Coords'].x, v.GeneralInformation['MarkerInformation']['Coords'].y, v.GeneralInformation['MarkerInformation']['Coords'].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, v.GeneralInformation['MarkerInformation']['MarkerColor'].R, v.GeneralInformation['MarkerInformation']['MarkerColor'].G, v.GeneralInformation['MarkerInformation']['MarkerColor'].B, v.GeneralInformation['MarkerInformation']['MarkerColor'].A, true, false, false, true, false, false, false)
                        if distance < 1.5 then
                            DrawText3D(v.GeneralInformation['MarkerInformation']['Coords'].x, v.GeneralInformation['MarkerInformation']['Coords'].y, v.GeneralInformation['MarkerInformation']['Coords'].z, "~g~E~w~ - " .. k .. " Police Garage")
                            if IsControlJustReleased(0, 38) then
                                local Data = {
                                    userent = v.UseRent,
                                    rentvehicles = v.VehiclesInformation['RentVehicles'],
                                    purchasevehicles = v.VehiclesInformation['PurchaseVehicles'],
                                    coordsinfo = v.VehiclesInformation['SpawnCoords'],
                                    station = k,
                                    job = v.JobRequired,
                                }
                                TriggerEvent("CL-PoliceGarageV2:OpenMainMenu", Data)
                            end
                        end
                    end
                end
                Wait(0)
            end
        end
    end
end)

RegisterNetEvent('CL-PoliceGarageV2:OpenMainMenu', function(data)
    local MainMenu = {
        {
            header = data.station .. " - Garage",
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        }
    }
    if data.userent then
        table.insert(MainMenu, {
            header = "Rent Vehicles",
            txt = "View and rent vehicles for a selected amount of time",
            icon = "fa-solid fa-file-contract",
            params = {
                event = "CL-PoliceGarageV2:OpenRentingMenu",
                args = {
                    rentvehicles = data.rentvehicles,
                    coordsinfo = data.coordsinfo,
                    station = data.station,
                    job = data.job,
                },
            }
        })
    end
    table.insert(MainMenu, {
        header = "Purchase Vehicles",
        txt = "View and purchase vehicles to use as your own",
        icon = "fa-solid fa-money-check-dollar",
        params = {
            event = "CL-PoliceGarageV2:OpenPurchaseMenu",
            args = {
                purchasevehicles = data.purchasevehicles,
                coordsinfo = data.coordsinfo,
                station = data.station,
                job = data.job,
            },
        }
    })
    if PlayerRentedVehicle[PlayerPedId()] and PlayerRentedVehicle[PlayerPedId()].station == data.station then
        table.insert(MainMenu, {
            header = "Return Vehicle",
            txt = "Return your rented vehicle",
            icon = "fa-solid fa-left-long",
            params = {
                event = "CL-PoliceGarageV2:ReturnRentedVehicle",
            }
        })
    end
    local menus = {
        [data.station .. "MainMenu"] = MainMenu
    }
    exports['qb-menu']:openMenu(menus[data.station .. "MainMenu"])
end)

RegisterNetEvent("CL-PoliceGarageV2:OpenRentingMenu", function(data)
    if QBCore.Functions.SpawnClear(vector3(data.coordsinfo['VehicleSpawn'].x, data.coordsinfo['VehicleSpawn'].y, data.coordsinfo['VehicleSpawn'].z), data.coordsinfo['CheckRadius']) then
        local RentingMenu = {
            {
                header = data.station .. " - Garage",
                icon = "fa-solid fa-circle-info",
                isMenuHeader = true,
            }
        }
        if not PlayerRentedVehicle[PlayerPedId()] then
            for k, v in pairs(data.rentvehicles) do
                table.insert(RentingMenu, {
                    header = "Rent " .. k,
                    txt = "Rent: " .. k .. "<br> For: " .. v.PricePerMinute .. "$ (Per Minute)",
                    icon = "fa-solid fa-car",
                    params = {
                        event = "CL-PoliceGarageV2:ChooseRent",
                        args = {
                            price = v.PricePerMinute,
                            vehiclename = k,
                            vehicle = v.Vehicle,
                            coordsinfo = data.coordsinfo,
                            station = data.station,
                            job = data.job,
                        }
                    }
                })
            end
        elseif PlayerRentedVehicle[PlayerPedId()].station ~= data.station then
            for k, v in pairs(data.rentvehicles) do
                table.insert(RentingMenu, {
                    header = "Rent " .. k,
                    txt = "Rent: " .. k .. "<br> For: " .. v.PricePerMinute .. "$ (Per Minute)",
                    icon = "fa-solid fa-car",
                    params = {
                        event = "CL-PoliceGarageV2:ChooseRent",
                        args = {
                            price = v.PricePerMinute,
                            vehiclename = k,
                            vehicle = v.Vehicle,
                            coordsinfo = data.coordsinfo,
                            station = data.station,
                            job = data.job,
                        }
                    }
                })
            end
        end
        if PlayerRentedVehicle[PlayerPedId()] and PlayerRentedVehicle[PlayerPedId()].station == data.station then
            table.insert(RentingMenu, {
                header = "Return Vehicle",
                txt = "Return your rented vehicle",
                icon = "fa-solid fa-left-long",
                params = {
                    event = "CL-PoliceGarageV2:ReturnRentedVehicle",
                }
            })
        end
        local menus = {
            [data.station .. "RentingMenu"] = RentingMenu
        }
        exports['qb-menu']:openMenu(menus[data.station .. "RentingMenu"])
    else
        QBCore.Functions.Notify(Config.Locals["Notifications"]["VehicleInSpawn"], "error")
    end
end)

RegisterNetEvent("CL-PoliceGarageV2:OpenPurchaseMenu", function(data)
    local VehicleMenu = {
        {
            header = data.station .. " - Garage",
            icon = "fa-solid fa-circle-info",
            isMenuHeader = true,
        }
    }
    table.sort(data.purchasevehicles, function(a, b)
        return a.Rank >= b.Rank
    end)
    for k, v in pairs(data.purchasevehicles) do
        if PlayerJob.grade.level >= v.Rank then
            table.insert(VehicleMenu, {
                header = "Purchase " .. k,
                txt = "Purchase: " .. k .. "<br> For: " .. v.TotalPrice .. "$",
                icon = "fa-solid fa-circle-check",
                params = {
                    event = "CL-PoliceGarageV2:StartPreview",
                    args = {
                        price = v.TotalPrice,
                        vehiclename = k,
                        vehicle = v.Vehicle,
                        coordsinfo = data.coordsinfo,
                        station = data.station,
                        job = data.job,
                    }
                }
            })
        end
    end
    local menus = {
        [data.station .. "VehicleMenu"] = VehicleMenu
    }
    exports['qb-menu']:openMenu(menus[data.station .. "VehicleMenu"])
end)

RegisterNetEvent("CL-PoliceGarageV2:SpawnRentedVehicle", function(vehicle, vehiclename, amount, time, realtime, spawncoords, paymenttype, job, station)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        local player = PlayerPedId()
        SetVehicleDirtLevel(veh, 0.0)
		PlayerRentedVehicle[player] = {vehicle = veh, station = station, name = vehiclename, amount = amount, paymenttype = paymenttype, time = time, starttime = realtime, job = job}
        SetVehicleNumberPlateText(veh, "LSPD"..tostring(math.random(1000, 9999)))
        exports[Config.FuelSystem]:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(player, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        StartLoop(veh, vehiclename, time, player, station)
    end, spawncoords, true)
end)

RegisterNetEvent("CL-PoliceGarageV2:SpawnPurchasedVehicle", function(vehicle, spawncoords, checkradius, job)
    if QBCore.Functions.SpawnClear(vector3(spawncoords.x, spawncoords.y, spawncoords.z), checkradius) then
        QBCore.Functions.SpawnVehicle(vehicle, function(veh)
            SetVehicleNumberPlateText(veh, "LSPD"..tostring(math.random(1000, 9999)))
            exports[Config.FuelSystem]:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            SetVehicleDirtLevel(veh, 0.0)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            TriggerServerEvent("CL-PoliceGarageV2:AddData", "vehiclepurchased", vehicle, GetHashKey(veh), QBCore.Functions.GetPlate(veh), job)
        end, spawncoords, true)
    else
        QBCore.Functions.Notify(Config.Locals["Notifications"]["VehicleInSpawn"], "error")
    end
end)

RegisterNetEvent("CL-PoliceGarageV2:ReturnRentedVehicle", function()
	local player = PlayerPedId()
    QBCore.Functions.TriggerCallback('CL-PoliceGarageV2:GetRealTime', function(result)
        if not PlayerRentedVehicle[player] then
            QBCore.Functions.Notify(Config.Locals['Notifications']['NoRentedVehicle'])
            return
        end
        TaskLeaveVehicle(player, PlayerRentedVehicle[player].vehicle, 1)
        Citizen.Wait(2000)
        local remainingTime = (PlayerRentedVehicle[player].time * 60) - (result - PlayerRentedVehicle[player].starttime)
        local refund = math.floor(PlayerRentedVehicle[player].amount * (remainingTime / (PlayerRentedVehicle[player].time * 60)))
        QBCore.Functions.Notify(Config.Locals['Notifications']['VehicleReturned'] .. PlayerRentedVehicle[player].name .. " Refund amount : " .. refund .. "$")
        TriggerServerEvent("CL-PoliceGarageV2:RefundRent", PlayerRentedVehicle[player].paymenttype, refund, GetPlayerServerId(PlayerId()), PlayerRentedVehicle[player].job)
        DeleteVehicle(PlayerRentedVehicle[player].vehicle)
        DeleteEntity(PlayerRentedVehicle[player].vehicle)
        PlayerRentedVehicle[player] = nil
    end)
end)

RegisterNetEvent("CL-PoliceGarageV2:StartPreview", function(data)
    local player = PlayerPedId()
    if not IsCamActive(VehicleCam) then
        QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
            SetEntityVisible(player, false, 1)
            if Config.SetVehicleTransparency == 'low' then
                SetEntityAlpha(veh, 200)
            elseif Config.SetVehicleTransparency == 'medium' then
                SetEntityAlpha(veh, 150)
            elseif Config.SetVehicleTransparency == 'high' then
                SetEntityAlpha(veh, 100)
            elseif Config.SetVehicleTransparency == 'none' then
                SetEntityAlpha(veh, 255)
            end
            FreezeEntityPosition(player, true)
            SetVehicleNumberPlateText(veh, "LSPD"..tostring(math.random(1000, 9999)))
            exports[Config.FuelSystem]:SetFuel(veh, 0.0)
            SetVehicleDirtLevel(veh, 0.0)
            FreezeEntityPosition(veh, true)
            SetVehicleEngineOn(veh, false, false)
            DoScreenFadeOut(200)
            Citizen.Wait(500)
            DoScreenFadeIn(200)
            SetVehicleUndriveable(veh, true)
            VehicleCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", data.coordsinfo['CameraInformation']['CameraCoords'].x, data.coordsinfo['CameraInformation']['CameraCoords'].y, data.coordsinfo['CameraInformation']['CameraCoords'].z, data.coordsinfo['CameraInformation']['CameraRotation'].x, data.coordsinfo['CameraInformation']['CameraRotation'].y, data.coordsinfo['CameraInformation']['CameraRotation'].z, data.coordsinfo['CameraInformation']['CameraFOV'], false, 0)
            SetCamActive(VehicleCam, true)
            RenderScriptCams(true, true, 500, true, true)
            Citizen.CreateThread(function()
                while IsCamActive(VehicleCam) do
                    ShowHelpNotification("~INPUT_PICKUP~ to confirm your purchase. ~INPUT_CELLPHONE_CANCEL~ To cancel")
                    if IsControlJustReleased(0, 177) then
                        SetEntityVisible(player, true, 1)
                        FreezeEntityPosition(player, false)
                        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        QBCore.Functions.DeleteVehicle(veh)
                        DoScreenFadeOut(200)
                        Citizen.Wait(500)
                        DoScreenFadeIn(200)
                        SetCamActive(VehicleCam, false)
                        RenderScriptCams(false, false, 1, true, true)
                        break
                    end
                    if IsControlJustReleased(0, 38) then
                        SetEntityVisible(player, true, 1)
                        FreezeEntityPosition(player, false)
                        PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        QBCore.Functions.DeleteVehicle(veh)
                        DoScreenFadeOut(200)
                        Citizen.Wait(500)
                        DoScreenFadeIn(200)
                        SetCamActive(VehicleCam, false)
                        RenderScriptCams(false, false, 1, true, true)
                        local VehicleData = {
                            price = data.price,
                            vehiclename = data.vehiclename,
                            vehicle = data.vehicle,
                            coordsinfo = data.coordsinfo,
                            job = data.job,
                            station = data.station,
                        }
                        TriggerEvent("CL-PoliceGarageV2:ChoosePayment", VehicleData)
                        break
                    end
                    Citizen.Wait(1)
                end
            end)
        end, data.coordsinfo['PreviewSpawn'], true)
    end
end)

RegisterNetEvent("CL-PoliceGarageV2:ChooseRent", function(data)
    local minutes = exports["qb-input"]:ShowInput({
        header = "Enter Number Of Minutes",
        submitText = "Submit",
        inputs = {
            {
                text = 'Minutes',
                name = 'minutes',
                type = 'number',
                isRequired = true,
            }
        }
    })
    if minutes ~= nil then
        local minutesamount = tonumber(minutes.minutes)
        if minutesamount > 0 and minutesamount <= Config.RentMaximum then
            local paymentType = exports["qb-input"]:ShowInput({
                header = "Choose Payment Type",
                submitText = "Submit",
                inputs = {
                    {
                        text = 'Payment Type',
                        name = 'paymenttype',
                        type = 'radio',
                        isRequired = true,
                        options = {
                            {
                                value = "cash",
                                text = "Cash"
                            },
                            {
                                value = "bank",
                                text = "Bank"
                            }
                        }
                    }
                }
            })
            if paymentType ~= nil then
                local finalPrice = (minutes.minutes * data.price)
                local price = exports["qb-input"]:ShowInput({
                    header = "Final Price",
                    submitText = "Rent",
                    inputs = {
                        {
                            text = 'Final Price: $' .. finalPrice,
                            name = 'finalprice',
                            type = 'checkbox',
                            options = {
                                { 
                                    value = "agree", 
                                    text = "Confirm final price",
                                    checked = true,
                                },
                            }
                        }
                    }
                })
                if price ~= nil then
                    TriggerServerEvent("CL-PoliceGarageV2:RentVehicle", paymentType.paymenttype, finalPrice, data.vehiclename, data.vehicle, minutes.minutes, data.coordsinfo, data.job, data.station)
                end
            end
        else
            QBCore.Functions.Notify("Invalid amount ! minutes needs to be more then 0 and less then " .. Config.RentMaximum .. ". Minutes choosen " .. minutes.minutes, "error")
        end
    end
end)

RegisterNetEvent("CL-PoliceGarageV2:ChoosePayment", function(data)
    local paymentType = exports["qb-input"]:ShowInput({
        header = "Choose Payment Type",
        submitText = "Submit",
        inputs = {
            {
                text = 'Payment Type',
                name = 'paymenttype',
                type = 'radio',
                isRequired = true,
                options = {
                    {
                        value = "cash",
                        text = "Cash"
                    },
                    {
                        value = "bank",
                        text = "Bank"
                    }
                }
            }
        }
    })
    if paymentType ~= nil then
        local price = exports["qb-input"]:ShowInput({
            header = "Final Price",
            submitText = "Rent",
            inputs = {
                {
                    text = 'Final Price: $' .. data.price,
                    name = 'finalprice',
                    type = 'checkbox',
                    options = {
                        { 
                            value = "agree", 
                            text = "Confirm final price",
                            checked = true,
                        },
                    }
                }
            }
        })
        if price ~= nil then
            TriggerServerEvent("CL-PoliceGarageV2:BuyVehicle", paymentType.paymenttype, data.price, data.vehiclename, data.vehicle, data.coordsinfo, data.job, data.station)
        end
    end
end)

function StartLoop(veh, vehname, time, player, station)
    local Notified = false
    local normalTime = time * 60000
    local reducedTime = math.floor(normalTime * 0.8)
    repeat
        Wait(1000)
        normalTime = normalTime - 1000
        reducedTime = reducedTime - 1000
        if normalTime <= 0 then
            DeleteVehicle(veh)
            PlayerRentedVehicle[player] = nil
            DeleteEntity(veh)
            QBCore.Functions.Notify(Config.Locals['Notifications']['RentOver'] .. vehname .. " is over")           
            break
        end
        if reducedTime <= 0 and not Notified then
            QBCore.Functions.Notify(Config.Locals['Notifications']['RentWarning'] .. vehname)
            Notified = true
        end
    until false or not PlayerRentedVehicle[player] or not station == PlayerRentedVehicle[player].station
end