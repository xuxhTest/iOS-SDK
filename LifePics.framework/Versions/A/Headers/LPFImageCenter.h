//
//  LPFImageCenter.h
//  LifePics
//
//  Created by Dave Batton on 2/11/14.
//  Copyright (c) 2014 Taylor Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LifePics/LifePics.h>

@class LPFImage;
@class LPFImageSource;
@class LPFImageSelectionGroup;

@interface LPFImageCenter : NSObject

- (void)selectPhotosFromViewController:(UIViewController *)presentingViewController imageSource:(LPFImageSource *)imageSource imageGroup:(LPFImageSelectionGroup *)imagesForPrintOrder;
- (void)uploadImages:(NSArray *)image
           progress:(void (^)(NSInteger imageInProgress, NSInteger totalImages))progressBlock
         completion:(void (^)(NSError *error))completionBlock;

@end
