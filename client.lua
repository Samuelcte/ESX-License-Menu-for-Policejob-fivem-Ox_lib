ESX = exports["es_extended"]:getSharedObject()

if Config.Computer == true then
    Citizen.CreateThread(function()
        while true do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local dist = GetDistanceBetweenCoords(playerCoords, Config.Computerlocation.x, Config.Computerlocation.y, Config.Computerlocation.z, true)

            if dist < 1.5 then
                DrawText3DTest(Config.Computerlocation.x, Config.Computerlocation.y, Config.Computerlocation.z + 0.3, 'Press [' .. Config.Opencomputerkeyinfobar .. ']~s~ to open license system')
                if IsControlJustReleased(0, Config.Opencomputerkey) then
                    ESX.TriggerServerCallback('licenses:checkjob', function(jobname) 
                        if jobname == Config.Job then
                            openMenu()
                        else
                            ESX.ShowNotification('You are ~r~ not ~s~ an Police Officer!')
                        end
                    end)
                end
            end
            Citizen.Wait(1)
        end
    end)
end



if Config.Command == true then
    RegisterCommand(Config.Commandname, function(source, args)

        ESX.TriggerServerCallback('licenses:checkjob', function(jobname) 
            if jobname == Config.Job then
                openMenu()
            else
                ESX.ShowNotification('You are ~r~ not ~s~ an Police Officer!')
            end
        end)
    end)
end

function openMenu()
    lib.registerContext({
        id = 'mainMenu',
        title = 'License System',
        options = {
            {title = 'Weapon License', icon = 'fa-gun', event = 'cte_license:weaponmenu'},
            {title = 'Car Driver License', icon = 'fa-car', event = 'cte_license:carmenu'},
            {title = 'Bike Driver License', icon = 'fa-motorcycle', event = 'cte_license:bikemenu'},
            {title = 'Truck Driver License', icon = 'fa-truck', event = 'cte_license:truckmenu'},
            {title = 'DMV School Theory Test License', icon = 'fa-book', event = 'cte_license:theorymenu'},
        }
    })

    lib.showContext('mainMenu')
end

-- Weapon Menu
RegisterNetEvent('cte_license:weaponmenu')
AddEventHandler('cte_license:weaponmenu', function()
    lib.registerContext({
        id = 'weaponMenu',
        title = 'Weapon License',
        options = {
            {title = 'Give Weapon License', icon = 'fa-user-check', event = 'cte_license:giveLicense', args = 'weapon'},
            {title = 'Revoke Weapon License', icon = 'fa-user-xmark', event= 'cte_license:removeLicense', args = 'weapon'}
        }
    })
    lib.showContext('weaponMenu')
end)

-- Car Menu
RegisterNetEvent('cte_license:carmenu')
AddEventHandler('cte_license:carmenu', function()
    lib.registerContext({
        id = 'carMenu',
        title = 'Car Driving License',
        options = {
            {title = 'Give Car Driving License', icon = 'fa-user-check', event = 'cte_license:giveLicense', args = 'drive'},
            {title = 'Revoke Car Driving License', icon = 'fa-user-xmark', event = 'cte_license:removeLicense', args = 'drive'}
        }
    })
    lib.showContext('carMenu')
end)

-- Bike Menu
RegisterNetEvent('cte_license:bikemenu')
AddEventHandler('cte_license:bikemenu', function()
    lib.registerContext({
        id = 'bikeMenu',
        title = 'Bike Driving License',
        options = {
            {title = 'Give Bike Driving License', icon = 'fa-user-check', event = 'cte_license:giveLicense', args = 'drive_bike'},
            {title = 'Revoke Bike Driving License', icon = 'fa-user-xmark', event = 'cte_license:removeLicense', args = 'drive_bike'}
        }
    })
    lib.showContext('bikeMenu')
end)

-- Truck Menu
RegisterNetEvent('cte_license:truckmenu')
AddEventHandler('cte_license:truckmenu', function()
    lib.registerContext({
        id = 'truckMenu',
        title = 'Truck Driving License',
        options = {
            {title = 'Give Truck Driving License', icon = 'fa-user-check', event = 'cte_license:giveLicense', args = 'drive_truck'},
            {title = 'Revoke Truck Driving License', icon = 'fa-user-xmark', event = 'cte_license:removeLicense', args = 'drive_truck'}
        }
    })
    lib.showContext('truckMenu')
end)

-- Theory Menu
RegisterNetEvent('cte_license:theorymenu')
AddEventHandler('cte_license:theorymenu', function()
    lib.registerContext({
        id = 'theoryMenu',
        title = 'DMV School Theory Test License',
        options = {
            {title = 'Give DMV Theory Test License', icon = 'fa-user-check', event = 'cte_license:giveLicense', args = 'dmv'},
            {title = 'Revoke DMV Theory Test License', icon = 'fa-user-xmark', event = 'cte_license:removeLicense', args = 'dmv'}
        }
    })
    lib.showContext('theoryMenu')
end)

-- General Events Give/Remove
RegisterNetEvent('cte_license:giveLicense')
AddEventHandler('cte_license:giveLicense', function(licensetype)
    input = lib.inputDialog('Give ' .. licensetype .. ' License', {
        {type = 'input', label = 'Player ID', icon = 'fa-user'}
    })
    if input ~= nil then
    input = tonumber(input[1])
        TriggerServerEvent('cte_license:giveLicenseServer', input, licensetype)
    else
        ESX.ShowNotification('Invalid ID')
    end
end)

RegisterNetEvent('cte_license:removeLicense')
AddEventHandler('cte_license:removeLicense', function(licensetype)
    input = lib.inputDialog('Revoke ' .. licensetype .. ' License', {
        {type = 'input', label = 'Player ID', icon = 'fa-user'}
    })
    if input ~= nil then
    input = tonumber(input[1])
        TriggerServerEvent('cte_license:removeLicenseServer', input, licensetype)
    else
        ESX.ShowNotification('Invalid ID')
    end
end)









function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
    -- AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
    -- DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
    -- while (UpdateOnscreenKeyboard() == 0) do
    --  DisableAllControlActions(0);
    --  Wait(0);
    -- end
    -- if (GetOnscreenKeyboardResult()) then
    --  local displayResult = GetOnscreenKeyboardResult()
    --  return displayResult
    -- end
    local input = lib.inputDialog('Player ID', {
        {type = 'input', label = 'Player ID'}
    })
    if input == nil then
        return nil
    else
        return input[1]
    end
end


function showInfoBar(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function DrawText3DTest(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.2, 0.2)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end