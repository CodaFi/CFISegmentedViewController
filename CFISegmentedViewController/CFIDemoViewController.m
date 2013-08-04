//
//  CFIDemoViewController.m
//  CFISegmentedViewController
//
//  Created by Robert Widmann on 8/3/13.
//  Copyright (c) 2013 Robert Widmann. All rights reserved.
//

#import "CFIDemoViewController.h"
#import "CFISegmentedControl.h"

@interface CFIDemoViewController ()

@end

@implementation CFIDemoViewController {
	CGRect _contentRect;
}

- (id)initWithContentRect:(CGRect)contentRect {
	self = [super initWithSegmentedControlClass:CFISegmentedControl.class];
	_contentRect = contentRect;
	self.transitionType = CFISegmentedViewControllerTransitionTypeCrossFade;
	return self;
}

- (void)loadView {
	UIView *view = [[UIView alloc]initWithFrame:_contentRect];
	view.backgroundColor = UIColor.clearColor;
	UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
	imageView.image = [UIImage imageNamed:@"Wallpaper.png"];
	[view addSubview:imageView];
	self.view = view;
}

- (void)layoutSegmentedControl {
	[super layoutSegmentedControl];
	self.segmentedControl.frame = CGRectOffset(self.segmentedControl.frame, 0, 22);
}

@end
