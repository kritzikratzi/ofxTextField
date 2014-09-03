

///--------------------------------------------------------------------------
///--------------------------------------------------------------------------
///TEXTBOX FOR OF add this code inside ofSystemUtils.cpp
///--------------------------------------------------------------------------
///--------------------------------------------------------------------------


#include "ofTextField.h"



ofTextFieldBase::ofTextFieldBase(){
    TextDirection_ = ofTextField_Align_LEFT;
    isCreated = false;
    posX=0,posY=0,width=0,height=0;
    showingScrolBar=false;
    isMultiline=false;//change this if you want multiline text as default
    isPassword =false;
    isHiding =false;
    isDrawing = true;
}


ofTextFieldBase::~ofTextFieldBase(){
    isCreated=false;
}


void ofTextFieldBase::draw(int x, int y,int w,int h){
    if(!isCreated){
        create(x,y,w,h);
        isCreated=true;
    }
	else{
		posX=x,posY=y,width=w,height=h;
		drawImpl( x, y, w, h );
	}
}

bool ofTextFieldBase::getIsHiding(){
    return isHiding;
}

bool ofTextFieldBase::setPassWordMode(bool passwrdmd ){
    
    isPassword= passwrdmd;
    
    return isPassword;
}

void ofTextFieldBase::setTextDir(ofTextField_Alignment direction){
    if(!isCreated){
        TextDirection_ = direction;
    }else cout<<"ofTField::Alignment Should Be called on Setup"<<endl;
}






