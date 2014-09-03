#include "ofTextFieldMac.h"
#if TARGET_OS_MAC & !TARGET_OS_IPHONE


#pragma mark NSWindow stuff

@interface ofNsWindow : NSWindow

- (BOOL)canBecomeKeyWindow;

@end
@implementation ofNsWindow{
    
}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

- (NSText *)fieldEditor:(BOOL)createWhenNeeded forObject:(id)anObject
{
    NSText* text = [super fieldEditor:createWhenNeeded forObject:anObject];
    if ([text isKindOfClass:[NSTextView class]])
        [(NSTextView *)text setUsesRuler:YES];
    return text;
}
@end

@class AXCVHandler;

struct obj_ofT_{
public:
    obj_ofT_( ofNsWindow *wal_,
             NSView * uiView_,
             NSTextView *	myTextView_){
        
        wal = wal_;
        uiView = uiView_;
        myTextView = myTextView_;
        myTextField=NULL;
        
    }
    obj_ofT_( ofNsWindow *wal_,
             NSView * uiView_,
             AXCVHandler *	myTextField_){
        
        wal = wal_;
        uiView = uiView_;
        myTextField = myTextField_;
        myTextView = NULL;
    }
    obj_ofT_( ofNsWindow *wal_,
             NSView * uiView_,
             NSSecureTextField *	myPassField_){
        wal = wal_;
        uiView = uiView_;
        myPasswordField = myPassField_;
        myTextView = NULL;
    }
    ~obj_ofT_(){
        wal = NULL;
        uiView = NULL;
        myTextView = NULL;
        myTextField=NULL;
        myPasswordField=NULL;
    }
    ofNsWindow *wal;
    NSView * uiView;
    NSTextView *	myTextView;
    AXCVHandler*	myTextField;
    NSSecureTextField* myPasswordField;
    int id;
    
};
int quantity_ofBoxes;
extern "C" AXError _AXUIElementGetWindow(AXUIElementRef, CGWindowID* out);


