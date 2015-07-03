//
//  ViewController.h
//  EarthQuakeMonitorApp
//
//  Created by Arte Digital on 6/29/15.
//  Copyright (c) 2015 Gelacio Lazaro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerSummary : UIViewController<UITableViewDelegate, UITableViewDataSource>

    @property(nonatomic, weak) IBOutlet UITableView * earthQuakeTableView;
-(IBAction)refreshSummary:(id)sender;

@end

