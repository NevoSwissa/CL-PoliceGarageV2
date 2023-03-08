fx_version 'adamant'

game 'gta5'
lua54 'yes'
author "NevoSwissa#0111"
description "A Simple Police Garage Made By NevoSwissa#0111 For CloudDevelopment"

client_scripts {
    'client/client.lua',
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'config.lua',
}