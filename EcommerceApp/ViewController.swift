//
//  ViewController.swift
//  EcommerceApp
//
//  Created by Mac on 22/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var InfoTableView: UITableView!
    
    var Arraynm:[Fetchdata] = []
    var Arraynm1:[Rating] = []
    var rate:Float?
    var count:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        InfoTableView.dataSource = self
        InfoTableView.delegate = self
        self.InfoTableView.register(UINib(nibName: "DataTableViewCell", bundle: nil), forCellReuseIdentifier: "DataTableViewCell")
        fetch()

    }

    func fetch(){
         let urlstring = "https://fakestoreapi.com/products"
        guard  let url = URL(string: urlstring) else{
            print("Url is Invalide")
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request){(data,response,error) in
            print("Data received from url is\(String(describing: data))")
            
            if let error = error {
                print("error received from url is\(error)")
            } else{
                    guard let response = response as? HTTPURLResponse,
                          response.statusCode == 200,
                          let data = data else{
                              print("Status code is invalide")
                              return
                    }
                    
                do{
                    let jsonobject = try? JSONSerialization.jsonObject(with: data)
                    as? [[String:Any]]
                    
                    for dictinary in jsonobject!{
                        let eachdictinary = dictinary as [String:Any]
                        let pid = eachdictinary["id"] as! Int
                        let ptitle = eachdictinary["title"] as! String
                        let pdesription = eachdictinary["description"] as! String
                      //  let pprize = eachdictinary["price"] as! Int
                        let pcategory = eachdictinary["category"] as! String
                        let pimage = eachdictinary["image"] as!String
                     //  let rating = eachdictinary["rating"] as! [String:Any]
                       // let rate = rating["rate"] as? Double
                        //let count = rating["count"] as? Int
                        
                        let newdata = Fetchdata(id: pid, title: ptitle,  description: pdesription, category: pcategory, image: pimage)
                        self.Arraynm.append(newdata)
                        
                       /* print("id is:\(pid)\n title is:\(ptitle)\n description is: \(pdesription)\n category is:\(pcategory)\n image is:\(pimage)")*/
                        DispatchQueue.main.async {
                            self.InfoTableView.reloadData()
                        }
                    }
                }catch let myerror{
                    print("error data convert to json\(myerror.localizedDescription)")
                    }
            }
        }
            dataTask.resume()
                
        }
    }
    

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arraynm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard   let vc = self.InfoTableView.dequeueReusableCell(withIdentifier: "DataTableViewCell")as? DataTableViewCell
        else{
            return UITableViewCell()
        }
        vc.idLabel.text = String(Arraynm[indexPath.row].id as Int)
        vc.titleLabel.text = Arraynm[indexPath.row].title as String
        vc.descriptionLabel.text = Arraynm[indexPath.row].description as String
       // vc.prizeLabel.text = String(Float(Arraynm[indexPath.row].price as Int))
        vc.category.text = Arraynm[indexPath.row].category as String
       //vc.rateLabel.text = String(Arraynm1[indexPath.row].rate as Float)
    //   vc.count.text = String(Arraynm1[indexPath.row].count as Int)
        guard let imageURl = URL(string: Arraynm[indexPath.row].image) else {
            return vc
        }
      vc.imageLabel.downloadImage(from: imageURl)
        return vc
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}
extension UIImageView {
    func downloadImage(from url: URL){
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            let image = UIImage(data: data!)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
