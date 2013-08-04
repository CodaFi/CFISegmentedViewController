//
//  CFISegmentedViewController.m
//  CFISegmentedViewController
//
//  Created by Robert Widmann on 8/3/13.
//  Copyright (c) 2013 Robert Widmann. All rights reserved.
//

#import "CFISegmentedViewController.h"

#if __has_feature(objc_arc)
#define CFI_SAFEBRIDGE(x) (__bridge x)
#define CFI_SAFEAUTORELEASE(x) x
#define CFI_SAFERELEASE(x)
#define CFI_SAFERETAIN(x) x
#define CFI_SAFEDEALLOC
#define CFI_SAFEATOMICRETVAL(x) x
#else
#define CFI_SAFEBRIDGE(x) (x)
#define CFI_SAFEAUTORELEASE(x) [x autorelease]
#define CFI_SAFERELEASE(x) [x release]
#define CFI_SAFERETAIN(x) [x retain]
#define CFI_SAFEDEALLOC [super dealloc]
#define CFI_SAFEATOMICRETVAL(x) [[x retain]autorelease]
#endif

@interface CFISegmentedViewController ()
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@end

@implementation CFISegmentedViewController {
	struct {
		unsigned int delegateShouldSelectViewController;
		unsigned int delegateDidSelectViewController;
	} _flags;
}

#pragma mark - Lifecycle

- (id)init {
	self = [super init];
	_selectedSegmentIndex = NSNotFound;
	CFICommonInit(self);
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	_selectedSegmentIndex = NSNotFound;
	CFICommonInit(self);
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	_selectedSegmentIndex = NSNotFound;
	CFICommonInit(self);
	return self;
}

- (id)initWithSegmentedControlClass:(Class)controlClass {
	NSParameterAssert(controlClass != Nil);
	NSParameterAssert([controlClass instancesRespondToSelector:@selector(insertSegmentWithTitle:atIndex:animated:)]);
	NSParameterAssert([controlClass instancesRespondToSelector:@selector(removeAllSegments)]);
	self = [self init];
	
	CFI_SAFERELEASE(_segmentedControl);
	_segmentedControl = nil;
	self.segmentedControl = CFI_SAFEAUTORELEASE([[controlClass alloc]initWithFrame:CGRectZero]);
	[self.segmentedControl addTarget:self action:@selector(updateSelectedSegment:) forControlEvents:UIControlEventValueChanged];
	
	return self;
}

- (void)dealloc {
    CFI_SAFERELEASE(_segmentedControl);
	_segmentedControl = nil;
    CFI_SAFEDEALLOC;
}

