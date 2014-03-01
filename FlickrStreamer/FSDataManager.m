//
//  FSDataManager.m
//  FlickrStreamer
//
//  Created by Andrew Hails on 01/03/2014.
//  Copyright (c) 2014 Andrew Hails. All rights reserved.
//

#import "FSDataManager.h"
#import "Photo.h"
#import <RestKit/RestKit.h>


@interface FSDataManager ()
@property (nonatomic, readwrite) NSArray *ports;
@end

@implementation FSDataManager
+ (FSDataManager *)sharedInstance
{
    static id sharedInstance = nil;
    @synchronized ([self class]) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
        return sharedInstance;
    }
}


- (void)loadPhotosWithCompletion:(FSDataManagerPhotoCompletionHandler)completionHandler
{
    RKObjectMapping *photoMapping = [RKObjectMapping mappingForClass:[Photo class]];
    [photoMapping addAttributeMappingsFromDictionary:@{
                                                       @"id" : @"photoId",
                                                       @"owner" : @"owner",
                                                       @"secret" : @"secret",
                                                       @"server" : @"server",
                                                       @"farm" : @"farm",
                                                       @"title" : @"title",
                                                       }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:photoMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"photos.photo"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&api_key=6a17cc6856ecc191235326bd4739442e&tags=flowers&nojsoncallback=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completionHandler) {
            completionHandler(mappingResult.array, nil);
        }
        RKLogInfo(@"Load collection of Photos: %@", mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completionHandler) {
            completionHandler(nil, error);
        }
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
}

@end
