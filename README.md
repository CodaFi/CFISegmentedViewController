CFISegmentedViewController
==========================

A specialized view controller that organizes view controllers and allows navigation between them via a segmented control.

Setup
=====

This control requires iOS 5, and is compatible with both MRC and ARC.

Usage
=====

The control seeks to emulate UITabBarController’s interface as much as possible.  A typical application would subclass `CFISegmentedViewController`, then set its ‘viewControllers’ property, like so:

```Objective-C
self.viewController = [[CFIDemoViewController alloc]initWithContentRect:self.window.bounds];
[self.viewController setViewControllers:@[ [CFITodayViewController new], [CFIAllNotificationsViewController new], [CFIMissedViewController new] ]];
```

There is a small demo project included with the control that illustrates this fact along with tests compatible with both XCTest and Sen.

License
=======

This control is licensed under the [WTFPL](http://www.wtfpl.net).  Seriously.



