//
//  ViewController.h
//  FitPay
//
//  Created by Robert Crosby on 4/5/15.
//  Copyright (c) 2015 Robert Crosby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <QuartzCore/QuartzCore.h>
#import <iAd/iAd.h>
#import "BFPaperButton.h"
#import "UIColor+BFPaperColors.h"
#import <Parse/Parse.h>
#import <Social/Social.h>


@interface ViewController : UIViewController  <UITextFieldDelegate,ADBannerViewDelegate,UIAlertViewDelegate> {
    NSNumber *stepstaken,*bitcoin,*conversionrate;

}
@property (weak, nonatomic) IBOutlet UIScrollView *overall;

// Get step count
@property (nonatomic, strong) CMPedometer *steps;

// UI
@property (weak, nonatomic) IBOutlet UILabel *card;
@property (weak, nonatomic) IBOutlet UILabel *stepslabel;
@property (weak, nonatomic) IBOutlet UILabel *menubar;
@property (weak, nonatomic) IBOutlet UILabel *mbtclabel;
@property (weak, nonatomic) IBOutlet UILabel *card2;
@property (weak, nonatomic) IBOutlet UILabel *card3;
@property (weak, nonatomic) IBOutlet UITextField *btcaddress;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIButton *transferbutton;
@property (weak, nonatomic) IBOutlet UILabel *card4;
@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;
@property (weak, nonatomic) IBOutlet UIButton *helpbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll5;
@property (weak, nonatomic) IBOutlet UIButton *mebutton;

// Help
@property (weak, nonatomic) IBOutlet UILabel *helpcard;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *card5;


@end

