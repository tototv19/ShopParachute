ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('tototv:giveparachute')
AddEventHandler('tototv:giveparachute', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 1000
    local xMoney = xPlayer.getMoney()

    if xPlayer.hasWeapon('GADGET_PARACHUTE') then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous avez déja un parachute sur vous.")
    else
    if xMoney >= price then

        xPlayer.removeMoney(price)
        xPlayer.addWeapon('GADGET_PARACHUTE', 42)
        TriggerClientEvent('esx:showNotification', source, "~g~Parachute obtenue ! ~w~1000$")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent")
    end
    end
end)

    

    