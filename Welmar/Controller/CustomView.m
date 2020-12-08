//
//  CustomView.m
//  Welmar
//
//  Created by jliussuweno on 04/12/20.
//

#import "CustomView.h"

@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    self.layer.cornerRadius = 5.0;
}

@end
