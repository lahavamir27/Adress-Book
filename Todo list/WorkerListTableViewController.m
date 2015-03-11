//
//  ToDoListTableViewController.m
//  Todo list
//
//  Created by amir on 12/01/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import "WorkerListTableViewController.h"
#import "AddWorkerViewController.h"
#import "DetailViewController.h"


@interface WorkerListTableViewController ()

@property NSMutableArray *workerArray;
@property NSArray *sortArray;
@property RLMResults *workerDB;



@end

@implementation WorkerListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

 //   RLMRealm *realm = [RLMRealm defaultRealm];// Create realm pointing to default file
    _workerDB = [RLMWorker allObjects];
    
    
        // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_workerDB count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    NSString * name = [[_workerDB objectAtIndex:indexPath.row] name];
    NSString * familyName =[  [_workerDB objectAtIndex:indexPath.row] familyName];
    NSString * city =[  [_workerDB objectAtIndex:indexPath.row] city];
    NSString * address =[  [_workerDB objectAtIndex:indexPath.row] workerAddress];

    // Configure the cell...
    cell.textLabel.text =  [NSString stringWithFormat:@"%@ %@",familyName ,name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",address];
;
  /*
    if (toDoItem.isComplite) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    */
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_workerArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return YES;
        }
    }
    return YES;
    
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detail"]) {
        DetailViewController *detailVC = [segue destinationViewController];
        detailVC.item = _detailItem;
        ;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _detailItem = [_workerDB objectAtIndex:indexPath.row];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self performSegueWithIdentifier:@"detail" sender:self];
    
    
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    AddWorkerViewController *source = [segue sourceViewController];
    Worker *item = source.worker;
    
    NSLog(@"%@",item.name);
    if (item != nil) {
        [self.workerArray addObject:item];
        [self.tableView reloadData];
    }
}



@end
