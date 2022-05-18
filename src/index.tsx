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

export function tokenize(text: string): Promise<string> {
  return JapaneseTextAnalyzer.tokenize(text);
}
