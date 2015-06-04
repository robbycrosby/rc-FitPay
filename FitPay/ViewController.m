//
//  ViewController.m
//  FitPay
//
//  Created by Robert Crosby on 4/5/15.
//  Copyright (c) 2015 Robert Crosby. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
-(void) viewWillAppear:(BOOL)animated {
    if (IS_IPHONE_4) {
        [self cellshader:_menubar];
        [self cellshader:_card];
        [self cellshader:_card2];
        [self cellshader:_card3];
        [self cellshader:_card4];
        [self cellshader:_card5];
        [_scroll setFrame:CGRectMake(0, 100, 320, 380)];
        [_scroll setContentSize:CGSizeMake(320, 740)];
    }
    else if( IS_IPHONE_5 )
    {
        
        [self cellshader:_menubar];
        [self cellshader:_card];
        [self cellshader:_card2];
        [self cellshader:_card3];
        [self cellshader:_card4];
        [self cellshader:_card5];
        [_scroll setContentSize:CGSizeMake(320, 658)];
    }
    else
    {
        [self cellshader:_menubar];
        [self cellshader:_card];
        [self cellshader:_card2];
        [self cellshader:_card3];
        [self cellshader:_card4];
        [self cellshader:_card5];
        [_scroll setContentSize:CGSizeMake(375, 658)];
    }
    
}





-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


-(void)viewDidAppear:(BOOL)animated {
    NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"runs"];
    if (x == 1) {
        NSDate *now = [NSDate date];
        NSDate *ago = [now dateByAddingTimeInterval:-60*60*24*1];
        _steps = [[CMPedometer alloc]init];
        [_steps queryPedometerDataFromDate:ago toDate:now withHandler:^(CMPedometerData *pedometerData, NSError *error)
         {
             if (error)
             {
                 _stepslabel.text = @"Error";
                 _mbtclabel.text = @"😞";
                 
             } else {
                 stepstaken = pedometerData.numberOfSteps;
                 //stepstaken = [NSNumber numberWithInt:5001];
                 _stepslabel.text = [NSString stringWithFormat:@"%@",stepstaken];
                 [self conversion];
             }
         }];
    }
    
    }

- (void)viewDidLoad {
    _btcaddress.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"bitcoin"];
    BFPaperButton *raisedPaperButton = [[BFPaperButton alloc] initWithFrame:_transferbutton.frame raised:YES];
    [raisedPaperButton setShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.0f]];
    [raisedPaperButton setTitle:@"Transfer" forState:UIControlStateNormal];
    raisedPaperButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [raisedPaperButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [raisedPaperButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    raisedPaperButton.titleFont = [UIFont fontWithName:@"Avenir Next Medium" size:20];
    [self.view addSubview:raisedPaperButton];
    [raisedPaperButton addTarget:self action:@selector(transferbtc) forControlEvents:UIControlEventTouchUpInside];
    raisedPaperButton.rippleBeyondBounds = YES;
    BFPaperButton *raisedhelp = [[BFPaperButton alloc] initWithFrame:_helpbutton.frame raised:YES];
    [raisedhelp setTitle:@"?" forState:UIControlStateNormal];
    raisedhelp.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    [raisedhelp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [raisedhelp setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    raisedhelp.titleFont = [UIFont fontWithName:@"Avenir Next Medium" size:20];
    [raisedhelp setShadowColor:[[UIColor whiteColor] colorWithAlphaComponent:0.0f]];
    raisedhelp.rippleBeyondBounds = YES;
    [self.view addSubview:raisedhelp];
    
    [raisedhelp addTarget:self action:@selector(showhelp) forControlEvents:UIControlEventTouchUpInside];

    [super viewDidLoad];
    [self timesincelast];
    self.adBanner.delegate = self;
    NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"runs"];
    if (x > 1) {
        NSDate *now = [NSDate date];
        NSDate *ago = [now dateByAddingTimeInterval:-60*60*24*1];
        _steps = [[CMPedometer alloc]init];
        [_steps queryPedometerDataFromDate:ago toDate:now withHandler:^(CMPedometerData *pedometerData, NSError *error)
         {
             if (error)
             {
                 _stepslabel.text = @"Error";
                 _mbtclabel.text = @"😞";
                 
             } else {
                 stepstaken = pedometerData.numberOfSteps;
                 //stepstaken = [NSNumber numberWithInt:5001];
                 _stepslabel.text = [NSString stringWithFormat:@"%@",stepstaken];
                 [self conversion];
             }
         }];
    }

        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)conversion{
    // 5000 Steps = 1 mBTC
    float btc = stepstaken.floatValue / 5000;
    NSLog(@"%f",btc);
    bitcoin = [NSNumber numberWithFloat:btc];
    _mbtclabel.text = [NSString stringWithFormat:@"%@",bitcoin];
}


-(void)cellshader:(UILabel*)button{
    button.maskView.layer.cornerRadius = 4.0f;
    button.layer.shadowRadius = 2.0f;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 2.5f);
    button.layer.shadowOpacity = 0.3f;
    button.layer.masksToBounds = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_address resignFirstResponder];
    if (IS_IPHONE_4) {
        [_scroll setContentSize:CGSizeMake(320, 740)];
        [_scroll setContentOffset:CGPointMake(0, 280) animated:YES];
    }
    else if (IS_IPHONE_5) {
        [_scroll setContentSize:CGSizeMake(320, 658)];
    } else {
        [_scroll setContentSize:CGSizeMake(375, 658)];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"bitcoin"];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (IS_IPHONE_4) {
        [_scroll setContentSize:CGSizeMake(320, 950)];
        [_scroll setContentOffset:CGPointMake(0, 480) animated:YES];
    }
    else if (IS_IPHONE_5) {
        [_scroll setContentSize:CGSizeMake(320, 898)];
        [_scroll setContentOffset:CGPointMake(0, 375) animated:YES];
    } else {
        [_scroll setContentSize:CGSizeMake(375, 898)];
        [_scroll setContentOffset:CGPointMake(0, 375) animated:YES];
    }

    return YES;
}

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    return YES;
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
}

