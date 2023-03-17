Config = {}

Config.UseLogs = false -- Set to true to enable discord logs, using default QBCore logs system

Config.BanWhenExploit = false -- Set to true if you want to ban players / cheaters when buying items without the job (Just another safety system)

Config.UseBlips = true -- Set to false to disable all script blips

Config.RentMaximum = 60 -- The rent maximum allowed minutes

Config.Target = "qb-target" -- The name of your target

Config.FuelSystem = "LegacyFuel" -- Put here your fuel system LegacyFuel by default

Config.SetVehicleTransparency = 'none' -- Want to make the vehicle more transparent? you have a lot of options to choose from: low, medium, high, none

Config.Locals = {
    Targets = {
        GarageTarget = {
            Distance = 5.0,
            Icon = "fa fa-car",
            Label = "Garage - ",  
        },
    },

    Notifications = {
        RentOver = "The rent time for ",
        RentWarning = "Return the vehicle or it will get deleted ! vehicle ",
        NoRentedVehicle = "There are no rented vehicles on your name",
        NoMoney = "You dont have enough money",
        VehicleReturned = "Vehicle returned. Vehicle ",
        SuccessfullyRented = " successfully rented for ",
        SuccessfullyBought = " successfully bought from ",
        NotDriver = "You must be the driver !",
        ExtraTurnedOn = " vehicle extra successfully got turned on",
        ExtraTurnedOff = " vehicle extra successfully got turned off",
        VehicleInSpawn = 'Theres a vehicle in the spawn area !',
        NotInVehicle = "You are not in any vehicle !",
        LiverySet = "Vehicle livery has been successfully set to ",
        LeftVehicle = "You have left the vehicle",
        IncorrectVehicle = "Incorrect vehicle ! you rented "
    },
}

Config.Locations = {
    Stations = {
        ["MRPD"] = { -- Full template, inculdes all script features
            UseTarget = true, -- Set to false to use the Marker for this station
            UseRent = true, -- Set to false to disable the rent feature for this station (Garage WONT WORK if UseRent and UsePurchasable are set to false)
            UseOwnable = true, -- Set to false to disable ownable vehicles 
            UseExtras = true, -- Set to false to disable the extras feature
            UsePurchasable = true, -- Set to false to disable purchasable vehicles (Garage WONT WORK if UseRent and UsePurchasable are set to false)
            UseLiveries = true, -- Set to false to disable the livery feature
            JobRequired = "police", -- The job required for this station garage
            VehiclesInformation = {
                RentVehicles = { -- Rent vehicles information, if UseRent set to true as : UseRent = true
                    ["Bati"] = {
                        Vehicle = "bati", -- The vehicle to spawn
                        PricePerMinute = 50, -- The price to charge for that vehicle every minute
                    }, 
                },
                PurchaseVehicles = { -- Purchasable vehicles, make sure you have the vehicle information set in qb-core > shared > vehicles.lua
                    ["Police Vehicle 1"] = {
                        Vehicle = "police", -- The vehicle to spawn
                        TotalPrice = 5000, -- The total price it costs to buy this vehicle
                        Rank = 0, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                        VehicleSettings = { -- Everthing inside those brackets is totally optional (If you dont want to use it simply remove)
                            DefaultExtras = { 1, 2 }, -- Default extras that the vehicle will spawn with the numbers to represent the vehicle extra id (Keep empty to remove all extras or delete to disable this feature)
                            DefaultLiveries = { -- Default liveries that the player would be spawned if the player have the required rank.
                                ["Supervisor"] = { -- The livery name for example : Supervisor, patrol ghost etc
                                    RankRequired = 0, -- The minimum required rank for this livery
                                    LiveryID = 1, -- The livery id
                                },                 
                                ["Patrol"] = { -- The livery name for example : Supervisor, patrol ghost etc
                                    RankRequired = 2, -- The minimum required rank for this livery
                                    LiveryID = 5, -- The livery id
                                },
                            },
                            TrunkItems = { -- Trunk items the vehicle would spawn with
                                [1] = {
                                    name = "heavyarmor",
                                    amount = 2,
                                    info = {},
                                    type = "item",
                                    slot = 1,
                                },
                            },
                        },
                    }, 
                    ["Police Vehicle 2"] = {
                        Vehicle = "police2", -- The vehicle to spawn
                        TotalPrice = 7500, -- The total price it costs to buy this vehicle
                        Rank = 1, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                        VehicleSettings = { -- Everthing inside those brackets is totally optional
                            -- Example of how it should look like if you dont want to use any of those features
                        },
                    }, 
                    ["Police Vehicle 3"] = {
                        Vehicle = "police3", -- The vehicle to spawn
                        TotalPrice = 10000, -- The total price it costs to buy this vehicle
                        Rank = 2, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                        VehicleSettings = { -- Everthing inside those brackets is totally optional
                            -- Example of how it should look like if you dont want to use any of those features
                        },
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
            UseRent = false, -- Set to false to disable the rent feature for this station (Garage WONT WORK if UseRent and UsePurchasable are set to false)
            UseOwnable = true, -- Set to false to disable ownable vehicles 
            UsePurchasable = true, -- Set to false to disable purchasable vehicles (Garage WONT WORK if UseRent and UsePurchasable are set to false)
            UseExtras = true, -- Set to false to disable the extras feature
            UseLiveries = false, -- Set to false to disable the livery menu
            JobRequired = "ambulance", -- The job required for this station garage
            VehiclesInformation = {
                PurchaseVehicles = { -- Purchasable vehicles, make sure you have the vehicle information set in qb-core > shared > vehicles.lua
                    ["Ambulance"] = {
                        Vehicle = "ambulance", -- The vehicle to spawn
                        TotalPrice = 2500, -- The total price it costs to buy this vehicle
                        Rank = 0, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                        VehicleSettings = { -- Everthing inside those brackets is totally optional
                            TrunkItems = { -- Trunk items (This is optional)
                                [1] = {
                                    name = "bandage",
                                    amount = 10,
                                    info = {},
                                    type = "item",
                                    slot = 1,
                                },
                            },
                        },
                    }, 
                },
                SpawnCoords = {
                    VehicleSpawn = vector4(329.84863, -558.5644, 28.743801, 69.063636), -- Vehicle spawn and vehicle clear check coords
                    PreviewSpawn = vector4(329.84863, -558.5644, 28.743801, 69.063636), -- Preview vehicle spawn coords
                    CheckRadius = 5.0, -- The radius the script checks for vehicle
                    CameraInformation = {
                        CameraCoords = vector3(321.73477, -555.7084, 30.743782), -- Vehicle preview camera coords
                        CameraRotation = vector3(-10.00, 0.00, 253.18), -- Vehicle preview camera rotation coords
                        CameraFOV = 70.0, -- The vehicle preview camera fov value
                    },
                },
            },
            GeneralInformation = {
                Blip = { -- If UseTarget set to true it uses the target ped coords and if false it uses the marker coords
                    BlipId = 357, -- The blip id. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipColour = 2, -- The blip colour. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipScale = 0.4, -- The blip scale
                    Title = "EMS - Garage" -- The blip title string
                },
                TargetInformation = { -- If UseTarget set to true this is the required information
                    Ped = "a_m_y_smartcaspat_01", -- The ped model. More models can be found at : https://docs.fivem.net/docs/game-references/ped-models/
                    Coords = vector4(333.92584, -561.8319, 27.743801, 341.15295), -- The ped coords
                    Scenario = "WORLD_HUMAN_CLIPBOARD", -- Ped scenario. More can be found at : https://wiki.rage.mp/index.php?title=Scenarios
                },
            },  
        },
    },
}