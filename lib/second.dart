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
import './cuisine.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SecondPage extends StatefulWidget{

@override

  _SecondPage createState() => _SecondPage();

}

class _SecondPage extends State<SecondPage>{

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
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email',googleSignIn.currentUser.email);
            prefs.setString('photo',googleSignIn.currentUser.photoUrl);
  return 'signInWithGoogle succeeded: $user';
}
void signOutGoogle() async{
  await googleSignIn.signOut();
  globals.userName = "";
  print("User Sign Out");
 
Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
}


  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getData());
  }
TextEditingController searchcont = new TextEditingController();
List all = [];
String search = 'chicken';
Future<String> getData() async {

  http.Response response = await http.get(
    Uri.encodeFull('https://api.edamam.com/search?q=$search&app_id=c1a1d72c&app_key=9f7486ccef2d63744b13f70f5987ee09&from=0&to=50'),
    headers:{
      "Accept": "application/json"
    }
    );
List data = jsonDecode(response.body)["hits"];

setState(() {
  all = data;
});
print(all.length);
}

@override
Widget build(BuildContext context){

return Scaffold(
  body:Column(
    mainAxisAlignment: MainAxisAlignment.end,
     children:[ 

Container(
  height:180.0,
  decoration: BoxDecoration(
color: Colors.white,
  ),


child:

Column(children:
[
  SizedBox(height:2.0),
  Text("Top Categories",style: TextStyle(fontSize:25.0, fontWeight:FontWeight.bold,fontFamily: "Montserrat"),),
  SizedBox(height:10.0),
  Container(
    height: 132.0,
  child:ListView(
  scrollDirection:Axis.horizontal,
  children: <Widget>[
    SizedBox(width:20.0),
   OutlineButton(onPressed: (){

Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyName(name: "chicken",)));

   }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0),child: Column( children:[
      Image.network("https://www.curriuk.co.uk/image/cache/catalog/images/slider_1477468024-500x500.png", height: 100.0, width: 100.0,),
  Text("Chicken",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat"))
  ]),
   ),
   SizedBox(width:15.0),
 OutlineButton(onPressed: (){
   
Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyName(name: "pasta",)));

 }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0), child:Column( children:[
      Image.network("https://wilbraham-hampdenscholarshipfoundation.org/wp-content/uploads/2014/01/Pasta.png"
, height: 100.0, width: 100.0,),
  Text("Pasta",style: TextStyle(color:Colors.black,fontSize:20.0,fontFamily: "Montserrat")),]),
 ),
 SizedBox(width:15.0),
 OutlineButton(onPressed: (){
   
Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyName(name: "paneer",)));

 }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0), child:Column( children:[
      Image.network("https://s3.ap-south-1.amazonaws.com/zopnow-uploads/PALAK_PANEER-20180717-054928.png"
, height: 100.0,width: 100.0,),
  Text("Paneer",style: TextStyle(color:Colors.black, fontSize:20.0,fontFamily: "Montserrat")),]),
 ),
SizedBox(width:15.0),
 OutlineButton(onPressed: (){
   
Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyName(name: "beverages",)));

 }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0), child:Column( children:[
      Image.network("https://www.pngarts.com/files/3/Cocktail-PNG-Photo.png"
, height: 100.0,width: 100.0,),
  Text("Beverages",style: TextStyle(color:Colors.black, fontSize:20.0,fontFamily: "Montserrat")),]),
 ),
SizedBox(width:15.0),
 OutlineButton(onPressed: (){
   
Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyName(name: "pizza",)));

 }, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0), child:Column( children:[
      Image.network("https://i.dlpng.com/static/png/326202_preview.png"
, height: 100.0,width: 100.0,),
  Text("Pizza",style: TextStyle(color:Colors.black, fontSize:20.0,fontFamily: "Montserrat")),]),
 ),
