package com.reactnativejapanesetextanalyzer;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableArray;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.bridge.WritableNativeArray;
import com.facebook.react.bridge.Arguments;

import com.atilika.kuromoji.ipadic.Token;
import com.atilika.kuromoji.ipadic.Tokenizer;
import java.util.List;

@ReactModule(name = JapaneseTextAnalyzerModule.NAME)
public class JapaneseTextAnalyzerModule extends ReactContextBaseJavaModule {
    public static final String NAME = "JapaneseTextAnalyzer";
    private static final Tokenizer tokenizer = new Tokenizer();

    public JapaneseTextAnalyzerModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }


    @ReactMethod
    public void tokenize(String text, Promise promise) {
        try {
            List<Token> tokens = tokenizer.tokenize(text);
            WritableArray list = new WritableNativeArray();
            for (Token token : tokens) {
                WritableMap map = new WritableNativeMap();
                map.putString("surface_form", token.getSurface());
                String[] features = token.getAllFeatures().split(",");
                map.putString("pos", features[0]);
                map.putString("pos_detail_1", features[1]);
                map.putString("pos_detail_2", features[2]);
                map.putString("pos_detail_3", features[3]);
                map.putString("conjugated_type", features[4]);
                map.putString("conjugated_form", features[5]);
                map.putString("basic_form", features[6]);
                map.putString("reading", features[7]);
                map.putString("pronunciation", features[8]);
                list.pushMap(map);
            }
            promise.resolve(list);
        } catch (Exception e) {
            promise.reject(e);
        }
    }
}
