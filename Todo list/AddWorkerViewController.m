//
//  AddToDoItemViewController.m
//  Todo list
//
//  Created by amir on 12/01/15.
//  Copyright (c) 2015 la computers. All rights reserved.
//

#import "AddWorkerViewController.h"

@interface AddWorkerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@end

@implementation AddWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender != self.saveButton) return;
    if (self.textField.text.length > 0) {
        self.worker = [[Worker alloc] init];
        self.worker.name = self.textField.text;
        self.worker.isComplite = NO;
    }
}

@end
