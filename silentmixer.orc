
       	sr = 44100
	kr = 44100
	ksmps = 1
	nchnls = 4

      gkmute1 init 1
      gkmute2 init 1
      gkmute3 init 1
      gkmute4 init 1
      gkthresh1 init 1
      gkthresh2 init 1

;zakinit 20,20

;massign 1,1

;turnon 1,0
;maxalloc 1,1


FLcolor	180,200,199
FLpanel 	"Silent Mixer",200,300
    istarttim = 0
    idropi = 666
    idur = 1
    ;ibox0  FLbox  "FM Synth (abram)", 1, 6, 12, 300, 20, 0, 0
    ;FLsetFont   7, ibox0
                
    gkamp1,    iknob1 FLknob  "AMP1", 0.0001, 2, -1,1, -1, 50, 0,0
    gkamp2,    iknob2 FLknob  "AMP2", 0.0001, 2, -1,1, -1, 50, 50,0
    gkamp3,    iknob3 FLknob  "Threshold1", 0.01, 32000, -1,1, -1, 50, 100,0
    gkamp4,    iknob4 FLknob  "Threshold2", 0.01, 32000, -1,1, -1, 50, 150,0
    ;                                      ionioffitype
    
    FLsetVal_i   1.0, iknob1
    FLsetVal_i   1.0, iknob2
    FLsetVal_i   1.0, iknob3
    FLsetVal_i   1.0, iknob4
    
FLpanel_end	;***** end of container

FLrun		;***** runs the widget thread 


      gkamp1 init 1
      gkamp2 init 1
      gkamp3 init 1
      gkamp4 init 1

      gkmute1 init 1
      gkmute2 init 1
      gkmute3 init 1
      gkmute4 init 1



; the mixer
        instr 1
	a1,a2,a3,a4 inq
        ka3 downsamp a3
        ka4 downsamp a4
        ;ar3 limit a3, gkamp3, 10000000
        ;ar4 limit a4, gkamp4, 10000000
        ;krms3 rms a3, 10000
        ;krms4 rms a4, 10000
        ;kb3 = (krms3 > gkamp3)?0:1
        ;kb4 = (krms4 > gkamp4)?0:1
        kb3 = (abs(ka3) > gkamp3)?0:1
        kb4 = (abs(ka4) > gkamp4)?0:1
        ;ar3 min 1.0 + 0*ar3, ar3
        ;ar4 min 1.0 + 0*ar4, ar4
	;aa1 = a1 * gkamp1 * gkmute1 * ar3 * kb3
	;aa2 = a2 * gkamp2 * gkmute2 * ar4 * kb4
	aa1 = a1 * (gkamp1 - 0.0001) * gkmute1 *  kb3
	aa2 = a2 * (gkamp2 - 0.0001) * gkmute2 *  kb4

	outs aa1,aa2
        endin   

        instr 2
	a1,a2,a3,a4 inq
        ka3 downsamp a3
        kmix1 = (abs(ka3) > gkthresh1)?1:0
        kmix2 = (abs(ka3) < gkthresh2)?1:0
	aa1 = a1 * kmix1 * gkmute1 
	aa2 = a2 * kmix2 * gkmute2 
	outs aa1,aa2
        endin   

