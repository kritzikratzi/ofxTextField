#pragma once

#include "ofMain.h"
#include "ofTextField.h"

#if TARGET_OS_IPHONE
	#include "ofxiOS.h"
	#include "ofxiOSExtras.h"
	#define OF_APP ofxiOSApp
#else
	#define OF_APP ofBaseApp
#endif


class testApp : public OF_APP{

	public:
		void setup();
		void update();
		void draw();

		void keyPressed  (int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);
	
    ofTextField text, text2, text3;

    void exit();
};
