//
//  CFISegmentedViewController.h
//  CFISegmentedViewController
//
//  Created by Robert Widmann on 8/3/13.
//  Copyright (c) 2013 Robert Widmann. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CFISegmentedViewControllerTransitionType) {
	CFISegmentedViewControllerTransitionTypeNone, // Equivalent to passing NO to any animated parameters.
	CFISegmentedViewControllerTransitionTypeCrossFade,
	CFISegmentedViewControllerTransitionTypeSlide
};

@protocol CFISegmentedViewControllerDelegate, CFISegmentedControl;

NS_CLASS_AVAILABLE_IOS(5_0) @interface CFISegmentedViewController : UIViewController <NSCoding> {
	UISegmentedControl *_segmentedControl;
	NSUInteger _selectedSegmentIndex;
}

/**
 * Creates and returns a segmented view controller with the given segmented
 * control class.  The provided class must implement the methods outlined in 
 * CFISegmentedControl.  Failure to do so will result in undefined behavior and
 * assertion failures.
 */
- (id)initWithSegmentedControlClass:(Class)controlClass;

/**
 * Sets the controller's view controller stack and forces a reload of the
 * segmented control.  Segments are automatically created with the title of the 
 * view controllers contained within the array.
 */
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;

/**
 * Sets the segmented control's selected index and adjusts the content view 
 * according to the control's transition type.
 */
- (void)setSelectedSegmentIndex:(NSUInteger)selectedIndex animated:(BOOL)flag;

/**
 * The view controllers associated with this view controller.  When this is set,
 * `setSelectedSegmentIndex:animated:` is called, and the tabs are reloaded
 * without animation.
 */
@property (nonatomic, copy) NSArray *viewControllers;

@property (nonatomic, assign) UIViewController *selectedViewController;
@property (nonatomic) CFISegmentedViewControllerTransitionType transitionType;
@property (nonatomic, readonly) UISegmentedControl *segmentedControl;

@property (nonatomic) NSUInteger selectedSegmentIndex;

@property (nonatomic, assign) id<CFISegmentedViewControllerDelegate> delegate;

/**
 * A hook that allows subclasses to layout the segmented control.
 */
- (void)layoutSegmentedControl;

@end

@interface UIViewController (CFISegmentedViewControllerItem)

/**
 * If the view controller has a segmented view controller as its ancestor, 
 * return it.  Otherwise return nil.
 */
@property (nonatomic, readonly, retain) CFISegmentedViewController *segmentedViewController;

@end

@protocol CFISegmentedViewControllerDelegate <NSObject>
@optional
- (BOOL)segmentedViewController:(CFISegmentedViewController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)segmentedViewController:(CFISegmentedViewController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@protocol CFISegmentedControl <NSObject>
@required
- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated;
- (void)removeAllSegments;

@end