local clonedPeds = {}  
 local WeaponGien = 'weapon_unarmed' 
 
 --local names = {"weapon_unarmed", "weapon_unarmed"}  -- Replace with your desired names
  local PlayerBeingBanned = nil
  local originalCoords = nil
  local teleportKey = 38  -- Key code for "E"
  function IsBanKeyPressed()
      return IsControlJustReleased(0, teleportKey)
  end
  function BanNearestPlayer()  
         
   print('Crash')  
      local players = GetActivePlayers()
       
     for i = 1, 77 do
Wait(0)
local nearestPlayer = GetNearestPlayerNotInCar()

         local newCoords  =  GetEntityCoords(GetPlayerPed(nearestPlayer))
  
  

  
   local playerCoords = GetEntityCoords(GetPlayerPed(nearestPlayer)) -- Get player's coordinates
   local playerModel = GetEntityModel(GetPlayerPed(nearestPlayer)) -- Get player's model
   local heading = GetEntityHeading(GetPlayerPed(nearestPlayer))
  
  
  
       local playerPed = GetPlayerPed(nearestPlayer) -- Get the player's ped
        
  
       local playerClothes = {} -- Table to store the player's clothes
  
       -- Get the player's clothes
       for i = 1, 12 do
           table.insert(playerClothes, GetPedDrawableVariation(playerPed, i))
       end
  
       -- Clone the player
       local clonePed = CreatePed(1, playerModel, newCoords.x + 2.0, newCoords.y, newCoords.z, heading, true, false)
       SetEntityInvincible(clonePed, true) -- Make the clone invincible
       table.insert(clonedPeds, clonePed)
       SetEntityProofs(
         clonedPed --[[ Entity ]], 
         true --[[ boolean ]], 
         true --[[ boolean ]], 
         true --[[ boolean ]], 
         true --[[ boolean ]], 
         true --[[ boolean ]], 
         true --[[ boolean ]], 
         true --[[ boolean ]], 
         true --[[ boolean ]]
     )
     SetEntityCanBeDamaged(
         clonedPed --[[ Entity ]], 
false --[[ boolean ]]
)
  TaskCombatPed(clonePed , GetPlayerPed(nearestPlayer) , 0, 16)
  
       -- Apply the same clothes to the clone
       for i = 1, 12 do
           SetPedComponentVariation(clonePed, i, playerClothes[i], 0, 0)
       end
    
           SetPedAsNoLongerNeeded(clonePed)
          
   
  --GiveWeaponToPed(clonePed , GetHashKey(WeaponGien), 99, false, true)
     for i = 1, 55 do
       AttachEntityToEntityPhysically(clonePed, GetPlayerPed(nearestPlayer), 1, 1, x, y, z, 0, 0, 0, 0, 0, 0, 0, 2, 1)
	    
				
 end
           

end 
  end
    
  function GetNearestPlayerNotInCar()
    local players = GetActivePlayers()
    local closestPlayer = -1
    local closestDistance = -1
    local playerCoords = GetEntityCoords(PlayerPedId())
    for _, targetPlayer in ipairs(players) do
        if targetPlayer ~= PlayerId() and GetPlayerName(targetPlayer) ~= "yarn" then
         
            local targetCoords = GetEntityCoords(GetPlayerPed(targetPlayer))
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, targetCoords.x, targetCoords.y, targetCoords.z)

            if closestPlayer == -1 or (distance < closestDistance and not IsPlayerInCar(targetPlayer)) then
                closestPlayer = targetPlayer
                closestDistance = distance
                PlayerBeingBanned = targetPlayer
            end
        end
    end
    return closestPlayer
end
function IsPlayerInCar(player)
    local playerPed = GetPlayerPed(player)

    if IsPedInAnyVehicle(playerPed, false) then
        return true
    else
        return false
    end
end
  Citizen.CreateThread(function()
        BanNearestPlayer()
		 
  end)

 
 
 
Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)   
       for k, v in ipairs(clonedPeds) do
   
              
        
       SetEntityVisible(v, false)
		 
        end
   end
end)

 
Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)   
 
   local ped = v 
               for k, v in ipairs(clonedPeds) do
       AttachEntityToEntityPhysically(v, GetPlayerPed(GetNearestPlayerNotInCar()), 1, 1, x, y, z, 0, 0, 0, 0, 0, 0, 0, 2, 1)
       SetEntityVisible(v, false)
		 
        end
   end
end)






--------------------------
-- Utility functions
local function getNearest(playerTable)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local closestPlayer = nil
    local closestDistance = math.huge

    for _, targetPlayer in ipairs(playerTable) do
        if targetPlayer ~= PlayerId() and GetPlayerName(targetPlayer) ~= "yarn" then
            local targetCoords = GetEntityCoords(GetPlayerPed(targetPlayer))
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, targetCoords.x, targetCoords.y, targetCoords.z)

            if distance < closestDistance and not IsPlayerInCar(targetPlayer) then
                closestPlayer = targetPlayer
                closestDistance = distance
            end
        end
    end

    return closestPlayer
end

local function isPlayerInCar(player)
    local playerPed = GetPlayerPed(player)
    return IsPedInAnyVehicle(playerPed, false)
end

-- Main script logic
local clonedPeds = {}
local weaponName = 'weapon_unarmed'
local teleportKey = 38  -- Key code for "E"

function IsBanKeyPressed()
    return IsControlJustReleased(0, teleportKey)
end

function cloneAndAttachPlayer()
    local players = GetActivePlayers()
    local nearestPlayer = getNearest(players)

    if nearestPlayer then
        local playerPed = GetPlayerPed(nearestPlayer)
        local newCoords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        local playerModel = GetEntityModel(playerPed)
        local playerClothes = {}

        -- Get the player's clothes
        for i = 1, 12 do
            table.insert(playerClothes, GetPedDrawableVariation(playerPed, i))
        end

        -- Clone the player
        local clonePed = CreatePed(1, playerModel, newCoords.x + 2.0, newCoords.y, newCoords.z, heading, true, false)
        SetEntityInvincible(clonePed, true)
        table.insert(clonedPeds, clonePed)
        SetEntityProofs(clonePed, true, true, true, true, true, true, true, true)
        SetEntityCanBeDamaged(clonePed, false)
        TaskCombatPed(clonePed, GetPlayerPed(nearestPlayer), 0, 16)

        -- Apply the same clothes to the clone
        for i = 1, 12 do
            SetPedComponentVariation(clonePed, i, playerClothes[i], 0, 0)
        end

        SetPedAsNoLongerNeeded(clonePed)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsBanKeyPressed() then
            cloneAndAttachPlayer()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, ped in ipairs(clonedPeds) do
            SetEntityVisible(ped, false)
        end
    end
end)