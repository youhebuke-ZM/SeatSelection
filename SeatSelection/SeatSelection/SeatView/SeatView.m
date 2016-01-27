//
//  SeatView.m
//  wangle
//
//  Created by zm on 15/6/11.
//
//

#import "SeatView.h"
#import "Utils.h"

#define SeatScrollTAG 1000
#define IndexScrollTAG 2000

@implementation SeatView
{
    NSMutableArray *rowLabelArr;

    UIImageView *screen;
    UIView *_bgView;
}

-(id)initWithFrame:(CGRect)frame rowMaxNum:(NSInteger)rowMaxNum columnMaxNum:(NSInteger)columnMaxNum
{
    self = [super initWithFrame:frame];
    if (self) {
        rowLabelArr = [NSMutableArray array];
        _seatBtnArr = [NSMutableArray array];
        _selectedBtnArr = [NSMutableArray array];
        
        _rowMaxNum = rowMaxNum;
        _columnMaxNum = columnMaxNum;
        
        [self setBackgroundColor:HexRGB(0xf5f5f5)];
        
        [self setInstructionsUI];//顶部 厅号和座位总数
        [self initSeatsWithRow:_rowMaxNum column:_columnMaxNum];//座位布局
    }
    return self;
}

//页面初始化 
-(void)setInstructionsUI
{
    //厅号和座位总数
    screen = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen.size.width-200)/2, 0, 200, 15)];
    [screen setImage:[UIImage imageNamed:@"screenBg"]];
    [self addSubview:screen];
    
    _seatInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake( screen.frame.origin.x+10, screen.frame.origin.y, screen.frame.size.width - 20, screen.frame.size.height)];
    _seatInfoLabel.font = [UIFont systemFontOfSize:11];
    _seatInfoLabel.textColor = HexRGB(0x999999);
    _seatInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_seatInfoLabel];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(screen.frame), kScreen.size.width, self.frame.size.height  - CGRectGetMaxY(screen.frame))];
    _scrollView.backgroundColor = [UIColor clearColor];
    [_scrollView setTag:SeatScrollTAG];
    _scrollView.delegate = self;
//    _scrollView.bounces = NO;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.minimumZoomScale = 1.0;
    [self addSubview:_scrollView];
    
    _bgView = [UIView new];
    _bgView.frame = CGRectMake(0, 0, kScreen.size.width, self.frame.size.height  - CGRectGetMaxY(screen.frame));
    [_scrollView addSubview:_bgView];
}


//显示座位号
-(void)setRoomName:(NSString *)roomName seatNum:(int)seatNum
{
    [_seatInfoLabel setText:[NSString stringWithFormat:@"%@共%d座",roomName,seatNum]];
}


#pragma mark   ---初始化座位，最大列，最大行
-(void)initSeatsWithRow:(NSInteger)rowNum column:(NSInteger)columnNum
{
    _maxColNum = columnNum;
    _maxRowNum = rowNum;
    
    CGFloat btnWidth = Item_Width;
    _bgView.frame = CGRectMake(0, 0, columnNum*btnWidth + (columnNum + 1)*Item_Gap + btnWidth + 50,  rowNum*btnWidth + (rowNum + 1)*Item_Gap + 40);
    
    
    for (int i = 0; i < rowNum * columnNum; i ++) {
        CGFloat column = i % columnNum;//第几列
        CGFloat row = i / columnNum;//第几行
        
        SeatBtn *seatBtn = [SeatBtn buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(column * btnWidth + (column + 1) * Item_Gap + btnWidth + 25 ,row * btnWidth + (row + 1) * Item_Gap + 20, btnWidth, btnWidth);
        seatBtn.frame = frame;
        [seatBtn setSeatStatus:CHOOSABLE];
        
        seatBtn.seat_X = row + 1;
        seatBtn.seat_Y = column + 1;
        seatBtn.hidden = YES;
        [seatBtn addTarget:self action:@selector(seatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_seatBtnArr addObject:seatBtn];
        [_bgView addSubview:seatBtn];
    }
    _scrollView.contentSize = CGSizeMake(columnNum*btnWidth + (columnNum + 1)*Item_Gap + btnWidth + 50, rowNum*btnWidth + (rowNum + 1)*Item_Gap + 40);
    
    _rowScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5,_scrollView.frame.origin.y, 15, _scrollView.frame.size.height)];
    _rowScrollView.backgroundColor = [HexRGB(0xc4c4c4) colorWithAlphaComponent:0.8];
    _rowScrollView.layer.cornerRadius = 7.5;
    _rowScrollView.layer.masksToBounds = YES;
    _rowScrollView.delegate = self;
    _rowScrollView.tag = IndexScrollTAG;
    [self addSubview:_rowScrollView];
    
    for (int j = 0; j < rowNum; j ++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, j * btnWidth + (j + 1) * Item_Gap + 20, 15, btnWidth);
        label.text = [NSString stringWithFormat:@"%d",j+1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        [rowLabelArr addObject:label];
        [_rowScrollView addSubview:label];
    }
    _rowScrollView.contentSize = CGSizeMake(15, _scrollView.contentSize.height);
}

