-- Script inspired of https://github.com/DeVerino-DVR, Thanks
_menuPool = NativeUI.CreatePool()
armoryMenu = NativeUI.CreateMenu("Armory", "~b~Police Armory")
_menuPool:Add(armoryMenu)

-- Add weapons to the menu function
function addWeaponList(menu)
    local armorySubMenu = _menuPool:AddSubMenu(menu,"~b~Weapons","~w~Weapon list")

    for _, weapon in pairs(Config.Weapons) do
        local weaponItem = NativeUI.CreateItem(weapon.Label, "")
        armorySubMenu:AddItem(weaponItem)
        
        armorySubMenu.OnItemSelect = function(_, _, index)
            giveWeapon(Config.Weapons[index].Hash, Config.Weapons[index].Ammo)
        end
    end
end

addWeaponList(armoryMenu)
_menuPool:RefreshIndex()

-- Display Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for k,armory in pairs(Config.PoliceArmories) do
			if (GetDistanceBetweenCoords(coords, armory.x, armory.y, armory.z, true) < 100) then
				DrawMarker(1, armory.x, armory.y, armory.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
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

        for k,armory in pairs(Config.PoliceArmories) do

            if (GetDistanceBetweenCoords(coords, armory.x, armory.y, armory.z, true) < 3) then

                -- If E is pressed
                if IsControlJustPressed(1, 51) then
                    armoryMenu:Visible(not armoryMenu:Visible())
                end
            end  
        end
    end
end)

--Function to give a weapon
function giveWeapon(weaponModel, ammo)
    local weaponModel = GetHashKey(weaponModel)

    GiveWeaponToPed(PlayerPedId(), weaponModel, ammo, false, true)
    PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
end