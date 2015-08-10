//
//  MilesCounterTableViewController.m
//  Miles Counter
//
//  Created by jim1985 on 2015/8/10.
//  Copyright (c) 2015年 jim1985. All rights reserved.
//

#import "MilesCounterTableViewController.h"

@interface MilesCounterTableViewController ()

@end
enum FieldTag {
    CurrentMiles_TextField = 2,
    CurrentCost_TextField  = 12
};
enum CellTag {
    CurrentMiles_Cell = 1,
    CurrentCost_Cell  = 11
};
enum SectionTag{
    Prev_Miles_Section    = 0,
    Prev_Cost_Section     = 1,
    Prev_Average_Section  = 2,
    Curr_Miles_Section    = 3,
    Curr_Cost_Section     = 4,
    Input_Button_Section  = 5,
};
@implementation MilesCounterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
    Prev_Miles = [defaults integerForKey:@"pMiles"];
    Prev_Cost  = [defaults integerForKey:@"pCost"];
    NSLog(@"%lu, %lu",(unsigned long)Prev_Miles, (unsigned long)Prev_Cost);

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 6;
}
#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section == Input_Button_Section) {
        NSUserDefaults* defaults = [[NSUserDefaults alloc] init];
        for (UIView* v1 in [tableView subviews]) {
            for (UITableViewCell* v2 in [v1 subviews]) {
                if (v2.tag == 11 || v2.tag == 1) {
                    UITextField* tmp =(UITextField*) [[[v2 contentView] subviews] objectAtIndex:0];
                    switch (tmp.tag) {
                        case CurrentMiles_TextField:
                        {
                            NSLog(@"%ld",[[tmp text] integerValue]);
                            [defaults setInteger:[[tmp text] integerValue] forKey:@"pMiles"];
                        }
                            break;
                        case CurrentCost_TextField:
                        {
                            NSLog(@"%ld",[[tmp text] integerValue]);
                            [defaults setInteger:[[tmp text] integerValue] forKey:@"pCost"];
                        }
                            break;
                    }

                    
                    
                }
            }

        }
        [defaults synchronize];
        NSString* TitleMSG = NSLocalizedString(@"Miles Counter", nil);
        NSString* HintMSG = NSLocalizedString(@"里程數資料輸入成功", nil);
        UIAlertController* TipController = [UIAlertController alertControllerWithTitle:TitleMSG
                                                                               message:HintMSG
                                                                        preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* OkAction = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        [TipController addAction:OkAction];
        [self presentViewController:TipController animated:YES completion:nil];
        
    }
}
#pragma mark - numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
#pragma mark - titleForHeaderInSection
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case Prev_Miles_Section:
            return @"上次里程數:";
        case Prev_Cost_Section:
            return @"上次花費:";
        case Prev_Average_Section:
            return @"上次平均花費:";
        case Curr_Miles_Section:
            return @"本次里程數:";
        case Curr_Cost_Section:
            return @"本次花費:";
        case Input_Button_Section:
            return @"";

    }
    return nil;
}
#pragma mark - cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];

    switch (indexPath.section) {
        case Prev_Miles_Section:
            cell.textLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)Prev_Miles];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case Prev_Cost_Section:
            cell.textLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)Prev_Cost];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case Prev_Average_Section:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (Prev_Cost == 0) cell.textLabel.text = @"0";
            else
                cell.textLabel.text = [NSString stringWithFormat:@"%2lu",Prev_Miles/Prev_Cost];
        
        }
            break;
        case Curr_Miles_Section:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITextField* MilesTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 100, cell.frame.size.height)];
            cell.tag = CurrentMiles_Cell;
            MilesTextField.tag = CurrentMiles_TextField;
            [MilesTextField setText:@"0"];
            [cell.contentView addSubview:MilesTextField];
        }
            break;
        case Curr_Cost_Section:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITextField* CostTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 100, cell.frame.size.height)];
            cell.tag = CurrentCost_Cell;
            CostTextField.tag = CurrentCost_TextField;
            [CostTextField setText:@"0"];
            [cell.contentView addSubview:CostTextField];
        }
            break;
        case Input_Button_Section:
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor blueColor];
            cell.textLabel.text = @"輸入";
            break;
    }

    
    return cell;
}

@end
