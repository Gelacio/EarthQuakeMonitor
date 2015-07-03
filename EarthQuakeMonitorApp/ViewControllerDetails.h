//
//  ViewControllerDetails.h
//  EarthQuakeMonitorApp
//
//  Created by Arte Digital on 7/1/15.
//  Copyright (c) 2015 Gelacio Lazaro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewControllerDetails : UIViewController<MKMapViewDelegate>

    @property NSDictionary *detailsDictionary;

@property(nonatomic, weak) IBOutlet UILabel *magTextField;
@property(nonatomic, weak) IBOutlet UILabel *dateTimeTextField;
@property(nonatomic, weak) IBOutlet UILabel *locationTextField;

@property(strong, nonatomic) IBOutlet MKMapView *mapView;



@end
