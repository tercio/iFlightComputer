//
//  IFCFirstViewController.m
//  iFlightComp
//
//  Created by Tercio Esperandio on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IFCConversionViewController.h"

#define CF_WSIZE 45 // must change this
#define LG_WSIZE 95 // must change this
#define TAS_WSIZE 165 // must change this


@implementation IFCConversionViewController
@synthesize mph;
@synthesize kmh;
@synthesize knot;
@synthesize distance;
@synthesize speed;
@synthesize flightTime;
@synthesize feet;
@synthesize meters;
@synthesize celsius;
@synthesize fahrenheit;
@synthesize liters;
@synthesize gallons;
@synthesize windowMovedUpBy;
@synthesize altitude;
@synthesize oat;
@synthesize densityAltitude;
@synthesize ias;
@synthesize iasAltitude;
@synthesize tas;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"convert-icon.png"];
        [self setWindowMovedUpBy:0];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[oat setKeyboardType:UIKeyboardTypeDecimalPad];
    [feet setKeyboardType:UIKeyboardTypeDecimalPad];
    [meters setKeyboardType:UIKeyboardTypeDecimalPad];
    //[celsius setKeyboardType:UIKeyboardTypeDecimalPad];
    //[fahrenheit setKeyboardType:UIKeyboardTypeDecimalPad];
    [gallons setKeyboardType:UIKeyboardTypeDecimalPad];
    [liters setKeyboardType:UIKeyboardTypeDecimalPad];
}

