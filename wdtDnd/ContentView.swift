import SwiftUI

struct ContentView: View {
    @State private var txt: String = "wdt://ec2-54-172-211-61.compute-1.amazonaws.com:30000?Enc=2:dbca562efd3eb37e90bee69d38040747&id=1612404778&iv_change_int=34359738368&num_ports=8&recpv=32&tls=0"
    @State private var value: Double = 0
    @State private var status: String = "Uploading"
    @State private var path: String = ""
    @State private var startStr = ""
    @State private var endStr = ""
    @State private var statusCode = 0
    var body: some View {
        TextField("URL:", text:$txt).padding();
        Button("Choose File to Upload") {
            let dialog = NSOpenPanel();

            dialog.title = "Choose a Directory To Transfer";
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = false;
            dialog.allowsMultipleSelection = false;
            dialog.canChooseDirectories = true;


            if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
                let result = dialog.url // Pathname of the file
                if (result != nil) {
                    status = "Uploading..."
                    let today = Date.now
                    let fmt = DateFormatter()
                    fmt.timeStyle = .medium
                    startStr = fmt.string(from: today)
                    status = status + startStr
                    value = 0
                    path = result!.path
                    
                } else {
                    path = ""
                        //result != nil
                        
                }
                    
            } else {
                // User clicked on "Cancel"
                return
            }
            
            DispatchQueue.global().async {
                if(path != "" && txt != "") {
                    statusCode = initializeWdtCSwift(url: txt, dir: path)
                    if (0 == statusCode) {
                        let today = Date.now
                        let fmt = DateFormatter()
                        fmt.timeStyle = .medium
                        endStr = fmt.string(from: today)
                        value = 100
                        status = "Completed." + startStr + " - " + endStr
                    } else {
                        value = 5
                        status = "Error. " + startStr + " - " + endStr
                        statusCode = -1;
                    }
                }
            }
            DispatchQueue.global().async {
                while(statusCode == 0) {
                    usleep(5000000)
                    value = getProgressCSwift()
                }
            }
        }
    
        
        
        ProgressView(status, value: value, total: 100.0).padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("Main")
            .frame(width: 300.0, height: 300.0)
            
    }
}
