//
//  DetailViewController.m
//  Todo list
//
//  Created by amir on 15/02/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import "DetailViewController.h"
#import "WorkerListTableViewController.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *adress;
//@property (weak, nonatomic) IBOutlet MKMapView *map;

@property RLMResults *workerDB;

@property (nonatomic,strong) GMSMapView *mapView;


@end
#define METERS_PER_MILE 1609.344

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_item.lat
                                                            longitude:_item.lan
                                                                 zoom:16];
    _mapView = [GMSMapView  mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;
    
    _name.text = [NSString stringWithFormat:@"%@ %@",_item.name,_item.familyName];
    _adress.text = [NSString stringWithFormat:@"%@ ",_item.workerAddress];

    _navBar.title = [NSString stringWithFormat:@"%@ %@",_item.name,_item.familyName];        // Do any additional setup after loading the view.
    
    
    NSString *bus = [NSString stringWithFormat:@"%@",[self fetchNearbyBusAndDrewMarker]];
    NSDictionary *dic = [self fetchDircation:bus];
    [self drewRouteToBus:dic];
    
    
    
    
    
    
    
    /*
        NSString *urlString2 =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&rankby=distance&types=bus_station&key=AIzaSyBVNciaykmz13memL2XK1sAF9WCacHiF-g",_item.lat,_item.lan];
    NSString *urlString =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=32.8340986,35.1015794&mode=walking&key=AIzaSyBVNciaykmz13memL2XK1sAF9WCacHiF-g",_item.lat,_item.lan];
    
    
    
    

    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:(requestURL)];
    
    //response
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSDictionary *locationResults = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    [self drewRouteToBus:locationResults];
    */
    /*
    
    NSString *stringLatitude = [[[[[locationResults objectForKey:@"results" ]objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
    
    NSString *stringLongitude = [[[[[locationResults objectForKey:@"results" ]objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
    
    GMSMarker *markerBus = [[GMSMarker alloc] init];
    markerBus.title = @"Pastush";
    markerBus.snippet = @"Pastush";
    markerBus.icon = [UIImage imageNamed:@"blue-dot"];
    markerBus.map = _mapView;

    markerBus.position = CLLocationCoordinate2DMake([stringLatitude doubleValue], [stringLongitude doubleValue]);
*/
   // NSLog(@"%@",locationResults);
}

-(void)viewDidAppear:(BOOL)animated
{
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.

    
    // Creates a marker in the center of the map.
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(_item.lat, _item.lan);
    marker.title = [NSString stringWithFormat:@"%@ %@",_item.name, _item.familyName];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.snippet = _item.workerAddress;
    marker.map = _mapView;
    /*

*/

    /*
    _workerDB = [RLMWorker allObjects];
    
    for (int i = 0; i<_workerDB.count; i++) {
        
        Worker *tempWorker = [[Worker alloc]init];
        tempWorker = _workerDB[i];
        GMSMarker *marker = [[GMSMarker alloc] init];
        
        marker.position = CLLocationCoordinate2DMake(tempWorker.lat,tempWorker.lan);
        marker.title = [NSString stringWithFormat:@"%@ %@",tempWorker.name, tempWorker.familyName];        marker.snippet = tempWorker.workerAddress;
        marker.map = _mapView;
        
        
        
    }
*/

}

-(NSString*)fetchNearbyBusAndDrewMarker
{
    
    NSString *coord = [[NSString alloc]init];;
    NSDictionary *dic =[ NSDictionary dictionary];
    NSString *urlString =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&rankby=distance&types=bus_station&key=AIzaSyBVNciaykmz13memL2XK1sAF9WCacHiF-g",_item.lat,_item.lan];
    
    //fetch
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:(requestURL)];
    
    //response
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    dic = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];
    
    NSString *stringLatitude = [[[[[dic objectForKey:@"results" ]objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
    
    NSString *stringLongitude = [[[[[dic objectForKey:@"results" ]objectAtIndex:0] objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
    
    coord = [NSString stringWithFormat:@"%@,%@",stringLatitude,stringLongitude];
    
    GMSMarker *markerBus = [[GMSMarker alloc] init];
    markerBus.map = _mapView;
    markerBus.icon = [UIImage imageNamed:@"bus"];
    markerBus.position = CLLocationCoordinate2DMake([stringLatitude doubleValue], [stringLongitude doubleValue]);
    NSLog(@"%@",dic);
    
    return coord;
}

-(NSDictionary*)fetchDircation:(NSString*)dirc
{
    NSString *urlString =[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%@&mode=walking&key=AIzaSyBVNciaykmz13memL2XK1sAF9WCacHiF-g",_item.lat,_item.lan,dirc];
    
    
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:(requestURL)];
    
    //response
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *jsonParsingError = nil;
    NSDictionary *locationResults = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonParsingError];

    return locationResults;


}


-(void)drewRouteToBus:(NSDictionary*)dic
{
    NSDictionary *route = [dic[@"routes"] objectAtIndex:0];
    NSDictionary *routes = [route objectForKey: @"overview_polyline"];
    NSString *overview_polyline = [routes objectForKey:@"points"];
    
    GMSPath * path = [GMSPath pathFromEncodedPath:overview_polyline];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map=_mapView;
    polyline.strokeColor = [UIColor redColor];
    polyline.strokeWidth = 2.0f;
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)loadDetail:(UIStoryboardSegue *)segue
{
    
    
}

@end
