#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#pragma semicolon 1

#define DATA "b0.1"

new Handle:g_iConVar = INVALID_HANDLE;


public Plugin:myinfo = 
{
	name = "SM Catch Nades Redux",
	author = "Franc1sco Steam: franug",
	description = "Catch nades on air",
	version = DATA,
	url = "http://www.servers-cfg.foroactivo.com/"
};

public OnPluginStart()
{
	CreateConVar("sm_catch_nades_version", DATA, "plugin", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_REPLICATED|FCVAR_NOTIFY);

	// cvars
	g_iConVar = CreateConVar("sm_catch_nades","1");
}


public OnEntityCreated(entity, const String:classname[])
{
    if(!GetConVarInt(g_iConVar))
	  return;


    if (StrEqual(classname, "hegrenade_projectile"))
    {
        SDKHook(entity, SDKHook_StartTouch, SDKHook_Touch_Callback);
    }
    else if (StrEqual(classname, "flashbang_projectile"))
    {
        SDKHook(entity, SDKHook_StartTouch, SDKHook_Touch_Callback2);
    }
    else if (StrEqual(classname, "smokegrenade_projectile"))
    {
        SDKHook(entity, SDKHook_StartTouch, SDKHook_Touch_Callback3);
    }
}

public SDKHook_Touch_Callback(ent1, ent2)
{

    if (!IsValidEntity(ent1))
        return;



    if (IsValidClient(ent2))
    {
          GivePlayerItem(ent2, "weapon_hegrenade");
          RemoveEdict(ent1);
    }
}  

public SDKHook_Touch_Callback2(ent1, ent2)
{

    if (!IsValidEntity(ent1))
        return;



    if (IsValidClient(ent2))
    {
          GivePlayerItem(ent2, "weapon_flashbang");
          RemoveEdict(ent1);
    }
}  

public SDKHook_Touch_Callback3(ent1, ent2)
{

    if (!IsValidEntity(ent1))
        return;



    if (IsValidClient(ent2))
    {
          GivePlayerItem(ent2, "weapon_smokegrenade");
          RemoveEdict(ent1);
    }
}  

public IsValidClient( client ) 
{ 
    if ( !( 1 <= client <= MaxClients ) || !IsClientInGame(client) ) 
        return false; 
     
    return true; 
}