//
//  ViewController.m
//  TurboOctoWookie
//
//  Created by Ariel Rodriguez on 3/21/15.
//  Copyright (c) 2015 Ariel Rodriguez. All rights reserved.
//

#import "ViewController.h"
#import "OverlayViewController.h"

@interface UIColor (RandomColor)
+ (UIColor *)randomColor;
@end

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor
{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
    
}

@end

@interface ViewController ()
@property (nonatomic, strong) UIWindow *overlay;

- (IBAction)changeColor:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIWindow *overlay = [[UIWindow alloc] initWithFrame:frame];
    [self setOverlay:overlay];
    [overlay setBackgroundColor:[UIColor clearColor]];
    [overlay setWindowLevel:UIWindowLevelAlert];
    [overlay setUserInteractionEnabled:NO];
    
    OverlayViewController *ovc = [[OverlayViewController alloc] initWithNibName:NSStringFromClass([OverlayViewController class]) bundle:nil];
    [overlay setRootViewController:ovc];
    
    [overlay setHidden:NO];
}

- (IBAction)changeColor:(id)sender {
    UIWindow *overlay = [self overlay];
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Test" message:@"Test message" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *changeColorAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        OverlayViewController *ovc = (OverlayViewController *)[overlay rootViewController];
        [[ovc thumb] setBackgroundColor:[UIColor randomColor]];
    }];
    [ac addAction:changeColorAction];
    [self presentViewController:ac animated:YES completion:NULL];
}
@end
