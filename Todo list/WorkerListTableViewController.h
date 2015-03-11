//
//  ToDoListTableViewController.h
//  Todo list
//
//  Created by amir on 12/01/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Worker.h"
#import <Realm/Realm.h>
#import "ISWorker.h"
@interface WorkerListTableViewController : UITableViewController
@property (nonatomic) Worker *detailItem;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
