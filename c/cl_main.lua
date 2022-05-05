reppuselas = false
ESX = nil

CreateThread(function()
    while ESX == nil do
        Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent('esx_pommireppu:kayta')
AddEventHandler('esx_pommireppu:kayta', function()
    reppuselas = true
    TriggerEvent('ReppuSelkaan')
end)

CreateThread(function()
    local odotus = 1000
    while true do
        if reppuselas then
            odotus = 1
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            ESX.ShowHelpNotification("Paina...\n ~INPUT_VEH_HEADLIGHT~ Räjäyttääksesi\n ~INPUT_MP_TEXT_CHAT_TEAM~ Riisuaksesi")
            if IsControlJustPressed(0,74) then
                TriggerServerEvent('esx_pommireppu:SusImposter', pos.x, pos.y, pos.z)
                local rajahdus = 0
                CreateThread(function()
                    while rajahdus < 3 do
                        if rajahdus == 0 then
                            Wait(math.random(200, 700))
                            local pos2 = GetEntityCoords(ped)
                            AddExplosion(pos2.x, pos2.y, pos2.z, 32, 5.0, true, false, 1.0, false)
                        else
                            AddExplosion(pos.x + math.random(-1, 1), pos.y + math.random(-1, 1), pos.z, 32, 5.0, true, false, 1.0, false)
                        end
                        rajahdus = rajahdus + 1
                        Citizen.Wait(500)
                    end
                end)
                TriggerEvent('ReppuSelast')
                reppuselas = false
                odotus = 1000
            end
            if IsControlJustPressed(0,246) then
                TriggerEvent('ReppuSelast')
                TriggerServerEvent('esx_pommireppu:ReppuTakas')
                reppuselas = false
                odotus = 1000
            end
        end
        Citizen.Wait(odotus)
    end
end)

RegisterNetEvent('ReppuSelkaan')
AddEventHandler('ReppuSelkaan', function()
    Citizen.Wait(200)
    TriggerEvent('skinchanger:getSkin', function(skin)
        local skin = skin
        if skin.sex == 1 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Reppu.Naiset)
        end
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, Config.Reppu.Miehet)
        end
    end)
end)

RegisterNetEvent('ReppuSelast')
AddEventHandler('ReppuSelast', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 1 then
            local clothesSkin = {
            ['bags_1']  = 0,  ['bags_2']  = 0,
            } 
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        elseif skin.sex == 0 then
            local clothesSkin = {
            ['bags_1']  = 0,  ['bags_2']  = 0,
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        end
    end)
end)