- (void)viewDidUnload
{
    [self setMph:nil];
    [self setKmh:nil];
    [self setKnot:nil];
    [self setDistance:nil];
    [self setSpeed:nil];
    [self setFlightTime:nil];
    [self setFeet:nil];
    [self setMeters:nil];
    [self setCelsius:nil];
    [self setFahrenheit:nil];
    [self setLiters:nil];
    [self setGallons:nil];
    [self setAltitude:nil];
    [self setOat:nil];
    [self setDensityAltitude:nil];
    [self setIas:nil];
    [self setIasAltitude:nil];
    [self setTas:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
    if ([self windowMovedUpBy] != 0)
        [self setViewMovedUp:NO byHeight:[self windowMovedUpBy]];
        
}
    

- (IBAction)speedValueChanged:(id)sender {
    
    if ([[kmh text] length] != 0) {
                
        NSString *sMPH = [NSString stringWithFormat:@"%.0f",[FlightComputer mphFromKmh:[[kmh text] doubleValue]]];
        NSString *sKNOT = [NSString stringWithFormat:@"%.0f",[FlightComputer knotFromKmh:[[kmh text] doubleValue]]];
        [mph setText:sMPH];
        [knot setText:sKNOT];
        [kmh resignFirstResponder];
    }
    
    if ([[mph text] length] != 0) {
        
        NSString *sKMH = [NSString stringWithFormat:@"%.0f",[FlightComputer kmhFromMph:[[mph text] doubleValue]]];
        NSString *sKNOT = [NSString stringWithFormat:@"%.0f",[FlightComputer knotFromMph:[[mph text] doubleValue]]];
        [kmh setText:sKMH];
        [knot setText:sKNOT];
        [mph resignFirstResponder];
        
    }
    
    if ([[knot text] length] != 0) {

        NSString *sMPH = [NSString stringWithFormat:@"%.0f",[FlightComputer mphFromKnot:[[knot text] doubleValue]]];
        NSString *sKMH = [NSString stringWithFormat:@"%.0f",[FlightComputer kmhFromKnot:[[knot text] doubleValue]]];
        [mph setText:sMPH];
        [kmh setText:sKMH];
        [knot resignFirstResponder];
        
    }

}

- (IBAction)calculateFlightTime:(id)sender {
    
    float ft = [FlightComputer flightTimeForDistance:[[distance text] floatValue]
                                            andSpeed:[[speed text] floatValue]];
    NSString *sFT = [NSString stringWithFormat:@"%02d:%02d",[FlightComputer getHours:ft],[FlightComputer getMinutes:ft]];
    [flightTime setText:sFT];
    [speed resignFirstResponder];
    [distance resignFirstResponder];
    
}

- (IBAction)calculateFeetMeters:(id)sender {
    
    if ([[feet text] length] != 0) {
        NSString *sMeters = [NSString stringWithFormat:@"%.0f",[FlightComputer metersFromFeet:[[feet text] doubleValue]]];
        [meters setText:sMeters];
        [feet resignFirstResponder];
                             
    }
    if ([[meters text] length] != 0) {
        NSString *sFeet = [NSString stringWithFormat:@"%.0f",[FlightComputer feetFromMeters:[[meters text] doubleValue]]];
        [feet setText:sFeet];
        [meters resignFirstResponder];
    }
}



- (IBAction)calculateCelsiusFahrenheit:(id)sender {
    
    if ([[celsius text] length] != 0) {
        NSString *sFa = [NSString stringWithFormat:@"%.1f",[FlightComputer fahrenheitFromCelsius:[[celsius text] doubleValue]]];
        [fahrenheit setText:sFa];
        [celsius resignFirstResponder];
        [self setViewMovedUp:NO byHeight:CF_WSIZE];
    } else if ([[fahrenheit text] length] != 0) {
        NSString *sC = [NSString stringWithFormat:@"%.1f",[FlightComputer celsiusFromFahrenheit:[[fahrenheit text] doubleValue]]];
        [celsius setText:sC];
        [fahrenheit resignFirstResponder];
        [self setViewMovedUp:NO byHeight:CF_WSIZE];
    }
    
    
    
}

- (IBAction)calculateLitersGallons:(id)sender {
    
    if ([[liters text] length] != 0) {
        NSString *sG = [NSString stringWithFormat:@"%.1f",[FlightComputer gallonFromLiter:[[liters text] floatValue]]];
        [gallons setText:sG];
        [liters resignFirstResponder];
        [self setViewMovedUp:NO byHeight:LG_WSIZE];
    } else if ([[gallons text] length] != 0) {
        NSString *sL = [NSString stringWithFormat:@"%.1f",[FlightComputer literFromGallon:[[gallons text] floatValue]]];
        [liters setText:sL];
        [gallons resignFirstResponder];
        [self setViewMovedUp:NO byHeight:LG_WSIZE];
    }
}

- (IBAction)calculateTAS:(id)sender {
    
    
    float ftas = [FlightComputer iasToTAS:[[ias text] floatValue] altitude:[[iasAltitude text] floatValue]];
    
    NSString *sTAS = [NSString stringWithFormat:@"%.0f",ftas];
    
    [[self view] endEditing:YES];
    
    
    [tas setText:sTAS];
    [self setViewMovedUp:NO byHeight:TAS_WSIZE];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:kmh]) {
        [mph setText:@""];
        [knot setText:@""];
    }
    if ([textField isEqual:mph]) {
        [kmh setText:@""];
        [knot setText:@""];
    }
    if ([textField isEqual:knot]) {
        [kmh setText:@""];
        [mph setText:@""];
    }
    if ([textField isEqual:feet]) {
        [meters setText:@""];
    }
    
    if ([textField isEqual:meters]) {
        [feet setText:@""];
    }
    
    // celsius and fahrenheit
    if ([textField isEqual:celsius]) {
        [fahrenheit setText:@""];
        [self setViewMovedUp:YES byHeight:CF_WSIZE];
    }
    if ([textField isEqual:fahrenheit]) {
        [celsius setText:@""];
        [self setViewMovedUp:YES byHeight:CF_WSIZE];
    }
    
    // liters and gallons
    if ([textField isEqual:liters]) {
        [gallons setText:@""];
        [self setViewMovedUp:YES byHeight:LG_WSIZE];
    }
    if ([textField isEqual:gallons]) {
        [liters setText:@""];
        [self setViewMovedUp:YES byHeight:LG_WSIZE];
    }
    
    if ([textField isEqual:ias])
        [self setViewMovedUp:YES byHeight:TAS_WSIZE];
    
    if ([textField isEqual:iasAltitude])
        [self setViewMovedUp:YES byHeight:TAS_WSIZE];
    
    
    return YES;
}

-(void)setViewMovedUp:(BOOL)movedUp byHeight:(int) h
{
    
    // we prevent the window to move up when it was already moved and user is only moving from a 
    // uitextfield that is aside the one - in this case window must not be moved up, otherwise it will
    // keep being moved indefinetely
    if ([self windowMovedUpBy] != 0 && movedUp) return;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= h;
        rect.size.height += h;
    }
    else
    {
        if (rect.origin.y != 0) {
            // revert back to the normal state.
            rect.origin.y += h;
            rect.size.height -= h;
        }
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
    if (movedUp == TRUE)
        [self setWindowMovedUpBy:h];
    else
        [self setWindowMovedUpBy:0];
}

- (IBAction)calculateDensityAltitude:(id)sender {
    
    NSString *sDA = [NSString stringWithFormat:@"%.0f",[FlightComputer altitudeDensityForAltitude:[[altitude text]floatValue] withTrueTemperature:[[oat text] floatValue]]];
    [densityAltitude setText:sDA];
    [oat resignFirstResponder];
    [altitude resignFirstResponder];
}


@end
