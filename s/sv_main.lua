ESX = nil

local webhook = "https://discord.com/api/webhooks/971810399047520306/72tK9fJR_Zj8Gf4nAixCMLXPGVH8RmXDmpQ8EfsVdYvoD0Mx9Uxztj5QC2eA8OUyW0Dz"

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('pommireppu', function(source)
	TriggerClientEvent('esx_pommireppu:kayta', source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	Log("**Puki päällensä pommirepun**", '3863105', GetPlayerName(source), "POMMIREPPU logs")
	xPlayer.removeInventoryItem('pommireppu', 1)
end)

RegisterServerEvent("esx_pommireppu:ReppuTakas")
AddEventHandler("esx_pommireppu:ReppuTakas", function()
    local xPlayer  = ESX.GetPlayerFromId(source)
	Log("**Riisui pommirepun**", '3863105', GetPlayerName(source), "POMMIREPPU logs")
    xPlayer.addInventoryItem('pommireppu', 1)
end)

RegisterServerEvent("esx_pommireppu:SusImposter")
AddEventHandler("esx_pommireppu:SusImposter", function(X,Y,Z)
	Log("**RÄJÄYTTI REPUN \nCOORDINAATIT: X: **" ..X.. "  **Y:**  " ..Y.. "  **Z:  **" ..Z, '3863105', GetPlayerName(source), "POMMIREPPU logs")
end)

function Log(m, c, t, n)
    local co = {
        {
            ["color"] = c,
            ["title"] = t,
            ["description"] = m,
            ["footer"] = {
                ["text"] = os.date("%x | %X")
            },
        }
    }

    PerformHttpRequest(webhook, function(status, text, headers)
		if status ~= 204 then
			print("logi")
		end
    end, 'POST', json.encode({username = n, embeds = co}), { ['Content-Type'] = 'application/json'})
end