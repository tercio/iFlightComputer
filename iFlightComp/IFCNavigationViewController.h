//
//  IFCNavigationViewController.h
//  iFlightComp
//
//  Created by Tercio Esperandio on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFCNavigationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *distance;
@property (weak, nonatomic) IBOutlet UITextField *hour;
@property (weak, nonatomic) IBOutlet UITextField *minute;

@property (weak, nonatomic) IBOutlet UITextField *autonomy;
@property (weak, nonatomic) IBOutlet UITextField *speed;
@property (weak, nonatomic) IBOutlet UILabel *resDistance;
@property (weak, nonatomic) IBOutlet UILabel *resTime;
@property (weak, nonatomic) IBOutlet UILabel *resConsuption;
@property (weak, nonatomic) IBOutlet UITextField *heading;
@property (weak, nonatomic) IBOutlet UITextField *windDir;
@property (weak, nonatomic) IBOutlet UITextField *windSpeed;
@property (weak, nonatomic) IBOutlet UILabel *resGroundSpeed;
@property (weak, nonatomic) IBOutlet UILabel *resHeadingCorrection;



- (IBAction)calculateNavigation:(id)sender;


- (float) timeStringToFloat:(NSString *) t;

@end
