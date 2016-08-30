//
//  AppDelegate.h
//  EarthQuakeMonitorApp
//
//  Created by Arte Digital on 6/29/15.
//  Copyright (c) 2015 Gelacio Lazaro. All rights reserved.
//
//Testing 1
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDelegate>

    @property(strong, nonatomic) UIWindow *window;
@property Reachability* reach;

@property(readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Conflict1
@property(strong, nonatomic) NSMutableData  *responseData;
@property(strong, nonatomic) NSDictionary *responseDictionary;

@property(strong, nonatomic) NSURLConnection  *summaryRequestConnection;

-(void) getSummary;
-(BOOL) isNetworkConnectivity;


//Testing 22


@end

