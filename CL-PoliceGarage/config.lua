Config = Config or {}

-- Discord Logs Config

Config.LogsImage = "https://cdn.discordapp.com/attachments/926465631770005514/966038265130008576/CloudDevv.png"

Config.WebHook = "YOUR WEBHOOK"

Config.FuelSystem = "LegacyFuel" -- Put here your fuel system LegacyFuel by default

Config.UsePreviewMenuSync = false -- Sync for the preview menu when player is inside the preview menu other players cant get inside (can prevent bugs but not have to use)

Config.UseMarkerInsteadOfMenu = true -- Want to use the marker to return the vehice? if false you can do that by opening the menu

Config.SetVehicleTransparency = 'low' -- Want to make the vehicle more transparent? you have a lot of options to choose from: low, medium, high, none

Config.Job = 'police' --The job needed to open the menu

--You Can Add As Many As You Like
--DO NOT add vehicles that are not in your shared ! otherwise the qb-garages wont work
Config.Vehicles = {
    [1] = {
        ['vehiclename'] = "T20", --Name
        ['vehicle'] = "t20", --Model
        ['price'] = 5000, --Price
    }, 
    [2] = {
        ['vehiclename'] = "Police2", --Name
        ['vehicle'] = "sultan", --Model
        ['price'] = 10000, --Price
    }, 
    [3] = {
        ['vehiclename'] = "Bati", --Name
        ['vehicle'] = "bati", --Model
        ['price'] = 52000, --Price
    }, 
}

Config.RepairLocations = {
    --MRPD
    [1] = {
        ['coords'] = vector3(439.94305, -1021.742, 28.604888),
        ['distance'] = 32.0
    },  
}