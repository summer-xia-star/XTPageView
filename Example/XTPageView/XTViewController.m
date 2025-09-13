//
//  XTViewController.m
//  XTPageView
//
//  Created by summerrrxia on 09/11/2025.
//  Copyright (c) 2025 summerrrxia. All rights reserved.
//

#import "XTViewController.h"
#import "XTPageView-Swift.h"

@interface XTViewController ()

@property (nonatomic, strong) XTHoverPageViewController *hoverViewController;

@property (nonatomic, copy) NSArray<NSString *> *titles;

@property (nonatomic, strong) NSMutableArray<XTAnchorViewController *> *anchorViewCtl;

@end

@implementation XTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"VIP", @"看内容", @"VIP", @"看内容", @"VIP", @"看内容", @"VIP", @"看内容", @"看内容", @"看内容"];
    _anchorViewCtl = [NSMutableArray array];
    [_titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_anchorViewCtl addObject:[[XTAnchorViewController alloc] init]];
    }];
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = UIColor.redColor;
    _hoverViewController = [[XTHoverPageViewController alloc]
                            initWithChildViewControlls:_anchorViewCtl
                                headerView:headerView
                                headerViewHeight:300
                                titles:_titles];
    [self.view addSubview:_hoverViewController.view];
    _hoverViewController.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
}

@end
