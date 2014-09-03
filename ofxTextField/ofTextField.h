
///--------------------------------------------------------------------------
///--------------------------------------------------------------------------
///TEXTBOX FOR OF add the following code inside ofSystemUtils.h
///--------------------------------------------------------------------------
///--------------------------------------------------------------------------

#pragma once

#include "ofMain.h"


enum ofTextField_Alignment{
    ofTextField_Align_LEFT=0,
    ofTextField_Align_RIGHT=2,
    ofTextField_Align_CENTER=1
};

class ofTextFieldBase{
protected:
    string text,question, standardAppName;
    bool isCreated,isMultiline,isPassword,isHiding,isDrawing,isCentered;
    int winPosx,winPosy;
	int posX,posY,width,height;
	bool showingScrolBar;
    ofTextField_Alignment TextDirection_;
    
	virtual void create(int x, int y,int w,int h) = 0;
	virtual void drawImpl(int x, int y, int w,int h) = 0;
	
public:
	ofTextFieldBase();
    virtual ~ofTextFieldBase();
	
	void draw(int x, int y,int w,int h);
    bool setPassWordMode(bool passwrdmd = true);
    void setTextDir(ofTextField_Alignment direction= ofTextField_Align_CENTER);
    bool getIsHiding();

	virtual bool activeApp() = 0;
    virtual bool isActive() = 0;
    
    virtual string getText() = 0;
    virtual void setText(string dtext="") = 0;
	
    virtual bool showScrollBar(bool showing = true) = 0;
    virtual bool setMultiline(bool multiln=true) = 0;
    virtual void hide() = 0;
    virtual void show() = 0;
	
    virtual void hideIfNotDrawing() = 0;
};


#if TARGET_OS_WIN32
#include "ofTextFieldWin.h"
#elif TARGET_OS_IPHONE
#include "ofTextFieldiOS.h"
#elif TARGET_OS_MAC
#include "ofTextFieldMac.h"
#endif
