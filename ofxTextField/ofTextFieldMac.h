//
//  ofTextFieldMac.h
//  emptyExample
//
//  Created by Hansi on 27.08.14.
//  based on https://github.com/igiso/ofxTextField
//

#pragma once

#include "ofTextField.h"

class obj_ofT_;
extern int quantity_ofBoxes;


class ofTextFieldMac : public ofTextFieldBase{
private:
	CGRect appWindow;
    obj_ofT_ * pointer;
    void *pointerToWindow;	

protected:
	virtual void create(int x, int y,int w,int h);
	virtual void drawImpl(int x, int y, int w,int h);

	
public:
	ofTextFieldMac();
	virtual ~ofTextFieldMac();
	
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

typedef ofTextFieldMac ofTextField;


