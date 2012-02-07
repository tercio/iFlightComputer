//
//  IFCFirstViewController.h
//  iFlightComp
//
//  Created by Tercio Esperandio on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightComputer.h"

@interface IFCConversionViewController : UIViewController <UITextFieldDelegate> {
    

}
@property (weak, nonatomic) IBOutlet UITextField *mph;
@property (weak, nonatomic) IBOutlet UITextField *kmh;
@property (weak, nonatomic) IBOutlet UITextField *knot;
@property (weak, nonatomic) IBOutlet UITextField *distance;
@property (weak, nonatomic) IBOutlet UITextField *speed;
@property (weak, nonatomic) IBOutlet UILabel *flightTime;
@property (weak, nonatomic) IBOutlet UITextField *feet;
@property (weak, nonatomic) IBOutlet UITextField *meters;
@property (weak, nonatomic) IBOutlet UITextField *celsius;
@property (weak, nonatomic) IBOutlet UITextField *fahrenheit;
@property (weak, nonatomic) IBOutlet UITextField *liters;
@property (weak, nonatomic) IBOutlet UITextField *gallons; 
@property (assign, nonatomic) int windowMovedUpBy;
@property (weak, nonatomic) IBOutlet UITextField *altitude;
@property (weak, nonatomic) IBOutlet UITextField *oat;
@property (weak, nonatomic) IBOutlet UILabel *densityAltitude;
@property (weak, nonatomic) IBOutlet UITextField *ias;
@property (weak, nonatomic) IBOutlet UITextField *iasAltitude;
@property (weak, nonatomic) IBOutlet UILabel *tas;



- (void)setViewMovedUp:(BOOL)movedUp  byHeight:(int) h;

- (IBAction)calculateDensityAltitude:(id)sender;

- (IBAction)speedValueChanged:(id)sender;

- (IBAction)calculateFlightTime:(id)sender;
- (IBAction)calculateFeetMeters:(id)sender;
- (IBAction)calculateCelsiusFahrenheit:(id)sender;
- (IBAction)calculateLitersGallons:(id)sender;
- (IBAction)calculateTAS:(id)sender;

@end
