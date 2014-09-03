//
//  ofTextFieldMac.h
//  emptyExample
//
//  Created by Hansi on 27.08.14.
//  based on https://github.com/igiso/ofxTextField
//

#pragma once
#if TARGET_OS_IPHONE
#include "ofTextField.h"



class ofTextFieldiOS : public ofTextFieldBase{
private:
    void *textView;
	static int quantity_ofBoxes;
	
protected:
	virtual void create(int x, int y,int w,int h);
	virtual void drawImpl(int x, int y, int w,int h);
	
	
public:
	ofTextFieldiOS();
	virtual ~ofTextFieldiOS();
	
	virtual bool activeApp();
    virtual bool isActive();
    
    virtual string getText();
    virtual void setText(string dtext="");
	
    virtual bool showScrollBar(bool showing = true);
    virtual bool setMultiline(bool multiln=true);
    virtual void hide();
    virtual void show();
	
    virtual void hideIfNotDrawing();
};

typedef ofTextFieldiOS ofTextField;


#endif