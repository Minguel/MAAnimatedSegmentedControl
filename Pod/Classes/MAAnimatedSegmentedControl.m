//
//  MAAnimatedSegmentedControl.m
//  Pods
//
//  Created by Miguel A Aragones Castaneda on 15/10/15.
//
//

#import "MAAnimatedSegmentedControl.h"

@interface MAAnimatedSegmentedControl ()

@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) UIView *thumbView;

@property (nonatomic, copy) IBInspectable UIColor *selectedLabelColor;
@property (nonatomic, copy) IBInspectable UIColor *unselectedLabelColor;
@property (nonatomic, copy) IBInspectable UIColor *thumbColor;
@property (nonatomic, copy) IBInspectable UIColor *borderColor;

@end

@implementation MAAnimatedSegmentedControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = 2.f;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.items = @[@"Fist1", @"Second2"];
    [self setupLabels];
    
    self.thumbView = [[UIView alloc] init];
    [self insertSubview:self.thumbView atIndex:0];
}

- (void)setupLabels
{
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        [label removeFromSuperview];
    }];
    
    [self.labels removeAllObjects];
    
    self.labels = [NSMutableArray array];
    
    [self.items enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = [[UILabel alloc] init];
        
        label.text = title;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        _font = _font ? _font : [UIFont fontWithName:@"Avenir-Black" size:15.f];
        label.font = self.font;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        [label sizeToFit];
        [self.labels addObject:label];
        
    }];
    
    [self addItemsConstraints:self.labels padding:0.f];
}

- (void)addItemsConstraints:(NSArray *)labels padding:(CGFloat)padding
{
    
    [labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                             constraintWithItem:label
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self
                                             attribute:NSLayoutAttributeTop
                                             multiplier:1.f 
                                             constant:0.f];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint
                                                constraintWithItem:label
                                                attribute:NSLayoutAttributeBottom
                                                relatedBy:NSLayoutRelationEqual
                                                toItem:self
                                                attribute:NSLayoutAttributeBottom
                                                multiplier:1.f
                                                constant:0.f];
        
        NSLayoutConstraint *rightConstraint = nil;
        
        if (idx == labels.count - 1) {
        
            rightConstraint = [NSLayoutConstraint constraintWithItem:label
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.f
                                                            constant:-padding];
                           
        } else {
            
            UILabel *nextLabel = labels[idx+1];
            rightConstraint = [NSLayoutConstraint constraintWithItem:label
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nextLabel
                                                           attribute:NSLayoutAttributeLeft 
                                                          multiplier:1.f
                                                            constant:-padding];
        }
        
        NSLayoutConstraint *leftConstraint;
        
        if (idx == 0) {
            
            leftConstraint = [NSLayoutConstraint constraintWithItem:label
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:padding];
            
        } else {
        
            UILabel *previousLabel = labels[idx-1];
            leftConstraint = [NSLayoutConstraint constraintWithItem:label
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:previousLabel
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.f
                                                           constant:padding];
            
            UILabel *firstItem = labels[0];
            
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                               attribute:NSLayoutAttributeWidth
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:firstItem
                                                                               attribute:NSLayoutAttributeWidth
                                                                              multiplier:1.f
                                                                                constant:0.f];
            [self addConstraint:widthConstraint];
        }
        
        [self addConstraints:@[topConstraint, bottomConstraint, rightConstraint, leftConstraint]];
        
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat newWidth = ceil(rect.size.width / self.items.count);
    rect.size.width = newWidth;
    self.thumbView.frame = rect;
    self.thumbView.backgroundColor = self.thumbColor;
    self.thumbView.layer.cornerRadius = rect.size.height / 2;
    self.layer.borderColor = self.borderColor.CGColor;
    
    [self displayNewSelectedIndex];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:self];
    
    __block NSUInteger calculatedIndex = NSNotFound;
    
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(label.frame, location)) {
            calculatedIndex = idx;
        }
    }];
    
    if (calculatedIndex != NSNotFound) {
        
        [self setSelectedIndex:calculatedIndex];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
    }
    
    return false;
}

- (void)displayNewSelectedIndex
{
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.textColor = self.unselectedLabelColor;
    }];
    
    UILabel *label = self.labels[self.selectedIndex];
    label.textColor = self.selectedLabelColor;
    
    [UIView animateWithDuration:.5f
                          delay:0.f
         usingSpringWithDamping:.5f
          initialSpringVelocity:.8f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.thumbView.frame = label.frame;
                         
                     } completion:nil];
}

- (void)setSelectedColors
{
    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.textColor = self.unselectedLabelColor;
    }];
    
    if (self.labels.count > 0) {
        ((UILabel *)self.labels[0]).textColor = self.selectedLabelColor;
    }
    
    self.thumbView.backgroundColor = self.thumbColor;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self setupLabels];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self displayNewSelectedIndex];
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self setupLabels];
}

@end
