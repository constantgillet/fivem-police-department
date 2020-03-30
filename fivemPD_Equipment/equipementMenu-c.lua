-- Script inspired of https://github.com/DeVerino-DVR, Thanks
_menuPool = NativeUI.CreatePool()
equimentMenu = NativeUI.CreateMenu("Equipment", "~b~Police equipment")
_menuPool:Add(equimentMenu)

-- Add Equipments to the menu function
function addEquipmentList(menu)
    local outfitsSubMenu = _menuPool:AddSubMenu(menu,"~b~Outfits","~w~Outfits list")

    for _, outfit in pairs(Config.Outfits) do
        local outfitItem = NativeUI.CreateItem(outfit.Label, "")
        outfitsSubMenu:AddItem(outfitItem)
        
        outfitsSubMenu.OnItemSelect = function(_, _, index)
            setCopOutfit(Config.Outfits[index].Model)
        end
    end

    local armourCheckbox = NativeUI.CreateCheckboxItem("Body armour", bool, "Toggle this item")
    menu:AddItem(armourCheckbox)
    menu.OnCheckboxChange = function (sender, item, checked_)
        
        -- check if what changed is from this menu
        if item == armourCheckbox then
            bool = checked_

            if bool == true then
                toggleBodyArmour(true)
            else
                toggleBodyArmour(false)
            end
        end
    end
end

equipments = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
}

-- Ped variation menu
function addVariationList(menu)
    local pedVariationSubMenu = _menuPool:AddSubMenu(menu, "Equipment variation","~w~Equipment variation list")

    local element1List = NativeUI.CreateListItem("Element 1", equipments, 1)
    pedVariationSubMenu:AddItem(element1List)

    local element2List = NativeUI.CreateListItem("Element 2", equipments, 1)
    pedVariationSubMenu:AddItem(element2List)

    local element3List = NativeUI.CreateListItem("Element 3", equipments, 1)
    pedVariationSubMenu:AddItem(element3List)

    local element4List = NativeUI.CreateListItem("Element 4", equipments, 1)
    pedVariationSubMenu:AddItem(element4List)

    local element5List = NativeUI.CreateListItem("Element 5", equipments, 1)
    pedVariationSubMenu:AddItem(element5List)

    local element6List = NativeUI.CreateListItem("Element 6", equipments, 1)
    pedVariationSubMenu:AddItem(element6List)

    local element7List = NativeUI.CreateListItem("Element 7", equipments, 1)
    pedVariationSubMenu:AddItem(element7List)

    local element8List = NativeUI.CreateListItem("Element 8", equipments, 1)
    pedVariationSubMenu:AddItem(element8List)

    local element9List = NativeUI.CreateListItem("Element 9", equipments, 1)
    pedVariationSubMenu:AddItem(element9List)

    local element10List = NativeUI.CreateListItem("Element 10", equipments, 1)
    pedVariationSubMenu:AddItem(element10List)

    local element11List = NativeUI.CreateListItem("Element 11", equipments, 1)
    pedVariationSubMenu:AddItem(element11List)

    pedVariationSubMenu.OnListSelect = function(sender, item, index)
        if item == element1List then
            SetPedComponentVariation(PlayerPedId(), 1, index-1, 0, 0)  
        elseif item == element2List then
            SetPedComponentVariation(PlayerPedId(), 2, index-1, 0, 0)
        elseif item == element3List then
            SetPedComponentVariation(PlayerPedId(), 3, index-1, 0, 0)
        elseif item == element4List then
            SetPedComponentVariation(PlayerPedId(), 4, index-1, 0, 0)
        elseif item == element5List then
            SetPedComponentVariation(PlayerPedId(), 5, index-1, 0, 0)
        elseif item == element6List then
            SetPedComponentVariation(PlayerPedId(), 6, index-1, 0, 0)
        elseif item == element7List then
            SetPedComponentVariation(PlayerPedId(), 7, index-1, 0, 0)
        elseif item == element8List then
            SetPedComponentVariation(PlayerPedId(), 8, index-1, 0, 0)
        elseif item == element9List then
            SetPedComponentVariation(PlayerPedId(), 9, index-1, 0, 0)
        elseif item == element10List then
            SetPedComponentVariation(PlayerPedId(), 10, index-1, 0, 0)
        elseif item == element11List then
            SetPedComponentVariation(PlayerPedId(), 11, index-1, 0, 0)
        end
    end
end


addEquipmentList(equimentMenu)
addVariationList(equimentMenu)
_menuPool:RefreshIndex()

-- Display Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for k, equipmentMarker in pairs(Config.EquipmentMarkers) do
			if (GetDistanceBetweenCoords(coords, equipmentMarker.x, equipmentMarker.y, equipmentMarker.z, true) < 100) then
				DrawMarker(1, equipmentMarker.x, equipmentMarker.y, equipmentMarker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, false, false, false)	
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

        for k,equipmentMarker in pairs(Config.EquipmentMarkers) do

            if (GetDistanceBetweenCoords(coords, equipmentMarker.x, equipmentMarker.y, equipmentMarker.z, true) < 3) then

                -- If E is pressed
                if IsControlJustPressed(1, 51) then
                    equimentMenu:Visible(not equimentMenu:Visible())
                end
            end  
        end
    end
end)

--Function to add or remove armour to the plaeyr
function toggleBodyArmour(bool)

    playerPed = PlayerPedId()

    if bool == true then
        AddArmourToPed(playerPed, 100)
        SetPedArmour(playerPed, 100)
        SetPedComponentVariation(GetPlayerPed(-1), 9, 27, 9, 2)
        notify("You got a ~b~bullet proof")
    else
        SetPedArmour(playerPed, 0)
        notify("You removed your ~b~bullet proof")
    end
end

function setCopOutfit(model)
    modelHash = GetHashKey(model)

	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		Citizen.Wait(0)
    end
    
    SetPlayerModel(PlayerId(), modelHash)
end