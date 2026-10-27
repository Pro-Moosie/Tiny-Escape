//basic movement + collison check
var _wlkspeed = 0 // laat de speler starten met 0 speed
if (keyboard_check(ord("D"))) _wlkspeed = 4 // voegt speed toe aan _wlkspeed als je op d drukt
else if (keyboard_check(ord("Q"))) _wlkspeed = -4 // voegt speed toe aan _wlkspeed als je op de q drukt

if (place_meeting(x + _wlkspeed, y, obj_box) == false) // of de player botst met het object dat is ingetyped (obj_box)
{													   // laat ook de player alleen wandelen als de function false is
	x += _wlkspeed
}

//---------------------------------------------------------------------------------------//

// gravity (een beetje springen)

// 1. Bereken de verticale beweging (voorbeeldvariabelen)
 vspd += grav; // vspd = verticale snelheid, grav = zwaartekracht

// 2. Controleer op verticale botsingen
var on_ground = place_meeting(x, y + 1, obstacol);

	 /// gravity + springen

// 1. Zwaartekracht
vspd += grav;

// 2. Check of de speler op de grond staat (1 pixel onder de speler)
var _on_ground = place_meeting(x, y + 1, obstacol);

// 3. Springen met spatiebalk (alleen vanaf de grond)
if (keyboard_check_pressed(vk_space) and _on_ground)
{
    vspd = -jump_speed; // negatief = omhoog
}

// 4. Verticale botsingen
if (place_meeting(x, y + vspd, obstacol))
{
    while (!place_meeting(x, y + sign(vspd), obstacol))
    {
        y += sign(vspd);
    }

    if (vspd > 0)
    {
    
    }

    vspd = 0;
}

// 3. pas de uiteindelijk
y += vspd;

//--------------------------------------------------------------------------------------------------//
//ladder klimmen

// staat de player in een geplaatste ladder?
// Beginnen met klimmen
// 1. Ladder-check
var _ladder = instance_place(x, y, obj_ladder);
var on_ladder = (_ladder != noone and _ladder.placed and _ladder.image_angle mod 180 == 0);

if (on_ladder and (keyboard_check(ord("W")) or keyboard_check(ord("S"))))
{
    climbing = true;
}
if (!on_ladder) climbing = false;

// 2. Springen (van de grond of van de ladder af)
if (keyboard_check_pressed(vk_space))
{
    if (climbing)
    {
        climbing = false;
        vspd = -jump_speed;
    }
    else if (_on_ground)
    {
        vspd = -jump_speed;
    }
}

// 3. Klimmen of zwaartekracht (één plek!)
if (climbing)
{
    vspd = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * climb_speed;
}
else
{
    vspd += grav;
}

// 4. Verticale botsingen
if (place_meeting(x, y + vspd, obstacol))
{
    while (!place_meeting(x, y + sign(vspd), obstacol))
    {
        y += sign(vspd);
    }
    vspd = 0;
}

// 5. Toepassen
y += vspd;
//----------------------------------------------------------------------------------------------//

if (keyboard_check_pressed(ord("E")) and carrying != noone)
{
    var spot = instance_place(x, y, obj_ladder_spot);

    if (spot != noone and !spot.filled)
    {
        carrying.x = spot.x;
        carrying.y = spot.y;
        carrying.image_angle = spot.image_angle;
        carrying.carried = false;   // ontbrak
        carrying.placed = true;
        spot.filled = true;
        spot.visible = false;
		if (spot.image_angle mod 180 != 0)
		{
			var _solid = instance_create_depth(spot.x, spot.y, 0, obj_bridge_ladder);
			_solid.sprite_index = carrying.sprite_index
			_solid.image_angle = spot.image_angle;
		
		while (place_meeting(x, y, obstacol)) y -= 1;
		_solid.image_xscale = carrying.image_xscale;
		_solid.image_yscale = carrying.image_yscale;
		}
        carrying = noone;           // typfout gefixt
    }
}
//----------------------------------------------------------------------------------//
if (power_up_boost > 0)
{
	power_up_boost -= 1 / game_get_speed(gamespeed_fps);
}
//----------------------------------------------------------------------//
// Sprite kiezen
if (climbing)
{
    sprite_index = Sprite28;
}

// Kijkrichting (links/rechts spiegelen)
if (keyboard_check(ord("Q"))) sprite_index = Sprite27;
if (keyboard_check(ord("D"))) sprite_index = Sprite26;