-(void)transferbtc{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Transfer Request Ready"
                                                    message:@"You will not be able to make another request for at least 24 hours."
                                                   delegate:self
                                          cancelButtonTitle:@"Forget It"
                                          otherButtonTitles:@"Confirm",nil];
    [alert show];
}

-(void)showhelp{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"How It Works"
                                                    message:@"Using your iPhone's HealthKit Data, FitCoin will use the steps you record throughout the day and convert them to Bitcoin. To use this, you need a Bitcoin Wallet. Use the buttons below to do so. A minimum withdrawal of 1 mBTC is required."
                                                   delegate:self
                                          cancelButtonTitle:@"Got It"
                                          otherButtonTitles:@"Use Coinbase (Cloud)",@"Use Breadwallet (iOS)",@"Privacy Information",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    if([buttonTitle isEqualToString:@"Confirm"]) {
        NSDate *day = [[NSUserDefaults standardUserDefaults] objectForKey:@"day"];
        if (_btcaddress.text.length < 1) {
            UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Enter Your Bitcoin Address"
                                                            message:@"Scroll to the bottom to do so."
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:nil, nil];
            [toast show];
            
            int duration = 2; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [toast dismissWithClickedButtonIndex:0 animated:YES];
            });
        } else {
            if (!day) {
                [self sendtransaction];
            } else {
                NSDate *lastday = [[NSUserDefaults standardUserDefaults] objectForKey:@"day"];
                NSDate *today = [NSDate date];
                NSTimeInterval distanceBetweenDates = [lastday timeIntervalSinceDate:today];
                double secondsInAnHour = 3600;
                NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
                if (hoursBetweenDates < -23.9) {
                    [self sendtransaction];
                } else {
                    NSLog(@"%ld",(long)hoursBetweenDates);
                    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Slow Down Cowboy"
                                                                    message:@"Need to wait at least 24 hours everytime."
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:nil, nil];
                    [toast show];
                    
                    int duration = 2; // duration in seconds
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [toast dismissWithClickedButtonIndex:0 animated:YES];
                    });
                    
                }
            }
        }
        
            }
    if ([buttonTitle isEqualToString:@"Use Coinbase (Cloud)"]) {
        NSString *iTunesLink = @"https://www.coinbase.com/";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
    if ([buttonTitle isEqualToString:@"Use Breadwallet (iOS)"]) {
        NSString *iTunesLink = @"https://itunes.apple.com/us/app/breadwallet-bitcoin-wallet/id885251393?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
    if ([buttonTitle isEqualToString:@"Sure!"]) {
        NSString *iTunesLink = @"https://itunes.apple.com/us/app/fitcoin/id982863828?ls=1&mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
    if ([buttonTitle isEqualToString:@"Tweet The App!"]) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"I just got free bitcoin by working out using #FitCoin for iOS Download it here: https://itunes.apple.com/us/app/fitcoin/id982863828?ls=1&mt=8"];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
    }
    
    if ([buttonTitle isEqualToString:@"Privacy Information"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Privacy"
                                                        message:@"FitCoin only uses HealthKit's pedometer data. This data is never shared with any 3rd-party sources."
                                                       delegate:self
                                              cancelButtonTitle:@"Got It"
                                              otherButtonTitles:nil];
        [alert show];
    }
    

}




-(void)sendtransaction{
    NSString *btc = [[NSUserDefaults standardUserDefaults] objectForKey:@"bitcoin"];
    if ((stepstaken.floatValue < 5000) || (!btc)) {
        UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Yikes"
                                                        message:@"You need to either get to 1 mBTC or enter your Bitcoin Address on the homescreen."
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:nil, nil];
        [toast show];
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });

    } else {
        
        PFObject *gameScore = [PFObject objectWithClassName:@"Transactions"];
        gameScore[@"address"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"bitcoin"];
        gameScore[@"amount"] = bitcoin;
        [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSInteger x = [[NSUserDefaults standardUserDefaults] integerForKey:@"runs"];
                if (x == 9) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"That's A Lot Of Transfers!"
                                                                    message:@"Looks like you really like FitCoin! Help spread the wealth by leaving us a review, it really helps!"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Eh, Not Now"
                                                          otherButtonTitles:@"Sure!",nil];
                    [alert show];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"day"];
                } else {
                    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:@"Confirmation Recieved"
                                                                    message:@"Start Walking for Tomorrow! Requests generally take around 12 hours to process."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Awesome!"
                                                          otherButtonTitles:nil];
                    [toast show];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"day"];
                }
                
                            } else {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Connection"
                                                                                message:@"Try again later"
                                                                               delegate:self
                                                                      cancelButtonTitle:@"Ok"
                                                                      otherButtonTitles:nil];
                                [alert show];

            }
        }];
        
    }

}

-(void)timesincelast{
    NSDate *lastday = [[NSUserDefaults standardUserDefaults] objectForKey:@"day"];
    if (!lastday) {
        _time.text = @"None!";
    } else {
        NSDate *today = [NSDate date];
        NSTimeInterval distanceBetweenDates = [lastday timeIntervalSinceDate:today];
        double secondsInAnHour = 3600;
        NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
        NSInteger time = 24 + hoursBetweenDates;
        if (time > 0) {
            _time.text = [NSString stringWithFormat:@"%ld",(long)time];
        } else {
            _time.text = @"None!";
        }
    }
    
}
@end
