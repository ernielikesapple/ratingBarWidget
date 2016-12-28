//
//  RatingBar.m
//  my1stRatingbarDemo
//
//  Created by ernie.cheng on 12/27/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//
#import "RatingBar.h"
@interface RatingBar()
@property(nonatomic,strong)UIView *starBackgroundView;
@property(nonatomic,strong)UIView *starForegroundView;
@end
@implementation RatingBar
#pragma mark init Ratingbar View
-(id)initWithFrame:(CGRect)frame numberOfStar:(int)number{
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStars = number;
        self.starBackgroundView = [self setRatingBarImageWithName:unSelectedStar];
        self.starForegroundView = [self setRatingBarImageWithName:fullSelectedStar];
        [self addSubview:self.starBackgroundView];
        [self addSubview:self.starForegroundView];
    }
    return self;
}
-(UIView *)setRatingBarImageWithName:(NSString *)imageName{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.clipsToBounds = YES;   //❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓this line of code is crucial ,however ask mark what's the usage of it?????
    for (int i= 0; i < self.numberOfStars; i++) {
        UIImageView *imageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(frame.size.width/self.numberOfStars * i, 0, frame.size.width/self.numberOfStars, frame.size.height);
        [view addSubview:imageView];
    }
    return view;
}

#pragma mark obesering the User touch Event on screen
//listening to the pan like gesture,notice u can use UIPanGesture to deal such logic see https://github.com/yuyedaidao/RatingBar/blob/master/RatingBar/RatingBar.m
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{   UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(rect, point)) {
        [self resizeStarForegroundViewWithPoint:point];
    }
}
//listening to the tap gesture
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak __typeof(self) weakSelf = self;  //❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf resizeStarForegroundViewWithPoint:point];  //❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓❓
    }];
}

#pragma mark resize fore ground view to change the rating star dynamically    ----core part!has two versions:only allow half star shows and conversely
-(void)resizeStarForegroundViewWithPoint:(CGPoint)point{
    CGPoint loacalPoint = point;
    BOOL isZeroRating = NO; BOOL isFullRating = NO;
    if (loacalPoint.x <= 0) {loacalPoint.x = 0; isZeroRating = YES;}
    if (loacalPoint.x >= self.frame.size.width) {loacalPoint.x = self.frame.size.width; isFullRating = YES;}

    
    //    //只能含有半星处理
    //    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kBACKGROUND_STAR]];
    //    CGFloat width = imageView.frame.size.width;
    //    NSInteger count = (int)(p.x/width);
    //    float remainder = (p.x - count * width)/width;
    //    float coefficient = 0.0;
    //    NSLog(@"-%d--%f---%f----💣💣💣",count,remainder,p.x);
    //    if (remainder >= 0.5) {
    //        if (full) {
    //            coefficient = kNUMBER_OF_STAR;
    //        }else{
    //        coefficient = count+1;
    //        }
    //    }else{
    //        if (zero) {
    //            coefficient = 0;
    //        }else{
    //        coefficient = count+0.5;
    //        }}
    //
    //    self.starForegroundView.frame = CGRectMake(0, 0, width * coefficient, self.frame.size.height);
    //    //只有半星处理
    //    float score = coefficient;
    
    //全精确处理
    self.starForegroundView.frame = CGRectMake(0, 0, loacalPoint.x, self.frame.size.height);
    
    //polishing score number before put it into ratingBar lable to show
    NSString *str = [NSString stringWithFormat:@"%0.2f",loacalPoint.x / self.frame.size.width];
    float score = [str floatValue] * 10; // *10 determines the precision
    loacalPoint.x = score * self.frame.size.width;//?????????
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(RatingLabelScore:score:)]) {
        [self.delegate RatingLabelScore:self score:score];
    }
    
}






//#pragma mark - Set Score//设置初始值分数
//- (void)setScore:(float)score withAnimation:(bool)isAnimate
//{[self setScore:score withAnimation:isAnimate completion:^(BOOL finished){}];
//}
//- (void)setScore:(float)score withAnimation:(bool)isAnimate completion:(void (^)(BOOL finished))completion
//{NSAssert((score >= 0.0)&&(score <= 1.0), @"score must be between 0 and 1");if(score < 0){score = 0;}if(score > 1){score = 1;}
//    CGPoint point = CGPointMake(score * self.frame.size.width, 0);
//    if(isAnimate){
//        __weak __typeof(self)weakSelf = self;///??????????????????????????????????????????????????????????????????????
//        [UIView animateWithDuration:0.2 animations:^{
//            [weakSelf resizeStarForegroundViewWithPoint:point];
//        } completion:^(BOOL finished){
//            if (completion){
//                completion(finished);}}];
//    }else {[self resizeStarForegroundViewWithPoint:point];
//    }}

@end
