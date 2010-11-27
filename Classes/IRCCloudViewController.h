//
//  IRCCloudViewController.h
//  IRCCloud
//
//  Created by Ryan Petrich on 10-11-27.
//  Copyright 2010 Ryan Petrich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IRCCloudViewController : UIViewController<UIWebViewDelegate> {
@private
	UIWebView *_webView;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end

