import 'package:final_630710056/model/api.dart';
import 'package:final_630710056/model/ball_item.dart';
import 'package:flutter/material.dart';


class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  List<BallItem>? _ballList;
  var _isLoading = false;
  String? _errMessage;

  @override
  void initState() {
    super.initState();
    _fetchFoodData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /*Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _fetchFoodData,
              child: const Text('GET FOOD DATA'),
            ),
          ),*/
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  // spreadRadius: 5,//รอบ 4 ด้าน
                  blurRadius: 3,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.jpg",width: 200,height: 200,),
                ],
              ),
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                if (_ballList != null)
                  ListView.builder(
                    itemBuilder: _buildListItem,
                    itemCount: _ballList!.length,
                  ),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (_errMessage != null && !_isLoading)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(_errMessage!),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _fetchFoodData();
                          },
                          child: const Text('RETRY'),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _fetchFoodData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch(""); //ใส่"" get vote คำหลัง/__
      setState(() {
        _ballList = data
            .map<BallItem>((item) => BallItem.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var ballItem = _ballList![index];

    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              ballItem.flagImage,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Column(
                children: [
              Text(ballItem.team,style: TextStyle(fontSize: 16.0),),
              Text("GROUP "+ballItem.group),
        ],
            ),

          ],
        ),
      ),
    );
  }
}//