//
//  APIRequest.swift
//  AdaProject
//
//  Created by user191120 on 8/16/21.
//

import Foundation

let response = Response()





struct ApiRequest {
    
    
    func requestWithBody(body: Dictionary<String, Any>, requestURL: String, httpMethodType: String, getData: @escaping (Response) -> ()){
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        let url = URL(string: "\(requestURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            do {
                
                let result = try JSONDecoder().decode(Response.self, from: data!)
                getData(result)
                
                return
                
            } catch {
                
            }
        }.resume()
    }
    
    func requestWithToken(requestURL: String, httpMethodType: String, getData: @escaping (Response) -> ()){
        var tokenValue = ""
        if let tokens = UserDefaults.standard.object(forKey: "Token") as? String {
            tokenValue = tokens
        }
        let url = URL(string: "\(requestURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(tokenValue)", forHTTPHeaderField: "Authorization")
        
        
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            do {
                
                let result = try JSONDecoder().decode(Response.self, from: data!)
                getData(result)
                
                
                return
                
            } catch {
                
            }
        }.resume()
    }
    
    func requestWithBodyAndToken(body: Dictionary<String, Any>, requestURL: String, httpMethodType: String){
        var tokenValue = ""
        if let tokens = UserDefaults.standard.object(forKey: "Token") as? String {
            tokenValue = tokens
        }
        let jsonData = try! JSONSerialization.data(withJSONObject: body, options: [])
        print(jsonData)
        let url = URL(string: "\(requestURL)")!
        var request = URLRequest(url: url)
        request.httpMethod = "\(httpMethodType)"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(tokenValue)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            do {
                
                let result = try JSONDecoder().decode(Response.self, from: data!)
                print(result)
                return
                
            } catch {
                
            }
        }.resume()
    }
    
    func requestWithPhoneNumber(inputParameter: String, getData: @escaping (Response) -> ()){
        
        let replacePlus = inputParameter.replacingOccurrences(of: "+", with: "00")
        let body = [
            "phoneNumber" : replacePlus
        ]
        requestWithBody(body: body, requestURL: "http://ec2-52-17-33-184.eu-west-1.compute.amazonaws.com:8080/auth", httpMethodType: "POST"){data in getData(data)}
    }
    
    func requestWithValidationCode(inputParameter: String, getData: @escaping (Response) -> ()) {
        var locationValue = ""
        if let locations = UserDefaults.standard.object(forKey: "UserID") as? String {
            locationValue = locations
        }
        let body = [
            "validationCode" : inputParameter
        ]
        requestWithBody(body: body, requestURL: locationValue, httpMethodType: "POST"){data in
          UserDefaults.standard.set(data.token!, forKey: "Token")
            getData(data)
        }
    }
    
    func userCheck(comp: @escaping(Response) -> ()) {
        requestWithToken(requestURL: "http://ec2-52-17-33-184.eu-west-1.compute.amazonaws.com:8080/user/check", httpMethodType: "GET"){(data) in comp(data)}
    }
    
    func registrationData(privacyContract: Bool, reportContract: Bool, name: String, estimatedBirthDate: String, realBirthdate: String, grams: String, sexuality: String, doctorName: String, email: String) {
        let body : [String : Any] = [
            "privacyContract": privacyContract,
            "reportContract": reportContract,
            "child": [
                "name": name,
                "estimatedBirthDate": estimatedBirthDate,
                "realBirthDate": realBirthdate,
                "grams": grams,
                "sexuality": sexuality,
                "doctorName": doctorName
            ],
            "email": email
        ]
        requestWithBodyAndToken(body: body, requestURL: "http://ec2-52-17-33-184.eu-west-1.compute.amazonaws.com:8080/user", httpMethodType: "POST")
    }
    
    func getVideoList(getData: @escaping ([Videos]) -> ()) {
        requestWithToken(requestURL: "http://ec2-52-17-33-184.eu-west-1.compute.amazonaws.com:8080/video/list", httpMethodType: "GET"){(data) in getData(data.videos!)}
        
    }
    
    func getProfilData(getInfo: @escaping (Response) -> ()){
        requestWithToken(requestURL: "http://ec2-52-17-33-184.eu-west-1.compute.amazonaws.com:8080/user", httpMethodType: "GET"){(data) in getInfo(data)}
    }
    
}
