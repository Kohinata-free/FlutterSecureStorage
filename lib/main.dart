import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:secure_stor/SecondPage.dart';

void main() {
  var app = MyApp();
  var scope = ProviderScope(child: app);
  runApp(scope);
}

final prov1 = StateProvider<String>((ref) {
  return 'prov1';
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            centerTitle: true,
            titleSpacing: 0,
            foregroundColor: Colors.white,
            backgroundColor: Colors.black45),
        // primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
      },
      // home: FirstPage(),
    );
  }
}

class FirstPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final provText = ref.watch(prov1);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'FirstPage',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '保存データ=$provText',
              style: TextStyle(
                color: Colors.red,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple.shade100),
              ),
              onPressed: () async {
                final storage = FlutterSecureStorage();
                await storage.delete(key: 'KEY_TEMP');
                var ret = await Navigator.pushNamed(context, '/second');
                print(ret);
                ref.read(prov2.notifier).state = ret.toString();
                final String? dat = await storage.read(key: 'KEY_TEMP');
                ref.read(prov1.notifier).state = dat != null ? dat : 'null';
              },
              child: Text(
                '次のページ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'next',
        child: const Icon(Icons.navigate_next),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
