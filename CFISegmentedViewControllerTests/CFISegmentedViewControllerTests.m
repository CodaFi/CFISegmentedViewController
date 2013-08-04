//
//  CFISegmentedViewControllerTests.m
//  CFISegmentedViewControllerTests
//
//  Created by Robert Widmann on 8/3/13.
//  Copyright (c) 2013 Robert Widmann. All rights reserved.
//

#import "CFISegmentedViewController.h"

#if __clang_major__ >= 5

#import <XCTest/XCTest.h>

@interface CFISegmentedViewControllerTests : XCTestCase
@property (nonatomic, strong) UIViewController *testSegmentViewController;
@end

@implementation CFISegmentedViewControllerTests

- (void)setUp {
	_testSegmentViewController = [UIViewController new];
	_testSegmentViewController.title = @"Test";
	[super setUp];
}

- (void)testInstantiation {
    CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	XCTAssertNotNil(controller, @"Expected controller to be instantiated properly");
	XCTAssertNotNil(controller.view, @"Expected controller to instantiate its view");
	XCTAssertNotNil(controller.segmentedControl, @"Expected controller to instantiate its segmented control");
	XCTAssertNil(controller.selectedViewController, @"Expected controller to instantiate its segmented control");
	XCTAssertNil(controller.delegate, @"Expected controller not to have a delegate");
}

- (void)testSelectedSegmentIndex {
	CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	XCTAssertEquals(controller.selectedSegmentIndex, (NSUInteger)NSNotFound, @"Expected controller to have no selection without view controllers");
	[controller setViewControllers:@[]];
	XCTAssertEquals(controller.selectedSegmentIndex, (NSUInteger)NSNotFound, @"Expected controller to have no selection without view controllers");
	[controller setViewControllers:@[ [UIViewController new], [UIViewController new]  ]];
	XCTAssertEquals(controller.selectedSegmentIndex, (NSUInteger)0, @"Expected controller to select the first view controller.");
	[controller setViewControllers:@[ [UIViewController new], [UIViewController new], [UIViewController new], [UIViewController new], [UIViewController new] ]];
	XCTAssertEquals(controller.selectedSegmentIndex, (NSUInteger)0, @"Expected controller to select the first view controller.");
}

- (void)testSegmentCount {
	CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	XCTAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)0, @"Expected segmented control to have no segments");
	[controller setViewControllers:@[]];
	XCTAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)0, @"Expected segmented control to have no segments");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController  ]];
	XCTAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)2, @"Expected segmented control to have the right number of segments.");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController ]];
	XCTAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)5, @"Expected segmented control to have the right number of segments.");
}

- (void)testSelectedViewController {
	CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	XCTAssertNil(controller.selectedViewController, @"Expected controller have no selected view controller");
	[controller setViewControllers:@[]];
	XCTAssertNil(controller.selectedViewController, @"Expected controller have no selected view controller");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController  ]];
	XCTAssertNotNil(controller.selectedViewController, @"Expected controller have a selected view controller");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController ]];
	XCTAssertNotNil(controller.selectedViewController, @"Expected controller have a selected view controller");
}

@end

#else

#import <SenTestingKit/SenTestingKit.h>

@interface CFISegmentedViewControllerTests : SenTestCase
@property (nonatomic, strong) UIViewController *testSegmentViewController;
@end

@implementation CFISegmentedViewControllerTests

- (void)setUp {
	_testSegmentViewController = [UIViewController new];
	_testSegmentViewController.title = @"Test";
	[super setUp];
}

- (void)testInstantiation {
    CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	STAssertNotNil(controller, @"Expected controller to be instantiated properly");
	STAssertNotNil(controller.view, @"Expected controller to instantiate its view");
	STAssertNotNil(controller.segmentedControl, @"Expected controller to instantiate its segmented control");
	STAssertNil(controller.selectedViewController, @"Expected controller to instantiate its segmented control");
	STAssertNil(controller.delegate, @"Expected controller not to have a delegate");
}

- (void)testSelectedSegmentIndex {
	CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	STAssertEquals(controller.selectedSegmentIndex, (NSUInteger)NSNotFound, @"Expected controller to have no selection without view controllers");
	[controller setViewControllers:@[]];
	STAssertEquals(controller.selectedSegmentIndex, (NSUInteger)NSNotFound, @"Expected controller to have no selection without view controllers");
	[controller setViewControllers:@[ [UIViewController new], [UIViewController new]  ]];
	STAssertEquals(controller.selectedSegmentIndex, (NSUInteger)0, @"Expected controller to select the first view controller.");
	[controller setViewControllers:@[ [UIViewController new], [UIViewController new], [UIViewController new], [UIViewController new], [UIViewController new] ]];
	STAssertEquals(controller.selectedSegmentIndex, (NSUInteger)0, @"Expected controller to select the first view controller.");
}

- (void)testSegmentCount {
	CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	STAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)0, @"Expected segmented control to have no segments");
	[controller setViewControllers:@[]];
	STAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)0, @"Expected segmented control to have no segments");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController  ]];
	STAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)2, @"Expected segmented control to have the right number of segments.");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController ]];
	STAssertEquals(controller.segmentedControl.numberOfSegments, (NSUInteger)5, @"Expected segmented control to have the right number of segments.");
}

- (void)testSelectedViewController {
	CFISegmentedViewController *controller = [[CFISegmentedViewController alloc]init];
	STAssertNil(controller.selectedViewController, @"Expected controller have no selected view controller");
	[controller setViewControllers:@[]];
	STAssertNil(controller.selectedViewController, @"Expected controller have no selected view controller");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController  ]];
	STAssertNotNil(controller.selectedViewController, @"Expected controller have a selected view controller");
	[controller setViewControllers:@[ _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController, _testSegmentViewController ]];
	STAssertNotNil(controller.selectedViewController, @"Expected controller have a selected view controller");
}

@end

#endif
