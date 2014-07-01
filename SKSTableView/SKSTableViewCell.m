//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"
#import "SKSTableViewCellIndicator.h"

#define kIndicatorViewTag -1

@interface SKSTableViewCell ()
@property(nonatomic) UIImageView* customAccessoryView;
@property(nonatomic) BOOL isLayoutCustomAccessoryView;
@end

@implementation SKSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.expandable = YES;
        self.expanded = NO;
        self.accessoryView = [self expandableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (!self.isLayoutCustomAccessoryView) {
        self.isLayoutCustomAccessoryView = TRUE;
        self.customAccessoryView.center = self.accessoryView.center;
    }
}

static UIImage *_image = nil;
- (UIView *)expandableView
{
    if (!_image) {
        _image = [UIImage imageNamed:@"profile_accessory_view.png"];
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, _image.size.width, _image.size.height);
    button.frame = frame;

    UIImageView* imageView = [[UIImageView alloc] initWithImage:_image];
    imageView.center = CGPointZero;
    self.customAccessoryView = [[UIImageView alloc] initWithImage:_image];
    [self addSubview:self.customAccessoryView];

    return button;
}

- (void)setExpandable:(BOOL)isExpandable
{
    _expandable = isExpandable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (BOOL)containsIndicatorView
{
    return [self.contentView viewWithTag:kIndicatorViewTag] ? YES : NO;
}

- (void)accessoryViewAnimation
{
    [UIView animateWithDuration:0.2f animations:^{
        if (self.isExpanded) {
            self.customAccessoryView.transform = CGAffineTransformMakeRotation(M_PI_2);
        } else {
            self.customAccessoryView.transform = CGAffineTransformMakeRotation(0);
        }
    } completion:^(BOOL finished) {
    }];
}

- (void)setFrame:(CGRect)frame {
    if (!UIEdgeInsetsEqualToEdgeInsets(self.cellMargin, UIEdgeInsetsZero)) {
        frame.origin.x += self.cellMargin.left;
        frame.origin.y += self.cellMargin.top;
        frame.size.width -= (self.cellMargin.left + self.cellMargin.right);
        frame.size.height -= (self.cellMargin.top + self.cellMargin.bottom);
    }
    [super setFrame:frame];
}

@end
