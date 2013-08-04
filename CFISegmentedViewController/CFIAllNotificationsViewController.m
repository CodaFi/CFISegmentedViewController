//
//  CFIAllNotificationsViewController.m
//  CFISegmentedViewController
//
//  Created by Robert Widmann on 8/3/13.
//  Copyright (c) 2013 Robert Widmann. All rights reserved.
//

#import "CFIAllNotificationsViewController.h"

static NSString *const CFIAllNotificationsIdentifier = @"CFIAllNotificationsIdentifier";

@interface CFINotificationHeaderView : UIView
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@end

@implementation CFINotificationHeaderView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
	self = [super initWithFrame:frame];
	
	self.backgroundColor = [UIColor colorWithRed:0.405 green:0.479 blue:0.534 alpha:1.000];
	
	return self;
}

@end

@interface CFIAllNotificationsViewController ()
@property (nonatomic, strong) NSArray *sectionHeaderTitles;
@end

@implementation CFIAllNotificationsViewController

- (id)init {
	self = [super init];
	_sectionHeaderTitles = @[ @"Messages", @"Calendar", @"Game Center" ];
	return self;
}

- (void)viewDidLoad {
	self.view.backgroundColor = UIColor.clearColor;
	[super viewDidLoad];
}

- (NSString *)title {
	return @"all";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CFIAllNotificationsIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CFIAllNotificationsIdentifier];
		cell.contentView.backgroundColor = UIColor.clearColor;
		cell.backgroundColor = UIColor.clearColor;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 1) {
		return 1;
	}
	return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return [[CFINotificationHeaderView alloc]initWithFrame:CGRectZero title:self.sectionHeaderTitles[section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 28.f;
}

@end
