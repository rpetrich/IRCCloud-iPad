//
//  IRCCloudViewController.m
//  IRCCloud
//
//  Created by Ryan Petrich on 10-11-27.
//  Copyright 2010 Ryan Petrich. All rights reserved.
//

#import "IRCCloudViewController.h"

@implementation IRCCloudViewController

@synthesize webView = _webView;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	for (id scrollView in webView.subviews) {
		if ([scrollView respondsToSelector:@selector(setAlwaysBounceVertical:)])
			[scrollView setAlwaysBounceVertical:NO];
		if ([scrollView respondsToSelector:@selector(setAlwaysBounceHorizontal:)])
			[scrollView setAlwaysBounceHorizontal:NO];
		if ([scrollView respondsToSelector:@selector(setBounces:)])
			[scrollView setBounces:YES];
	}
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		NSURL *url = request.URL;
		if ([[url absoluteString] hasPrefix:@"https://irccloud.com/#"])
			return YES;
		if (![[UIApplication sharedApplication] openURL:url]) {
			UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Unable to load URL" message:[request.URL absoluteString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[av show];
			[av release];
		}
		return NO;
	}
	return YES;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://irccloud.com/"]]];
}

- (void)dealloc {
	if (_webView.delegate == self)
		_webView.delegate = nil;
	[_webView release];
    [super dealloc];
}

@end
