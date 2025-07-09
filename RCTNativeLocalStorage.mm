#import "RCTNativeLocalStorage.h"
#import <Foundation/Foundation.h>

@implementation RCTNativeLocalStorage

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(fetchWeatherForRiyadh:(RCTResponseSenderBlock)callback) {
  NSString *apiKey = @"6c68a17d9b182868b79065916bb3ad1d";
  NSString *urlString = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?q=Riyadh&appid=%@&units=metric", apiKey];
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      callback(@[@"Error fetching weather", [NSNull null]]);
      return;
    }
    
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError) {
      callback(@[@"Error parsing JSON", [NSNull null]]);
      return;
    }
    
    callback(@[[NSNull null], json]);
  }];
  
  [task resume];
}

@end
