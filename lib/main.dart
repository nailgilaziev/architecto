import 'package:flutter/material.dart';
import 'dart:async';

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
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class Template {
  final String title;
  final String summary;
  final String entity;

  const Template(this.title, this.summary, this.entity);
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
        subtitle: new Text(template.entity + '. ' + template.summary),
      ),
    );
  }
}

enum UiState { progress, downloaded, error }

class _MyHomePageState extends State<MyHomePage> {
  UiState uiState = UiState.progress;
  Exception lastError;

  Widget progresView() {
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text('Ожидайте...'),
        ),
        body: new Center(
          child: new CircularProgressIndicator(),
        ));
  }

  Widget mainView() {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text('Начало'),
      ),
      body: new SingleChildScrollView(
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
                    'Исполнитель просто должен выполнить задачу', 'Заявки'),
                new Template('Инвентаризация',
                    'Ведение контроля имущественных ценностей', 'Объекты'),
                new Template('Деятельность', 'Что нужно сделать исполнителю',
                    'Сущности'),
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
        onPressed: null,
        tooltip: 'Increment',
        child: new Icon(Icons.forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget errorView() {
    return new Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text('Произошла ошибка'),
        ),
        body: new Center(
          child: new Text(lastError.toString()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    switch (uiState) {
      case UiState.downloaded:
        return mainView();
      case UiState.error:
        return errorView();
      default:
        if (new DateTime.now().second % 2 == 0)
          new Timer(const Duration(seconds: 2), afterTemplatesDownloaded);
        else
          new Timer(const Duration(seconds: 2),tmpShowError);
        return progresView();
    }
  }

  void afterTemplatesDownloaded() {
    setState(() {
      uiState = UiState.downloaded;
    });
  }

  void tmpShowError(){
    showError(new TimeoutException('Now Current second is NOT % 2 == 0'));
  }


  void showError(Exception ex) {
    setState(() {
      lastError = ex;
      uiState = UiState.error;
    });
    new Timer(const Duration(seconds: 8), afterTemplatesDownloaded);
  }
}
