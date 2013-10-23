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

    NSStatusItem *statusItem;
    NSImage *statusImage;
    NSImage *statusHighlightImage;
}

@end
