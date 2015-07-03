//
//  ViewControllerDetails.m
//  EarthQuakeMonitorApp
//
//  Created by Arte Digital on 7/1/15.
//  Copyright (c) 2015 Gelacio Lazaro. All rights reserved.
//

#import "ViewControllerDetails.h"

@interface ViewControllerDetails()

@end

@implementation ViewControllerDetails

@synthesize detailsDictionary, magTextField, dateTimeTextField, mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];



    NSLog(@"detailsDictionary: %@", self.detailsDictionary);

    NSDictionary *item = [  self.detailsDictionary objectForKey:@"properties"];

    /*Displaying magnitud */
    NSLog(@"mag: %@", [item objectForKey:@"mag"]);
    NSLog(@"place: %@", [item objectForKey:@"place"]);
    float mag = [[item objectForKey:@"mag"] floatValue];
    NSString *magStr = [NSString stringWithFormat:@"%1.2f", mag ];
    magTextField.text = magStr;



    /*Converting time to date format */
    long long timeMS = [[item objectForKey:@"time"] longLongValue];
    NSDate *dateAD = [NSDate dateWithTimeIntervalSince1970:(timeMS / 1000)];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:dateAD];
    self.dateTimeTextField.text = dateString;





    /*Getting the eartyhquake location and coordinates */
    NSDictionary *geometryDictionary = [self.detailsDictionary objectForKey:@"geometry"];
    NSArray *coordinates = [geometryDictionary objectForKey:@"coordinates"];
    double lon = [coordinates[0] doubleValue];
    double lat = [coordinates[1] doubleValue];
    double dep = [coordinates[2] doubleValue];

    /*Coordinates, lat,lon and dep*/
    self.locationTextField.text = [NSString stringWithFormat:@"lon:%f lat:%f depth:%f", lon, lat, dep ];

    self.mapView.delegate = self;


    /*Adding the Annotation into the map */
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = lat;
    annotationCoord.longitude =   lon;
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = [item objectForKey:@"place"];
    annotationPoint.subtitle =  [item objectForKey:@"title"];
    [mapView addAnnotation:annotationPoint];



    /*Centenring the annotation into the map */
    MKUserLocation *userLocation = mapView.userLocation;
    MKCoordinateRegion region =
        MKCoordinateRegionMakeWithDistance(
            userLocation.location.coordinate, 50, 50);
    [mapView setRegion:region animated:NO];


    CLLocationCoordinate2D location;
    location.latitude =  lat;
    location.longitude =  lon;

    MKCoordinateRegion region1 = MKCoordinateRegionMakeWithDistance(location, 1000000, 1000000);
    [self.mapView setRegion:[self.mapView regionThatFits:region1] animated:YES];



}


- (void)mapView:(MKMapView *)mapView
    didUpdateUserLocation:
    (MKUserLocation *)userLocation
{
    self.mapView.centerCoordinate =
        userLocation.location.coordinate;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
