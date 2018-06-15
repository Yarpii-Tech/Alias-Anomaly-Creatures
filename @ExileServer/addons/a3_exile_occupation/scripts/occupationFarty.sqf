private ["_veh","_weed","_weed2","_weed3","_weed4","_weed5","_weed6","_staticGuns","_group","_position"];
if (!isServer) exitWith {};
_logDetail = format ["[OCCUPATION:Farty]:: Starting Occupation Farty"];
[_logDetail] call SC_fnc_log;
_logDetail = format["[OCCUPATION:Farty]:: worldname: %1 crates to spawn: %2",worldName,SC_numberofFarts];
[_logDetail] call SC_fnc_log;
private _position = [0,0,0];
for "_i" from 1 to SC_numberofFarts do{
_validspot = false;
while{!_validspot} do {
sleep 0.2;
if(SC_occupyFartStatic) then{
_tempPosition = SC_occupyFartLocations call BIS_fnc_selectRandom;
SC_occupyFartLocations = SC_occupyFartLocations - _tempPosition;
_position = [_tempPosition select 0, _tempPosition select 1, _tempPosition select 2];
if(isNil "_position") then{
_position = [ false, false ] call SC_fnc_findsafePos;
};
}else{
_position = [ false, false ] call SC_fnc_findsafePos;
};
_validspot= true;
_nearOtherCrate = (nearestObjects [_position,["CargoNet_01_box_F"],500]) select 0;
if (!isNil "_nearOtherCrate") then { _validspot = false; };
};
_mapMarkerName = format ["Toxic_%1", _i];
if (SC_occupyFartMarkers) then {
_event_marker = createMarker [_mapMarkerName, _position];
_event_marker setMarkerColor "ColorGreen";
_event_marker setMarkerAlpha 1;
_event_marker setMarkerText "Toxic Weed Crop";
_event_marker setMarkerType "ExileContaminatedZoneIcon";
};
null = [_mapMarkerName,"H_PilotHelmetFighter_B",true,30,0.01,true,12] execVM "scripts\anomaly\AL_farty\area_toxic_ini.sqf";
null = [_mapMarkerName,"H_PilotHelmetFighter_B",false] execvm "scripts\anomaly\AL_spark\al_sparky.sqf";
if (SC_SpawnFartGuards) then{
_AICount = SC_FartCrateGuards;
if(SC_FartCrateGuardsRandomize) then {
_AICount = 1 + (round (random (SC_FartCrateGuards-1)));    
};
if(_AICount > 0) then{
_spawnPosition = [_position select 0, _position select 1, 0];
_initialGroup = createGroup SC_BanditSide;
_initialGroup setCombatMode "BLUE";
_initialGroup setBehaviour "SAFE";
for "_i" from 1 to _AICount do{
_customGearSet = ["srifle_DMR_05_blk_F",["muzzle_snds_93mmg","optic_AMS","bipod_01_F_blk"],[["10Rnd_93x64_DMR_05_Mag",6],["Titan_AT",2]],"",[""],["Rangefinder","ItemGPS"],"launch_O_Titan_short_ghex_F","H_PilotHelmetFighter_B","U_I_Protagonist_VR","V_PlateCarrierIAGL_dgtl","B_Carryall_ghex_F"];
_unit = [_initialGroup,_spawnPosition,"custom","random","bandit","soldier",_customGearSet] call DMS_fnc_SpawnAISoldier; 
_unitName = ["bandit"] call SC_fnc_selectName;
if(!isNil "_unitName") then { _unit setName _unitName; }; 
reload _unit;
};
enableSentences true;
enableRadio true; 
_group = createGroup SC_BanditSide;           
_group setVariable ["DMS_LockLocality",nil];
_group setVariable ["DMS_SpawnedGroup",true];
_group setVariable ["DMS_Group_Side", SC_BanditSide];
{
_unit = _x;           
[_unit] joinSilent grpNull;
[_unit] joinSilent _group;
_unit setCaptive false;                               
}foreach units _initialGroup;  
deleteGroup _initialGroup;
[_group, _spawnPosition, 25] call bis_fnc_taskPatrol;
_group setBehaviour "STEALTH";
_group setCombatMode "RED";
_veh =[
[
[(_position select 0) -(25-(random 25)),(_position select 1) +(25+(random 25)),0]
],
_group,"assault","hardcore","bandit","random"
] call DMS_fnc_SpawnAIVehicle;
_logDetail = format ["[OCCUPATION:Farty]::  Creating crate %3 at drop zone %1 with %2 guards",_position,_AICount,_i];
[_logDetail] call SC_fnc_log;
};
}else{
_logDetail = format ["[OCCUPATION:Farty]::  Creating crate %2 at drop zone %1 with no guards",_position,_i];
[_logDetail] call SC_fnc_log;
};
_weed5 = createVehicle ["Land_DPP_01_transformer_F",[(_position select 0) - 3, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
_weed6 = createVehicle ["Mass_grave",[(_position select 0) - 10, (_position select 1),-0.1],[], 0, "CAN_COLLIDE"];
_box = "CargoNet_01_box_F" createvehicle _position;
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
_box enableRopeAttach SC_FartropeAttach;
_box setVariable ["permaLoot",true];
_box setVariable ["ExileMoney",16000,true];
_box allowDamage false;
{
_item = _x select 0;
_amount = _x select 1;
_randomAmount = _x select 2;
_amount = _amount + (random _randomAmount);
_itemType = _x call BIS_fnc_itemType;
if((_itemType select 0) == "Weapon") then{ _box addWeaponCargoGlobal [_item, _amount];};
if((_itemType select 0) == "Magazine") then{ _box addMagazineCargoGlobal [_item, _amount];};
if((_itemType select 0) == "Item") then{ _box addItemCargoGlobal [_item, _amount];};
if((_itemType select 0) == "Equipment") then{ _box addItemCargoGlobal [_item, _amount];};
if((_itemType select 0) == "Backpack") then{ _box addBackpackCargoGlobal [_item, _amount];};
}forEach SC_LootCrateItems;
_effect = "test_EmptyObjectForSmoke";
_wreckFire = _effect createVehicle (position _weed5);   
_wreckFire attachto [_weed5, [0,0,-1]];
_staticGuns = [[
[(_position select 0) +(45-(random 10)),(_position select 1)-(45-(random 10)),0],
[(_position select 0) +(25-(random 10)),(_position select 1)-(25-(random 10)),0]
],
_group,"assault","difficult","bandit","random"
] call DMS_fnc_SpawnAIStaticMG;   
_wrecks = selectRandom ["Land_AncientHead_01_F","Land_AncientStatue_02_F","Land_Slum_House03_F","Land_Slum_House02_F","Land_cargo_house_slum_F","Land_Slum_03_F","Land_Slum_House01_F"];
_vehWreck = _wrecks createVehicle [0,0,0];
_vehWreckRelPos = _box getRelPos [(10 + (ceil random 15)), (random 360)];
_vehWreck setPos _vehWreckRelPos;
_vehWreck setDir (random 360);
_vehWreck setVectorUp surfaceNormal position _vehWreck;
};
