//
//  BookTableViewCell.m
//  Books
//
//  Created by Артем on 13/07/15.
//  Copyright (c) 2015 Artem Novichkov. All rights reserved.
//

#import "BookTableViewCell.h"
#import "CustomCollectionView.h"
#import "CollectionViewCell.h"

@interface BookTableViewCell()

@property (weak, nonatomic) IBOutlet CustomCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@end

@implementation BookTableViewCell

- (void)awakeFromNib {
    _collectionViewHeightConstraint.constant = 0.f;
    [self setNeedsUpdateConstraints];
    _collectionView.backgroundColor = self.backgroundColor;
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

#pragma mark - Chapters

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    _collectionView.dataSource = dataSourceDelegate;
    _collectionView.delegate = dataSourceDelegate;
    _collectionView.indexPath = indexPath;
    NSString *identifier = NSStringFromClass([CollectionViewCell class]);
    [_collectionView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
    [_collectionView reloadData];
}
- (void)showChapters
{
    _chapterShowing = YES;
    [UIView animateWithDuration:2.0 animations:^{
        _collectionViewHeightConstraint.constant = 200.f;
        [self setNeedsDisplay];
        [self setNeedsUpdateConstraints];
    }];
}

- (void)hideChapters
{
    _chapterShowing = NO;
    [UIView animateWithDuration:2.0 animations:^{
        _collectionViewHeightConstraint.constant = 0.f;
        [self setNeedsDisplay];
        [self setNeedsUpdateConstraints];
    }];
}

@end
