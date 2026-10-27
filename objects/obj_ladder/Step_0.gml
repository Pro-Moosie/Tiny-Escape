if (placed) carried = false;

if (carried)
{
	depth = obj_player.depth - 3 // voor de player
    x = obj_player.x + 10; // offset zodat het lijkt alsof hij hem vasthoudt
    y = obj_player.y - 5;
    image_angle = 45; // optioneel: schuin dragen
}
else
{
	depth = obj_player.depth + 3 //achter de player
}