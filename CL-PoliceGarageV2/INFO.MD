Thank you downloading CL-PoliceGarageV2 (More like CL-JobsGarages)!

This script allows you to create garages for purchasing and renting vehicles and much more. To get started, follow the steps below:

1. Configuring the Garage Template

The garage template is located in the `config.lua` file. Here you can enable/disable features and configure settings such as job requirements and vehicle information. Each garage requires a unique name that can be used as the station/garage name.

2. Setting Up Vehicles

You can set up vehicles for purchase or rent in the `config.lua` file. For purchasable vehicles, make sure you have the vehicle information set in `qb-core > shared > vehicles.lua`. For rentable vehicles, set the price per minute. You can also set the required rank and vehicle settings such as extras, liveries, and trunk items.

3. Setting Up Coordinates and Camera Information

In the `config.lua` file, you can set up the spawn coordinates for the vehicle, the preview spawn coordinates, the check radius, and the camera information for the preview. You can also choose whether to use a marker or a target as the garage interaction.

4. Adding a Blip and Target Ped (Optional)

If you choose to use a target ped, you can set the ped model in the `config.lua` file. You can also add a blip to the garage by setting the blip ID, color, scale, and title.

5. Starting the Garage

Once you have configured the garage, start the script and enjoy!

Thank you for using CL-PoliceGarageV2. If you have any questions or issues, please join https://discord.com/invite/rp6ynCJTKK.



F&Q :

- Question : Can I use the script for renting ?
- Answer : Yes, you can use the script as a renting system as well using `JobRequired = "all"` to allow all jobs to access the garage.

- Question : My garages stopped working after using the garage with the `UsePurchasable` feature. How to fix that ?
- Answer : To use the `UsePurchasable` feature you must follow this instructions : Firstly, make sure to add the vehicle correctly to the `qb-core > shared > vehicles.lua` by using this templates :

If you are using an older version of `qb-core` use :

```lua
	['police2'] = { -- Vehicle model, must be same as ['model']
		['name'] = 'Police 2', -- Vehicle name, can be any string
		['brand'] = nil, -- No need can be deleted (Used for qb-vehicleshop)
		['model'] = 'police2', -- Vehicle model same as the table name
		['price'] = nil, -- No need, can be deleted (Used for qb-vehicleshop)
		['category'] = "custom", -- Must have, can be any name 
		['hash'] = `police2`, -- The vehicle hash key
		['shop'] = nil, -- Can be deleted (Used for qb-vehicleshop)
	},
```

For newer versions of `qb-core` use :

```lua
    ['police2'] = { -- Vehicle model, must be same as ['model']
        ['name'] = 'police2', -- Vehicle name, can be any string
		['brand'] = nil, -- No need can be deleted (Used for qb-vehicleshop)
		['model'] = 'police2', -- Vehicle model same as the table name
		['price'] = nil, -- No need, can be deleted (Used for qb-vehicleshop)
        ['category'] = 'custom', -- This must match "VehicleClass" in vehicles.meta for the vehicle and must also exist in https://docs.fivem.net/natives/?_0x29439776AAA00A62
        ['categoryLabel'] = nil, -- Can be deleted (Used for qb-vehicleshop)
		['hash'] = `police2`, -- The vehicle hash key
		['shop'] = nil, -- Can be deleted (Used for qb-vehicleshop)
    },
```