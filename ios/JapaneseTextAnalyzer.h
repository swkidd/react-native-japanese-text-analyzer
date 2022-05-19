//
//  JapaneseTextAnalyzer.h
//  JapaneseTextAnalyzer
//
//  Created by Kidd, Steven on 2022/05/18.
//

#ifndef JapaneseTextAnalyzer_h
#define JapaneseTextAnalyzer_h

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <iostream>
#import "mecab/mecab.h"

#define CHECK(eval) if (! eval) { \
   const char *e = tagger ? tagger->what() : MeCab::getTaggerError(); \
   std::cerr << "Exception:" << e << std::endl; \
   delete tagger; \
   return e; }

@interface Token : NSObject
@property (strong, atomic) NSObject *token;
- (instancetype)initWithString:(NSString *)string;
@end

@interface JapaneseTextAnalyzer: NSObject <RCTBridgeModule>
- (NSArray<Token*>*) getTokens:(char *)input;
@end

#endif /* JapaneseTextAnalyzer_h */
