//
//  TCViewController.m
//  LifePicsDemo
//
//  Copyright (c) 2014 Taylor Corp. All rights reserved.
//

#import "TCViewController.h"
#import "TCColorPickerViewController.h"
#import <LifePics/LifePics.h>
#import "TCSimpleImageDataSource.h"

@interface TCViewController () <TCColorPickerViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *versionLabel;
@property (nonatomic, weak) IBOutlet UIButton *primaryColorButton;
@property (nonatomic, weak) IBOutlet UIButton *secondaryColorButton;
@property (nonatomic, weak) IBOutlet UIButton *orderPrintsButton;

@property (nonatomic, strong) LPFSessionManager *sessionManager;
@property (nonatomic, strong) LPFOrderViewController *orderViewController;
@property (nonatomic, strong) LPFImageCenter *imageCenter;

@end


@implementation TCViewController


#pragma mark - UIViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.versionLabel.text = [self version];

    UIColor * const defaultPrimaryColor = [UIColor colorWithRed:0.36f green:0.69f blue:0.13f alpha:1.0f];
    UIColor * const defaultSecondaryColor = [UIColor colorWithRed:0.99f green:0.50f blue:0.14f alpha:1.0];

    self.orderPrintsButton.backgroundColor = defaultPrimaryColor;

    [self.primaryColorButton setTitleColor:defaultPrimaryColor forState:UIControlStateNormal];
    [self.secondaryColorButton setTitleColor:defaultSecondaryColor forState:UIControlStateNormal];

    [self connect];
}


#pragma mark - Private


- (void)connect
{
    // To keep this demo simple we're not going to properly handle errors here.
    // You should probably retry to connect when your application becomes active
    // or use Reachability to detect if the network settings have changed.
    // If you get an error you'll need to relaunch the demo to enable the Order Prints button again.

    NSString *partnerID = @"Partner ID";
    NSString *sourceID = @"Source ID";
    NSString *password = @"Password";

    if ([partnerID isEqualToString:@"Partner ID"]) {
        [[[UIAlertView alloc] initWithTitle:@"LifePics Partner ID Required"
                                   message:@"To fully explore this demo, you'll first need to get a LifePics partner ID. Put it in the TCViewController.m file. Details are provided in the ReadMe.\n\nWe'll take you as far as we can without a partner ID, but you'll see errors when trying to find photofinisher locations."
                                  delegate:nil
                         cancelButtonTitle:@"I’ll Get Right On That"
                         otherButtonTitles:nil] show];
    }
    else {
        [[LPFSessionManager sharedManager] beginPartnerSessionWithID:partnerID
                                                            sourceID:sourceID
                                                            password:password
                                                          completion:^(NSError *error) {
                                                              if ([error code] != 0) {
                                                                  self.orderPrintsButton.enabled = NO;
                                                                  self.orderPrintsButton.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];  // Fake disabled look.
                                                                  [[[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                                                              message:nil
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil] show];
                                                              }
                                                          }];
    }
}


- (NSString *)version
{
    NSString *versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"Version %@", versionNumber];
}


#pragma mark - TCColorPickerViewControllerDelegate


- (void)colorPickerViewController:(TCColorPickerViewController *)viewController didSelectColor:(UIColor *)color
{
    NSString *variableName = [viewController.userInfo objectForKey:@"TCAssociatedVariableName"];

    if ([variableName isEqualToString:@"primaryColor"]) {
        [self.primaryColorButton setTitleColor:color forState:UIControlStateNormal];
        self.orderPrintsButton.backgroundColor = color;
    }
    else if ([variableName isEqualToString:@"secondaryColor"]) {
        [self.secondaryColorButton setTitleColor:color forState:UIControlStateNormal];
    }
}


#pragma mark - Actions


- (IBAction)orderPrints:(id)sender
{
    TCSimpleImageDataSource *imageDataSource = [[TCSimpleImageDataSource alloc] init];
    LPFOrderViewController *vc = [[LPFOrderViewController alloc] initWithImageDataSource:imageDataSource];
    vc.primaryColor = self.primaryColorButton.currentTitleColor;
    vc.secondaryColor = self.secondaryColorButton.currentTitleColor;
    [self presentViewController:vc animated:YES completion:NULL];
}


- (IBAction)colorPicker:(UIButton *)sender
{
    TCColorPickerViewController *vc = [[TCColorPickerViewController alloc] init];
    vc.delegate = self;
    vc.color = sender.currentTitleColor;
    if (sender == self.primaryColorButton) {
        vc.userInfo = @{@"TCAssociatedVariableName" : @"primaryColor"};
        vc.title = @"Primary Color";
    }
    else {
        vc.userInfo = @{@"TCAssociatedVariableName" : @"secondaryColor"};
        vc.title = @"Secondary Color";
    }
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:NULL];
}


@end
