//
//  ContentView.swift
//  testapp1
//
//  Created by Raheem Chisman on 3/2/25.
//

import SwiftUI
import IntuneMAMSwift


struct ContentView: View {
    class EnrollmentDelegateClass: NSObject, IntuneMAMEnrollmentDelegate {
        func enrollmentRequestDidComplete(_ identity: String, error: Error?) {
            if let error = error {
                print(Date(), "Enrollment failed: \(error.localizedDescription)")
            } else {
                print(Date(), "Enrollment successful for user: \(identity)")
            }
        }
        
        func enrollmentRequest(with status: IntuneMAMEnrollmentStatus) {
            
            var msg = ""
            if status.didSucceed {
                msg = Data().description + "Enrollment successful!"
            } else {
                //In the case unenrollment failed, log error
                msg =  (Date().description) + (" Enrollment result for identity \(status.identity) with status code \(status.statusCode)") + (" Debug message: \(String(describing: status.errorString))")
            }
            print(msg)
            
            let alert = UIAlertController(title: "Enrollment Result", message: msg, preferredStyle: .alert)
            let closeAlert = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(closeAlert)
            
            /*    if nil != self.presentingViewController {
             self.presentingViewController!.present(alert, animated: true, completion: nil)
             } else {
             UIUtils.getCurrentViewController()?.present(alert, animated: true, completion: nil)
             }*/
        }
        
        /*
         This is a method of the delegate that is triggered when an instance of this class is set as the delegate of the IntuneMAMEnrollmentManager and an unenrollment is attempted.
         The status parameter is a member of the IntuneMAMEnrollmentStatus class. This object can be used to check for the status of an attempted unenrollment.
         Logic for logout/token clearing is initiated here.
         */
        func unenrollRequest(with status: IntuneMAMEnrollmentStatus) {
            
            var msg = ""
            if status.didSucceed {
                msg = "Unenrollment successful!"
            } else {
                //In the case unenrollment failed, log error
                msg = ("Unenrollment result for identity \(status.identity) with status code \(status.statusCode)") + (" Debug message: \(String(describing: status.errorString))")
            }
            print(msg)
            
            let alert = UIAlertController(title: "Enrollment Result", message: msg, preferredStyle: .alert)
            let closeAlert = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alert.addAction(closeAlert)
            
            /*if nil != self.presentingViewController {
             self.presentingViewController!.present(alert, animated: true, completion: nil)
             } else {
             UIUtils.getCurrentViewController()?.present(alert, animated: true, completion: nil)
             }*/
        }
        
        
        func policyRequest(with status: IntuneMAMEnrollmentStatus) {
            var msg = ""
            if status.didSucceed {
                msg = "Policy fetch successful!"
            } else {
                msg = ("Policy fetch result for identity \(status.identity) with status code \(status.statusCode)") + (" Debug message: \(String(describing: status.errorString))")
            }
            print(msg)
        }
        
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        
        Button(action: {
            IntuneMAMEnrollmentManager.instance().loginAndEnrollAccount(nil)
        }) {
            Text("Enroll with Intune")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        
        Button(action: {
            let enrollAccountId = IntuneMAMEnrollmentManager.instance().enrolledAccountId()
            print("Starting unEnrollment forObjectid:" + enrollAccountId!)
            IntuneMAMEnrollmentManager.instance().deRegisterAndUnenrollAccountId(enrollAccountId!, withWipe: false)
            print(Date(), "De-Enrolled Account")
        }){
        Text("De-Enroll")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        
        Button(action: {
            intuneLogs()
        }) {
            Text("Diagnostics Logs")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        
    }
    
    func enrollFunction() {
        let enrollmentDelegate = EnrollmentDelegateClass()
        IntuneMAMEnrollmentManager.instance().delegate = enrollmentDelegate
        IntuneMAMEnrollmentManager.instance().loginAndEnrollAccount(nil)
        print(Date(), "Enrollment Initiated")
    }
    
    func intuneLogs() {
        IntuneMAMDiagnosticConsole.display()
        print(Date(), "Diagnostics Logs Generated")    }
    
   
}
   
        
    

