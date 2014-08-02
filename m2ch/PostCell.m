//
//  PostCell.m
//  Tabula
//
//  Created by Alexander Tewpin on 25/07/14.
//  Copyright (c) 2014 Alexander Tewpin. All rights reserved.
//

#import "PostCell.h"

@interface PostCell ()

@property (nonatomic, strong) UIColor *darkGrey;
@property (nonatomic, strong) UIColor *lightGrey;
@property (nonatomic, strong) UIColor *separatorGrey;
@property (nonatomic, strong) UIColor *celestiaGreen;
@property (nonatomic, strong) UIColor *celestiaOrange;

@end

@implementation PostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
    self.celestiaGreen = [UIColor colorWithRed:(17/255.0) green:(139/255.0) blue:(116/255.0) alpha:1.0];
    self.celestiaOrange = [UIColor colorWithRed:(255/255.0) green:(139/255.0) blue:(16/255.0) alpha:1.0];
    self.darkGrey = [UIColor colorWithRed:(155/255.0) green:(155/255.0) blue:(155/255.0) alpha:1.0];
    self.lightGrey = [UIColor colorWithRed:(216/255.0) green:(216/255.0) blue:(216/255.0) alpha:1.0];
    self.separatorGrey = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    
    self.comment.textContainerInset = UIEdgeInsetsMake(CELL_TEXT_VIEW_V_INSET, 0, CELL_TEXT_VIEW_V_INSET, 0);
    self.comment.linkTextAttributes = @{NSForegroundColorAttributeName: self.celestiaOrange};
    self.imagePosition = self.postImage.frame.origin;
    
    self.separator = [[UIView alloc]init];
    self.separator.backgroundColor = self.separatorGrey;
    [self addSubview:self.separator];
    
    self.moreButton.tintColor = self.darkGrey;
    self.repliesButton.tintColor = self.darkGrey;
    self.replyButton.tintColor = self.darkGrey;
    
    self.status.textColor = self.darkGrey;
    self.subtitle.textColor = self.darkGrey;
}

- (id) setPost:(Post *)post {
    //title
    self.title.text = post.name;
    
    //subtitle
    self.subtitle.text = [NSString stringWithFormat:@"#%@  №%@", post.threadNumber, post.postId];
    
    //status & date
    self.status.text = post.date;
    
    //image
    self.postImage.tnHeight = post.tnHeight;
    self.postImage.tnWidth = post.tnWidth;
    
    self.postImage.frame = CGRectMake(self.imagePosition.x, self.imagePosition.y, 0, 0);
    [self.postImage resetSize];
    
    self.postImage.bigImageUrl = post.imageUrl;
    [self.postImage setImageWithURL:post.thumbnailUrl];
    
    //comment (image-depend)
    if (post.tnHeight > 0 && post.tnWidth > 0) {
        UIBezierPath *imagePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.postImage.bounds.size.width+CELL_IMAGE_H_INSET, self.postImage.bounds.size.height+CELL_IMAGE_V_INSET)];
        self.comment.textContainer.exclusionPaths = @[imagePath];
    } else {
        self.comment.textContainer.exclusionPaths = nil;
    }
    
    self.comment.attributedText = post.body;
    
    //replies
    NSInteger postReplies = [post.replies count];
    NSInteger postReplyTo = [post.replyTo count];
    NSString *title = @"";
    
    if (postReplies > 0 && postReplyTo > 0) {
        self.repliesButton.hidden = NO;
        title = [NSString stringWithFormat:@"▲%ld  ▼%ld", (long)postReplyTo, (long)postReplies];
    } else if (postReplies > 0) {
        self.repliesButton.hidden = NO;
        title = [NSString stringWithFormat:@"▼%ld", (long)postReplies];
    } else if (postReplyTo > 0) {
        self.repliesButton.hidden = NO;
        title = [NSString stringWithFormat:@"▲%ld", (long)postReplyTo];
    } else {
        self.repliesButton.hidden = YES;
    }
    
    //воркэраунд против бага(?) в 7, который несмотря ни на что анимирует изменение текста
    self.repliesButton.titleLabel.text = title;
    [self.repliesButton setTitle:title forState:UIControlStateNormal];
    
    self.postId = post.postId;
    self.separator.frame = CGRectMake(15, self.frame.size.height-0.5, 305, 0.5);
    
    return self;
}

@end