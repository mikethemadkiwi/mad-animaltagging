# mad-animaltagging
RDO replication of the animal tagging system.  
I had planned to release this as a free escrowed mod...  
but tbh. i'd rather let you all see how it's done...  
Without telemetry flow and transactions being part of the session, this is mostly just a hijack of the systems. if you wish to store the values of the compendium and sampled values, you will have to store and readd them on load each time. i do NOT do that here. this is just tranq ped flags. then prompt hijacking, calling the compedium database for the right sample item...  
Enough Waffling. Enjoy.
  
- Designed to replicate RDO features.
- Players require only to equip a varmint rifle with sedative rounds.
- item is output to easy to find functions.  
  
Item Hashnames used in this script.  
> weapon_rifle_varmint
> AMMO_22_TRANQUILIZER