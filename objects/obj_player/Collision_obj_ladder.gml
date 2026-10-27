// Alleen oppakken als je nog niks vasthoudt en de ladder niet al geplaatst is
if (carrying == noone and !other.placed)
{
	carrying = other.id;
	other.carried = true;
}