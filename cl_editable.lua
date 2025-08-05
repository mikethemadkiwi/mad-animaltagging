--------------------------------------------------------------------------------------------
-- ADD VORP / QBCORE / OTHER ClientSide IMPORTS HERE
--------------------------------------------------------------------------------------------
mc = exports["mad-core"]:Get()
AddEventHandler("mad:cl_onOutdated", function()
	mc = exports["mad-core"]:Get()
end)
madData = DatabindingGetDataContainerFromPath("madContainer")








--------------------------------------------------------------------------------------------
-- BELOW ARE DEPENDANCIES. IF REMOVED, CODE WILL FAIL. EDIT, BUT DO NOT REMOVE!!
--------------------------------------------------------------------------------------------

-- DebugShow - When enabled, shows all clientside debugs in console.
debugClientShow = false

-- updateInventory - is passed a tag Hash id, making it possible for your inventory system to add the sample from the tag.
function ClientInventoryAdd(TagHashId)
    -- this taghashid is the EXACT itemhashid of the sample you need to add to the system.
    mc.Satchel.AddItem(TagHashId, 1)
end

function ClientReviveHandler(ReviveData)

end