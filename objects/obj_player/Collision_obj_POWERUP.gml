jump_speed += 8
instance_destroy(other)
power_up_boost = 8
call_later(8, time_source_units_seconds, function() // wacht 6 sec en dan vooor de func tussen de acco uit
{
	jump_speed -= 8 
}
)