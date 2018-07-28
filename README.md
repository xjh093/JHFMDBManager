# JHFMDBManager

## Dependence
- FMDB

## Logs
- 1.upload.(2018-7-27)

## Example

```
#import "JHFMDBManager.h"

@interface HNReportListDBManager : JHFMDBManager

+ (BOOL)setup;

+ (BOOL)insertRecord:(NSArray *)array;
+ (BOOL)deleteRecord:(NSString *)keyWord;
+ (BOOL)updateRecord:(NSArray *)array;
+ (NSArray *)queryRecord;

@end
```

```
#import "HNReportListDBManager.h"

@implementation HNReportListDBManager

+ (BOOL)setup{
    if ([super setup]) {
        BOOL flag = [super updateRecord:@"CREATE TABLE IF NOT EXISTS t_xuncha (xid integer PRIMARY KEY AUTOINCREMENT, json text, images text, time text)" arguments:nil];
        if (flag) NSLog(@"创建表 t_xuncha 成功!");
        else NSLog(@"创建表 t_xuncha 失败!");
        return YES;
    }
    return NO;
}

+ (BOOL)insertRecord:(NSArray *)array{
    // json , images , time
    return [super insertRecord:@"INSERT INTO t_xuncha (json, images, time) VALUES (?,?,?)" arguments:array];
}

+ (BOOL)deleteRecord:(NSString *)keyWord{
    return [super deleteRecord:@"DELETE FROM t_xuncha WHERE time = ?" arguments:@[keyWord]];
}

+ (BOOL)updateRecord:(NSArray *)array{
    // json , images , time
    return [super updateRecord:@"UPDATE t_xuncha SET json = ? , images = ? WHERE time = ?" arguments:array];
}

+ (NSArray *)queryRecord{
    FMResultSet *result = [super queryRecord:@"select * from t_xuncha" arguments:nil];
    NSMutableArray *marr = @[].mutableCopy;
    while ([result next]) {
        NSString *json   = [result stringForColumn:@"json"];
        NSString *images = [result stringForColumn:@"images"];
        NSString *time   = [result stringForColumn:@"time"];
        
        NSMutableArray *tmarr = @[].mutableCopy;
        [tmarr addObject:json];
        [tmarr addObject:images];
        [tmarr addObject:time];
        
        [marr addObject:tmarr];
    }
    return marr;
}

@end
```
