//
//  AccountTableViewCell.m
//  Welmar
//
//  Created by jliussuweno on 03/12/20.
//

#import "AccountTableViewCell.h"

@implementation AccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imageArrow.image = [_imageArrow.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imageArrow setTintColor:[UIColor whiteColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
