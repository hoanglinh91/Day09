//
//  ViewController.m
//  autoLayout
//
//  Created by MAC on 10/25/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong , nonatomic) NSArray *myArray;
@property (strong , nonatomic) NSArray *array;
@property (strong , nonatomic) NSLayoutConstraint *cst;
@end

static int dem;
@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    dem = 0;
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"face1"]];
    UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"face2"]];
    UIImageView *img3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"face3"]];
//    img1.backgroundColor =[UIColor blackColor];
//    img2.backgroundColor =[UIColor blackColor];
//    img3.backgroundColor =[UIColor blackColor];
    [img1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [img2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [img3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:img1];
    [self.view addSubview:img2];
    [self.view addSubview:img3];
    _myArray = @[img1,img2,img3];
}

-(void)constrantViewHor:(UIImageView *)img1 :(UIImageView *)img2 :(UIImageView *)img3
{
    UIView *superview = self.view;
    NSDictionary *group = NSDictionaryOfVariableBindings(img1,img2,img3,superview);
    
    _array = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[img1(img2)]-20-[img2(img3)]-20-[img3]-30-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:group];
    
    [self.view addConstraints:_array];

    _cst = [NSLayoutConstraint constraintWithItem:img1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-230];
    // self.view.center.y
    NSLog(@"%2.1f",self.view.center.y);
    [self.view addConstraint:_cst];
}

-(void)constrantViewVer:(UIImageView *)img1 :(UIImageView *)img2 :(UIImageView *)img3
{
    UIView *superview = self.view;
    NSDictionary *group = NSDictionaryOfVariableBindings(img1,img2,img3,superview);
    
    _array = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[img1(img2)]-20-[img2(img3)]-20-[img3]-30-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:group];
    
    [self.view addConstraints:_array];
    
    _cst = [NSLayoutConstraint constraintWithItem:img1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-230];
    //self.view.center.y
    NSLog(@"%2.1f",self.view.center.y);
    [self.view addConstraint:_cst];
}


-(void)viewWillLayoutSubviews{
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight || self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self.view removeConstraint:_cst];
        [self.view removeConstraints:_array];
        [self constrantViewVer:_myArray[0] :_myArray[1] :_myArray[2]];
        dem++;
    }
    else
    {
        
        if (dem) {
            [self.view removeConstraint:_cst];
            [self.view removeConstraints:_array];
        }
        [self constrantViewHor:_myArray[0] :_myArray[1] :_myArray[2]];
        dem++;
    }
}

-(void)viewDidLayoutSubviews
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
