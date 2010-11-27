//
//  IRCCloudAppDelegate.h
//  IRCCloud
//
//  Created by Ryan Petrich on 10-11-27.
//  Copyright 2010 Ryan Petrich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IRCCloudViewController;

@interface IRCCloudAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IRCCloudViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IRCCloudViewController *viewController;

@end

