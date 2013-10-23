//
//  HPCAppController.h
//  HeadphoneControl
//
//  Created by Aaron Morais on 2013-10-22.
//  Copyright (c) 2013 Aaron Morais. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPCAppController : NSObject {
    IBOutlet NSMenu *statusMenu;
    IBOutlet NSMenuItem *startAtLoginMenuItem;

    NSStatusItem *statusItem;
    NSImage *statusImage;
    NSImage *statusHighlightImage;
}

- (IBAction)startAtLoginToggled:(id)sender;

@end
