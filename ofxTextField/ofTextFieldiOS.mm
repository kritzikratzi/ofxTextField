#include "ofTextFieldiOS.h"
#if TARGET_OS_IPHONE
#include "ofxiOSExtras.h"

#pragma mark ofTextFieldiOS Implementation

int ofTextFieldiOS::quantity_ofBoxes = 0;

ofTextFieldiOS::ofTextFieldiOS(){
}

ofTextFieldiOS:: ~ofTextFieldiOS(){
}

void ofTextFieldiOS::create(int x, int y,int w,int h){
    quantity_ofBoxes++;
	
	CGRect frame = CGRectMake( x, y, w, h );
	NSString * txt = [NSString stringWithUTF8String:text.c_str()];
	
    NSTextAlignment align = NSTextAlignment(TextDirection_);
	
	if(isMultiline){
		UITextView * view = [UITextView new];
		view.frame = frame;
		view.text = txt;
		view.secureTextEntry = isPassword;
		view.textAlignment = align;
		textView = view;
	}else{
		UITextField * view = [UITextField new];
		view.frame = frame;
		view.text = txt;
		view.secureTextEntry = isPassword;
		view.textAlignment = align;
		textView = view;
    }
    
	UIView * view = (UIView*)textView;
	view.frame = frame;
	view.opaque = YES;
	view.layer.cornerRadius = 5.0;
	view.layer.borderWidth = 1.0;
	view.layer.borderColor = UIColor.blackColor.CGColor;
	view.backgroundColor = UIColor.whiteColor;
	view.layer.sublayerTransform = CATransform3DMakeTranslation(5, 5, 0);
	[(UIView*)textView becomeFirstResponder];
	
	[ofxiOSGetGLParentView() addSubview:view];
	
	
    isCreated = true;
}


void ofTextFieldiOS::drawImpl(int x, int y, int w,int h){
	UIView * view = (UIView*)this->textView;
	view.frame = CGRectMake(x, y, w, h);
}


bool ofTextFieldiOS::activeApp(){
	return true;
}


bool ofTextFieldiOS::isActive(){
	UIView * view = (UIView*)this->textView;
	return [view isFirstResponder];
}


string ofTextFieldiOS::getText(){
	if( !isCreated ) return text;
	UIView * view = (UIView*)this->textView;
	NSString * txt;
	if( [view isKindOfClass:UITextField.class] ){
		txt = ((UITextField*)view).text;
	}
	else{
		txt = ((UITextView*)view).text;
	}
	
	return string([txt UTF8String]);
}


bool ofTextFieldiOS::showScrollBar(bool showing){
    showingScrolBar = showing;
    return showingScrolBar;
}


bool ofTextFieldiOS::setMultiline(bool multln){
    showScrollBar(multln);
    isMultiline = multln;
    return isMultiline;
}

void ofTextFieldiOS::hide()
{
	UIView * view = (UIView*) textView;
	view.hidden = YES;
    isHiding = true;
}

void ofTextFieldiOS::show()
{
    if(isHiding&&isCreated){
		UIView * view = (UIView*) textView;
		view.hidden = NO;
        isHiding = false;
	}
}


void ofTextFieldiOS::setText(string dtext){
    if(isCreated){
		UIView * view = (UIView*)this->textView;
		NSString * txt = [NSString stringWithUTF8String:dtext.c_str()];
		if( [view isKindOfClass:UITextField.class] ){
			((UITextField*)view).text = txt;
		}
		else{
			((UITextView*)view).text = txt;
		}
    }
	
    text =dtext;
}


///this is the weird part of the code
//since this textbox is drawing above openGL
//you might want to use this function to figure out
//how to hide it when you don't want it.
void ofTextFieldiOS::hideIfNotDrawing(){
    //code needed
}

#endif