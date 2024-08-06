import 'package:flutter/material.dart';
import 'package:flutter_240719/notification.dart';
import 'shop.dart';
import 'style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'notification.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( ChangeNotifierProvider(
    create: (c) => Store1(),
    child: MaterialApp(
        theme: style.theme,
        home: const MyApp()
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var post = [];
  var userImage;
  var userContent;


  @override
  void initState() {
    super.initState();
    initNotification(context);
    getData();
  }

  getData() async {
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState( (){
      post = result2;
    });
  }

  addData() async{
    var newPost = await http.get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    setState((){
      post.add(jsonDecode(newPost.body));
    });
  }

  setUserContent(a){
    setState(() {
      userContent = a;
    });
  }

  addFromPhone(){
    var myData = {'id':4, 'image':userImage , 'likes':423, 'date': 'July 25',
      'content': userContent, 'liked': false, 'user':'yes_empty'};
    setState((){
      post.insert(0, myData);
    });
  }


  @override
  Widget build(BuildContext context) {

    print(MediaQuery.of(context).size.width);

    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Text('+'), onPressed: (){
        showNotification2();
      }),
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [IconButton(
          icon: Icon(Icons.add_box_outlined),
          onPressed: () async{
            var picker = ImagePicker();
            var image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                userImage = File(image.path);
              });
            }
            Navigator.push(context,
              MaterialPageRoute(builder: (c) =>  Upload(userImage: userImage, addFromPhone: addFromPhone, setUserContent: setUserContent,) )
            );
          },
        )],),
      body: [Home(post: post, addData: addData), Shop()][tab],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i){
          setState((){
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Shop')],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, this.post, this.addData});
  final post;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent){
        widget.addData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if(widget.post.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.post.length, controller: scroll,
          itemBuilder: (c, i) {
            return Container(
                child: Column(
                  children: [
                widget.post[i]['image'].runtimeType == String
                ? Image.network(widget.post[i]['image'])
                    : Image.file(widget.post[i]['image']),
                    Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('좋아요 ' + widget.post[i]['likes'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            GestureDetector(
                              child: Text(widget.post[i]['user']),
                              onTap: (){
                                Navigator.push(context,
                                CupertinoPageRoute(builder: (c) => Profile()));
                              },
                            ),
                            Text(widget.post[i]['content']),
                          ],
                        )
                    )
                  ],
                )
            );
          }
      );
    } else { return CircularProgressIndicator(); }
  }
}

class Upload extends StatelessWidget {
  const Upload({super.key, this.userImage, this.addFromPhone, this.setUserContent});
  final userImage;
  final addFromPhone;
  final setUserContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( actions: [IconButton(onPressed: (){addFromPhone();}, icon: Icon(Icons.send),)],),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          TextField(onChanged: (text){ setUserContent(text); }),
            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close)),
          ],
      )
    );
  }
}

class Store1 extends ChangeNotifier {
  var name = 'john kim';
  var follower = 0;
  var followed = false;
  var profileImage = [];

  getData() async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    notifyListeners();
  }

  changeFollow(){
    if (followed==false){
      follower += 1;
      followed = true;
    } else {
      follower -= 1;
      followed = false;
    }
    notifyListeners();
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {

  @override
  void initState(){
    super.initState();
    context.read<Store1>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store1>().name)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
              (c, i) => Image.network(context.watch<Store1>().profileImage[i]),
                childCount: context.watch<Store1>().profileImage.length,
          ), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
            ),
            Text('팔로워 ${context.watch<Store1>().follower}명'),
            ElevatedButton(onPressed: (){
              context.read<Store1>().changeFollow();
            }, child: Text('팔로우'))
          ]
      ),
    );
  }
}





