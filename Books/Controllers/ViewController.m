//
//  ViewController.m
//  Books
//
//  Created by Артем on 13/07/15.
//  Copyright (c) 2015 Artem Novichkov. All rights reserved.
//

#import "ViewController.h"
#import "BookTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *books;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _books = [@[] mutableCopy];
    for (int i = 0; i < 50; i++) {
        NSMutableDictionary *book = [@{} mutableCopy];
        NSMutableArray *chapters = [@[] mutableCopy];
        NSInteger chapterCount = arc4random() % 100;
        for (int j = 0; j < chapterCount; j++) {
            NSString *chapterTitle = [NSString stringWithFormat:@"Chapter %i", j + 1];
            [chapters addObject:chapterTitle];
        }
        NSString *bookTitle = [NSString stringWithFormat:@"Book %i", i + 1];
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
    NSDictionary *book = _books[indexPath.row];
    cell.bookTitleLabel.text = [[book allKeys] firstObject];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *chapters = _books[indexPath.row];
    NSLog(@"%@", chapters);
}

@end
