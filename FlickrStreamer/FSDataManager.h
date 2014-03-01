//
//  FSDataManager.h
//  FlickrStreamer
//
//  Created by Andrew Hails on 01/03/2014.
//  Copyright (c) 2014 Andrew Hails. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^FSDataManagerPhotoCompletionHandler)(NSArray *photo, NSError *error);

@interface FSDataManager : NSObject
@property (nonatomic, readonly) NSArray *photos;


+ (FSDataManager *)sharedInstance;
- (void)loadPhotosWithCompletion:(FSDataManagerPhotoCompletionHandler)completionHandler;

@end
