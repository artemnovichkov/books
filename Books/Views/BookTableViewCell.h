//
//  BookTableViewCell.h
//  Books
//
//  Created by Артем on 13/07/15.
//  Copyright (c) 2015 Artem Novichkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (nonatomic) BOOL chapterShowing;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;
- (void)showChapters;
- (void)hideChapters;

@end
