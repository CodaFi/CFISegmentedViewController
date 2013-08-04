//
//  CFIAppDelegate.m
//  CFISegmentedViewController
//
//  Created by Robert Widmann on 8/3/13.
//  Copyright (c) 2013 Robert Widmann. All rights reserved.
//

#import "CFIAppDelegate.h"
#import "CFIDemoViewController.h"
#import "CFITodayViewController.h"
#import "CFIAllNotificationsViewController.h"
#import "CFIMissedViewController.h"

@interface CFIAppDelegate ()
@property (nonatomic, strong) CFIDemoViewController *viewController;
@end

@implementation CFIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[CFIDemoViewController alloc]initWithContentRect:self.window.bounds];
	[self.viewController setViewControllers:@[ [CFITodayViewController new], [CFIAllNotificationsViewController new], [CFIMissedViewController new] ]];
	self.window.rootViewController = self.viewController;
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
	return YES;
}

@end
