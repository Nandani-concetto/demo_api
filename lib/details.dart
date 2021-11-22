import 'package:demo_api/employee.dart';
import 'package:demo_api/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Employee user;

  const Details(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
            color: Colors.black,
          ), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyApp()),
        );  },
        ),
          title: Text("User Detais",
            style: TextStyle(
              color: Colors.black
            ),
          ),
      ),
      body: Stack(
        children: [
          Image(image: AssetImage("assets/image/img.png"),),
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getProfilePic(),
                  getNameAndUserName(user.name!),
                  getNameAndUserName(user.username!),
                  Padding(
                    padding: const EdgeInsets.only(top:60),
                    child: Container(
                      height:380,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 5,
                        child: Column(
                          children: [
                            getDetailsOfUser(Icons.email,user.name!),
                            getDetailsOfUser(Icons.phone,user.phone!),
                            getDetailsOfUser(Icons.language,"Website: "+user.website!),
                            getAddressAndCompanyDetail(Icons.location_on_outlined,user.address!.getAddress(),user.address!.geo!.getGeo()),
                            getAddressAndCompanyDetail(Icons.card_travel,"Company's Details",user.company!.getComany()),

                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
  Widget getProfilePic(){
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CircleAvatar(
          radius:50,
          backgroundImage:NetworkImage("https://picsum.photos/200/300",)
      ),
    );
  }
  Widget getNameAndUserName(String text){
    return Text(text,
      style: TextStyle(
        fontSize: 18,
      ),
    );

  }
  Widget getDetailsOfUser(IconData icon,String text){
    return SizedBox(
      height:50,
      child: ListTile(
        leading: Icon(icon,
          color: Colors.blue,
        ) ,
        title: Text(text,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );

  }
  Widget getAddressAndCompanyDetail(IconData icon,String title,String subtitle){
    return SizedBox(
      height:90,
      child: ListTile(
        leading: Icon(icon,
            color: Colors.blue,
          ),
        title:Padding(
          padding: const EdgeInsets.only(top:13
          ),
          child: Text(title),
        ),
        subtitle:Text( subtitle,
          style: TextStyle(
              fontSize:17
          ),
        ),
      ),
    );
  }
}
