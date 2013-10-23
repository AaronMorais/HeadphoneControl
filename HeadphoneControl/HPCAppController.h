//
//  HPCAppController.h
//  HeadphoneControl
//
//  Created by Aaron Morais on 2013-10-22.
//  Copyright (c) 2013 Aaron Morais. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPCAppController : NSObject {
/* Our outlets which allow us to access the interface */
IBOutlet NSMenu *statusMenu;

/* The other stuff :P */
NSStatusItem *statusItem;
NSImage *statusImage;
NSImage *statusHighlightImage;
}

/* Our IBAction which will call the helloWorld method when our connected Menu Item is pressed */
-(IBAction)helloWorld:(id)sender;

@end
