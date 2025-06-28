RegisterNetEvent('whitelist:checkVehicle')
AddEventHandler('whitelist:checkVehicle', function(vehicleNet, vehName)
    local src = source
    local acePerm = Config.VehicleWhitelist[vehName]
    if not acePerm then return end

    if not IsPlayerAceAllowed(src, acePerm) then
        TriggerClientEvent('whitelist:deleteVehicle', src, vehicleNet)
    end
end)
