import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';
import './second.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CuisinePage extends StatefulWidget{

@override

  _CuisinePage createState() => _CuisinePage();

}

class _CuisinePage extends State<CuisinePage>{


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
        title: Text("First Bite"),
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed:(){
          if(_scaffoldKey.currentState.isDrawerOpen == false){
            _scaffoldKey.currentState.openDrawer();
          }else{
            _scaffoldKey.currentState.openEndDrawer();
          }
        }),
      ),
      body:Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height:15.0),
                        Text("Search by Cuisines", style: TextStyle(fontFamily:"Montserrat",fontSize: 20.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
SizedBox(height:15.0),
Expanded(
            child:ListView(children:[
            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: <Widget>[
              
                 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Indian",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://www.pngkey.com/png/full/254-2544777_real-traditional-indian-food-greatest-indian-food-everyone.png", height: 100.0, width: 100.0,),
  Text("Indian",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),

 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Mexican",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://cdn10.name.com/blog/wp-content/uploads/2015/03/Taco.png", height: 100.0, width: 100.0,),
  Text("Mexican",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),


 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Japanese",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://jamison.wildgingerpa.com/_nuxt/img/98040f0.png", height: 100.0, width: 100.0,),
  Text("Japanese",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),


            ],),

            SizedBox(height: 20.0,),

Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: <Widget>[
              
              
               OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "British",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://img.pngio.com/dishfoodcuisinefish-and-chipsfried-foodfrench-friesjunk-food-british-cuisine-png-900_600.png", height: 100.0, width: 100.0,),
  Text("British",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),
 



                 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "French",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://www.freepngimg.com/thumb/croissant/28784-3-croissant-photos-thumb.png", height: 100.0, width: 100.0,),
  Text("French",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),


              
              
                 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Chinese",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://i.dlpng.com/static/png/1476371-chinese-food-png-chinese-food-png-pictures-606_536_preview.png", height: 100.0, width: 100.0,),
  Text("Chinese",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),


            ],),

            SizedBox(height: 20.0,),

            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: <Widget>[
              
OutlineButton(onPressed: (){
Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Italian",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://cdn.shopify.com/s/files/1/0012/9240/2755/products/tasty_italian_pizza_1_982b93ea-d1f8-4626-9c84-1cdd5bbde93c_570x570_crop_top.png?v=1531992589", height: 100.0, width: 100.0,),
  Text("Italian",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),

 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "American",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://webcomicms.net/sites/default/files/clipart/175118/hot-dog-png-transparent-images-175118-9345017.png", height: 100.0, width: 100.0,),
  Text("American",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),


 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Nordic",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://i.pinimg.com/originals/05/cc/c5/05ccc525df440f6506d98766a1f2d7bd.jpg", height: 100.0, width: 100.0,),
  Text("Nordic",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),


            ],),

            
            SizedBox(height: 20.0,),

            Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: <Widget>[
              
                 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Middle Eastern",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://pngimage.net/wp-content/uploads/2018/06/%D9%85%D8%B4%D8%A7%D9%88%D9%8A-png-1.png", height: 100.0, width: 100.0,),
  Text("Middle Eastern",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),

 OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyCName(name: "Mediterranean",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://2.bp.blogspot.com/-E92w4GSljKA/T9IFuNpTpVI/AAAAAAAAAI4/IWYYSXrCXc8/s1600/shawarma.png", height: 100.0, width: 100.0,),
  Text("Mediterranean",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),



            ],),

            ])),
SizedBox(height:20.0),
          ],
        ),
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
              title: Text('Home', style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                            Navigator.push(context, MaterialPageRoute(builder:(context) => MyApp()));
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



class LoadbyCName extends StatefulWidget {
  LoadbyCName({Key key, this.name}) : super(key: key);
  final String name;

  @override
  LoadbyCNameState createState() => LoadbyCNameState();
}

class LoadbyCNameState extends State<LoadbyCName> {
    String dropdownValue = 'All';
String Nam = '';
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getData(widget.name));
  }
List all = [];

