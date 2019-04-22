import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

// StatelessWidget 不可变, 所有属性值均为 final 不可变;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // first
    // final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'First Flutter App',
      home: new RandomWords(),
      // first & second
      // home: new Scaffold(
      //   appBar: new AppBar(
      //     title: new Text('Welcome to Flutter'),
      //   ),
      //   body: new Center(
      //     // first
      //     // child: const Text('Hello World'),
      //     // child: new Text(wordPair.asPascalCase)
      //     // second
      //     child: new RandomWords(),
      //   ),
      // ),
    );
  }
}

// second
// 实现 Stateful widgets: 需要 StatefulWidget 类和 State 类
// 前者不可变，但 State 在 widget 类中可变
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

// second & third
class RandomWordsState extends State<RandomWords> {
  // third
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次 itemBuilder，
      // 然后将单词对添加到 ListTile 行中
      // 在奇数行，该函数会添加一个分割线的 widget，来分隔相邻的词对。
      // 在偶数行，该函数会为单词对添加一个 ListTile row.
      // 注意，在小屏幕上，分割线看起来可能比较吃力。
      itemBuilder: (BuildContext _context, int i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if (i.isOdd) {
          return new Divider();
        }
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整）
        // 比如 i 为：1, 2, 3, 4, 5 时，结果为 0, 1, 1, 2, 2，
        // 这可以计算出 ListView 中减去分隔线后的实际单词对数量
        final int index = i ~/ 2;
        // 每 10个 增加
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // second
    // final WordPair wordPair = new WordPair.random();
    // return new Text(wordPair.asPascalCase);
    // third
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('emmm'),
      ),
      body: _buildSuggestions(),
    );
  }
}

