//
//  LPFOrderViewController.h
//  LifePics
//
//  Created by Dave Batton on 2/28/14.
//  Copyright (c) 2014 Taylor Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LifePics/LifePics.h>

@protocol LPFImageDataSource;
@class LPFFloatingNavigationView;
@class LPFStore;
@class LPFImageSelectionGroup;
@class LPFSizeQuantityViewController;

@protocol LPFOrderViewControllerDelegate;

@interface LPFOrderViewController : UINavigationController

@property (nonatomic, strong) LPFFloatingNavigationView *floatingNavigationView;
@property (nonatomic, strong) LPFCart *cart;
@property (nonatomic, strong) LPFImageSelectionGroup *imagesForPrintsOrder;
@property (nonatomic, readonly) UIEdgeInsets suggestedContentInset;
@property (nonatomic, readonly) UIEdgeInsets suggestedLowerContentInset;
@property (nonatomic, copy) UIColor *primaryColor;  // Default is green.
@property (nonatomic, copy) UIColor *secondaryColor;  // Default is orange.
@property (nonatomic, readonly) BOOL canShipToHome;
@property (nonatomic, readonly) LPFStore *genericStore;
@property (nonatomic, weak) id<LPFOrderViewControllerDelegate> orderDelegate;

+ (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication;

- (void)updateFloatingNavigationView;
- (LPFSizeQuantityViewController *)popToSizeQuantityViewControllerAnimated:(BOOL)animated;
- (instancetype)initWithImageDataSource:(id<LPFImageDataSource>)imageDataSource;
- (void)popToContinueShoppingViewControllerAnimated:(BOOL)animated;

@end


@protocol LPFOrderViewControllerDelegate

- (void)orderViewController:(LPFOrderViewController *)orderViewController didSubmitOrderWithCart:(LPFCart *)cart;
- (void)orderViewControllerDidCancel:(LPFOrderViewController *)orderViewController;

@end

