//
//  BGCircleView.m
//  progressCircleBar
//
//  Created by 李蝉 on 15/3/25.
//  Copyright (c) 2015年 宜信-宜定盈. All rights reserved.
//

#import "BGCircleView.h"

#define PROGRESS_LINE_WIDTH 20 //弧线的宽度
#define PROGRESS_SMALL_LINE_WIDTH 10 //小弧线的宽度
#define MAIN_SCREEN_ANIMATION_TIME 2 //动画时间

//找到最少的高度/长度
#define RADIUS CGRectGetWidth(self.frame) > CGRectGetHeight(self.frame) ? CGRectGetHeight(self.frame)/2 : CGRectGetWidth(self.frame)/2


@interface BGCircleView ()
@property(nonatomic)CAShapeLayer * shapelayer;
@property(nonatomic)CAShapeLayer * inShapelayer;
@property(nonatomic)CAShapeLayer * progressLayer;
@property (nonatomic,assign)CGFloat progressRate;
@end

@implementation BGCircleView


//绘制上下文
- (UIBezierPath*)createArcPathWithRadius:(CGFloat)radius circleWidth:(CGFloat)width
{
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2,CGRectGetWidth(self.frame)/2) radius:radius-width/2 startAngle:1.5 * M_PI endAngle:1.499 * M_PI clockwise:YES];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSLog(@"%f",self.frame.size.height);
    NSLog(@"%f",self.frame.size.width);
    _shapelayer = [CAShapeLayer layer];//创建一个track shape layer
    _shapelayer.frame = self.bounds;
    [self.layer addSublayer:_shapelayer];
    _shapelayer.fillColor = [[UIColor clearColor] CGColor];
    _shapelayer.strokeColor = [[UIColor colorWithRed:1.0 green:106.0/255.0 blue:89.0/255.0 alpha:0.25] CGColor];//指定path的渲染颜色
//    _shapelayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _shapelayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _shapelayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    UIBezierPath *path = [self createArcPathWithRadius:RADIUS circleWidth:PROGRESS_LINE_WIDTH];//上面说明过了用来构建圆形
    _shapelayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    
    _inShapelayer = [CAShapeLayer layer];//创建一个track shape layer
    _inShapelayer.frame = self.bounds;
   [self.layer addSublayer:_inShapelayer];
    _inShapelayer.fillColor = [[UIColor clearColor] CGColor];
    _inShapelayer.strokeColor = [[UIColor colorWithRed:248.0/255.0 green:57.0/255.0 blue:50.0/255.0 alpha:0.35] CGColor];//指定path的渲染颜色
//    _inShapelayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _inShapelayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _inShapelayer.lineWidth = PROGRESS_SMALL_LINE_WIDTH;//线的宽度
    UIBezierPath *inPath = [self createArcPathWithRadius:RADIUS-PROGRESS_LINE_WIDTH circleWidth:PROGRESS_SMALL_LINE_WIDTH];//上面说明过了用来构建圆形
    _inShapelayer.path =[inPath CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。

    //进度条
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor = [[UIColor colorWithRed:244.0/255.0 green:110.0/255.0 blue:78.0/255.0 alpha:1.0] CGColor];//指定path的渲染颜色
    //_progressLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;//线的宽度
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = _progressRate;
    [self.layer addSublayer:_progressLayer];
    
}


- (void)setProgressRate:(CGFloat)progressRate totle:(CGFloat)totleNumber animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:MAIN_SCREEN_ANIMATION_TIME];
    _progressLayer.strokeEnd = progressRate/totleNumber;
    [CATransaction commit];
    _progressRate = progressRate;
}








// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    //绘制背景圆形
//    //外环宽度
//    CGFloat waiWidth = 25;
//    //内环宽度
//    CGFloat neiWidth = 10;
//    
//    //外圈
//     CGContextRef context = UIGraphicsGetCurrentContext();
//      CGContextSetRGBFillColor (context,255/255,106/255,89/255,0.4);//设置填充颜色
//     CGContextFillEllipseInRect(context, CGRectMake(0,0,CGRectGetWidth(self.frame),CGRectGetWidth(self.frame)));
//    
//    //内圈
//    CGContextSetRGBFillColor (context,248/255,57/255,50/255,0.5);//设置填充颜色
//    CGContextFillEllipseInRect(context, CGRectMake(waiWidth,waiWidth,CGRectGetWidth(self.frame)-2*waiWidth,CGRectGetWidth(self.frame)-2*waiWidth));
//    
//    //白色背景
//    CGContextSetRGBFillColor (context,1,1,1,1.0);//设置填充颜色
//    CGContextFillEllipseInRect(context, CGRectMake(waiWidth+neiWidth,waiWidth+neiWidth,CGRectGetWidth(self.frame)-2*(waiWidth+neiWidth),CGRectGetWidth(self.frame)-2*(waiWidth+neiWidth)));
//}

- (void)drawRect:(CGRect)rect {
    // Drawing code

}






@end
