//
//  ISWorker.m
//  Todo list
//
//  Created by amir lahav on 07/03/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import "ISWorker.h"

@implementation ISWorker

+(void)setDatabase


{
    
  //  [[NSFileManager defaultManager] removeItemAtPath:[RLMRealm defaultRealmPath] error:nil];
    
    RLMRealm *realm = [RLMRealm defaultRealm];// Create realm pointing to default file
    RLMResults *checkWorkerDatabase = [RLMWorker allObjects];
    
    
    if (checkWorkerDatabase.count==0)
    {
        NSLog(@"create database with realm tech for the first time");
        
        NSMutableArray * realmWorkerObject = [ NSMutableArray array];
                
        NSString* path  = [[NSBundle mainBundle] pathForResource:@"worker" ofType:@"json"];
        
        NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *jsonError;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        NSDictionary *arrayResult = [NSDictionary dictionary];
        for (int i=0; i<[array count]; i++) {
            arrayResult = [array objectAtIndex:i];
            RLMWorker *worker = [[RLMWorker alloc] init];
            worker.name = [arrayResult objectForKey:@"private_name"];
            worker.familyName = [arrayResult objectForKey:@"family_name"];
            worker.city = [arrayResult objectForKey:@"city"];
            worker.workerAddress = [arrayResult objectForKey:@"original address"];

            worker.lan = [[arrayResult objectForKey:@"longitude"]  doubleValue];
            worker.lat = [[arrayResult objectForKey:@"latitude"] doubleValue];
            worker.nearBusLongtitue = 0;
            worker.nearBusLatitude = 0;
            [realmWorkerObject addObject:worker];

            NSLog(@"%f",worker.lan);

        }
     
        [realmWorkerObject sortUsingComparator:^NSComparisonResult(Worker *p1, Worker *p2) {
            return  [p1.workerAddress compare:p2.workerAddress];
        }];
      

        
        [realm beginWriteTransaction];
        [realm addObjects:realmWorkerObject];
        [realm commitWriteTransaction];
        

        
    }
    
}


@end
