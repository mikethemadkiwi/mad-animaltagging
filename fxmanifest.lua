--[[ FX Information ]]--
fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game         'rdr3'
--[[ Resource Information ]]--
name 'mad-animaltagging'
author 'mikethemadkiwi'
description 'RDO Replicated Animal Sampling'
version '0.0.1'
--[[ Dependancies ]]--
dependencies {
    '/onesync',
    'oxmysql'
}
--[[ Client Scripts ]]--
client_scripts {
    'cl_editable.lua',
    'taglistener.js',
    'cl_tagging.lua'
}
--[[ Server Scripts ]]--
server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'sv_editable.lua',
    'sv_tagging.lua'
}
--[[ Editable Files ]]--
escrow_ignore {
    'cl_editable.lua',
    'taglistener.js',
    'sv_editable.lua'
}