# react-native-japanese-text-analyzer

A Japanese Text Morphological Analyzer for React Native using Kuromoji for Android and Mecab for iOS

## Installation

```sh
npm install react-native-japanese-text-analyzer
```

## IOS Installation

In order to use this package in iOS some additional steps are involved. There are two folders that must be copied into the ios project using x-code. 
`mecab` and `ipadic`, see the example project for folder struture. Select 'create groups` and 'add to target' in the add files dialog.

The ipadic folder must be added to the app bundle and the mecab folder to the compiler sources, both in the Build Phases tab of the target settings in x-code. 

Add 'HAVE_CONFIG_H' to the 'Preprocessor Macros' section of the probject Build Settings.

Finally, add `-liconv` as linking flags and `-fcxx-modules` and `-fmodules` as 'Other C++ Flags' in the target Build Settings tab

## Android Installation
In order to use this package for Android there is a single additional step required. Simply add the following to the 'android' section of the app build.gradle file.

```
android {
    ...
    packagingOptions {
        pickFirst 'META-INF/CONTRIBUTORS.md'
        pickFirst 'META-INF/LICENSE.md'
    }
}
```

## Usage

```js
import { tokenize } from "react-native-japanese-text-analyzer";

// ...

const result = await tokenize("お寿司が食べたい。");
```

Result of the form 
```
[ {
    surface_form: '黒文字',    // 表層形
    pos: '名詞',               // 品詞
    pos_detail_1: '一般',      // 品詞細分類1
    pos_detail_2: '*',        // 品詞細分類2
    pos_detail_3: '*',        // 品詞細分類3
    conjugated_type: '*',     // 活用型
    conjugated_form: '*',     // 活用形
    basic_form: '黒文字',      // 基本形
    reading: 'クロモジ',       // 読み
    pronunciation: 'クロモジ'  // 発音
  } ]
  ``` 

## License

MIT
