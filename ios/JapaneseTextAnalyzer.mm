//
//  JapaneseTextAnalyzer.mm
//  JapaneseTextAnalyzer
//
//  Created by Kidd, Steven on 2022/05/18.
//

#import "JapaneseTextAnalyzer.h"

@implementation JapaneseTextAnalyzer
RCT_EXPORT_MODULE()

+(mecab_t*)mecab {
  static mecab_t* mecab = nil;
  if (mecab == nil) {
    const char *bundlePath = [[[NSBundle mainBundle] resourcePath] UTF8String];
    char buf[256];
    snprintf(buf, sizeof(buf), "%s%s", "-d ", bundlePath);
    mecab = mecab_new2(buf);
  }
  return mecab;
}

- (NSArray<Token *>*) getTokens:(char *)input
{
  mecab_t *mecab = [JapaneseTextAnalyzer mecab];
  NSMutableArray<Token *> *tokens = [NSMutableArray new];
  if (mecab == nil) {
    return tokens;
  }
  const char *result = mecab_sparse_tostr([JapaneseTextAnalyzer mecab], input);
  NSArray *lines = [[NSString stringWithUTF8String:result] componentsSeparatedByString:@"\n"];
  for (NSString *line in lines) {
    if (line.length > 0 && ![line isEqualToString:@"EOS"]) {
      Token *token = [[Token alloc] initWithString:line];
      if (token != nil) {
        [tokens addObject:token];
      }
    }
  }
  return tokens;
}

RCT_EXPORT_METHOD(tokenize:(NSString *)input resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  @try {
    NSMutableArray *ret = [NSMutableArray new];
    if (input.length > 0) {
      NSArray<Token *>*tokens= [self getTokens: strdup([input UTF8String])];
      
      for (Token *token in tokens) {
        [ret addObject:token.token];
      }
    }
    resolve(ret);
  }
  @catch (NSError *exception) {
    reject(@"tokenize_error", @"could not tokenize", exception);

  }
}

@end

@implementation Token

- (NSString *)getFeatureOrNil:(NSArray *)features index:(int)index
{
  NSString *ret = @"";
  if (features.count > index) {
    ret = ![features[index] isEqualToString:@"*"] ? features[index] : @"";
  }
  return ret;
}

- (instancetype)initWithString:(NSString *)line
{
  NSArray *tabSplit = [line componentsSeparatedByString:@"\t"];
  
  NSString *surface;
  if (tabSplit.count > 0) {
    surface = tabSplit[0];
  } else {
    return nil;
  }
  
  if (tabSplit.count > 1) {
    NSArray *features = [tabSplit[1] componentsSeparatedByString:@","];
    NSString *partOfSpeech = [self getFeatureOrNil:features index:0];
    NSString *posDetail1= [self getFeatureOrNil:features index:1];
    NSString *posDetail2= [self getFeatureOrNil:features index:2];
    NSString *posDetail3= [self getFeatureOrNil:features index:3];
    NSString *inflection = [self getFeatureOrNil:features index:4];
    NSString *inflectionType = [self getFeatureOrNil:features index:5];
    NSString *originalForm = [self getFeatureOrNil:features index:6];
    NSString *reading = [self getFeatureOrNil:features index:7];
    NSString *pronunciation = [self getFeatureOrNil:features index:8];
  
    self.token = @{
      @"surface_form": surface,
      @"pos": partOfSpeech,
      @"pos_detail_1": posDetail1,
      @"pos_detail_2": posDetail2,
      @"pos_detail_3": posDetail3,
      @"conjugated_type": inflection,
      @"conjugated_form": inflectionType,
      @"basic_form": originalForm,
      @"reading": reading,
      @"pronunciation": pronunciation,
    };
  } else {
    self.token = @{
      @"surface_form": surface,
      @"pos": @"",
      @"pos_detail_1": @"",
      @"pos_detail_2": @"",
      @"pos_detail_3": @"",
      @"conjugated_type": @"",
      @"conjugated_form": @"",
      @"basic_form": @"",
      @"reading": @"",
      @"pronunciation": @"",
    };
  }
  
  return self;
}
@end
