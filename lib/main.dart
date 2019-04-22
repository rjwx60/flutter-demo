import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

// StatelessWidget 不可变, 所有属性值均为 final 不可变;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'First Flutter App',
      home: new RandomWords(),
    );
  }
}

// 实现 Stateful widgets: 需要 StatefulWidget 类和 State 类
// 前者不可变，但 State 在 widget 类中可变
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  void _pushSaved() {
    // 跳转收藏页面
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          });
          final List<Widget> divied = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();
          
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Favorite Suggestion'),
            ),
            body: new ListView(children: divied),
          );
        }
      ),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          // 奇数分割
          return new Divider();
        }
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整）
        // 如 i 为：1, 2, 3, 4, 5 时，结果为 0, 1, 1, 2, 2， 计算 ListView 中减去分隔线后的实际单词对数量
        final int index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
      trailing: new Icon(
        // 添加图标
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // 点击事件
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('emmm'),
        // 新增tab
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved,)
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

