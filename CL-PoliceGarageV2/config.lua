Config = {}

Config.LogsImage = "https://cdn.discordapp.com/attachments/926465631770005514/966038265130008576/CloudDevv.png" -- The image showen in the logs. No need to change

Config.WebHook = "YOUR WEBHOOK" -- Your discord webhook if you would like to use discord logs

Config.BanWhenExploit = false -- Set to true if you want to ban players / cheaters when buying items without the job (Just another safety system (: )

Config.UseBlips = true -- Set to false to disable all script blips

Config.RentMaximum = 60 -- The rent maximum allowed minutes

Config.Target = "qb-target" -- The name of your target (If you renamed qb-target exports etc DOES NOT support other targets)

Config.FuelSystem = "LegacyFuel" -- Put here your fuel system LegacyFuel by default

Config.SetVehicleTransparency = 'low' -- Want to make the vehicle more transparent? you have a lot of options to choose from: low, medium, high, none

Config.Locals = {
    Targets = {
        GarageTarget = {
            Distance = 5.0,
            Icon = "fa fa-car",
            Label = "Police Garage - ",  
        },
    },

    Notifications = {
        RentOver = "The rent time for ",
        RentWarning = "Return the vehicle or it will get deleted ! vehicle : ",
        NoRentedVehicle = "There are no rented vehicles on your name",
        NoMoney = "You dont have enough money",
        VehicleReturned = "Vehicle returned. Vehicle : ",
        SuccessfullyRented = " successfully rented for ",
        SuccessfullyBought = " successfully bought from ",
        VehicleInSpawn = 'Theres a vehicle in the spawn area !',
    },
}

Config.Locations = {
    Stations = {
        ["MRPD"] = {
            UseTarget = true, -- Set to false to use the Marker for this station
            UseRent = true, -- Set to false to disable the rent feature for this station
            JobRequired = "police", -- The job required for this station garage
            VehiclesInformation = {
                RentVehicles = { -- Rent vehicles information, if UseRent set to true as : UseRent = true
                    ["Bati"] = {
                        Vehicle = "bati", -- The vehicle to spawn
                        PricePerMinute = 50, -- The price to charge for that vehicle every minute
                    }, 
                },
                PurchaseVehicles = { -- Purchasable vehicles, make sure you have the vehicle information set in qb-core > shared > vehicles.lua
                    ["FBI"] = { -- Vehicle name goes here
                        Vehicle = "fbi", -- The vehicle to spawn
                        TotalPrice = 15000, -- The total price it costs to buy this vehicle
                        Rank = 1, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                    ["FBI 2"] = {
                        Vehicle = "fbi2", -- The vehicle to spawn
                        TotalPrice = 20000, -- The total price it costs to buy this vehicle
                        Rank = 0, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                    ["Police Vehicle 1"] = {
                        Vehicle = "police", -- The vehicle to spawn
                        TotalPrice = 5000, -- The total price it costs to buy this vehicle
                        Rank = 0, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                    ["Police Vehicle 2"] = {
                        Vehicle = "police2", -- The vehicle to spawn
                        TotalPrice = 7500, -- The total price it costs to buy this vehicle
                        Rank = 1, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                    ["Police Vehicle 3"] = {
                        Vehicle = "police3", -- The vehicle to spawn
                        TotalPrice = 10000, -- The total price it costs to buy this vehicle
                        Rank = 2, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                    ["Police T"] = {
                        Vehicle = "policet", -- The vehicle to spawn
                        TotalPrice = 6000, -- The total price it costs to buy this vehicle
                        Rank = 1, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                },
                SpawnCoords = {
                    VehicleSpawn = vector4(438.42324, -1021.07, 28.677057, 101.4219), -- Vehicle spawn and vehicle clear check coords
                    PreviewSpawn = vector4(453.6509, -1023.771, 28.494075, 62.526172), -- Preview vehicle spawn coords
                    CheckRadius = 5.0, -- The radius the script checks for vehicle
                    CameraInformation = {
                        CameraCoords = vector3(447.5325, -1020.384, 30.494419), -- Vehicle preview camera coords
                        CameraRotation = vector3(-10.00, 0.00, 240.494419), -- Vehicle preview camera rotation coords
                        CameraFOV = 80.0, -- The vehicle preview camera fov value
                    },
                },
            },
            GeneralInformation = {
                Blip = { -- If UseTarget set to true it uses the target ped coords and if false it uses the marker coords
                    BlipId = 357, -- The blip id. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipColour = 2, -- The blip colour. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipScale = 0.4, -- The blip scale
                    Title = "MRPD - Garage" -- The blip title string
                },
                TargetInformation = { -- If UseTarget set to true this is the required information
                    Ped = "a_m_y_smartcaspat_01", -- The ped model. More models can be found at : https://docs.fivem.net/docs/game-references/ped-models/
                    Coords = vector4(459.05987, -1017.118, 27.153299, 96.337463), -- The ped coords
                    Scenario = "WORLD_HUMAN_CLIPBOARD", -- Ped scenario. More can be found at : https://wiki.rage.mp/index.php?title=Scenarios
                },
                MarkerInformation = { -- If UseTarget set to false this is the required information
                    Coords = vector3(443.73809, -1017.172, 28.648283), -- The marker coords
                    MarkerType = 36, -- The marker type. More can be found at : https://docs.fivem.net/docs/game-references/markers/
                    MarkerColor = { R = 255, G = 0, B = 0, A = 100 }, -- The marker color. You can pick other colors here : https://rgbacolorpicker.com/
                },
            },  
        },
        ["EMS"] = {
            UseTarget = true, -- Set to false to use the Marker for this station
            UseRent = true, -- Set to false to disable the rent feature for this station
            JobRequired = "ambulance", -- The job required for this station garage
            VehiclesInformation = {
                RentVehicles = { -- Rent vehicles information, if UseRent set to true as : UseRent = true
                    ["Ambulance"] = {
                        Vehicle = "ambulance", -- The vehicle to spawn
                        PricePerMinute = 150, -- The price to charge for that vehicle every minute
                    }, 
                },
                PurchaseVehicles = { -- Purchasable vehicles, make sure you have the vehicle information set in qb-core > shared > vehicles.lua
                    ["Ambulance"] = { -- Vehicle name goes here
                        Vehicle = "ambulance", -- The vehicle to spawn
                        TotalPrice = 2500, -- The total price it costs to buy this vehicle
                        Rank = 0, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                },
                SpawnCoords = {
                    VehicleSpawn = vector4(328.50579, -558.1343, 28.743787, 72.116554), -- Vehicle spawn and vehicle clear check coords
                    PreviewSpawn = vector4(328.50579, -558.1343, 28.743787, 72.116554), -- Preview vehicle spawn coords
                    CheckRadius = 5.0, -- The radius the script checks for vehicle
                    CameraInformation = {
                        CameraCoords = vector3(318.32107, -554.5611, 30.743787), -- Vehicle preview camera coords
                        CameraRotation = vector3(-10.00, 0.00, 252.14), -- Vehicle preview camera rotation coords
                        CameraFOV = 80.0, -- The vehicle preview camera fov value
                    },
                },
            },
            GeneralInformation = {
                Blip = { -- If UseTarget set to true it uses the target ped coords and if false it uses the marker coords
                    BlipId = 357, -- The blip id. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipColour = 1, -- The blip colour. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipScale = 0.4, -- The blip scale
                    Title = "EMS - Garage" -- The blip title string
                },
                TargetInformation = { -- If UseTarget set to true this is the required information
                    Ped = "a_m_y_smartcaspat_01", -- The ped model. More models can be found at : https://docs.fivem.net/docs/game-references/ped-models/
                    Coords = vector4(333.84069, -561.9168, 27.743787, 338.39334), -- The ped coords
                    Scenario = "WORLD_HUMAN_CLIPBOARD", -- Ped scenario. More can be found at : https://wiki.rage.mp/index.php?title=Scenarios
                },
            },  
        },
    },
}