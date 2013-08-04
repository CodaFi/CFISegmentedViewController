//
//  CFIMissedViewController.m
//  CFISegmentedViewController
//
//  Created by Robert Widmann on 8/3/13.
//  Copyright (c) 2013 Robert Widmann. All rights reserved.
//

#import "CFIMissedViewController.h"

static NSString *const CFIMissedNotificationsIdentifier = @"CFIMissedNotificationsIdentifier";

@interface CFIMissedViewController ()
@end

@implementation CFIMissedViewController

- (id)init {
	self = [super init];
	return self;
}

- (void)viewDidLoad {
	self.view.backgroundColor = UIColor.clearColor;
	[super viewDidLoad];
}

- (NSString *)title {
	return @"missed";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CFIMissedNotificationsIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CFIMissedNotificationsIdentifier];
		cell.contentView.backgroundColor = UIColor.clearColor;
		cell.backgroundColor = UIColor.clearColor;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100.f;
}

@end
