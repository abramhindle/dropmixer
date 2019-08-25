(sleep 5;
    jack_disconnect csoundDropMixer:output1 system:playback_1 \
 ;  jack_disconnect csoundDropMixer:output2 system:playback_1 \
 ;  jack_disconnect csoundDropMixer:output3 system:playback_1 \
 ;  jack_disconnect csoundDropMixer:output4 system:playback_1 \
 ;  jack_disconnect csoundDropMixer:output1 system:playback_2 \
 ;  jack_disconnect csoundDropMixer:output2 system:playback_2 \
 ;  jack_disconnect csoundDropMixer:output3 system:playback_2 \
 ;  jack_disconnect csoundDropMixer:output4 system:playback_2 \
 ;  jack_disconnect system:capture_1 csoundDropMixer:input1 \
 ;  jack_disconnect system:capture_2 csoundDropMixer:input2 \
 ;  jack_disconnect system:capture_3 csoundDropMixer:input3 \
 ;  jack_disconnect system:capture_4 csoundDropMixer:input4 \
 ;  jack_connect csoundDropMixer:output1 "PulseAudio JACK Source:front-left" \
 ;  jack_connect csoundDropMixer:output2 "PulseAudio JACK Source:front-left" \
 ;  jack_connect csoundDropMixer:output3 "PulseAudio JACK Source:front-left" \
 ;  jack_connect csoundDropMixer:output4 "PulseAudio JACK Source:front-left" \
 ;  jack_connect csoundDropMixer:output1 "PulseAudio JACK Source:front-right" \
 ;  jack_connect csoundDropMixer:output2 "PulseAudio JACK Source:front-right" \
 ;  jack_connect csoundDropMixer:output3 "PulseAudio JACK Source:front-right" \
 ;  jack_connect csoundDropMixer:output4 "PulseAudio JACK Source:front-right" \
) &
exec bash dropmixer.sh
