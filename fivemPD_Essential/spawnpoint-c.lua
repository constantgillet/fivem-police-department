AddEventHandler("playerSpawned", function()

    -- Give the basic player model
    local model = GetHashKey("mp_m_freemode_01")

    RequestModel(model)

    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end

    SetPlayerModel(PlayerId(), model) 
    SetModelAsNoLongerNeeded(model)

    SetPedDefaultComponentVariation(GetPlayerPed(PlayerId()))

    StartPlayerTeleport(PlayerId(), -220.98, -1080.87, 29.29, 77, true, true, true)
end)