CreateThread(function()
    while true do
        Wait(500)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local model = GetEntityModel(vehicle)
                local name = GetDisplayNameFromVehicleModel(model):lower()
                local netId = NetworkGetNetworkIdFromEntity(vehicle)
                TriggerServerEvent('whitelist:checkVehicle', netId, name)
                Wait(5000) -- wait before checking again
            end
        else
            Wait(1000)
        end
    end
end)

RegisterNetEvent('whitelist:deleteVehicle')
AddEventHandler('whitelist:deleteVehicle', function(vehicleNet)
    local veh = NetworkGetEntityFromNetworkId(vehicleNet)
    if veh and DoesEntityExist(veh) then
        TaskLeaveVehicle(PlayerPedId(), veh, 0)
        Wait(100)
        SetEntityAsMissionEntity(veh, true, true)
        DeleteVehicle(veh)
        TriggerEvent('chat:addMessage', {
            args = { "[VehicleWhitelist]", "You are not authorized to use this vehicle. It has been removed." }
        })
    end
end)
