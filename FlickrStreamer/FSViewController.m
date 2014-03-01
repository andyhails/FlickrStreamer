//
//  FSViewController.m
//  FlickrStreamer
//
//  Created by Andrew Hails on 01/03/2014.
//  Copyright (c) 2014 Andrew Hails. All rights reserved.
//

#import "FSViewController.h"
#import "FSDataManager.h"

@interface FSViewController () <UICollectionViewDelegate>
@property (nonatomic) NSMutableArray *photos;
@property (nonatomic) BOOL loading;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *PhotoTitle;

@end

@implementation FSViewController


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _loading = NO;
        _photos = [@[] mutableCopy];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPhotos];
    [self setUpCollectionView];
}


- (void) setUpCollectionView
{

}


- (void)loadPhotos
{
    if (self.loading == NO) {
        self.loading = YES;
        [[FSDataManager sharedInstance] loadPhotosWithCompletion:[self loadPhotosCompletion]];
    }
}


- (FSDataManagerPhotoCompletionHandler)loadPhotosCompletion
{
    return ^(NSArray *items, NSError *error) {
        if (error) {
            [self loadPhotosFailed];
        }
        else {
            [self loadPhotosSuccessful:items];
        }
        
    };
}


- (void)loadPhotosSuccessful:(NSArray *)items
{
    if (items.count > 0) {
        [self.photos addObjectsFromArray:items];
    }
    self.loading = NO;
}


- (void)loadPhotosFailed
{
    NSLog(@"Unable to download photos for FSViewController screen");
}


- (void)setPhotos:(NSMutableArray *)photos
{
    _photos = photos;
    
}

#pragma mark -
#pragma mark UICollectionView



@end
