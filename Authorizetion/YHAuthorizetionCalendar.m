//
//  YHAuthorizetionCalendar.m
//  chanDemo
//
//  Created by apple on 2019/1/5.
//  Copyright © 2019 银河. All rights reserved.
//

#import "YHAuthorizetionCalendar.h"

@implementation YHAuthorizetionCalendar

// Determine whether authorization is currently available.
+ (BOOL)isAuthorized{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    return status == EKAuthorizationStatusAuthorized;
}

// Request calendar authorizetion.
+ (void)requestAuthorizetionWithCompletion:(void (^)(BOOL, BOOL))completion{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (status) {
        case EKAuthorizationStatusAuthorized:
        {
            completion ? completion(YES, NO) : nil;
        }
            break;
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted:
        {
            completion ? completion(NO, NO) : nil;
        }
            break;
        case EKAuthorizationStatusNotDetermined:
        {
            [[[EKEventStore alloc] init] requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion ? completion(granted, YES) : nil;
                });
            }];
        }
            break;
        default:
            break;
    }
}




@end