#pragma mark AXCHandler (copy/paste for textfields) 
// http://web.archive.org/web/20100126000339/http://www.cocoarocket.com/articles/copypaste.html
@interface AXCVHandler : NSTextField { }
@end
@implementation AXCVHandler
- (BOOL)performKeyEquivalent:(NSEvent *)event {
    if ([event modifierFlags] & NSCommandKeyMask) {
        // The command key is the ONLY modifier key being pressed.
        if ([[event charactersIgnoringModifiers] isEqualToString:@"x"]) {
            return [NSApp sendAction:@selector(cut:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"c"]) {
            return [NSApp sendAction:@selector(copy:) to:[[self window] firstResponder] from:self];
        } else if ([[event charactersIgnoringModifiers] isEqualToString:@"v"]) {
            return [NSApp sendAction:@selector(paste:) to:[[self window] firstResponder] from:self];
        } else if ( [[event charactersIgnoringModifiers] isEqualToString:@"a"]) {
            return [NSApp sendAction:@selector(selectAll:) to:[[self window] firstResponder] from:self];
        }
		else if( ([event modifierFlags] & NSControlKeyMask) && [[event charactersIgnoringModifiers] isEqualToString:@" "]){
			[[NSApplication sharedApplication] orderFrontCharacterPalette:[[self window] firstResponder]];
			return YES;
		}
    }
    return [super performKeyEquivalent:event];
}
@end

#pragma mark ofTextFieldMac Implementation


ofTextFieldMac::ofTextFieldMac(){
}

ofTextFieldMac:: ~ofTextFieldMac(){
}

void ofTextFieldMac::create(int x, int y,int w,int h){
    ofNsWindow *wal;
    NSView* uiView;
    NSTextView *	myTextView;
    AXCVHandler *	myTextField;
    NSSecureTextField* myPasswordField;
    
    quantity_ofBoxes++;
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleName = [NSString stringWithFormat:@"%@", [info objectForKey:@"CFBundleExecutable"]];
    standardAppName = [bundleName UTF8String];
    NSRect Srect =    [[NSScreen mainScreen] frame];
    NSRect rect =    NSMakeRect(x,y,w,h);
    NSArray * allWindows = [NSApp windows];
    uiView = [[[NSView alloc] initWithFrame:rect] autorelease];
    uiView.wantsLayer = YES;
    wal = [[[ofNsWindow alloc]initWithContentRect:rect
                                        styleMask:NSBorderlessWindowMask
                                          backing:NSBackingStoreBuffered
                                            defer:NO]autorelease];
    NSTextAlignment Allingment_ = NSTextAlignment(TextDirection_);
    
    if(!isPassword){
        if(isMultiline){
            myTextView = [[[NSTextView alloc] initWithFrame:rect]autorelease];
            [myTextView setString:[NSString stringWithCString:text.c_str()
                                                     encoding:NSUTF8StringEncoding]];
            [myTextView setEditable: YES];
            [myTextView setRichText:NO];
            NSScrollView *scrollview = [[[NSScrollView alloc]
                                         initWithFrame:rect]autorelease];
            NSSize contentSize = [scrollview contentSize];
            [scrollview setBorderType:NSGrooveBorder];
            [wal fieldEditor:YES forObject:myTextView];
            [scrollview setDocumentView:myTextView];
            [scrollview setHasVerticalScroller:YES];
            [scrollview setHasVerticalRuler:YES];
            [scrollview setAutohidesScrollers:NO];
            [scrollview setBorderType:NSBezelBorder];
            [wal setContentView:scrollview];
            [wal makeFirstResponder:myTextView];
        }else{
            myTextField = [[[AXCVHandler alloc] initWithFrame:rect]autorelease];
            [myTextField setStringValue:[NSString stringWithCString:text.c_str()
                                                           encoding:NSUTF8StringEncoding]];
            [myTextField setAlignment:Allingment_];
            [myTextField setBezeled:YES];
            [myTextField setEditable:YES];
            [myTextField setEnabled:YES];
            [wal setContentView:myTextField];
            [wal makeFirstResponder:myTextField];
        }
    }else{
        
        myPasswordField = [[[NSSecureTextField alloc] initWithFrame:rect]autorelease];
        [myPasswordField setStringValue:[NSString stringWithCString:text.c_str()
                                                           encoding:NSUTF8StringEncoding]];
        
        [myPasswordField setAlignment:Allingment_];
        [myPasswordField setBezeled:YES];
        [myPasswordField setEditable:YES];
        [myPasswordField setEnabled:YES];
        [wal setContentView:myPasswordField];
        [wal makeFirstResponder:myPasswordField];
        
    }
    
    
    [wal setLevel:NSNormalWindowLevel];
    [wal makeKeyAndOrderFront:wal];
    [wal orderFront:NSApp];
    NSWindow * aWindow = (NSWindow*)ofGetCocoaWindow();
    appWindow.size.height = [aWindow frame].size.height;
    appWindow.size.width =[aWindow frame].size.width;
    appWindow.origin.x = [aWindow frame].origin.x;
    appWindow.origin.y =[aWindow frame].origin.y;
    NSRect rectofT =  NSMakeRect(appWindow.origin.x+x,(appWindow.origin.y+appWindow.size.height-20)-(y+h),w,h);
    [wal setFrame:rectofT display:YES];
    [aWindow addChildWindow:wal ordered:NSWindowAbove];
    pointerToWindow = ofGetCocoaWindow();
    if( pointerToWindow == nil ){
		NSLog( @"Please use a ofAppGLFWWindow instead of ofAppGlutWindow in your main.cpp/main.mm if you need textfields. ");
		exit(1);
	}
    if(!isPassword){
        if(isMultiline){
            pointer = new obj_ofT_(wal,uiView,myTextView);
		}
        else{
            pointer = new obj_ofT_(wal,uiView,myTextField);
		}
    }else{
		pointer = new obj_ofT_(wal,uiView,myPasswordField);
	}
    
    
    isCreated = true;
    //  NSLog(@"%@",allWindows);
}


void ofTextFieldMac::drawImpl(int x, int y, int w,int h){
	NSWindow * aWindow = (NSWindow *)pointerToWindow;
	bool rePosisionTheTextBox = false;
	
	if([aWindow frame].size.width!=appWindow.size.width||[aWindow frame].size.height!=appWindow.size.height){
		rePosisionTheTextBox=true;
	}
	
	if(x!=posX||y!=posY||w!=width||h!=height||rePosisionTheTextBox){
		appWindow.size.height = [aWindow frame].size.height;
		appWindow.size.width =[aWindow frame].size.width;
		appWindow.origin.x = [aWindow frame].origin.x;
		appWindow.origin.y =[aWindow frame].origin.y;
		
		
		
		NSRect Srect =    [[NSScreen mainScreen] frame];
		
		NSRect rectofT =  NSMakeRect(appWindow.origin.x+x,(appWindow.origin.y+appWindow.size.height-20)-(y+h),w,h);
		
		[pointer->wal setFrame:rectofT display:!isHiding animate:NO];
		[aWindow setMinSize:NSMakeSize(x+w, h+y+h)];
	}
}


bool ofTextFieldMac::activeApp(){
    bool isactive=false;
    NSDictionary *activeApp = [[NSWorkspace sharedWorkspace] activeApplication];
    
    
    //This is the only place we should use Ascii encoding though UTF8 will also work
    if([(NSString *)[activeApp objectForKey:@"NSApplicationName"]isEqual:
        [NSString stringWithCString:standardAppName.c_str() encoding:NSASCIIStringEncoding]]){
        
        isactive = true;
        
        
        
        
    }else{
        
        isactive =false;
        
    }
    return isactive;
}


bool ofTextFieldMac::isActive(){
    bool isTextboxActive =false;
	// TODO:
    return isTextboxActive;
    
}


string ofTextFieldMac::getText(){
	if(!isPassword){
		if (!isMultiline){
			text = [[pointer->myTextField stringValue] UTF8String];
		}
		else{
			text = [[pointer->myTextView string] UTF8String];
		}
	}
	else{
		text = [[pointer->myPasswordField stringValue]UTF8String];
	}
	
    return text;
}


bool ofTextFieldMac::showScrollBar(bool showing){
    showingScrolBar = showing;
    return showingScrolBar;
}


bool ofTextFieldMac::setMultiline(bool multln){
    showScrollBar(multln);
    
    
    isMultiline = multln;
    return isMultiline;
}

void ofTextFieldMac::hide()
{
	if(!isHiding&&isCreated){
		if (!isMultiline){
			[pointer->myTextField setHidden:YES];
			[pointer->wal setAlphaValue:0];
		}
		else{
			[pointer->myTextView setHidden:YES];
			[pointer->wal setAlphaValue:0];
			
		}
	}
    isHiding = true;
}

void ofTextFieldMac::show()
{
    
    if(isHiding&&isCreated){
        if (!isMultiline){
            [pointer->myTextField setHidden:NO];
            [pointer->wal setAlphaValue:1];
        }
        else{
            [pointer->myTextView setHidden:NO];
            [pointer->wal setAlphaValue:1];
            
        }
        isHiding = false;
    }
}


void ofTextFieldMac::setText(string dtext){
    if(isCreated){
        if (!isMultiline){
            [pointer->myTextField setStringValue:[NSString stringWithCString:dtext.c_str()
                                                                    encoding:NSUTF8StringEncoding]];
        }
        else{
            [pointer->myTextView setString:[NSString stringWithCString:dtext.c_str()
                                                              encoding:NSUTF8StringEncoding]];
        }
    }else{
        text =dtext;
    }
}


///this is the weird part of the code
//since this textbox is drawing above openGL
//you might want to use this function to figure out
//how to hide it when you don't want it.
void ofTextFieldMac::hideIfNotDrawing(){
    //code needed
}


#endif