//
//  ISWorker.h
//  Todo list
//
//  Created by amir lahav on 07/03/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Worker.h"

@interface RLMWorker : RLMObject
@property NSString *name;
@property NSString *familyName;
@property double lan;
@property double lat;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *workerAddress;
@property double nearBusLongtitue;
@property double nearBusLatitude;


@end

@interface ISWorker : NSObject

+(void)setDatabase;

@end
