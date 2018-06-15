if (SC_occupyLootCratesMarkers) then{
for "_i" from 1 to SC_numberofLootCrates do{
_markerName = format ["SC_loot_marker_%1", _i];
_pos = getMarkerPos _markerName;
if(!isNil "_pos") then{
if([_pos, 15] call ExileClient_util_world_isAlivePlayerInRange) then{ 
deleteMarker _markerName; 
_logDetail =  format ["[OCCUPATION:LootCrates]:: marker %1 removed at %2",_markerName,time];
[_logDetail] call SC_fnc_log;
};
};
};
};
if (SC_occupyFartMarkers) then{
for "_i" from 1 to SC_numberofFarts do{
_markerName = format ["Toxic_%1", _i];
_pos = getMarkerPos _markerName;
if(!isNil "_pos") then{
if([_pos, 10] call ExileClient_util_world_isAlivePlayerInRange) then{ 
deleteMarker _markerName; 
["toastRequest", ["InfoTitleAndText", ["The ToXic SluG has been defeated!", "Grab a Pilot Helmet from a dead soldier to get near the crate."]]] call ExileServer_system_network_send_broadcast;
_logDetail =  format ["[OCCUPATION:LootCrates]:: marker %1 removed at %2",_markerName,time];
[_logDetail] call SC_fnc_log;
};
};
};
};
if (SC_occupySpectreMarkers) then{
for "_i" from 1 to SC_numberofSpectres do{
_markerName = format ["Spectre_%1", _i];
_pos = getMarkerPos _markerName;
if(!isNil "_pos") then{
if([_pos, 15] call ExileClient_util_world_isAlivePlayerInRange) then{ 
deleteMarker _markerName; 
["toastRequest", ["InfoTitleAndText", ["Spectre has been defeated!", "Grab a Pilot Helmet from a dead soldier to get near the crate."]]] call ExileServer_system_network_send_broadcast;
_logDetail =  format ["[OCCUPATION:LootCrates]:: marker %1 removed at %2",_markerName,time];
[_logDetail] call SC_fnc_log;
};
};
};
};
if (SC_occupyScreamerMarkers) then{
for "_i" from 1 to SC_numberofScreamers do{
_markerName = format ["Screamer_%1", _i];
_pos = getMarkerPos _markerName;
if(!isNil "_pos") then{
if([_pos, 15] call ExileClient_util_world_isAlivePlayerInRange) then{ 
deleteMarker _markerName; 
["toastRequest", ["InfoTitleAndText", ["The Screamer has been defeated!", "Grab a Pilot Helmet from a dead soldier to get near the crate."]]] call ExileServer_system_network_send_broadcast;
_logDetail =  format ["[OCCUPATION:LootCrates]:: marker %1 removed at %2",_markerName,time];
[_logDetail] call SC_fnc_log;
};
};
};
};
if (SC_HeliCrashMarkers) then{
for "_i" from 1 to SC_numberofHeliCrashes do{
_markerName = format ["SC_helicrash_marker_%1", _i];
_pos = getMarkerPos _markerName;
if(!isNil "_pos") then{
if([_pos, 15] call ExileClient_util_world_isAlivePlayerInRange) then{ 
deleteMarker _markerName; 
_logDetail =  format ["[OCCUPATION:HeliCrashes]:: marker %1 removed at %2",_markerName,time];
[_logDetail] call SC_fnc_log;
};
};
};
};
