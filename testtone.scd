// get script's directory for relative paths
~root_DIR = thisProcess.nowExecutingPath.dirname++"/";

// Name of the jack client
// s.options.device               = "ACID";

s.options.numInputBusChannels  = 2;
s.options.numOutputBusChannels = 2;


s.boot;

s.waitForBoot({

	{Out.ar(0,SinOsc.ar(234,0,0.1))}.play;
	{Out.ar(1,SinOsc.ar(345,0,0.1))}.play;

});