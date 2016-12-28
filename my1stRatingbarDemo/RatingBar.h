//
//  RatingBar.h
//  my1stRatingbarDemo
//
//  Created by ernie.cheng on 12/27/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//
#import <UIKit/UIKit.h>
#define unSelectedStar @"unSelected"
#define fullSelectedStar @"fullSelected"
#define number_Of_Star 5
@class RatingBar;
@protocol RatingBarLabelScoreDelegate<NSObject>
-(void)RatingLabelScore:(RatingBar *)view score:(float)score;
@end
@interface RatingBar : UIView
@property(nonatomic, readonly) int numberOfStars;
@property(nonatomic,weak)id<RatingBarLabelScoreDelegate>delegate;
//draw the ratingbar view
-(id)initWithFrame:(CGRect)frame numberOfStar:(int)number;




//an interface for programmer set the score from outside
-(void)setRatingBarSore:(float)score withAnimation:(bool)isAnimate;
-(void)setRatingBarScore:(float)score withAnimation:(bool)isAnimate completion:(void(^)(BOOL finished))completion;
@end
