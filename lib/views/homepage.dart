import 'package:api_workouts/model/post.dart';
import 'package:api_workouts/service/emote_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Post>? posts;
  var isLoaded = false;
@override
  void initState() {
    
    super.initState();

    // feth data from api
    getData();
  }

  getData()async{
    posts = await RemoteService().getPosts();
    if(posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
      ),

      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                
                children: [
                  Container(height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey
                  ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(posts![index].title, style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text(posts![index].body!, style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
          replacement: const Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
