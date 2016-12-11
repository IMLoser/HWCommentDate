//
//  HWListView.m
//  HWCommentDateDemo
//
//  Created by 曹航玮 on 2016/12/12.
//  Copyright © 2016年 曹航玮. All rights reserved.
//

#import "HWListView.h"
#import "NSCalendar+HWCommentDate.h"

@interface HWListView ()

@property (strong, nonatomic) NSArray * dateArray;

@end

@implementation HWListView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _dateArray = @[@"2012-02-02 12:12:12",
                   @"2016-11-30 12:12:12",
                   @"2016-12-12 00:40:40",
                   @"2016-12-12 00:45:40",
                   @"2016-12-12 00:51:40"
                  ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.rowHeight = 100;
}

#pragma mark - < UITableViewDataSource >

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * dateCell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    NSString * dateStr = [NSString stringWithFormat:@"%@ 更改后: %@",
                          _dateArray[indexPath.row],[NSCalendar commentDateByOriginalDate:_dateArray[indexPath.row]withDateFormat:@"yyyy-MM-dd HH:mm:ss"]
                          ];
    
    dateCell.textLabel.text = dateStr;
    dateCell.textLabel.numberOfLines = 0;
    return dateCell;
}

@end
