//
//  IRCCloudAppDelegate.m
//  IRCCloud
//
//  Created by Ryan Petrich on 10-11-27.
//  Copyright 2010 Ryan Petrich. All rights reserved.
//

#import "IRCCloudAppDelegate.h"
#import "IRCCloudViewController.h"
#import "URLOverrideCache.h"

@implementation IRCCloudAppDelegate

@synthesize window;
@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	URLOverrideCache *cache = [[URLOverrideCache alloc] initWithMemoryCapacity:1024 * 1024 diskCapacity:1024 * 1024 * 5 diskPath:@"cache"];
	[NSURLCache setSharedURLCache:cache];
	[cache release];
	
	if ([UIWindow instancesRespondToSelector:@selector(setRootViewController:)])
		self.window.rootViewController = viewController;
	else
		[self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

	return YES;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
