Config = {}

Config.LogsImage = "https://cdn.discordapp.com/attachments/926465631770005514/966038265130008576/CloudDevv.png"

Config.WebHook = "YOUR WEBHOOK"

Config.BanWhenExploit = false -- Set to true if you want to ban players / cheaters when buying items without the job (Just another safety system (: )

Config.UseBlips = true 

Config.RentMaximum = 60

Config.Target = "qb-target"

Config.UseTargets = true

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
            UseTarget = false, -- Set to false to use the Marker for this station
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
                    ["Bati"] = { -- Vehicle name goes here
                        Vehicle = "bati", -- The vehicle to spawn
                        TotalPrice = 5000, -- The total price it costs to buy this vehicle
                        Rank = 0, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                    ["Ferrari F1-75"] = {
                        Vehicle = "f175", -- The vehicle to spawn
                        TotalPrice = 20000, -- The total price it costs to buy this vehicle
                        Rank = 3, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
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
        ["PRISON"] = {
            UseTarget = true, -- Set to false to use the Marker for this station
            UseRent = false, -- Set to false to disable the rent feature for this station
            JobRequired = "records", -- The job required for this station garage
            VehiclesInformation = {
                RentVehicles = { -- Rent vehicles information, if UseRent set to true as : UseRent = true
                    ["Bati"] = {
                        Vehicle = "bati", -- The vehicle to spawn
                        PricePerMinute = 50, -- The price to charge for that vehicle every minute
                    }, 
                },
                PurchaseVehicles = { -- Purchasable vehicles, make sure you have the vehicle information set in qb-core > shared > vehicles.lua
                    ["T20"] = { -- Vehicle name goes here
                        Vehicle = "t20", -- The vehicle to spawn
                        TotalPrice = 25000, -- The total price it costs to buy this vehicle
                        Rank = 2, -- The rank required to purchase this vehicle. Set to 0 to enable all ranks
                    }, 
                },
                SpawnCoords = {
                    VehicleSpawn = vector4(1861.7213, 2699.5097, 45.953014, 186.18952), -- Vehicle spawn and vehicle clear check coords
                    PreviewSpawn = vector4(1858.0223, 2712.1608, 45.954685, 162.94125), -- Preview vehicle spawn coords
                    CheckRadius = 5.0, -- The radius the script checks for vehicle
                    CameraInformation = {
                        CameraCoords = vector3(1854.9989, 2702.4978, 45.834388), -- Vehicle preview camera coords
                        CameraRotation = vector3(-10.00, 0.00, 341.7), -- Vehicle preview camera rotation coords. Last value is heading
                        CameraFOV = 80.0, -- The vehicle preview camera fov value
                    },
                },
            },
            GeneralInformation = {
                Blip = { -- If UseTarget set to true it uses the target ped coords and if false it uses the marker coords
                    BlipId = 357, -- The blip id. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipColour = 2, -- The blip colour. More can be found at : https://docs.fivem.net/docs/game-references/blips/
                    BlipScale = 0.4, -- The blip scale
                    Title = "PRISON - Garage" -- The blip title string
                },
                TargetInformation = { -- If UseTarget set to true this is the required information
                    Ped = "a_m_y_smartcaspat_01", -- The ped model. More models can be found at : https://docs.fivem.net/docs/game-references/ped-models/
                    Coords = vector4(1865.1951, 2711.236, 44.834213, 124.57299), -- The ped coords
                    Scenario = "WORLD_HUMAN_CLIPBOARD", -- Ped scenario. More can be found at : https://wiki.rage.mp/index.php?title=Scenarios
                },
                MarkerInformation = { -- If UseTarget set to false this is the required information
                    Coords = vector3(1865.1951, 2711.236, 45.834213), -- The marker coords
                    MarkerType = 36, -- The marker type. More can be found at : https://docs.fivem.net/docs/game-references/markers/
                    MarkerColor = { R = 255, G = 0, B = 0, A = 100 }, -- The marker color. You can pick other colors here : https://rgbacolorpicker.com/
                },
            },  
        },
    },
}