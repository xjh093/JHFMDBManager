//
//  JHFMDBManager.m
//  JHKit
//
//  Created by HaoCold on 2017/6/23.
//  Copyright © 2017年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JHFMDBManager.h"

#define kJHDBNAME @"worklist.db"

static FMDatabase *_db;

@implementation JHFMDBManager

+ (BOOL)setup
{
    if (_db) {
        return YES;
    }
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *subPath = [doc stringByAppendingPathComponent:@"db"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:subPath isDirectory:NULL]) {
        NSError *error = nil;
        BOOL flag = [[NSFileManager defaultManager] createDirectoryAtPath:subPath withIntermediateDirectories:NO attributes:nil error:nil];
        if (flag) {
            NSLog(@"创建文件夹成功");
        }else{
            NSLog(@"创建文件夹失败,error:%@",[error localizedDescription]);
        }
    }
    
    NSString *dbPath = [subPath stringByAppendingPathComponent:kJHDBNAME];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open]) {
        NSLog(@"db open success!");
        _db = db;
        return YES;
    }else{
        NSLog(@"db open failure!");
        return NO;
    }
    return YES;
}

+ (BOOL)insertRecord:(NSString *)sql,...{
    if (_db == nil) return NO;
    
    BOOL flag = [_db executeUpdate:sql];
    if (flag){
        NSLog(@"插入数据成功!");
    }else{
        NSLog(@"插入数据失败!");
    }
    return flag;
}

+ (BOOL)deleteRecord:(NSString *)sql,...{
    if (_db == nil) return NO;
    
    BOOL flag = [_db executeUpdate:sql];
    if (flag){
        NSLog(@"删除数据成功!");
    }else{
        NSLog(@"删除数据失败!");
    }
    return flag;
}

+ (BOOL)updateRecord:(NSString *)sql,...{
    if (_db == nil) return NO;
    
    BOOL flag = [_db executeUpdate:sql];
    if (flag){
        NSLog(@"更新数据成功!");
    }else{
        NSLog(@"更新数据失败!");
    }
    return flag;
}

+ (FMResultSet *)queryRecord:(NSString *)sql,...{
    return [_db executeQuery:sql];
}

@end