SizedBox(width:15.0),
OutlineButton(onPressed: (){
  
Navigator.push(context,MaterialPageRoute(builder: (context) => LoadbyName(name: "cake",)));

}, color: Colors.white, padding: EdgeInsets.only(bottom: 4.0), child:Column( children:[
      Image.network("https://3brothersbakery.com/wp-content/uploads/2018/05/Cake8DeathByChocolate1.png"
, height: 100.0,width: 100.0,),
  Text("Cakes",style: TextStyle(color:Colors.black, fontSize:20.0,fontFamily: "Montserrat")),]),
 ),
SizedBox(width:20.0),
],)
)
])
),
Container( color: Colors.white,
child:Column(children:[
  SizedBox(height:10.0),
  Row(mainAxisAlignment: MainAxisAlignment.center,
  children:[
    SizedBox(width:20.0),
    Container(width: 180.0, child:TextField(
              controller: searchcont,
              
              style: TextStyle(color: Colors.black,    fontSize:20.0,),
                decoration: new InputDecoration(
                  hintText:"Eg: Chicken Biryani",
                    enabledBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(color: Colors.black)
                        )
                ),
            ),),
SizedBox(width:0.0),
IconButton(icon: Icon(Icons.search), iconSize: 45.0, color: Colors.black, onPressed: ()=>{

setState(()=>{
            search = searchcont.text.toString().trim().replaceAll(" ","-"),
          }),
          getData()

})

            ])

]),
),

Expanded(child: Container(
  width: MediaQuery.of(context).size.width,
decoration:BoxDecoration(color:
Colors.white,
) ,

child:
all.length != null ? Padding(padding:EdgeInsets.only(top:10.0) ,child:
all.length != 0? ListView.builder(
itemCount: all.length,
itemBuilder: (context,index){
final item = all[index];
List i = item["recipe"]["healthLabels"];  
 return Padding(
  padding: EdgeInsets.all(20.0),
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
(i.contains("Vegetarian") && i.contains("Egg-Free")) ? Text("Vegetarian", style: TextStyle(fontFamily:"Montserrat", color:Colors.green, fontSize: 12.0, fontWeight: FontWeight.bold),)
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
);
}
)

: 
Padding(
  padding: EdgeInsets.only(top:40.0, bottom: 20.0, left: 20.0,right: 20.0),
  child: Column(children:[
  Text("Loading....", textAlign: TextAlign.center, style: TextStyle(fontFamily:"Montserrat", fontSize:20),),
  Text("Make sure the dish name is always a valid one!", textAlign: TextAlign.center, style: TextStyle(fontFamily:"Montserrat", fontSize:20),),
  ])))
//main check for null
: Padding(padding: EdgeInsets.only(left:30.0,right:30.0),
child: 
Container(
  width: 500.0,
  padding: EdgeInsets.only(top:100.0),
  child:Column(children:[Text("Finding Recipes for You!!", textAlign: TextAlign.center,style: TextStyle(
  fontSize:25.0, color:Colors.black,
),)
])),
),
)),
  ]),
);



}

}



class LoadbyName extends StatefulWidget {
  LoadbyName({Key key, this.name}) : super(key: key);
  final String name;

  @override
  LoadbyNameState createState() => LoadbyNameState();
}

class LoadbyNameState extends State<LoadbyName> {
String Nam = '';
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getData(widget.name));
  }
List all = [];

