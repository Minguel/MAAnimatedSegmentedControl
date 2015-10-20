//
//  MAViewController.m
//  MAAnimatedSegmentedControl
//
//  Created by Miguel Ángel Aragonés Castañeda on 10/15/2015.
//  Copyright (c) 2015 Miguel Ángel Aragonés Castañeda. All rights reserved.
//

#import "MAViewController.h"

#import "MAAnimatedSegmentedControl.h"

@interface MAViewController ()

@property (weak, nonatomic) IBOutlet MAAnimatedSegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, copy) NSArray *images;

@end

@implementation MAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.images = @[@"bttf", @"bttfII", @"bttfIII", @"bttfAll"];
    
    self.segmentedControl.items = @[@"Back", @"To", @"The", @"Future"];
    self.segmentedControl.font = [UIFont fontWithName:@"Avenir-Medium" size:16.f];
    
    [self.segmentedControl addTarget:self action:@selector(segmentedControlDidChangeIndex) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)segmentedControlDidChangeIndex
{
    CATransition *transition = [CATransition animation];
    transition.duration = .3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    self.imageView.image = [UIImage imageNamed:self.images[self.segmentedControl.selectedIndex]];
}

@end
