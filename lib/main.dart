import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Architecto',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Начало'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class Template {
  final String title;
  final String summary;

  const Template(this.title, this.summary);
}

class TemplateList extends StatefulWidget {
  final List<Template> templates;

  TemplateList({Key key, this.templates}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _TemplateListState();
}

class _TemplateListState extends State<TemplateList> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 110.0,
      child: new ListView(
          scrollDirection: Axis.horizontal,
          itemExtent: 230.0,
          children: widget.templates.map((Template template) {
            return new _TemplateItem(template);
          }).toList()),
    );
  }
}

class _TemplateItem extends StatelessWidget {
  final Template template;

  _TemplateItem(this.template) : super(key: new ObjectKey(template));

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new ListTile(
        title: new Text(template.title),
        subtitle: new Text(template.summary),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var scrollController = new ScrollController();
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        controller: scrollController,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text(
                'Подумайте о Вашей предметной области и определите с какими сущностями вы работаете.',
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text(
                'Это могут быть: Задачи, обьекты, заявки, напоминания, заказы, встречи, занятия, контракты, документы и прочее.',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text(
                'Начните с выбора подходящего шаблона или настройте все с нуля',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            new TemplateList(
              templates: [
                new Template('Выполнение ремонта',
                    'Исполнитель просто должен выполнить задачу'),
                new Template('Инвентаризация',
                    'Ведение контроля имущественных ценностей'),
                new Template('Деятельность', 'Что нужно сделать исполнителю'),
              ],
            ),
            new Padding(
              padding: new EdgeInsets.all(16.0),
              child: new Text(
                'Создайте и настройте все с нуля',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            new Card(
              child: new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: new TextField(
                  decoration: new InputDecoration(
                      labelText: 'Имя Вашей сущности',
                      hintText: 'например: Заявки',
                      hideDivider: true,
                      isDense: true),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
