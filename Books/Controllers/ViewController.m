//
//  ViewController.m
//  Books
//
//  Created by Артем on 13/07/15.
//  Copyright (c) 2015 Artem Novichkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _books = [@{} mutableCopy];
    for (int i = 0; i < 50; i++) {
        NSMutableArray *book = [@[] mutableCopy];
        NSInteger chapterCount = arc4random() % 100;
        for (int j = 0; j < chapterCount; j++) {
            NSString *chapterTitle = [NSString stringWithFormat:@"Chapter %i", j + 1];
            [book addObject:chapterTitle];
        }
        NSString *bookTitle = [NSString stringWithFormat:@"Book %i", i + 1];
        self.books[bookTitle] = book;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