#pragma mark  ---设置座位的状态，是否显示------

-(void)setSeatStatus:(NSArray *)arr
{
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *seatInfoDic = [arr objectAtIndex:idx];
        NSString *colNumber = [NSString stringWithFormat:@"%@",[seatInfoDic objectForKey:@"colNumber"]];
        NSString *rowNumber = [NSString stringWithFormat:@"%@",[seatInfoDic objectForKey:@"rowNumber"]];
        NSInteger _x = [[seatInfoDic objectForKey:@"x"] integerValue];
        NSInteger _y = [[seatInfoDic objectForKey:@"y"] integerValue];
        NSLog(@"%@-%@:%ld-%ld",rowNumber,colNumber,(long)_x,(long)_y);
//        NSInteger seatStatus = [[seatInfoDic objectForKey:@"seatStatus"] integerValue];
        NSString *seatCode = [NSString stringWithFormat:@"%@",[seatInfoDic objectForKey:@"seatCode"]];
        
        [_seatBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SeatBtn *seatBtn = (SeatBtn *)[_seatBtnArr objectAtIndex:idx];
            


            if (seatBtn.seat_X == _x && seatBtn.seat_Y == _y) {
                
                seatBtn.rowNum = rowNumber;
                seatBtn.colNum = colNumber;
                if (![rowNumber isEqualToString:@""] && ![colNumber isEqualToString:@""]) {
                    seatBtn.hidden = NO;
                }else
                {
                    seatBtn.hidden = YES;
                }
                [seatBtn setSeatCode:seatCode];
            }
        }];
    }];
}

//将已经售出或预定的座位改为红色并且不可选
-(void)setSoldSeatsStatus:(NSArray *)arr
{
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *seatInfoDic = [arr objectAtIndex:idx];
        NSString *seatCode = [NSString stringWithFormat:@"%@",[seatInfoDic objectForKey:@"seatCode"]];
        [_seatBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SeatBtn *seatBtn = (SeatBtn *)[_seatBtnArr objectAtIndex:idx];
            if ([seatBtn.seatCode isEqualToString:seatCode]) {
                 [seatBtn setSeatStatus:0];
            }
        }];
    }];
}

#pragma mark  ----UIScrollViewDelegate---

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float y = scrollView.contentOffset.y;
    
    if (scrollView.tag == SeatScrollTAG)
    {
        [_rowScrollView setContentOffset:CGPointMake(0, y)];
        
    }else if (scrollView.tag == IndexScrollTAG)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, y)];
    }
}





#pragma mark
-(void)seatBtnClick:(id)sender
{
    SeatBtn *seatBtn = (SeatBtn *)sender;
    
    if (seatBtn.seatStatus == SELECTED)
    {
        [seatBtn setSeatStatus:CHOOSABLE];
        
        [_selectedBtnArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SeatBtn *btn = (SeatBtn *)[_selectedBtnArr objectAtIndex:idx];
            if (btn.seatStatus == CHOOSABLE) {
                *stop = YES;
                if (*stop) {
                    [_selectedBtnArr removeObject:btn];
                    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"seat_Y" ascending:YES];
                    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
                    [_selectedBtnArr sortUsingDescriptors:sortDescriptors];
                }
            }
        }];
    }else if (seatBtn.seatStatus == CHOOSABLE)
    {
        if (_selectedBtnArr.count >= 5) {
            [Utils showHUDText:@"最多可选5个座位"];
            return;
        }
        
        [seatBtn setSeatStatus:SELECTED];
        NSString *str = [NSString stringWithFormat:@"%@排%@座",seatBtn.rowNum,seatBtn.colNum];
        [Utils showHUDText:str];
        [_selectedBtnArr addObject:seatBtn];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"seat_Y" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
        [_selectedBtnArr sortUsingDescriptors:sortDescriptors];
    }
    
    NSLog(@"%@",_selectedBtnArr);
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView.tag == SeatScrollTAG) {
        return _bgView;
    }else
    {
        return nil;
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{

    if (scrollView.tag == SeatScrollTAG) {
        NSLog(@"%f-----%f",scrollView.zoomScale,Item_Width * scrollView.zoomScale);

        CGFloat newHeight = Item_Width * scrollView.zoomScale;
        CGFloat newGap = Item_Gap * scrollView.zoomScale;
        
        _scrollView.contentSize = CGSizeMake(_columnMaxNum*newHeight + (_columnMaxNum + 1)*newGap + newHeight + 50, _rowMaxNum*newHeight + (_rowMaxNum + 1)*newGap + 40);
        
        [rowLabelArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UILabel *rowLabel = (UILabel *)rowLabelArr[idx];
            [rowLabel setFrame:CGRectMake(0, idx * newHeight + (idx + 1) * newGap + 20*scrollView.zoomScale, 15, newHeight)];
        }];
    }

}


@end
