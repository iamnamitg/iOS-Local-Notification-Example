//
//  ViewController.m
//  Local Notification Example
//
//  Created by Namit on 21/04/15.
//  Copyright (c) 2015 Namit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSUserDefaults *defaults;
}

@property (weak, nonatomic) IBOutlet UILabel *ibLabel1;
@property (weak, nonatomic) IBOutlet UILabel *ibLabel2;
@property (weak, nonatomic) IBOutlet UIButton *ibStartButton;
@property (weak, nonatomic) IBOutlet UIButton *ibStopButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
}

-(void)viewWillAppear:(BOOL)animated{
    BOOL notificationIsActive = [defaults boolForKey:@"notificationIsActive"];
    if (notificationIsActive == true) {
        self.ibLabel1.hidden = false;
        self.ibLabel2.hidden = false;
        self.ibStartButton.hidden = true;
        self.ibStopButton.hidden = false;
    }
}

- (IBAction)ibaStartButton:(id)sender {
    [defaults setBool:YES forKey:@"notificationIsActive"];
    [defaults synchronize];
    self.ibLabel1.hidden = false;
    self.ibLabel2.hidden = false;
    self.ibStartButton.hidden = true;
    self.ibStopButton.hidden = false;
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0]; //Enter the time here in seconds.
    localNotification.alertBody = @"Your alert message";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatInterval = NSCalendarUnitMinute; //Repeating instructions here.
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (IBAction)ibaStopButton:(id)sender {
    [defaults setBool:NO forKey:@"notificationIsActive"];
    [defaults synchronize];
    self.ibLabel1.hidden = true;
    self.ibLabel2.hidden = true;
    self.ibStartButton.hidden = false;
    self.ibStopButton.hidden = true;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
