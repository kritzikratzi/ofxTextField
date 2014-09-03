	This is not finished yet!!! 
	This is updated constantly. Please re-visit
	and PLEASE DO open issues if you find any!

ofxTextField
====
This is a textbox for openFrameworks that supports all languages.

Unlike many other projects it's the real deal -- a native textfield widget from your platform. 
Ideally you should Subclass this and only create it, or show it when the user is inputing text. 
When the user is not inputing text then hide it and draw in its place a white rect with the text in it.


Usage
---
	// in your testApp.h file: 
	#include "ofTextField.h"
	class testApp : public ofBaseApp{
		...
		ofTextField textfield; 
	}
	
	// in your testApp.cpp file: 
	void testApp::draw(){
	    textfield.draw(100,100, 100, 40);
	    cout << "text = " << textfield.getText() << endl; 
	}

Keep in mind that this is attached above your gl-window! 



Updates
---

**//UPDATE SEP/3/2014**

* readme format is now markdown
* copy/paste/select all/special chars palette shortcuts work in osx 
* added iOS implementation+project files
* refactored OSX implementation into it's own implementation files. added project files for osx. 
* temporarily removed windows implementation (will be back soon)

**//UPDATE AUG/5/2014**

* Fixed a bug that caused crash on exit under mac
* Added password MODE!!

**///UPDATE 16/6/2014**

* Fixed a bug that did not give focus to the main window correctly on PC when clicking outside the textbox and multiple textboxes were available

**//UPDATE 10/4/2014**

* fixed some bugs that caused crashes.
* setText() can be called both in Setup and in loop

**//Update 3 28/3/2014**

* Added Support for V-Studio
* Fixed minor bugs
* Added multiline ability for both MAC and PC
* Added a scroll-bar bot on MAC and PC
* scroll-bar listens to mouse-scroll events 
* in the mac version twofinger gestrue is also supported
* added Hide() show() function for Mac+PC
* added getText() for mac and PC

**//Update 2 : 15/3/2014** 

* fixed autopositioning bug on osx


**//Update 1**

* Tested it with OF 8.1
* Added support for GLFW


Contributors: 
--- 

* Kyriacos Kousoulides
* Hansi Raber

Todo
---

* When pressing Tab change focus between textboxes

