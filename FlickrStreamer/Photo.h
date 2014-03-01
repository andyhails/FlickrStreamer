//
//  Photo.h
//  FlickrStreamer
//
//  Created by Andrew Hails on 01/03/2014.
//  Copyright (c) 2014 Andrew Hails. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, copy) NSString *photoId;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, copy) NSString *farm;
@property (nonatomic, copy) NSString *title;

@end
