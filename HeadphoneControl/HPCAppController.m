//
//  HPCAppController.m
//  HeadphoneControl
//
//  Created by Aaron Morais on 2013-10-22.
//  Copyright (c) 2013 Aaron Morais. All rights reserved.
//

#import "HPCAppController.h"
#import "DDHidLib.h"

@interface HPCAppController ()
@property (nonatomic, retain) NSArray *mikeys;
@property (nonatomic, assign) BOOL relaunchOnLogin;
@end

typedef enum {
  KeyType_SOUND_UP = 0,
  KeyType_SOUND_DOWN = 1,
  KeyType_PLAY = 16,
  KeyType_NEXT = 19,
  KeyType_PREVIOUS = 20
} KeyType;

@implementation HPCAppController

- (void) awakeFromNib {
  //Create the NSStatusBar and set its length
  statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];

  //Used to detect where our files are
  NSBundle *bundle = [NSBundle mainBundle];

  //Allocates and loads the images into the application which will be used for our NSStatusItem
  statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon" ofType:@"png"]];
  statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon" ofType:@"png"]];

  //Sets the images in our NSStatusItem
  [statusItem setImage:statusImage];
  [statusItem setAlternateImage:statusHighlightImage];

  //Tells the NSStatusItem what menu to load
  [statusItem setMenu:statusMenu];
  //Sets the tooptip for our item
  [statusItem setToolTip:@"Headphone Control"];
  //Enables highlighting
  [statusItem setHighlightMode:YES];

  [self _setMikeysEnabled:YES];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [self setRelaunchOnLogin:[[defaults objectForKey:@"relaunchOnLogin"] boolValue]];
}

- (void)setRelaunchOnLogin:(BOOL)relaunchOnLogin {
  if (relaunchOnLogin) {
    [NSApp enableRelaunchOnLogin];
  } else {
    [NSApp disableRelaunchOnLogin];
  }
  startAtLoginMenuItem.state = (BOOL)relaunchOnLogin;
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSNumber numberWithBool:relaunchOnLogin] forKey:@"relaunchOnLogin"];
  _relaunchOnLogin = relaunchOnLogin;
}

- (IBAction)startAtLoginToggled:(id)sender {
  if (sender == startAtLoginMenuItem) {
    NSMenuItem *menuItem = (NSMenuItem *)sender;
    BOOL state = (BOOL)menuItem.state;
    [self setRelaunchOnLogin:!state];
  }
}

- (void)_setMikeysEnabled:(BOOL)enabled {
  if (enabled) {
    self.mikeys = [DDHidAppleMikey allMikeys];
    [self.mikeys makeObjectsPerformSelector:@selector(setDelegate:) withObject:self];
    [self.mikeys makeObjectsPerformSelector:@selector(startListening)];
  } else {
    [self.mikeys makeObjectsPerformSelector:@selector(setDelegate:) withObject:nil];
    [self.mikeys makeObjectsPerformSelector:@selector(stopListening)];
    self.mikeys = nil;
  }
}

- (void) _simulateMediaKeyPressWithKeyType:(KeyType)type {
  [self _simulateMediaKeyWithKeyType:type isDown:YES];
  [self _simulateMediaKeyWithKeyType:type isDown:NO];
}

// Source: http://stackoverflow.com/questions/11045814/emulate-media-key-press-on-mac
- (void) _simulateMediaKeyWithKeyType:(KeyType)type isDown:(BOOL)down {
  NSEvent *event = [NSEvent otherEventWithType:NSSystemDefined
                                      location:CGPointMake(0, 0)
                                 modifierFlags:down ? 0xa00 : 0xb00
                                     timestamp:0
                                  windowNumber:0
                                       context:0
                                       subtype:8
                                         data1:((type << 16) | ((down ? 0xa : 0xb) << 8))
                                         data2:-1];
  CGEventPost(0, event.CGEvent);
}

#pragma mark DDHidAppleMikey Delegate

- (void) ddhidAppleMikey:(DDHidAppleMikey *)mikey press:(unsigned int)usageId upOrDown:(BOOL)upOrDown {
  if(upOrDown) return;
  if(usageId == 137) {
    [self _simulateMediaKeyPressWithKeyType:KeyType_PLAY];
  } else if(usageId == 138) {
    [self _simulateMediaKeyPressWithKeyType:KeyType_NEXT];
  } else if(usageId == 139) {
    [self _simulateMediaKeyPressWithKeyType:KeyType_PREVIOUS];
  }
}

@end
