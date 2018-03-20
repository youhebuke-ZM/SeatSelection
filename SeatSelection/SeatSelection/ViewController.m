//
//  ViewController.m
//  SeatSelection
//
//  Created by zm on 16/1/27.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ViewController.h"
#import "SeatView.h"
#import "Utils.h"
//testGit
#define MAX_X 9   //座位最大行
#define MAX_Y 12  //座位最大列

@interface ViewController ()
{
    SeatView *_seatView;
    UIView *_topView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"万万没想到:西游篇";
    [self addTopView];
    
    [self addSeatViewByMaxX:MAX_X MaxY:MAX_Y];

}
-(void)addTopView
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreen.size.width, 54)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    
    UILabel *cinemaLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, kScreen.size.width - 30, 20)];
    cinemaLabel.text = @"万达影院";
    cinemaLabel.font = [UIFont systemFontOfSize:15];
    cinemaLabel.textColor = HexRGB(0x2e2e2e);
    [_topView addSubview:cinemaLabel];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.text =  @"2016-01-29 20:30";
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textColor = HexRGB(0x605e5e);
    dateLabel.frame = CGRectMake(15, CGRectGetMaxY(cinemaLabel.frame), [Utils getLabelWidthByLabel:dateLabel], 20);
    [_topView addSubview:dateLabel];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dateLabel.frame) + 10, dateLabel.frame.origin.y, _topView.frame.size.width - CGRectGetMaxY(dateLabel.frame), 20)];
    typeLabel.text = [NSString stringWithFormat:@"%@%@",@"中文",@"3D"];
    typeLabel.font = [UIFont systemFontOfSize:11];
    typeLabel.textColor = HexRGB(0xec7844);
    [self.view addSubview:typeLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.frame.size.height - 1, kScreen.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_topView addSubview:line];
}

//添加最大数量座位视图
-(void)addSeatViewByMaxX:(NSInteger)maxX MaxY:(NSInteger)maxY
{
    UIView *buyTicketBg = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, kScreen.size.width, 100)];
    buyTicketBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buyTicketBg];
    
    //可选
    UIImageView *choosableImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen.size.width - Item_Width*6)/2 - 15-20, (50-Item_Width)/2, Item_Width, Item_Width)];
    [choosableImage setImage:[UIImage imageNamed:@"choosable"]];
    [buyTicketBg addSubview:choosableImage];
    
    UILabel *choosableLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(choosableImage.frame)+5, choosableImage.frame.origin.y, 30, 20)];
    choosableLabel.text = @"可选";
    choosableLabel.textColor = HexRGB(0x999999);
    choosableLabel.font = [UIFont systemFontOfSize:14];
    [buyTicketBg addSubview:choosableLabel];
    
    //已售
    UIImageView *soldImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(choosableLabel.frame)+10, (50-Item_Width)/2, Item_Width, Item_Width)];
    [soldImage setImage:[UIImage imageNamed:@"sold"]];
    [buyTicketBg addSubview:soldImage];
    
    UILabel *soldLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(soldImage.frame)+5, choosableImage.frame.origin.y, 30, 20)];
    soldLabel.text = @"已售";
    soldLabel.textColor = HexRGB(0x999999);
    soldLabel.font = [UIFont systemFontOfSize:14];
    [buyTicketBg addSubview:soldLabel];
    
    //已选
    UIImageView *selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(soldLabel.frame)+10, (50-Item_Width)/2, Item_Width, Item_Width)];
    [selectedImage setImage:[UIImage imageNamed:@"selected"]];
    [buyTicketBg addSubview:selectedImage];
    
    UILabel *selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(selectedImage.frame)+5, choosableImage.frame.origin.y, 30, 20)];
    selectedLabel.text = @"已选";
    selectedLabel.textColor = HexRGB(0x999999);
    selectedLabel.font = [UIFont systemFontOfSize:14];
    [buyTicketBg addSubview:selectedLabel];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 15, 50, kScreen.size.width - 30, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [buyTicketBg addSubview:line];
    
    UIButton *buyTicketBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    buyTicketBtn.frame = CGRectMake(buyTicketBg.frame.size.width - 133 - 15, 55, 133, 40);
    buyTicketBtn.backgroundColor = HexRGB(0x9cc7e3);
    [buyTicketBtn setTitle:@"立即购票" forState:UIControlStateNormal];
    buyTicketBtn.layer.cornerRadius = 8.0;
    buyTicketBtn.layer.masksToBounds = YES;
    [buyTicketBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyTicketBtn addTarget:self action:@selector(buyTicketNow) forControlEvents:UIControlEventTouchUpInside];
    [buyTicketBg addSubview:buyTicketBtn];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, buyTicketBg.frame.size.width - buyTicketBtn.frame.size.width - 15, 20)];
    lab.text = @"一次最多选择五个座位";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = HexRGB(0x999999);
    [buyTicketBg addSubview:lab];
    
    //根据最大行和最大列进行座位矩阵布局，包括现实存在的座位和不存在的座位（初始状态为隐藏）
    _seatView = [[SeatView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kScreen.size.width, kScreen.size.height - _topView.frame.size.height - buyTicketBg.frame.size.height - 64) rowMaxNum:maxX columnMaxNum:maxY];
    [_seatView setRoomName:@"21号厅" seatNum:118];
    [self.view addSubview:_seatView];
    
    [self getSeatList];
}

