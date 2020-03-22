function displayJoinMessages()
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        notify("Welcome to fivem PD")
        Citizen.Wait(1000)
        notify("This gamemod is in development")
    end)  
end