Future<String> getData(String cname) async {

setState(()=>{
          Nam = cname.toUpperCase(),
        });
        print(Nam);
        if(dropdownValue == "All"){
            http.Response response = await http.get(
    Uri.encodeFull('https://api.edamam.com/search?q=&app_id=c1a1d72c&app_key=9f7486ccef2d63744b13f70f5987ee09&from=0&to=50&cuisineType="$cname"'),
    headers:{
      "Accept": "application/json"
    }
    );
        
List data = jsonDecode(response.body)["hits"];

setState(() {
  all = data;
});
print(all);
        }
        else{
  http.Response response = await http.get(
    Uri.encodeFull('https://api.edamam.com/search?q=&app_id=c1a1d72c&app_key=9f7486ccef2d63744b13f70f5987ee09&from=0&to=50&cuisineType="$cname"&mealType="$dropdownValue"'),
    headers:{
      "Accept": "application/json"
    }
    );
        
List data = jsonDecode(response.body)["hits"];

setState(() {
  all = data;
});
print(all);
        }
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
  globals.purl = "";
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
        title: Text("First Bite"),
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed:(){
          if(_scaffoldKey.currentState.isDrawerOpen == false){
            _scaffoldKey.currentState.openDrawer();
          }else{
            _scaffoldKey.currentState.openEndDrawer();
          }
        }),
      ),
      body:Scaffold(
        body: Column(children:[
SizedBox(height: 20.0,),
          Text("Showing results for", style: TextStyle(fontFamily:"Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),   
       Text("$Nam  Cuisine", style: TextStyle(fontFamily:"Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Text("Meal Type:", style: TextStyle(fontFamily:"Montserrat", fontSize: 14.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
SizedBox(width: 10.0,),
DropdownButton<String>(
      value: dropdownValue,
      // icon: Icon(Icons.arrow_downward),
      // iconSize: 24,
       elevation: 16,
      style: TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        print(newValue);
        
        setState(() {
          all = [];
          dropdownValue = newValue;
        });
        getData(widget.name);
      },
      items: <String>['All', 'Breakfast', 'Lunch', 'Dinner']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
],),


Expanded(child:Padding(padding:EdgeInsets.only(top:10.0) ,child:

all != null || all.isNotEmpty ? ListView.builder(
itemCount: all.length,
itemBuilder: (context,index){
final item = all[index];
List i = item["recipe"]["healthLabels"];
if(all.length > 0) { return Padding(
  padding: EdgeInsets.only(top:10.0, bottom: 20.0, left: 10.0,right: 10.0),
  child: Container( 
  width: 100.0,
  decoration: BoxDecoration(
    
    borderRadius: BorderRadius.circular(10.0),
  ),
child:
Padding( padding: EdgeInsets.only(top:10.0,left:20.0, right: 20.0),
child:Column(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.center,
children:[
  SizedBox(height:10.0),
  Container(
    height: 250.0,
    decoration: BoxDecoration(
     borderRadius: BorderRadius.all(Radius.circular(55.0) ),
    ),
  child:Image.network(item["recipe"]["image"],height: 250.0,
  fit: BoxFit.contain,
  ),),
  SizedBox(height:10.0),
Text(item["recipe"]["label"],
textAlign: TextAlign.center,
style: TextStyle(
  fontFamily:"Montserrat",
  fontWeight:FontWeight.bold,
  fontSize: 20.0,
),),
SizedBox(height:1.0),
(i.contains("Vegetarian") && i.contains("Egg-Free"))? Text("Vegetarian", style: TextStyle(fontFamily:"Montserrat", color:Colors.green, fontSize: 12.0, fontWeight: FontWeight.bold),)
:Text("Non Vegetarian", style: TextStyle(fontFamily:"Montserrat", color:Colors.red, fontSize: 12.0, fontWeight: FontWeight.bold),),
SizedBox(height:7.0),
RaisedButton(onPressed: ()=>{   

  Navigator.push(context, MaterialPageRoute(builder:(context) => GetRecipe(oneitem: item["recipe"]))),
  print(item["recipe"]),

            },
color: Colors.green,
child:Text("Get Recipe", style: TextStyle(
  fontFamily: "Montserrat",
  fontSize:15.0,
),)),
SizedBox(height:0.0),
])

)
)

);}
else{
  return Padding(
  padding: EdgeInsets.only(top:10.0, bottom: 20.0, left: 10.0,right: 10.0),
  child: Text("No such recipe found, Please try again", style: TextStyle(fontFamily:"Montserrat", fontSize:20),),);
}
}
)
: Padding(padding: EdgeInsets.only(left:30.0,right:30.0),

child: Container(
  width: 500.0,
  padding: EdgeInsets.only(top:100.0),
  child:Column(children:[Text("Finding Recipes for You!!", textAlign: TextAlign.center,style: TextStyle(
  fontSize:25.0, color:Colors.black,
),)
]))
)
))]),

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
              title: Text('Home', style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                            Navigator.push(context, MaterialPageRoute(builder:(context) => MyApp()));
},
            ),
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
              Navigator.push(context, MaterialPageRoute(builder:(context) => MyLiked()));
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
