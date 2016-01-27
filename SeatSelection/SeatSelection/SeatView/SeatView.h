//
//  SeatView.h
//  wangle
//
//  Created by zm on 15/6/11.
//
//

#import <UIKit/UIKit.h>
#import "SeatBtn.h"


#define Item_Gap 5.0   //座位之间的间隙
#define Item_Width 20.0  //座位的宽度／高度

#define kScreen [UIScreen mainScreen].bounds

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SeatView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIScrollView *_rowScrollView;
    UILabel *_seatInfoLabel;
}
@property (assign,nonatomic) NSInteger maxRowNum;//最大行数
@property (assign,nonatomic) NSInteger maxColNum;//最大列数
@property (assign,nonatomic) NSInteger rowMaxNum;//行
@property (assign,nonatomic) NSInteger columnMaxNum;//列
@property (strong,nonatomic) NSMutableArray *selectedBtnArr;//已经选中的座位
@property (strong,nonatomic) NSMutableArray *seatBtnArr;//所有的座位


-(id)initWithFrame:(CGRect)frame rowMaxNum:(NSInteger)rowMaxNum columnMaxNum:(NSInteger)columnMaxNum;

//房间号，座位数
-(void)setRoomName:(NSString *)roomName seatNum:(int)seatNum;

//设置每个座位的状态 和 是否显示
-(void)setSeatStatus:(NSArray *)arr;

//将已经售出或预定的座位改为红色并且不可选
-(void)setSoldSeatsStatus:(NSArray *)arr;

@end
