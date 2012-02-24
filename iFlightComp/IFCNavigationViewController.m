//
//  IFCNavigationViewController.m
//  iFlightComp
//
//  Created by Tercio Esperandio on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IFCNavigationViewController.h"
#import "FlightComputer.h"

@implementation IFCNavigationViewController
@synthesize distance;
@synthesize hour;
@synthesize minute;
@synthesize autonomy;
@synthesize speed;
@synthesize resDistance;
@synthesize resTime;
@synthesize resConsuption;
@synthesize heading;
@synthesize windDir;
@synthesize windSpeed;
@synthesize resGroundSpeed;
@synthesize resHeadingCorrection;
@synthesize TAS;
@synthesize altitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Navigation", @"Navigation");
        self.tabBarItem.image = [UIImage imageNamed:@"nav-icon.png"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [autonomy setKeyboardType:UIKeyboardTypeDecimalPad];
}

- (void)viewDidUnload
{
    [self setDistance:nil];
    [self setHour:nil];
    [self setMinute:nil];
    [self setAutonomy:nil];
    [self setSpeed:nil];
    [self setResDistance:nil];
    [self setResTime:nil];
    [self setResConsuption:nil];
    [self setHeading:nil];
    [self setWindDir:nil];
    [self setWindSpeed:nil];
    [self setResGroundSpeed:nil];
    [self setResHeadingCorrection:nil];
    [self setTAS:nil];
    [self setAltitude:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:hour] || [textField isEqual:minute]) {
        [distance setText:@""];
        
    } else if ([textField isEqual:distance]) {
        [hour setText:@""];
        [minute setText:@""];
    }
    
    
    return YES;
}


- (float) timeStringToFloat:(NSString *) t {
    // convert time to float
    NSScanner* timeScanner=[NSScanner scannerWithString:t];
    int hours,minutes;
    
    [timeScanner scanInt:&hours];
    [timeScanner scanString:@":" intoString:nil]; //jump over :
    [timeScanner scanInt:&minutes];
    
    NSString *str = [NSString stringWithFormat:@"%d.%d",hours,minutes*100/60];
    
    float ret = [str floatValue];
    return ret;
    // --

}

- (IBAction)calculateNavigation:(id)sender {
    
    float fTime = 0.0;
    float fSpeed = [[speed text] floatValue];
    float fDist = [[distance text] floatValue];
    float fAutonomy = [[autonomy text] floatValue];
    float fResultConsuption = 0.0;
    float fwindDir = [[windDir text] floatValue];
    float fwindSpeeed = [[windSpeed text] floatValue];
    float fresWindCorrection;
    float fresGroundSpeed;
    float fHeading = [[heading text] floatValue];
    float ftas = 0.0;
    float faltitude = [[altitude text] floatValue];
    
    // first calulate wind data:
    
    
    ftas = [FlightComputer iasToTAS:fSpeed altitude:faltitude];
    
    NSArray *ret = [FlightComputer windCorrectionForHeading:fHeading airspeed:ftas windDir:fwindDir windSpeed:fwindSpeeed];
    
    fresWindCorrection = [[ret objectAtIndex:0] floatValue];
    fresGroundSpeed = [[ret objectAtIndex:1] floatValue];
    
    
    if ([[hour text] length] && [[minute text] length] ) {
        NSString *sTime = [NSString stringWithFormat:@"%02d:%02d",[[hour text] intValue],[[minute text] intValue]];
        fTime = [self timeStringToFloat:sTime];
    }
    
    if (fTime != 0.0 && fSpeed != 0.0) {
        
        fDist = [FlightComputer distanceForTime:fTime andSpeed:fresGroundSpeed];
        fResultConsuption = [FlightComputer fuelConsumedOnHours:fTime forAutonomy:fAutonomy];
        
        
    } else if (fDist != 0.0 && fSpeed != 0.0) {

        fTime = [FlightComputer  timeToTravel:fDist atSpeed:fresGroundSpeed];
        fResultConsuption = [FlightComputer fuelConsumedOnHours:fTime forAutonomy:fAutonomy];
        
        
    } else {
        fTime = fSpeed = ftas = fDist = fAutonomy = 0.0;
        [[self view] endEditing:YES];
        return;
    }
    
    
    NSString *sC = [NSString stringWithFormat:@"%.2f",fResultConsuption];
    NSString *sD = [NSString stringWithFormat:@"%.2f",fDist];
    NSString *sT = [NSString stringWithFormat:@"%02d:%02d",[FlightComputer getHours:fTime],[FlightComputer getMinutes:fTime]];
    NSString *sGS = [NSString stringWithFormat:@"%.0f",fresGroundSpeed];
    NSString *sWC = [NSString stringWithFormat:@"%.0f",fresWindCorrection];
    NSString *sTAS = [NSString stringWithFormat:@"%.0f",ftas];

    
    [resTime setText:sT];
    [resDistance setText:sD];
    [resConsuption setText:sC];
    [resGroundSpeed setText:sGS];
    [resHeadingCorrection setText:sWC];
    [TAS setText:sTAS];
    
    [[self view] endEditing:YES];
    
    
}
@end
