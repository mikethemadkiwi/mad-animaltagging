RegisterNetEvent('mad-animatagging:ReviveData', function(ReviveData)
    local pSrc = source
    local ReviveData = ReviveData
    local reviveUpdate = ServerAnimalRevive(ReviveData)
    TriggerClientEvent('mad-animatagging:Revived', pSrc, reviveUpdate)
    if debugServerShow then
        print('ReviveData', pSrc, ReviveData, reviveUpdate)  
    end
end)
--
RegisterNetEvent('mad-animatagging:SampleData', function(SampleData)
    local pSrc = source
    local SampleData = SampleData
    local invUpdate = ServerInventoryAdd(SampleData)
    TriggerClientEvent('mad-animatagging:Sampled', pSrc, invUpdate)
    if debugServerShow then
        print('SampleData', pSrc, SampleData, invUpdate) 
    end
end)