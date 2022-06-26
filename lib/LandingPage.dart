import "package:flutter/material.dart";
import 'package:rest_api/RemoteService.dart';

import 'Model/RestApiModel.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Welcome>? Welcomes;
  var isLoaded = false;
  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    Welcomes = await RemoteService().getPosts();
    if (Welcomes != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rest Api",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: Welcomes?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Welcomes![index].title ,
                          maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),

                          ),
                          Image(image: NetworkImage(Welcomes![index].thumbnailUrl),)],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
