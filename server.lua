ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('licenses:checkjob', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.job.name)

end)


--WEAPON
RegisterNetEvent('cte_license:giveLicenseServer')
AddEventHandler('cte_license:giveLicenseServer', function(input, licensetype)
    local xPlayerTarget = ESX.GetPlayerFromId(input)
    if xPlayerTarget ~= nil then
        local owner = xPlayerTarget.identifier
        local type = licensetype
        MySQL.insert('INSERT INTO user_licenses (type, owner) VALUES (?, ?)', {
            type,
            owner
        })
        TriggerClientEvent('esx:showNotification', input, 'You have ~g~ receive~s~ an '.. licensetype .. ' license!')
        TriggerClientEvent('esx:showNotification', source, 'You ~g~succesfully gave ~s~ a ' .. licensetype .. ' license to Player with ~g~ID:' .. input .. '')
    else
        TriggerClientEvent('esx:showNotification', source, 'This Player is ~r~ not online!')
    end
end)

RegisterNetEvent('cte_license:removeLicenseServer')
AddEventHandler('cte_license:removeLicenseServer', function(input, licensetype)
    local xPlayerTarget = ESX.GetPlayerFromId(input)
    if xPlayerTarget ~= nil then
        local owner = xPlayerTarget.identifier
        local type = licensetype
        MySQL.update('DELETE FROM user_licenses WHERE type = ? AND owner = ?', {
            type,
            owner
        })
        TriggerClientEvent('esx:showNotification', input, 'Your ' .. licensetype .. ' license has bean ~r~ revoked!')
        TriggerClientEvent('esx:showNotification', source, 'You ~g~ succesfully ~s~ ~r~ revoked~s~ ' .. licensetype .. ' license from Player with ~g~ID:' .. input .. '')
    else
        TriggerClientEvent('esx:showNotification', source, 'This Player is ~r~ not online!')
    end
end)