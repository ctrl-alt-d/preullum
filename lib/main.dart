import 'package:flutter/material.dart';
import 'package:my_app2/services/luzservice.dart';
import 'package:http/http.dart' as http;
import 'MyWidgets/MyCardsWidget.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Memo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var nomesFutur = true;
  final _controller = FadeInController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    List<StatelessWidget> butonsTitol = getBotonsTitol();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: butonsTitol,
        ),
      ),
      body: FadeIn(
        controller: _controller,
        child: FutureBuilder<LuzServiceResult>(
          future: fetchPreus(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? MyCardsWidget(
                    luzServiceResult: snapshot.data!,
                    nomesFutur: nomesFutur,
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
        duration: Duration(milliseconds: 250),
      ),
    );
  }

  List<StatelessWidget> getBotonsTitol() {
    var botonsTitol = [
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          _controller.fadeOut();
          Future.delayed(const Duration(milliseconds: 250), () {
            setState(() {});
            _controller.fadeIn();
          });
        },
      ),
      Text("💡"),
      Switch(
        onChanged: (value) {
          _controller.fadeOut();
          Future.delayed(const Duration(milliseconds: 250), () {
            setState(() {
              nomesFutur = value;
            });
            _controller.fadeIn();
          });
        },
        value: nomesFutur,
      ),
    ];
    return botonsTitol;
  }
}

class PreusList extends StatelessWidget {
  final List<Preu> preus;

  PreusList({Key? key, required this.preus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: preus.length,
      itemBuilder: (context, index) {
        return Text("${preus[index].hour} ${preus[index].price}");
      },
    );
  }
}
