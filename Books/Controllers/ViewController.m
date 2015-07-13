//
//  ViewController.m
//  Books
//
//  Created by Артем on 13/07/15.
//  Copyright (c) 2015 Artem Novichkov. All rights reserved.
//

#import "ViewController.h"
#import "BookTableViewCell.h"
#import "CustomCollectionView.h"
#import "CollectionViewCell.h"

@interface ViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *books;

@property (nonatomic) NSIndexPath *selectedIndexPath;

@end

static CGFloat const kTableViewCellHeight = 45.f;
static CGFloat const kCollectionViewCellHeight = 20.f;
static CGFloat const kInteritemSpacing = 2.f;
static NSInteger const kRowNumber = 5;
static NSInteger const kColumnNumber = 5;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _books = [@[] mutableCopy];
    for (int i = 0; i < 50; i++) {
        NSMutableDictionary *book = [@{} mutableCopy];
        NSMutableArray *chapters = [@[] mutableCopy];
        NSInteger chapterCount = arc4random() % 100;
        for (int j = 0; j < chapterCount; j++) {
            NSString *chapterTitle = [NSString stringWithFormat:@"Chapter %d", j + 1];
            [chapters addObject:chapterTitle];
        }
        NSString *bookTitle = [NSString stringWithFormat:@"Book %d", i + 1];
        book[bookTitle] = chapters;
        [_books addObject:book];
    }
    NSString *bookCellIdentifier = NSStringFromClass([BookTableViewCell class]);
    [_tableView registerNib:[UINib nibWithNibName:bookCellIdentifier bundle:nil] forCellReuseIdentifier:bookCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bookCellIdentifier = NSStringFromClass([BookTableViewCell class]);
    BookTableViewCell *cell = (BookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:bookCellIdentifier
                                                                                   forIndexPath:indexPath];
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSDictionary *book = _books[indexPath.row];
    cell.bookTitleLabel.text = [[book allKeys] firstObject];
    if (indexPath == _selectedIndexPath) {
        [cell showChapters];
    }
    else {
        [cell hideChapters];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndexPath = indexPath;
    BookTableViewCell *cell = (BookTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [cell showChapters];
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookTableViewCell *cell = (BookTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell hideChapters];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == _selectedIndexPath) {
        return kTableViewCellHeight + 5 * kCollectionViewCellHeight;
    }
    else {
        return kTableViewCellHeight;
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CustomCollectionView *customCollectionView = (CustomCollectionView *)collectionView;
    NSDictionary *book = _books[customCollectionView.indexPath.row];
    NSString *bookTitle = [NSString stringWithFormat:@"Book %ld", customCollectionView.indexPath.row + 1];
    NSArray *chapters = book[bookTitle];
    return chapters.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = NSStringFromClass([CollectionViewCell class]);
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                               forIndexPath:indexPath];
    CustomCollectionView *customCollectionView = (CustomCollectionView *)collectionView;
    NSDictionary *book = _books[customCollectionView.indexPath.row];
    NSString *bookTitle = [NSString stringWithFormat:@"Book %ld", customCollectionView.indexPath.row + 1];
    NSArray *chapters = book[bookTitle];
    cell.chapterTitleLabel.text = chapters[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionView *customCollectionView = (CustomCollectionView *)collectionView;
    NSDictionary *book = _books[customCollectionView.indexPath.row];
    NSString *bookTitle = [NSString stringWithFormat:@"Book %ld", customCollectionView.indexPath.row + 1];
    NSArray *chapters = book[bookTitle];
    NSLog(@"You selected %@ in %@", chapters[indexPath.row], bookTitle);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((CGRectGetWidth(collectionView.frame) - kInteritemSpacing * kRowNumber) / kRowNumber,
                      (CGRectGetHeight(collectionView.frame) - kInteritemSpacing * kColumnNumber) / kColumnNumber);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kInteritemSpacing;
}

@end
