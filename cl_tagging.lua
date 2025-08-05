------
samplestore = {}
sampleitems = {}
sampletimers = {}
------
RegisterNetEvent("mad-animatagging:Revived")
AddEventHandler("mad-animatagging:Revived", function(ReviveData)
	ClientReviveHandler(ReviveData)
	if debugClientShow then
		print(ReviveData)
	end
end)
------
RegisterNetEvent("mad-animatagging:Sampled")
AddEventHandler("mad-animatagging:Sampled", function(SampleData)
	ClientInventoryAdd(SampleData)
	if debugClientShow then
		print(SampleData)
	end
end)
------
function CleaupTranq(animalID)
	PromptSetVisible(samplestore[animalID], false)
	sampletimers[animalID] = nil
end
------
function CheckPedIsNet(animalID)
	repeat
		NetworkRegisterEntityAsNetworked(animalID) -- register entity to be networked again
		Wait(100)
	until NetworkDoesNetworkIdExist(NetworkGetNetworkIdFromEntity(animalID)) -- wait until it is	
	if debugClientShow then
		print(NetworkGetNetworkIdFromEntity(animalID), "netID Registered for Sampled Ped")
	end
end
------
function startTranq(animalID)
	if not UiPromptIsValid(samplestore[animalID]) then
		if debugClientShow then
			print('No Prompt exists for Sampled Entity, Creating.')
		end
		local itemretval = CompendiumAnimalGetSampleInventoryItem(CompendiumGetEntryByPedIndex(GetHashKey("ANIMALS"), animalID))
		local animalpromptgroup = UiPromptGetGroupIdForTargetEntity(animalID)
		Citizen.CreateThread(function()
			sampletimers[animalID] = GetGameTimer()
			promptString = CreateVarString(10, 'LITERAL_STRING', 'Take Sample')
			samplestore[animalID] = PromptRegisterBegin()
			PromptSetControlAction(samplestore[animalID], 0x956C2A0E)
			PromptSetText(samplestore[animalID], promptString)
			PromptSetEnabled(samplestore[animalID], true)
			PromptSetVisible(samplestore[animalID], false)
			PromptSetHoldMode(samplestore[animalID], 4000)
			PromptSetGroup(samplestore[animalID], animalpromptgroup)
			PromptRegisterEnd(samplestore[animalID])
			if debugClientShow then
				print('inserted "sample" prompt:', samplestore[animalID], 'to prompt attached to entity:', animalID)
			end
		end)
	end
end
------
function endTranq(animalID)
	SetPedConfigFlag(animalID, 580, 0)
	ClearPedTasks(animalID, 1, 0)
	ClearPedSecondaryTask(animalID)
	ClearPedTasksImmediately(animalID)
	local animalcoords = GetEntityCoords(animalID)
	TaskFleeCoord(animalID, animalcoords.x+100, animalcoords.y+100, animalcoords.z, 2, 0, -1.0, 5000, 0)
	CleaupTranq(animalID)
	if debugClientShow then
		print('End Tranq Cleanup', animalID)
	end
end
------
Citizen.CreateThread(function()
	while true do
		local gamePool = GetGamePool("CPed")
		local coords = GetEntityCoords(PlayerPedId())
		for _, aminal in ipairs(gamePool) do
			if not IsPedAPlayer(aminal) then -- dont include players
				if DoesEntityExist(aminal) then
					if IsEntityDead(aminal) then
						SetPedConfigFlag(aminal, 580, 0)
						if samplestore[aminal] ~= nil then
							PromptDelete(samplestore[aminal])
							samplestore[aminal] = nil
						end
						CleaupTranq(aminal)
					else						
						-- if UnlockIsUnlocked(-1153255129) then -- also maybe 273608212 inventory check for sample satchel
							if GetPedConfigFlag(aminal, 580, 1) then
								if sampletimers[aminal] == nil then									
									CheckPedIsNet(aminal)
									startTranq(aminal)
								end
							end
						-- end	
					end
				else
					CleaupTranq(aminal)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
------
Citizen.CreateThread(function()
	while true do
		for animalID, animalPrompt in pairs(samplestore) do
			--clamp fake dialogue to 1m radius
			local playerCoords = GetEntityCoords(PlayerPedId())			
			local animalcoords = GetEntityCoords(animalID)
			local distaTween = Vdist(animalcoords.x, animalcoords.y, animalcoords.z, playerCoords.x, playerCoords.y, playerCoords.z)
			if distaTween < 2.0 then
				PromptSetVisible(samplestore[animalID], true)
			else				
				PromptSetVisible(samplestore[animalID], false)
			end
			--- check player has completed the tagging prompt
			local completedP = UiPromptHasHoldModeCompleted(animalPrompt)
			if completedP then
				local itemretval = CompendiumAnimalGetSampleInventoryItem(CompendiumGetEntryByPedIndex(GetHashKey("ANIMALS"), animalID))
				TriggerServerEvent('mad-animatagging:SampleData', itemretval)
				UiPromptSetEnabled(animalPrompt, 0)
				UiPromptSetVisible(animalPrompt, 0)
				StatAddAnimalSampleTarget(GetPedAnimalType(animalID))
				SetPedQuality(animalID, -1)
				print(GetPedQuality(animalID))
				if debugClientShow then
					print('sampling complete, disabling prompt:', animalPrompt, 'Item Provided:', itemretval)
				end
			end
		end
        -- 
        local now = GetGameTimer()
		for animalID, animalSedatedAt in pairs(sampletimers) do
            local timediff = now - animalSedatedAt
            if timediff > 90000 then
				if debugClientShow then
					print('Tranq on animal Ended', animalID, timediff)
				end
				endTranq(animalID)
            end
        end
        Citizen.Wait(0)
    end
end)