//
//  ViewController.m
//  Realm
//
//  Created by 云财富 on 2019/5/6.
//  Copyright © 2019 YunCaiFu. All rights reserved.
//

#import "ViewController.h"
#import <Realm.h>
#import "MessageModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (assign, nonatomic) int  codeNum;
@property (weak, nonatomic) IBOutlet UITableView *mesTable;

@property(nonatomic,strong)RLMResults *DataArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _codeNum = 0;
   
    
}

- (IBAction)addModel:(id)sender {
    _codeNum ++;
    MessageModel *model =[[MessageModel alloc]init];
    model.userID = arc4random()%2 ==0 ?@"456":@"789";
    model.messageContext =@"测试";
    model.linkUrl = [NSString stringWithFormat:@"%d",_codeNum];
    model.isRead = arc4random()%2 ==0 ?YES:NO;
    NSDate *date=[NSDate date];
    NSDateFormatter *matter =[[NSDateFormatter alloc]init];
    [matter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *Datestr = [matter stringFromDate:date];
    model.Time = Datestr;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:model];
   
    }];
    
  
}
- (IBAction)deleteModel:(id)sender {
    
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *stuResult = [MessageModel allObjects];
    for (MessageModel *stu in stuResult) {
        [realm transactionWithBlock:^{
            [realm deleteObject:stu];
        }];
    }
    
}


- (IBAction)updateModel:(id)sender {
    
    
}


- (IBAction)selectModel:(id)sender {
    
   _DataArr = [MessageModel objectsWhere:@"userID = \"789\""];
    
    RLMResults *noRead =[MessageModel objectsWhere:[NSString stringWithFormat:@"userID = '%@' AND isRead = NO",@"789"]];
    
    
    [_mesTable reloadData];
    NSLog(@"%@++++%ld", [_DataArr sortedResultsUsingKeyPath:@"Time" ascending:NO],noRead.count);
    
    
    
    
}

#pragma mark  DataDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _DataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId =@"indexPath";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    RLMResults  *sortResults =[_DataArr sortedResultsUsingKeyPath:@"Time" ascending:NO];
    
    MessageModel *model = sortResults[indexPath.row];
    cell.textLabel.text= model.Time;
    
    return  cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLMRealm * realm = [RLMRealm defaultRealm];
    
     [realm transactionWithBlock:^{
        
         RLMResults * result =[self->_DataArr sortedResultsUsingKeyPath:@"Time" ascending:NO];
        
       if (result.count > 0) {
            
         MessageModel * model = result[indexPath.row];
           if (model.isRead==NO) {
               
               model.isRead = YES;
               
           }

            }
         
     }];
  
    
}

@end
