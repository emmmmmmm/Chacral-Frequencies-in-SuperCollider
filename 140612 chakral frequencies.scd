s.boot

//========================================================================
// set up frequencie - dicts:
(
d = ();
d.base = ();
d.sacral = ();
d.solar = ();
d.heart = ();
d.throat = ();
d.brow = ();
d.crown = ();

d.base.low = 90;
d.base.high = 104;
d.sacral.low = 106;
d.sacral.high = 115;
d.solar.low = 117;
d.solar.high = 124;
d.heart.low = 128;
d.heart.high = 139;
d.throat.low = 142;
d.throat.high = 148;
d.brow.low = 158 ;
d.brow.high = 174;
d.crown.low = 180;
d.crown.high = 243;
)

//========================================================================
//Synthdef
(
SynthDef(\syn, {
	|freq = 100,gate = 1,attack = 4,release = 5|
	var env,sig;
	var numfreqs = rrand(2,5);
	//env = EnvGen.ar(Env.adsr(attack,0,1,release),gate,doneAction:2);
	env = EnvGen.ar(Env.perc(attack,release),doneAction:2);
	sig = FreeVerb.ar(
		Klank.ar(`[(1..numfreqs),1/(1..numfreqs),{exprand(1,4)}!numfreqs],PinkNoise.ar([0.007, 0.007]),freq);
	, 0.5 ,0.9
	);
	Out.ar(0,sig*env*0.7);
}).add
//========================================================================
)
(
Tdef(\chakra, {|ev|
	loop{
		f = rrand(ev.lo,ev.hi);
		f = f*[0.5,1,2,4,5,6].choose;
		f.postln;
		a = Synth(\syn, [\freq, f,\attack,rrand(5,15),\release,rrand(8,16)]);
		[2,4].choose.wait;
//		a = Synth(\syn, [\freq, f*4.fib(0.5,1).choose,\release,rrand(0.2,0.51),\attack,0.01]);
//		[0.021,0.01].choose.wait;
	};
})
)



a = Synth(\syn);
//========================================================================

Tdef(\structure).play

(
Tdef(\structure, {
	var length,pause;
	length = 30;pause = 5;
	//s.record("/Users/manueleisl/Desktop/supercolliding chakras.wav");
	1.wait;
	Tdef(\chakra).play;
	"base".postln;
	Tdef(\chakra).set(\lo,d.base.low,\hi,d.base.high);
	length.wait;
	Tdef(\chakra).pause;pause.wait;Tdef(\chakra).play;
	"sacral".postln;
	Tdef(\chakra).set(\lo,d.sacral.low,\hi,d.sacral.high);
	length.wait;
	Tdef(\chakra).pause;pause.wait;Tdef(\chakra).play;
	"solar".postln;
	Tdef(\chakra).set(\lo,d.solar.low,\hi,d.solar.high);
	length.wait;
	Tdef(\chakra).pause;pause.wait;Tdef(\chakra).play;
	"heart".postln;
	Tdef(\chakra).set(\lo,d.heart.low,\hi,d.heart.high);
	length.wait;
	Tdef(\chakra).pause;pause.wait;Tdef(\chakra).play;
	"throat".postln;
	Tdef(\chakra).set(\lo,d.throat.low,\hi,d.throat.high);
	length.wait;
	Tdef(\chakra).pause;pause.wait;Tdef(\chakra).play;
	"brow".postln;
	Tdef(\chakra).set(\lo,d.brow.low,\hi,d.brow.high);
	length.wait;
	Tdef(\chakra).pause;pause.wait;Tdef(\chakra).play;
	"crown".postln;
	Tdef(\chakra).set(\lo,d.crown.low,\hi,d.crown.high);
	length.wait;
	"end".postln;
	Tdef(\chakra).stop;
	10.wait;
	//s.stopRecording;
})
)
Tdef(\structure).clear



//========================================================================

Tdef( \hello, { |ev| loop{ ev.postln; ev.hi.postln; 1.0.wait; } });
Tdef( \hello ).set( \hi, 3 );
Tdef( \hello ).play;
Tdef( \hello ).set( \hi, 6 );
Tdef( \hello ).stop;
//========================================================================

s.quit
