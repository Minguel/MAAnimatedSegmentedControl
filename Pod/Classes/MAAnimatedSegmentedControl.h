//
//  MAAnimatedSegmentedControl.h
//  Pods
//
//  Created by Miguel A Aragones Castaneda on 15/10/15.
//
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface MAAnimatedSegmentedControl : UIControl

@property (nonatomic, copy) UIFont *font;
@property (nonatomic, copy) NSArray *items;

@property (nonatomic, readonly) IBInspectable NSUInteger selectedIndex;

@end
