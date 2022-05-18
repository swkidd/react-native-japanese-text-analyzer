import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { tokenize } from 'react-native-japanese-text-analyzer';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  React.useEffect(() => {
    tokenize("お寿司が食べたい。").then(setResult);
  }, []);

  return (
    <View style={styles.container}>
      <Text>{JSON.stringify(result)}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
