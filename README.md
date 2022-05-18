# react-native-japanese-text-analyzer

A Japanese Text Morphological Analyzer for React Native using Kuromoji for Android and Mecab for iOS

# ONLY ANDROID IS IMPLEMENTED CURRENTLY
## Installation

```sh
npm install react-native-japanese-text-analyzer
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