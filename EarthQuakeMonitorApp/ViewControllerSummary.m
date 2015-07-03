//
//  ViewController.m
//  EarthQuakeMonitorApp
//
//  Created by Arte Digital on 6/29/15.
//  Copyright (c) 2015 Gelacio Lazaro. All rights reserved.
//

#import "ViewControllerSummary.h"
#import "AppDelegate.h"
#import "ViewControllerDetails.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewControllerSummary()
{
    NSMutableArray *list;
}
@end

@implementation ViewControllerSummary

@synthesize earthQuakeTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.earthQuakeTableView.delegate = self;
    self.earthQuakeTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.

    if([segue.destinationViewController isKindOfClass:[ViewControllerDetails class]])
    {
        ViewControllerDetails *destController = (ViewControllerDetails*)segue.destinationViewController;

        NSIndexPath *selectedIndexPath = [earthQuakeTableView indexPathForSelectedRow];

        NSDictionary *detailsDictionary = [list objectAtIndex:selectedIndexPath.row];
        destController.detailsDictionary = [[NSDictionary alloc] initWithDictionary:detailsDictionary];
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSummarySuccess:) name:@"SummaryRequestSuccess" object:nil];


    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

    [appDelegate getSummary];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SummaryRequestSuccess" object:nil];
}


-(IBAction)refreshSummary:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

    if([appDelegate isNetworkConnectivity])
    {
        [appDelegate getSummary];
    }

}

-(void) getSummarySuccess:(NSNotification*) notification
{

    NSDictionary *dictData = notification.userInfo;

    NSLog(@"data:%@", dictData);



    list = [[NSMutableArray alloc] initWithArray: [dictData  valueForKey:@"features"]];

    [earthQuakeTableView reloadData];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(list == nil) return 0;

    return [list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"@@@");
    NSLog(@"indexx: %d", (int)indexPath.row);

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }


    NSDictionary *earthDict =  [list objectAtIndex:indexPath.row];



    NSDictionary *item = [ earthDict objectForKey:@"properties"];

    UILabel *magnitudeLabel = (UILabel*)[cell viewWithTag:100];
    UILabel *placeLabel = (UILabel*)[cell viewWithTag:101];


    // NSLog(@"indexx: %d",indexPath.row);

    NSLog(@"mag: %@", [item objectForKey:@"mag"]);
    NSLog(@"place: %@", [item objectForKey:@"place"]);



    double mag =  [[item objectForKey:@"mag"] doubleValue];
    NSString *place =  [item objectForKey:@"place"];


    NSString *magStr = [NSString stringWithFormat:@"%1.2f", mag ];

    magnitudeLabel.text = magStr;
    placeLabel.text = place;

    cell.backgroundColor = [self getCellBGColor: mag];


    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self performSegueWithIdentifier:@"detailsSegue" sender:self];

}


-(UIColor*)getCellBGColor:(double) mag
{

    if(mag > 0 && mag < 1.0)
    {
        return UIColorFromRGB(0x1B5E20);
    }
    else if(mag >= 1.0 && mag < 2.0)
    {
        return UIColorFromRGB(0x2E7D32);

    }
    else if(mag >= 2.0 && mag < 3.0)
    {
        return UIColorFromRGB(0x388E3C);

    }
    else if(mag >= 3.0 && mag < 4.0)
    {
        return UIColorFromRGB(0x43A047);

    }
    else if(mag >= 4.0 && mag < 5.0)
    {
        return UIColorFromRGB(0x4CAF50);
    }
    else if(mag >= 5.0 && mag < 6.0)
    {
        return UIColorFromRGB(0xF44336);
    }
    else if(mag >= 6.0 && mag < 7.0)
    {
        return UIColorFromRGB(0xE53935);
    }
    else if(mag >= 7.0 && mag < 8.0)
    {
        return UIColorFromRGB(0xD32F2F);

    }
    else if(mag >= 8.0 && mag < 9.0)
    {
        return UIColorFromRGB(0xC62828);

    }
    else if(mag >= 9.0 && mag < 10.0)
    {
        return UIColorFromRGB(0xB71C1C);

    }

    return [UIColor clearColor];

}


@end
