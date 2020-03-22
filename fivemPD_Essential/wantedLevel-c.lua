--Disable police and join their group 
SetMaxWantedLevel(0)
SetWantedLevelMultiplier(0.0)
SetRelationshipBetweenGroups(0, GetHashKey("police"), GetHashKey("PLAYER"))
SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("police"))	