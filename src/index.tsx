import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-japanese-text-analyzer' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const JapaneseTextAnalyzer = NativeModules.JapaneseTextAnalyzer
  ? NativeModules.JapaneseTextAnalyzer
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

interface Token {
  surface_form: string;
  pos: string;
  pos_detail_1: string;
  pos_detail_2: string;
  pos_detail_3: string;
  conjugated_type: string;
  conjugated_form: string;
  basic_form: string;
  reading: string;
  pronunciation: string;
}

export function tokenize(text: string): Promise<Token[]> {
  return JapaneseTextAnalyzer.tokenize(text);
}
