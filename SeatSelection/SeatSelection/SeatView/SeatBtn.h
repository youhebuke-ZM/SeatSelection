//
//  SeatBtn.h
//  wangle
//
//  Created by zm on 15/6/11.
//
//



#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SOLD,//已售
    CHOOSABLE,//可选
    SELECTED,//已选
} SeatStatus;

@interface SeatBtn : UIButton


@property (nonatomic,assign) SeatStatus seatStatus;
@property (nonatomic,assign) NSInteger  seat_X;//排号（包括隐藏的SeatBtn）
@property (nonatomic,assign) NSInteger  seat_Y;//列号（包括隐藏的SeatBtn）
@property (nonatomic,strong) NSString   *seatCode;//座位号
@property (nonatomic,strong) NSString   *rowNum;//排号（不包括隐藏的SeatBtn）
@property (nonatomic,strong) NSString   *colNum;//列号（不包括隐藏的SeatBtn）
@property (nonatomic,assign) BOOL isEdge;//当前座位是否是当前这一排的最边上或者靠走廊
@end
