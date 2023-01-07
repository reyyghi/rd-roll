ESX = exports.es_extended:getSharedObject()

RegisterNetEvent("rolldadu", function (angka)
    local angka = math.random(1, angka)
    DiceRollAnimation()

    exports.mythic_notify:DoLongHudText("inform", "Kamu mendapatkan angka "..angka)

    ShowRoll("Roll: " ..angka, PlayerPedId(), 5, GetEntityCoords(PlayerPedId()))
end)


function DiceRollAnimation()
    RequestAnimDict("anim@mp_player_intcelebrationmale@wank") --Request animation dict.

    while (not HasAnimDictLoaded("anim@mp_player_intcelebrationmale@wank")) do --Waits till it has been loaded.
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intcelebrationmale@wank" ,"wank" ,8.0, -8.0, -1, 49, 0, false, false, false ) --Plays the animation.
    Citizen.Wait(2400)
    ClearPedTasks(PlayerPedId())
end

function DrawText3D(x,y,z, text) --Just a simple generic 3d text function. Copy pasted from my own core.
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
      end
end


function ShowRoll(text, sourceId, maxDistance, location)
	local coords = GetEntityCoords(PlayerPedId(), false) --Gets client's current coords.
	local dist = #(location - coords) --Finds the distance between the location of the current rolldice and client's current coords. THIS CHECKS FOR ALL X,Y,Z.

	if dist < maxDistance then --If distance is smaller than 15 then trigger the code below.
		local display = true
		
		Citizen.CreateThread(function() --We use this citizen create thead because we want it to run simultaneously with the draw text 3d below. Normal function won't work. Either this method or trigger events.
			Wait(5 * 1000) --Waits the amount of seconds set from the config.
			display = false
		end)
		
		Citizen.CreateThread(function()
			serverPed = sourceId --Gets the roller's server ped. We use this method because we want it to also be oncesync combatible.
			while display do
				Wait(7)
                local currentCoords = GetEntityCoords(serverPed) --Finds the coords of the roller's ped.

				DrawText3D(currentCoords.x, currentCoords.y, currentCoords.z + 1.2 - 1.25, text) --Prints the 3d text at the current coords of the roller's ped.
            end
		end)

	end
end