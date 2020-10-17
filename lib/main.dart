import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './second.dart';
import 'globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './cuisine.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
body: Padding(
  padding:EdgeInsets.only(top:0.0, left: 50.0,right: 50.0),
  child:Text("Loading Recipes.....", textAlign: TextAlign.center, style: TextStyle(
  color: Colors.black, fontFamily: "Montserrat", fontSize: 25.0,
),),));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'First Bite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => setData(),

        );
  }

void setData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
     if(!prefs.containsKey('email')){

       globals.userName = "";
       globals.purl = "";

     }
else{
setState(() {
     globals.userName = prefs.getString('email');
    //  = googleSignIn.currentUser.email;
    globals.purl = prefs.getString('photo');
  });}
}

  final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  setState(() {
     globals.userName = googleSignIn.currentUser.email;
     globals.purl = googleSignIn.currentUser.photoUrl;
   });
  SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email',googleSignIn.currentUser.email);
            prefs.setString('photo',googleSignIn.currentUser.photoUrl);
  return 'signInWithGoogle succeeded: $user';
}
void signOutGoogle() async{
  await googleSignIn.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            prefs.remove('photo');
  
   globals.userName = "";
   globals.purl = '';
   print("User Sign Out");
 
Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
}

  @override
  Widget build(BuildContext context) {
   
   
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return Scaffold(
      

      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed:(){
          if(_scaffoldKey.currentState.isDrawerOpen == false){
            _scaffoldKey.currentState.openDrawer();
          }else{
            _scaffoldKey.currentState.openEndDrawer();
          }
        }),
      ),
      body:Scaffold(
        body: SecondPage(),
        key: _scaffoldKey,
        drawer:Drawer(
        child:ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 185.0,
              child:DrawerHeader(
              child: globals.userName != '' ? Column(children: <Widget>[
                Image.network(globals.purl, height: 100.0,),
                SizedBox(height: 10.0,),
                Text("Hi, "+globals.userName,style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.bold, fontSize: 15.0,)),
                SizedBox(height: 20.0,)
              ],)
               :Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children:[

                   SizedBox(height: 30,),
                   Text("Login to access Favourites feature!!", style: TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.bold),),
                 RaisedButton(onPressed: (){
                   signInWithGoogle();
                   print(globals.userName);
                 }, child: Text("Login with Google", style: TextStyle(fontFamily: "Montserrat"),),)
              ]),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            )),
            ListTile(
              title: Text('Cuisines', style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CuisinePage()),
            );

              },
            ),
            ListTile(
              title: Text('My Favourites', style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyLiked()),
            );

              },
            ),
            ListTile(
              title: Text('About Us', style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                
                 Navigator.push(context, MaterialPageRoute(builder:(context) => AboutUs()));
              },
            ),
globals.userName !="" ?ListTile(
              title: RaisedButton(onPressed: () => {
                signOutGoogle(),  
              },child: Text("Logout",style: TextStyle(fontFamily: "Montserrat"), ),),
            )
            :ListTile(),


          ],
        ),
      ),
      )    
    );
  }
}
