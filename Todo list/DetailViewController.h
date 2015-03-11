//
//  DetailViewController.h
//  Todo list
//
//  Created by amir on 15/02/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Worker.h"
#import <MapKit/MapKit.h>
#import <Realm/Realm.h>
#import <GoogleMaps/GoogleMaps.h>

@interface DetailViewController : UIViewController


@property (nonatomic,strong) Worker *item;


@end
