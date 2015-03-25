//
//  ViewController.m
//  progressCircleBar
//
//  Created by 李蝉 on 15/3/25.
//  Copyright (c) 2015年 宜信-宜定盈. All rights reserved.
//

#import "ViewController.h"
#import "BGCircleView.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet BGCircleView *circleView;
@property (nonatomic,assign)CGFloat progressRate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//action
- (IBAction)ButtonPressed:(id)sender
{
    _progressRate += 20;
    
    if (_progressRate <= 100) {
         [_circleView setProgressRate:_progressRate totle:100 animated:YES];
    }
    
   
}



@end
