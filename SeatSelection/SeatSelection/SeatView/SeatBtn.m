//
//  SeatBtn.m
//  wangle
//
//  Created by zm on 15/6/11.
//
//

#import "SeatBtn.h"

@implementation SeatBtn

//根据状态选择座位图片
-(void)setSeatStatus:(SeatStatus)seatStatus
{
    _seatStatus = seatStatus;
    
    switch (_seatStatus) {
        case 0:
            [self setBackgroundImage:[UIImage imageNamed:@"sold"] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
            break;
        case 1:
            [self setBackgroundImage:[UIImage imageNamed:@"choosable"] forState:UIControlStateNormal];
            break;
        case 2:
            [self setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

//给座位分配座位号
-(void)setColNum:(NSString *)colNum{
    _colNum = colNum;
//    [self setTitle:[NSString stringWithFormat:@"%@",_colNum] forState:UIControlStateNormal];
//    [self setTitleColor:HexRGB(0x999999) forState:UIControlStateNormal];
//    self.titleLabel.font = [UIFont systemFontOfSize:9];
}


@end
