//
//  MilesCounterTableViewController.h
//  Miles Counter
//
//  Created by jim1985 on 2015/8/10.
//  Copyright (c) 2015年 jim1985. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MilesCounterTableViewController : UITableViewController //<UITextFieldDelegate>
{
    NSUInteger Prev_Miles;
    NSUInteger Prev_Cost;
    NSUInteger Current_Miles;
    NSUInteger Current_Cost;

}
@end