static void CFICommonInit(CFISegmentedViewController *self) {
	self.segmentedControl = CFI_SAFEAUTORELEASE([[UISegmentedControl alloc]initWithFrame:CGRectZero]);
	[self.segmentedControl addTarget:self action:@selector(updateSelectedSegment:) forControlEvents:UIControlEventValueChanged];
	self.contentView = CFI_SAFEAUTORELEASE([[UIView alloc]initWithFrame:CGRectZero]);
	self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {	
	CGRect slice, remainder;
	CGRectDivide(self.view.bounds, &slice, &remainder, 30, CGRectMinYEdge);
	_contentView.frame = remainder;

	[self.view addSubview:_contentView];
	[self.view addSubview:_segmentedControl];
		
	[super viewDidLoad];
	
	[self _reloadSegments:NO];
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
	CGRect slice, remainder;
	CGRectDivide(self.view.bounds, &slice, &remainder, 30, CGRectMinYEdge);
	[self layoutSegmentedControl];
	_contentView.frame = remainder;
}

- (void)layoutSegmentedControl {
	CGRect slice, remainder;
	CGRectDivide(self.view.bounds, &slice, &remainder, 30, CGRectMinYEdge);
	_segmentedControl.frame = CGRectInset(slice, 5, 0);
}

#pragma mark - Overrides

- (void)setDelegate:(id<CFISegmentedViewControllerDelegate>)delegate {
	_delegate = delegate;
	_flags.delegateShouldSelectViewController = [delegate respondsToSelector:@selector(segmentedViewController:shouldSelectViewController:)];
	_flags.delegateDidSelectViewController = [delegate respondsToSelector:@selector(segmentedViewController:didSelectViewController:)];
}

- (UISegmentedControl *)segmentedControl {
	return CFI_SAFEATOMICRETVAL(_segmentedControl);
}

- (void)setViewControllers:(NSArray *)viewControllers {
	[self setViewControllers:viewControllers animated:NO];
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)flag {
	_viewControllers = [viewControllers copy];

	UIViewController *oldSelectedViewController = self.selectedViewController;
    
	for (UIViewController *viewController in _viewControllers) {
		[viewController willMoveToParentViewController:nil];
		[viewController removeFromParentViewController];
	}
		
	NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if (newIndex != NSNotFound) {
		_selectedSegmentIndex = newIndex;
	} else if (newIndex < [_viewControllers count]) {
		_selectedSegmentIndex = newIndex;
	} else {
		_selectedSegmentIndex = 0;
	}
    
	for (UIViewController *viewController in _viewControllers) {
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
	}
    
	if ([self isViewLoaded])
		[self _reloadSegments:NO];
}

- (void)_reloadSegments:(BOOL)flag {
	_selectedSegmentIndex = NSNotFound;
	
	[self.segmentedControl removeAllSegments];
	NSUInteger index = 0;
	for (UIViewController *viewController in self.viewControllers) {
		[self.segmentedControl insertSegmentWithTitle:viewController.title atIndex:index animated:flag];
		index++;
	}
	
	if (index >= 1) {
		self.selectedSegmentIndex = 0;
	}
}

- (void)setSelectedSegmentIndex:(NSUInteger)selectedIndex {
	if (selectedIndex == NSNotFound) return;
	[self setSelectedSegmentIndex:selectedIndex animated:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)selectedIndex animated:(BOOL)flag {
	NSParameterAssert(selectedIndex < self.viewControllers.count);
	
	if (_flags.delegateShouldSelectViewController) {
		if (![self.delegate segmentedViewController:self shouldSelectViewController:[self.viewControllers objectAtIndex:selectedIndex]]) return;
	}
	
	if (!self.isViewLoaded) {
		_selectedSegmentIndex = selectedIndex;
	} else if (_selectedSegmentIndex != selectedIndex) {
		UIViewController *fromViewController = self.selectedViewController;
		UIViewController *toViewController = nil;
		
		NSUInteger oldSelectedIndex = _selectedSegmentIndex;
		_selectedSegmentIndex = selectedIndex;
		
		if (_selectedSegmentIndex != NSNotFound) {
            [self.segmentedControl setSelectedSegmentIndex:_selectedSegmentIndex];
			toViewController = self.selectedViewController;
		}
		
		if (!toViewController) {
			[fromViewController.view removeFromSuperview];
		} else if (!fromViewController) {
			toViewController.view.frame = self.contentView.bounds;
			[self.contentView addSubview:toViewController.view];
			
			if (_flags.delegateDidSelectViewController) {
				[self.delegate segmentedViewController:self didSelectViewController:[self.viewControllers objectAtIndex:selectedIndex]];
			}
		} else if (flag && self.transitionType != 0) {
			CGRect rect = self.contentView.bounds;
			if (self.transitionType == CFISegmentedViewControllerTransitionTypeSlide) {
				if (oldSelectedIndex < selectedIndex) {
					rect.origin.x = rect.size.width;
				} else {
					rect.origin.x = -rect.size.width;
				}
			}
			toViewController.view.frame = rect;
			self.segmentedControl.userInteractionEnabled = NO;
		
			[self transitionFromViewController:fromViewController
							  toViewController:toViewController
									  duration:0.3
									   options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
									animations:^{
										switch (self.transitionType) {
											case CFISegmentedViewControllerTransitionTypeCrossFade: {
												fromViewController.view.alpha = 0.f;
												toViewController.view.alpha = 1.f;
											}
												break;
											case CFISegmentedViewControllerTransitionTypeSlide: {
												CGRect rect = fromViewController.view.frame;
												if (oldSelectedIndex < selectedIndex)
													rect.origin.x = -rect.size.width;
												else
													rect.origin.x = rect.size.width;
												
												fromViewController.view.frame = rect;
												toViewController.view.frame = self.contentView.bounds;
											}
												break;
											default:
												break;
										}
									}
									completion:^(BOOL finished) {
										self.segmentedControl.userInteractionEnabled = YES;
										
										if (_flags.delegateDidSelectViewController) {
											[self.delegate segmentedViewController:self didSelectViewController:[self.viewControllers objectAtIndex:selectedIndex]];
										}
									}];
		} else {
			[fromViewController.view removeFromSuperview];
			
			toViewController.view.frame = self.contentView.bounds;
			[self.contentView addSubview:toViewController.view];
			
			if (_flags.delegateDidSelectViewController) {
				[self.delegate segmentedViewController:self didSelectViewController:[self.viewControllers objectAtIndex:selectedIndex]];
			}
		}
	}
}

- (void)updateSelectedSegment:(UISegmentedControl *)sender {
	[self setSelectedSegmentIndex:sender.selectedSegmentIndex animated:YES];
}

- (UIViewController *)selectedViewController {
	if (self.selectedSegmentIndex != NSNotFound) {
		return [self.viewControllers objectAtIndex:self.selectedSegmentIndex];
	}
	return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController {
	[self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated {
	NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
	if (index != NSNotFound) {
		[self setSelectedSegmentIndex:index animated:animated];
	}
}

@end

@implementation UIViewController (CFISegmentedViewControllerItem)

- (CFISegmentedViewController *)segmentedViewController {
	UIViewController *currentViewController = self;
	while (currentViewController.parentViewController != nil) {
		currentViewController = self.parentViewController;
		if ([currentViewController isKindOfClass:CFISegmentedViewController.class]) {
			return (CFISegmentedViewController *)currentViewController;
		}
	}
	return nil;
}

@end

