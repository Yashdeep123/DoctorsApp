//
//  PostViewModel.swift
//  DoctorsApp
//
//  Created by Yash Patil on 17/02/23.
//

import Foundation
import SwiftUI
import Combine

let dsfs = ""
class PostViewModel : ObservableObject {
 
    @Published var userLoginDetails : UserDetails? = nil
    @Published var userGetDetails : UserDetails? = nil
    
    var name : String = ""
    var email : String = ""
    var practiceFromMonth : String = ""
    var practiceFromYear : String = ""
    var selectedGender : Gender = .male
    var gender : String = ""
    
    init()  {
         
     }
    
    func postData()  {
        guard let url = URL(string: "http://199.192.26.248:8000/sap/opu/odata/sap/ZCDS_TEST_REGISTER_CDS/ZCDS_TEST_REGISTER") else { return }
        
        gender = String(selectedGender.rawValue.first!)
        
        let body : [String: String] = [
            "name" : name,
            "email" : email,
            "gender" : gender,
            "practice_frm_month" : practiceFromMonth,
            "practice_frm_year" : practiceFromYear
        ]
        
       
            let finalData =  try? JSONSerialization.data(withJSONObject: body)
            var request = URLRequest(url: url)
        
            request.httpMethod = "POST"
            request.httpBody = finalData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("X", forHTTPHeaderField: "X-Requested-With")
        
            URLSession.shared.dataTask(with: request) { data, _, error in
                print("DATA RECEIVED SUCCESSFULLY !!! : \(String(describing: data))")
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(PostModel.self, from: data!)
                        print("Result :\(result)")
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.userLoginDetails = result.d
                            GetViewModel().getData(getURL: result.d?.metadata.id ?? "")
                            
                            print("Fetched userdetails : \(String(describing: self?.userLoginDetails?.name))")
                        }
                    } catch let error {
                        print("\(error)")
                    }
                
            }
            .resume()
      
    }
    
}


class GetViewModel : ObservableObject  {
  
    @Published var userDetails : UserDetails? = nil
   
    init() {  }

    func getData(getURL : String)  {
       
        guard let url = URL(string: getURL) else { return }
       
        var getRequest = URLRequest(url: url)
        
        getRequest.httpMethod = "GET"
        getRequest.attribution = .developer
        getRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        getRequest.addValue("application/json", forHTTPHeaderField: "Accept")
       
        URLSession.shared.dataTask(with: getRequest) { data, _, error in
            if let data ,error == nil{
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(PostModel.self, from: data)
                    DispatchQueue.main.async {
                        self.userDetails = result.d
                        LoginView(username: self.userDetails?.name ?? "No name")
                        print("Fetched  result data : \(self.userDetails?.name ?? "No name")")
                    }
                }catch let error {
                    print("Error decoding : \(error.localizedDescription)")
                }
                
            }else {
                print("Error fetching the data : \(String(describing: error?.localizedDescription))")
            }
        }
        .resume()
    }
    
}
