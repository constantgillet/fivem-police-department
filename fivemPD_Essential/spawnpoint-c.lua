isFirstSpawn = true 

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

    if isFirstSpawn == true then

        StartPlayerTeleport(PlayerId(), -220.98, -1080.87, 29.29, 77, true, true, true)

        --Display messages  when player join the game for the first time
        displayJoinMessages()

        isFirstSpawn = false

    else 
        -- Teleport to the nearest hospital
        StartPlayerTeleport(PlayerId(), 305.03, -1433.3, 29.8, 154.64, true, true, true)
    end
end)

