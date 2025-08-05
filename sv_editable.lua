--------------------------------------------------------------------------------------------
-- ADD VORP / QBCORE / OTHER ServerSide IMPORTS HERE
--------------------------------------------------------------------------------------------








--------------------------------------------------------------------------------------------
-- BELOW ARE DEPENDANCIES. IF REMOVED, CODE WILL FAIL. EDIT, BUT DO NOT REMOVE!!
--------------------------------------------------------------------------------------------

-- debugServerShow - When enabled, shows all serverside debugs in console.
debugServerShow = false

-- ServerInventoryAdd - is passed a tag Hash id, making it possible for your inventory system to add the sample from the tag.
function ServerInventoryAdd(TagHashId)
    local addedSampleId = TagHashId
    -- if farts are blue  then send this instead return fart sampleid
    return addedSampleId -- reuturns the information that you want going to the client when the inventory udpates.
end
--
function ServerAnimalRevive(ReviveData)
    local updatedData = ReviveData
    --technically set honor level here.

    return updatedData
end