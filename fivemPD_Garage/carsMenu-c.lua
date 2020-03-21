-- Script inspired of https://github.com/DeVerino-DVR, Thanks
_menuPool = NativeUI.CreatePool()
carsGarageMenu = NativeUI.CreateMenu("Garage", "~b~Police Garage")
_menuPool:Add(carsGarageMenu)

-- Add cars to the menu function
function addCarList(menu)
    local carsubmenu = _menuPool:AddSubMenu(menu,"~b~Vehicules","~w~Vehicle list")

    for _, vehicles in pairs(Config.Vehicles) do
        local vehicleItem = NativeUI.CreateItem(vehicles.Label, "")
        carsubmenu:AddItem(vehicleItem)
        
        carsubmenu.OnItemSelect = function(_, _, index)
            spawnCar(Config.Vehicles[index].Hash)
        end
    end
end

addCarList(carsGarageMenu)
_menuPool:RefreshIndex()

-- Display Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for k,v in pairs(Config.PoliceCarGarages) do
			if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < 100) then
				DrawMarker(1, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

        local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

        for k,v in pairs(Config.PoliceCarGarages) do

            if (GetDistanceBetweenCoords(coords, v.GaragePoint.x, v.GaragePoint.y, v.GaragePoint.z, true) < 3) then

                -- If E is pressed
                if IsControlJustPressed(1, 51) then
                    carsGarageMenu:Visible(not carsGarageMenu:Visible())
                end
            end  
        end
    end
end)

--Function to Spawn a car
function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local vehicle = CreateVehicle(car, 442.81, -1019.61, 28.24, 90.89, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleNumberPlateText(vehicle, "LSPD911")
end