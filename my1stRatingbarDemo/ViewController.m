//
//  ViewController.m
//  my1stRatingbarDemo
//
//  Created by ernie.cheng on 12/27/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "ViewController.h"
#include "RatingBar.h"

@interface ViewController ()<RatingBarLabelScoreDelegate>       //  <UIGestureRecognizerDelegate>
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) RatingBar *ratingBar1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ratingBar1 = [[RatingBar alloc]initWithFrame:CGRectMake(30, 200, 250, 50) numberOfStar:number_Of_Star];
    self.ratingBar1.delegate = self;
    [self.view addSubview:self.ratingBar1];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(30, 400, 250,50)];
    [self.view addSubview:self.label];
    
//     [self.starRatingView setScore:0.0f withAnimation:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)RatingLabelScore:(RatingBar *)view score:(float)score{
    if (view == self.ratingBar1) {
        self.label.text = [NSString stringWithFormat:@"your current score is : %0.1f",score];
    }
}


@end