Future<String> getData(String name) async {

setState(()=>{
          Nam = name.toUpperCase(),
        });
  http.Response response = await http.get(
    Uri.encodeFull('https://api.edamam.com/search?q=$name&app_id=c1a1d72c&app_key=9f7486ccef2d63744b13f70f5987ee09&from=0&to=50'),
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
          Text("Showing Results for $Nam", style: TextStyle(fontFamily:"Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

Expanded(child:Padding(padding:EdgeInsets.only(top:10.0) ,child:

all != null ? ListView.builder(
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
(i.contains("Vegetarian") && i.contains("Egg-Free")) ? Text("Vegetarian", style: TextStyle(fontFamily:"Montserrat", color:Colors.green, fontSize: 12.0, fontWeight: FontWeight.bold),)
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



class GetRecipe extends StatefulWidget{
  
  GetRecipe({Key key, this.oneitem}) : super(key: key);
  final Map<String,dynamic> oneitem;

  @override
  _GetRecipe createState() => _GetRecipe(oneitem);
}

class _GetRecipe extends State<GetRecipe> {


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
  globals.purl= "";
  print("User Sign Out");
 
Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
}


Map<String,dynamic> item ={};
_GetRecipe(Map<String,dynamic> item){
  this.item = item;
}

_launchURL(String url) async {
  
  String ur = url;

  print(ur);
  if (await canLaunch(ur)) {
    await launch(ur,forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

addtoFavourites(String imgurl ,String label,String source,String ingredients, String calories,double servings, String cautions, String protein, String fat, String sugar, String calcium, String url){

if(globals.userName == ''){print("no user created");
showDialog(context: context, builder: (BuildContext context){
return AlertDialog(
 title: Text("Not logged in"),
 content: Text("Please login to access Favourites feature"),
 actions: <Widget>[
   FlatButton(onPressed: ()=>{
     Navigator.of(context).pop(),
   } ,child:Text("close"))
 ],
);
});}
else{  
DocumentReference documentReference = Firestore.instance.collection(globals.userName).document(label);
Map<String,String> todos = {
  "label": label,
  "imgurl": imgurl,
  "ingredients": ingredients,
  "calories":calories,
  "servings":servings.toString(),
  "cautions": cautions,
  "protein": protein,
  "fat": fat,
  "sugar":sugar,
  "calcium":calcium,
  "source":source,
  "url":url
};
documentReference.setData(todos).whenComplete(() =>print("$label created"));
showDialog(context: context, builder: (BuildContext context){
return AlertDialog(
 title: Text("Successful",style: TextStyle(color:Colors.green),),
 content: Text("$label !! sucessfully added to your favourites list"),
 actions: <Widget>[
   FlatButton(onPressed: ()=>{
     Navigator.of(context).pop(),
   } ,child:Text("close"))
 ],
);
});
}

}


  @override
  Widget build(BuildContext context) {
print(item["uri"]);
GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title:Text("First Bite"),
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed:(){
          if(_scaffoldKey2.currentState.isDrawerOpen == false){
            _scaffoldKey2.currentState.openDrawer();
          }else{
            _scaffoldKey2.currentState.openEndDrawer();
          }
        }),
      ),
      body: Scaffold(
        body: Container(child:ListView(
          children: <Widget>[
            Padding(padding:EdgeInsets.only(left: 20.0, right:20.0, top:20.0, bottom:10.0),
            child: Image.network(item["image"], height:200.0),),
            Text(item["label"], textAlign: TextAlign.center, style: TextStyle(fontFamily: "Montserrat", fontSize:22.0,fontWeight:FontWeight.bold),),
            Padding(padding: EdgeInsets.only(top:10.0,bottom: 20.0,left: 20.0,right: 20.0),
            child:
            
            Column(children: <Widget>[
              Row( 
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Source:",style: TextStyle(fontFamily: "Montserrat", fontSize:18.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              Text(item["source"],style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              ]),
              
              SizedBox(height:15.0),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Ingredients:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:0.0),
                ]),
                
              Text(item["ingredientLines"].toString().replaceAll("[","").replaceAll("]", ""),style: TextStyle(fontFamily: "Montserrat", fontSize:14.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(height:15.0),
            
              Row( 

                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Calories:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              Text((item["calories"]).toStringAsFixed(2),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:5.0),
              Text("kcal",style: TextStyle(fontFamily: "Montserrat", fontSize:14.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              
              ]),
              SizedBox(height:15.0),
              
Row( 

                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Servings:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              Text((item["yield"]).toStringAsFixed(2),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:5.0),
              
              ]),
              SizedBox(height:15.0),
              

Row(
children:[Text("Nutrients:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:0.0),
]),

Row(
  
mainAxisAlignment: MainAxisAlignment.start,

  children: <Widget>[

Row( children: <Widget>[
Text("Protein:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text((item["totalNutrients"]["PROCNT"]["quantity"]).toStringAsFixed(2),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text((item["totalNutrients"]["PROCNT"]["unit"]),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),

SizedBox(width: 30.0,),

Row( children: <Widget>[
Text("Fat:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text((item["totalNutrients"]["FAT"]["quantity"]).toStringAsFixed(2),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text((item["totalNutrients"]["FAT"]["unit"]),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),
]),


Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[


Row( children: <Widget>[
Text("Sugar:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text((item["totalNutrients"]["SUGAR"]["quantity"]).toStringAsFixed(2),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text((item["totalNutrients"]["SUGAR"]["unit"]),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),


SizedBox(width: 30.0,),



Row( children: <Widget>[
Text("Calcium:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text((item["totalNutrients"]["CA"]["quantity"]).toStringAsFixed(2),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text((item["totalNutrients"]["CA"]["unit"]),style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),



],),


              SizedBox(height:15.0),

              Row( 
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Cautions:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              item["cautions"].isNotEmpty ?Text(item["cautions"].toString().replaceAll("[","").replaceAll("]", ""),style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold, color: Colors.grey),)
              :Container(width:200.0, child:Text("NA",style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              ),SizedBox(width:5.0),
              ]),
              

              SizedBox(height: 15.0,),
              RaisedButton(onPressed: ()=>{

Navigator.push(context, MaterialPageRoute(builder:(context) => MyWeb(url:item["url"]))),

          //     Builder(builder: (BuildContext context) {
          //      return WebView(
          // initialUrl: item["url"],
          // javascriptMode: JavascriptMode.unrestricted,
          //       ); 
          //         })    //_launchURL(),
            },
color: Colors.green,
child:Text("Get Instructions", style: TextStyle(
  fontFamily: "Montserrat",
  fontSize:15.0,
),)),
                
                
              SizedBox(height: 15.0,),
              IconButton(icon: Icon(Icons.favorite), color: Colors.red, iconSize: 45.0, onPressed: ()=>{
                addtoFavourites(item["image"],item["label"],item["source"],item["ingredientLines"].toString().replaceAll("[","").replaceAll("]", ""),(item["calories"]).toStringAsFixed(2),item["yield"],item["cautions"].toString().replaceAll("[","").replaceAll("]", ""),(item["totalNutrients"]["PROCNT"]["quantity"]).toStringAsFixed(2),(item["totalNutrients"]["FAT"]["quantity"]).toStringAsFixed(2),
                (item["totalNutrients"]["SUGAR"]["quantity"]).toStringAsFixed(2),(item["totalNutrients"]["CA"]["quantity"]).toStringAsFixed(2),item["url"]),
              }),
              Text("Liked the recipe? Add it to favourites!!", style: TextStyle(fontFamily:"Montserrat", fontSize:10.0),),
                
            ],))
          ],
        )),
      key: _scaffoldKey2,
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
              title: Row(children:[Text('Home', style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),),
              ]),onTap: () {

                
                            Navigator.push(context, MaterialPageRoute(builder:(context) => MyApp()));
                // Update the state of the app
                // ...
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
      ),),
    );}
  }




class MyWeb extends StatefulWidget {
  MyWeb({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _MyWeb createState() => _MyWeb();
}

class _MyWeb extends State<MyWeb> {
 @override
  Widget build(BuildContext context) {
   
   final Completer<WebViewController> _controller =
      Completer<WebViewController>();

   return Scaffold(
      

      appBar: AppBar(
        title: Text("First Bite"),),
      
      body: WebView(
          initialUrl: widget.url,
         javascriptMode: JavascriptMode.unrestricted,
         onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
              ), 
   );
  }

}




class GetRecipetwo extends StatefulWidget{
  
  GetRecipetwo({Key key, this.oneitem}) : super(key: key);
  final Map<String,dynamic> oneitem;

  @override
  _GetRecipetwo createState() => _GetRecipetwo(oneitem);
}

class _GetRecipetwo extends State<GetRecipetwo> {


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
  globals.purl= "";
  print("User Sign Out");
 
Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
}


Map<String,dynamic> item ={};
_GetRecipetwo(Map<String,dynamic> item){
  this.item = item;
}

_launchURL(String url) async {
  
  String ur = url;

  print(ur);
  if (await canLaunch(ur)) {
    await launch(ur);
  } else {
    throw 'Could not launch $url';
  }
}


  @override
  Widget build(BuildContext context) {
print(item["label"]);
GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title:Text("First Bite"),
        leading: IconButton(icon: Icon(Icons.dehaze), onPressed:(){
          if(_scaffoldKey2.currentState.isDrawerOpen == false){
            _scaffoldKey2.currentState.openDrawer();
          }else{
            _scaffoldKey2.currentState.openEndDrawer();
          }
        }),
      ),
      body: Scaffold(
        body: Container(child:ListView(
          children: <Widget>[
            Padding(padding:EdgeInsets.only(left: 20.0, right:20.0, top:20.0, bottom:10.0),
            child: Image.network(item["imgurl"], height:200.0),),
            Text(item["label"], textAlign: TextAlign.center, style: TextStyle(fontFamily: "Montserrat", fontSize:22.0,fontWeight:FontWeight.bold),),
            Padding(padding: EdgeInsets.only(top:10.0,bottom: 20.0,left: 20.0,right: 20.0),
            child:
            
            Column(children: <Widget>[
              Row( 
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Source:",style: TextStyle(fontFamily: "Montserrat", fontSize:18.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              Text(item["source"],style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              ]),
              
              SizedBox(height:15.0),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Ingredients:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:0.0),
                ]),
                
              Text(item["ingredients"],style: TextStyle(fontFamily: "Montserrat", fontSize:14.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(height:15.0),
            
              Row( 

                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Calories:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              Text(item["calories"],style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:5.0),
              Text("kcal",style: TextStyle(fontFamily: "Montserrat", fontSize:14.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              
              ]),
              SizedBox(height:15.0),
              
Row( 

                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Servings:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              Text(item["servings"],style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:5.0),
              
              ]),
              SizedBox(height:15.0),
              

Row(
children:[Text("Nutrients:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:0.0),
]),

Row(
  
mainAxisAlignment: MainAxisAlignment.start,

  children: <Widget>[

Row( children: <Widget>[
Text("Protein:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text(item["protein"],style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text("g",style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),

SizedBox(width: 30.0,),

Row( children: <Widget>[
Text("Fat:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text(item["fat"],style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text("g",style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),
]),


Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[


Row( children: <Widget>[
Text("Sugar:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text(item["sugar"],style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text("g",style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),


SizedBox(width: 30.0,),



Row( children: <Widget>[
Text("Calcium:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
Text(item["calcium"],style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              Text("mg",style: TextStyle(fontFamily: "Montserrat", fontSize:15.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:3.0),
              ]),



],),


              SizedBox(height:15.0),

              Row( 
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                Text("Cautions:",style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold),),
              SizedBox(width:5.0),
              Text(item["cautions"],style: TextStyle(fontFamily: "Montserrat", fontSize:16.0,fontWeight:FontWeight.bold, color: Colors.grey),),
              SizedBox(width:5.0),
              ]),
              

              SizedBox(height: 15.0,),
              RaisedButton(onPressed: ()=>{   
                 Navigator.push(context, MaterialPageRoute(builder:(context) => MyWeb(url:item["url"]))),

            },
color: Colors.green,
child:Text("Get Instructions", style: TextStyle(
  fontFamily: "Montserrat",
  fontSize:15.0,
),)),
              SizedBox(height: 15.0,),  
            ],))
          ],
        )),
      key: _scaffoldKey2,
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
              title: Row(children:[Text('Home', style: TextStyle(fontFamily: "Montserrat", fontSize: 20.0, fontWeight: FontWeight.bold),),
              ]),onTap: () {

                
                            Navigator.push(context, MaterialPageRoute(builder:(context) => MyApp()));
                // Update the state of the app
                // ...
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
      ),),
    );}




}














  class AboutUs extends StatefulWidget{
    
  @override
  _AboutUs createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {

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

launchURL() async {
  
  if (await canLaunch("https://aniwebsite.netlify.com")) {
    await launch('https://aniwebsite.netlify.com');
  } else {
    throw 'Could not launch https://aniwebsite.netlify.com';
  }
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
        body: Padding(
padding: EdgeInsets.all(20.0),
child: Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children:[
      Text("First Bite is a Recipe search app,", style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.justify,),
      Text("Where you can find recipes for almost all of your favourite food dishes within few clicks!", style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.justify,),
      Text("Not just ingredients and instructions but you will also be getting the nutrients each dish has as well as any cautions you need to look after.", style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.justify,),
      SizedBox(height:10.0),
      Text("The app is build using Flutter as tech stack and uses Edamam's Recipe Search api.", style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.justify,),
      SizedBox(height:10.0),
      Text("First Bite is developed by Aniket Surve, A Tech enthusiast and an IT Engineer by profession.", style: TextStyle(color: Colors.black,fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.justify,),
      SizedBox(height:5.0),
      Text("You can reach out to me at my website!!", style: TextStyle(color: Colors.
      black,fontFamily: 'Montserrat', fontSize: 15.0),textAlign: TextAlign.justify,),
      Row( mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        OutlineButton(onPressed:()=>{
          launchURL(),
        }, child:Text("Visit My Website",style: TextStyle(color:Colors.green, fontFamily: "Montserrat",fontSize: 18.0,),))
      ],),
      SizedBox(height: 80.0),
    ],
  )
)
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
                 Navigator.push(context, MaterialPageRoute(builder:(context) => MyApp()));
                // Then close the drawer

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



class MyLiked extends StatefulWidget {
  
  @override
  _MyLikedState createState() => _MyLikedState();
}

class _MyLikedState extends State<MyLiked>{

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();


deleteMovie(String name){
  DocumentReference documentReference = Firestore.instance.collection(globals.userName).document(name);
documentReference.delete().whenComplete(() =>print("deleted"));

showDialog(context: context, builder: (BuildContext context){
return AlertDialog(
 title: Text("Deleted!!",style: TextStyle(color:Colors.red),),
 content: Text("$name !! sucessfully deleted!!"),
 actions: <Widget>[
   FlatButton(onPressed: ()=>{
     Navigator.of(context).pop(),
   } ,child:Text("close"))
 ],
);
});

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
Widget build(BuildContext context){

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
        body: (globals.userName != '')?

StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(globals.userName).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        
                if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return Container(
                 child: Padding(padding: EdgeInsets.all(20.0), child:Column(children:[
                   Image.network(document['imgurl'], height: 200.0,),
                    SizedBox(height:5.0),
                  Text(document['label'],style: TextStyle(color:Colors.black, fontFamily: 'Montserrat', fontSize: 22.0),textAlign: TextAlign.center,),
                  SizedBox(height:5.0),
                  Row( mainAxisAlignment: MainAxisAlignment.center, children:[
          RaisedButton(onPressed: ()=>{
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetRecipetwo(oneitem:document.data)),
            ),
                        },
            color: Colors.amber,
            child:Text("Details", style: TextStyle(
  fontSize:15.0,
),)),
SizedBox(width:10.0),
RaisedButton(onPressed: ()=>{
            
            deleteMovie(document['label']),
            
                        },
            color: Colors.red,
            child:Text("Remove", style: TextStyle(
  fontSize:15.0,
),)),



]),
                 ])) 
                );              }).toList(),
            );
        }
      },
    )

:    Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children:[Padding( padding: EdgeInsets.only(top:0.0,left:50.0,right:50.0), child:Text("Please Login to retrieve your Favourite Recipes", style: TextStyle(color:Colors.black, fontSize: 30.0),textAlign: TextAlign.center,),
),]),
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
                 Navigator.push(context, MaterialPageRoute(builder:(context) => MyApp()));
                // Then close the drawer

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
                Navigator.pop(context);
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


}}
