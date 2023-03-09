fx_version 'adamant'

game 'gta5'
lua54 'yes'
author "NevoSwissa#8239"
description "CL-PoliceGarageV2 or JobGarage it can do anything related to creating garages !"

client_scripts {
    'client/client.lua',
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'config.lua',
}