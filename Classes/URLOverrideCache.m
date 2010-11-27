//
//  URLOverrideCache.m
//  IRCCloud
//
//  Created by Ryan Petrich on 10-11-27.
//  Copyright 2010 Ryan Petrich. All rights reserved.
//

#import "URLOverrideCache.h"

#define HEAD_CONTENT_TO_ADD @ \
"<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no\">" \
"<style>" \
"* { -webkit-text-size-adjust:none;	-webkit-touch-callout:none; -webkit-tap-highlight-color:rgba(0,0,0,0); }" \
"textarea { -webkit-appearance:none; }" \
"#sidebar { width:175px!important; }" \
"#buffers { margin:0!important; }" \
"#bufferView { margin: 0 175px 0 0!important; border:none; border-right:1px solid #86B1ED; border-radius:0!important; }" \
"#statusBar { margin-left:-176px!important; margin-right:176px!important; }" \
"</style>"

#define BODY_CONTENT_TO_ADD @ \
"<script>" \
"document.body.ontouchmove = function(e) { e.preventDefault; };" \
"</script>"

@implementation URLOverrideCache

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
	NSLog(@"Cache check for request: %@", request);
	if ([[request.URL absoluteString] isEqualToString:@"https://irccloud.com/"]) {
		if (![[request valueForHTTPHeaderField:@"X-CacheData"] isEqualToString:@"Ignore"]) {
			NSMutableURLRequest *modifiedRequest = [[request mutableCopy] autorelease];
			[modifiedRequest setValue:@"Ignore" forHTTPHeaderField:@"X-CacheData"];
			NSURLResponse *response = nil;
			NSError *error = nil;
			NSData *data = [NSURLConnection sendSynchronousRequest:modifiedRequest returningResponse:&response error:&error];
			if (data) {
				NSMutableString *text = [[NSMutableString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
				if (text) {
					[text replaceOccurrencesOfString:@"</head>" withString:HEAD_CONTENT_TO_ADD"</head>" options:0 range:NSMakeRange(0, [text length])];
					[text replaceOccurrencesOfString:@"</body>" withString:BODY_CONTENT_TO_ADD"</body>" options:0 range:NSMakeRange(0, [text length])];
					data = [text dataUsingEncoding:NSUTF8StringEncoding];
					[text release];
				}
				return [[[NSCachedURLResponse alloc] initWithResponse:response data:data] autorelease];
			}
		}
	}
	return nil;
}

@end
