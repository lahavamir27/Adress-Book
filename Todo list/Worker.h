//
//  TodoItem.h
//  Todo list
//
//  Created by amir on 12/01/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Worker : NSObject


@property NSString *name;
@property NSString *familyName;
@property double lan;
@property double lat;

@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *workerAddress;

@property BOOL isComplite;
@property (readonly) NSData *creationDate;




@end
