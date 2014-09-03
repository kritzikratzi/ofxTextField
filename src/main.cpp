#include "ofMain.h"
#include "testApp.h"

#if !TARGET_OS_IPHONE
	#include "ofAppGlutWindow.h"
	#include "ofAppGLFWWindow.h"
#endif

//========================================================================
int main( ){


	#if TARGET_OS_IPHONE
		ofAppiOSWindow * window = new ofAppiOSWindow();
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
			ofSetupOpenGL(window, 768,1024, OF_FULLSCREEN);
		}
		else{
			CGRect screenRect = [[UIScreen mainScreen] bounds];
			CGFloat width = MIN(screenRect.size.width,screenRect.size.height);
			CGFloat height = MAX(screenRect.size.width,screenRect.size.height);
			ofSetupOpenGL(window, width, height, OF_FULLSCREEN);
		}
	
		ofRunApp(new testApp());
	
	#elif TARGET_OS_MAC
		ofAppGLFWWindow window;
		ofSetupOpenGL(&window, 1024,768, OF_WINDOW);
		ofRunApp( new testApp());
	#else
		ofAppGlutWindow window;
		ofSetupOpenGL(&window, 1024,768, OF_WINDOW);
		ofRunApp( new testApp());
	#endif
}