//所有现实存在的座位（将现实存在的座位显示出来）
-(void)getSeatList
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SeatList"ofType:@"txt"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        id tempArr = obj[@"data"];
        if (tempArr && [tempArr isKindOfClass:[NSArray class]]) {
            [_seatView setSeatStatus:tempArr];
        }
    }
    
    [self getSoldSeats];
}

//已经售出或预定了的的座位（将已经售出的座位标记）
-(void)getSoldSeats
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SoldSeats"ofType:@"txt"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        id tempArr = obj[@"data"];
        if (tempArr && [tempArr isKindOfClass:[NSArray class]]) {
            [_seatView setSoldSeatsStatus:tempArr];
        }
    }
}
//购票事件
-(void)buyTicketNow
{
    if (_seatView.selectedBtnArr && _seatView.selectedBtnArr.count > 0) {
        
        BOOL canBuyTicket = YES;
        
        //购票逻辑
        
        NSMutableDictionary *seatArrDic = [NSMutableDictionary dictionary];//每一排的选择的座位    字典｛key：数组 ｝
        NSMutableArray *xArra = [[NSMutableArray alloc] init];//排的号码        数组
        
        for (NSInteger i = 0; i < _seatView.selectedBtnArr.count; i++) {
            SeatBtn *seat = _seatView.selectedBtnArr[i];
            
            if (![xArra containsObject:seat.rowNum]) {
                [xArra addObject:seat.rowNum];
            }
        }
        
        for (NSString *tempX in xArra) {
            NSMutableArray *multXArra = [[NSMutableArray alloc]init];
            for (NSInteger i = 0; i < _seatView.selectedBtnArr.count; i++) {
                SeatBtn *seat = (SeatBtn *)_seatView.selectedBtnArr[i];
                
                if ([tempX integerValue] == [seat.rowNum integerValue]) {
                    [multXArra addObject:seat.colNum];
                }
            }
            
            [seatArrDic setObject:multXArra forKey:tempX];
        }
        
        //取出每一排的数据比较
        for (NSString *rowKey in seatArrDic.allKeys) {
            
            
            NSArray *tempArr = [seatArrDic objectForKey:rowKey];
            NSArray *resultArray = [tempArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSNumber *number1 = [NSNumber numberWithInteger:[obj1 integerValue]];
                NSNumber *number2 = [NSNumber numberWithInteger:[obj2 integerValue]];
                
                NSComparisonResult result = [number1 compare:number2];
                
                return result == NSOrderedDescending; // 升序
            }];
            
            NSMutableArray *curRowArr = [NSMutableArray array];//当前排的所有座位
            
            [_seatView.seatBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                SeatBtn *seatBtn = (SeatBtn*)_seatView.seatBtnArr[idx];
                if (seatBtn.seat_X == [rowKey integerValue]) {
                    [curRowArr addObject:seatBtn];
                }
            }];
            
            
            //取出选择的座位的最左边和最右边
            NSInteger min = [resultArray[0] integerValue];
            NSInteger max = [resultArray[resultArray.count - 1] integerValue];
            
            NSMutableArray *edgeArr = [NSMutableArray arrayWithArray:resultArray];//边界数组
            
            //找左边界
            for (NSInteger i = min - 1; i >=0; i--) {
                if (i > 0) {
                    __block SeatBtn *seatBtnLeft;
                    [curRowArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        SeatBtn *btn = (SeatBtn *)curRowArr[idx];
                        if (btn.seat_Y == i) {
                            seatBtnLeft = btn;
                            *stop = YES;
                        }
                    }];
                    if (seatBtnLeft != nil) {
                        if ([seatBtnLeft.rowNum isEqualToString:@""] || [seatBtnLeft.colNum isEqualToString:@""] || seatBtnLeft.seatStatus == SOLD) {
                            [edgeArr addObject:[NSString stringWithFormat:@"%ld",i]];
                            break;
                        }
                    }
                }else
                {
                    [edgeArr addObject:@"0"];
                    break;
                }
                
                
            }
            
            //找右边界
            for (NSInteger i = max + 1; i <= _seatView.maxColNum + 1; i++) {
                
                if (i <= _seatView.maxColNum) {
                    
                    __block SeatBtn *seatBtnRight;
                    [curRowArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        SeatBtn *btn = (SeatBtn *)curRowArr[idx];
                        if (btn.seat_Y == i) {
                            seatBtnRight = btn;
                            *stop = YES;
                        }
                    }];
                    if (seatBtnRight != nil) {
                        if ([seatBtnRight.rowNum isEqualToString:@""] || [seatBtnRight.colNum isEqualToString:@""] || seatBtnRight.seatStatus == SOLD) {
                            [edgeArr addObject:[NSString stringWithFormat:@"%ld",i]];
                            break;
                        }
                    }
                    
                }else
                {
                    [edgeArr addObject:[NSString stringWithFormat:@"%ld",(long)_seatView.maxColNum + 1]];
                    break;
                }
            }
            
            //找中间边界
            
            for (int j = 0; j < resultArray.count - 1; j ++) {
                NSInteger cur = [resultArray[j] integerValue];
                NSInteger next = [resultArray[j + 1] integerValue];
                
                NSInteger left = -1;
                NSInteger right = -1;
                //中间 的  左边界
                for (NSInteger k = cur + 1; k < next; k ++) {
                    
                    __block SeatBtn *seatBtnMiddle_left;
                    [curRowArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        SeatBtn *btn = (SeatBtn *)curRowArr[idx];
                        if ([btn.colNum integerValue] == k) {
                            seatBtnMiddle_left = btn;
                            *stop = YES;
                        }
                    }];
                    if (seatBtnMiddle_left != nil) {
                        if ([seatBtnMiddle_left.rowNum isEqualToString:@""] || [seatBtnMiddle_left.colNum isEqualToString:@""] || seatBtnMiddle_left.seatStatus == SOLD) {
                            left = k;
                            break;
                        }
                    }
                }
                
                
                //中间 的  右边界
                for (NSInteger l = next - 1; l > cur; l --) {
                    
                    __block SeatBtn *seatBtnMiddle_right;
                    [curRowArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        SeatBtn *btn = (SeatBtn *)curRowArr[idx];
                        if ([btn.colNum integerValue] == l) {
                            seatBtnMiddle_right = btn;
                            *stop = YES;
                        }
                    }];
                    if (seatBtnMiddle_right != nil) {
                        if ([seatBtnMiddle_right.rowNum isEqualToString:@""] || [seatBtnMiddle_right.colNum isEqualToString:@""] || seatBtnMiddle_right.seatStatus == SOLD) {
                            right = l;
                            break;
                        }
                    }
                    
                }
                
                if (left != -1 ) {
                    [edgeArr addObject:[NSString stringWithFormat:@"%ld",left]];
                }
                
                if (right != -1 && left != right) {
                    [edgeArr addObject:[NSString stringWithFormat:@"%ld",right]];
                }
            }
            
            //排序
            NSArray *edgeArrNew = [edgeArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                NSNumber *number1 = [NSNumber numberWithInteger:[obj1 integerValue]];
                NSNumber *number2 = [NSNumber numberWithInteger:[obj2 integerValue]];
                
                NSComparisonResult result = [number1 compare:number2];
                
                return result == NSOrderedDescending; // 升序
            }];
            
            NSLog(@"%@",edgeArrNew);
            
            BOOL isConnect = NO;
            BOOL isAlone = NO;
            BOOL isPoint = NO;
            
            NSInteger left_first = [edgeArrNew[0] integerValue];//第一个节点，只记录，不清算
            NSInteger right_first = [edgeArrNew[1] integerValue];
            if(right_first - left_first == 2){
                isAlone = YES;
            }
            
            if(right_first - left_first == 1 && [resultArray containsObject:[NSString stringWithFormat:@"%ld",(long)left_first]] != [resultArray containsObject:[NSString stringWithFormat:@"%ld",(long)right_first]])
            {
                isConnect = YES;
            }
            
            for (NSInteger i = 1; i < edgeArrNew.count - 1; i ++) {
                
                NSInteger left = [edgeArrNew[i] integerValue];
                NSInteger right = [edgeArrNew[i + 1] integerValue];
                
                BOOL isLeftSelf = [resultArray containsObject:[NSString stringWithFormat:@"%ld",(long)left]];//左边是否是自己选择的座位
                BOOL isRightSelf = [resultArray containsObject:[NSString stringWithFormat:@"%ld",(long)right]];//右边是否是自己选择的座位
                
                if (isLeftSelf != isRightSelf || right - left > 1) {
                    isPoint = YES;
                }else
                {
                    isPoint = NO;
                }
                
                if(isPoint){//从第二个节点开始
                    if(right - left == 2){
                        isAlone |= YES;
                    }
                    
                    if(right - left == 1 && isLeftSelf != isRightSelf){
                        isConnect |= YES;
                    }
                    
                    if(!isConnect && isAlone){//清算前两个节点
                        canBuyTicket = NO;
                    }else {
                        
                    }
                    
                    isConnect = NO;//重置为初始值
                    isAlone = NO;
                    
                    if(!canBuyTicket) break;
                    
                    if(right - left == 2){//重新记录，作为下一次清算前的记录
                        isAlone = YES;
                        
                    }
                    if(right - left == 1 && isLeftSelf != isRightSelf){
                        isConnect = YES;
                    }
                }
            }
        }
        
        if(!canBuyTicket) {
            [Utils showHUDText:@"请不要留下单个座位"];
        }else
        {
            [Utils showHUDText:@"可以购票"];
        }
        
    }else
    {
        [Utils showHUDText:@"请选择座位"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
