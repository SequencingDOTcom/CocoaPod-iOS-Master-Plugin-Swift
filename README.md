# Master CocoaPods Plugin for adding Sequencing.com's Real-Time Personalization technology to iOS apps coded in Swift

=========================================
This Master CocoaPods Plugin can be used to quickly add Real-Time Personalization to your app. This Master Plugin contains a customizable, end-to-end plug-n-play solution that quickly adds all necessary code (OAuth2, File Selector and App Chain coding) to your app.

Once this Master Plugin is added to your app all you'll need to do is:

1. add your [OAuth2 secret](https://sequencing.com/developer-center/new-app-oauth-secret)
2. add one or more [App Chain numbers](https://sequencing.com/app-chains/)
3. configure your app based on each [app chain's possible responses](https://sequencing.com/app-chains/)

To code Real-Time Personalization technology into apps, developers may [register for a free account](https://sequencing.com/user/register/) at Sequencing.com. App development with RTP is always free.

**The Master Plugin is also available in the following languages:**
* Swift (CocoaPod plugin) <-- this repo
* [Objective-C (CocoaPod plugin)](https://github.com/SequencingDOTcom/CocoaPod-iOS-Master-Plugin-ObjectiveC) 
* [Android (Maven plugin)](https://github.com/SequencingDOTcom/Maven-Android-Master-Plugin-Java)
* [Java (Maven plugin)](https://github.com/SequencingDOTcom/Maven-Android-Master-Plugin-Java)
* [C#/.NET (Nuget for Visual Studio)](https://sequencing.com/developer-documentation/nuget-visual-studio)

**Master Plugin - Plug-n-Play Samples** (This code can be used as an out-of-the-box solution to quickly add Real-Time Personalization technology into your app):
* [Swift (CocoaPod) Plug-n-Play Sample](https://github.com/SequencingDOTcom/iOS-Swift-Master-Plugin-Plug-n-Play-Sample)
* [Objective-C (CocoaPod) Plug-n-Play Sample](https://github.com/SequencingDOTcom/iOS-Objective-C-Master-Plugin-Plug-n-Play-Sample)
* [Android (Maven) Plug-n-Play Sample](https://github.com/SequencingDOTcom/Android-Master-Plugin-Plug-N-Play-Sample)

Contents
=========================================
* Implementation
* Master CocoaPods Plugin install
* Authentication flow
* OAuth CocoaPods Plugin integration
* File Selector CocoaPods Plugin integration
* AppChains CocoaPods Plugin integration
* Resources
* Maintainers
* Contribute

Implementation
======================================
To implement this Master Plugin for your app:

1) [Register](https://sequencing.com/user/register/) for a free account

2) Add this repo's Master Plugin to your app

3) [Generate an OAuth2 secret](https://sequencing.com/api-secret-generator) and insert the secret into the plugin

4) Add one or more [App Chain numbers](https://sequencing.com/app-chains/). The App Chain will provide genetic-based information you can use to personalize your app.

5) Configure your app based on each [app chain's possible responses](https://sequencing.com/app-chains/)


Master CocoaPod Plugin install
======================================
* see [CocoaPods guides](https://guides.cocoapods.org/using/using-cocoapods.html)
* create Podfile in your project directory: ```$ pod init```
* specify "sequencing-master-plugin-api-objc" pod parameters in Podfile: 

	```pod 'sequencing-master-plugin-api-swift', '~> 1.1.0'```

* install the dependency in your project: ```$ pod install```
* always open the Xcode workspace instead of the project file: ```$ open *.xcworkspace```
* as a result you'll have 3 CocoaPods plugins installed: OAuth, Files Selector and AppChains


Authentication flow
======================================
Sequencing.com uses standard OAuth approach which enables applications to obtain limited access to user accounts on an HTTP service from 3rd party applications without exposing the user's password. OAuth acts as an intermediary on behalf of the end user, providing the service with an access token that authorizes specific account information to be shared.

![Authentication sequence diagram]
(https://github.com/SequencingDOTcom/oAuth2-code-and-demo/blob/master/screenshots/oauth_activity.png)



## Steps

### Step 1: Authorization Code Link

First, the user is given an webpage opened by following authorization code link:

```
https://sequencing.com/oauth2/authorize?redirect_uri=REDIRECT_URL&response_type=code&state=STATE&client_id=CLIENT_ID&scope=SCOPES
```

Here is an explanation of the link components:
* ```https://sequencing.com/oauth2/authorize``` - the API authorization endpoint
* ```redirect_uri=REDIRECT_URL``` - where the service redirects the user-agent after an authorization code is granted
* ```response_type=code``` - specifies that your application is requesting an authorization code grant
* ```state=STATE``` - holds the random verification code that will be compared with the same code within the server answer in order to verify if response was being spoofed
* ```client_id=CLIENT_ID``` - the application's client ID (how the API identifies the application)
* ```scope=CODES``` specifies the level of access that the application is requesting

![login dialog](https://github.com/SequencingDOTcom/oAuth2-code-and-demo/blob/master/screenshots/oauth_auth.png)


### Step 2: User Authorizes Application

User must first log in to the service, to authenticate their identity (unless they are already logged in). Then they will be prompted by the service to authorize or deny the application access to their account. Here is an example authorize application prompt

![grant dialog](https://github.com/SequencingDOTcom/oAuth2-code-and-demo/blob/master/screenshots/oauth_grant.png)


### Step 3: Application Receives Authorization Code

When user clicks "Authorize Application", the service will open the redirect_URI url address, which was specified during the authorization request. In iOS application following ```redirect_uri``` was used:

```
authapp://Default/Authcallback
```

As soon as your application detects that redirect_uri page was opened then it should analyse the server response with the state verification code. If the state verification code matches the one was sent in authorization request then it means that the server response is valid.
Now we can get the authorization code form the server response.


### Step 4: Application Requests Access Token

The application requests an access token from the API, by passing the authorization code (got from server response above) along with authentication details, including the client secret, to the API token endpoint. Here is an example POST request to Sequencing.com token endpoint:

```
https://sequencing.com/oauth2/token
```

Following POST parameters have to be sent

* grant_type='authorization_code'
* code=AUTHORIZATION_CODE (where AUTHORIZATION_CODE is a code acquired in a "code" parameter in the result of redirect from sequencing.com)
* redirect_uri=REDIRECT_URL (where REDIRECT_URL is the same URL as the one used in step 1)


### Step 5: Application Receives Access Token

If the authorization is valid, the API will send a JSON response containing the token object to the application. Token object contains accessToken, its expirationDate, tokenType, scope and refreshToken.



OAuth CocoaPod Plugin integration
======================================
* **Add Application Transport Security setting**
	* open project settings > Info tab
	* add ```App Transport Security Settings``` row parameter (as Dictionary)
	* add subrow to App Transport Security Settings parameter as ```Exception Domains``` dictionary parameter
	* add subrow to Exception Domains parameter with ```sequencing.com``` string value
	* add subrow to App Transport Security Settings parameter with ```Allow Arbitrary Loads``` boolean value
	* set ```Allow Arbitrary Loads``` boolean value as ```YES```
	
	![sample files](https://github.com/SequencingDOTcom/CocoaPod-iOS-OAuth-ObjectiveC/blob/master/Screenshots/authTransportSecuritySetting.png)

* **Use authorization method**
	* **create View Controllers, e.g. for Login view and for SelectFile view**
	
	* **in your LoginViewController class:**
	
		* add pod import (pay attention to substitute original dash characters in title to underscore characters) 
		
			```import sequencing_oauth_api_swift```

		* for authorization you need to specify your application parameters in String format (BEFORE using authorization methods)
		
			```
			let CLIENT_ID: String		= "your CLIENT_ID here"
			let CLIENT_SECRET: String	= "your CLIENT_SECRET here"
			let REDIRECT_URI: String    = "REDIRECT_URI here"
			let SCOPE: String           = "SCOPE here"
			```		
		
		* register these parameters into OAuth module instance
	
			```
			SQOAuth.instance.registrateApplicationParametersClientID(CLIENT_ID,
                                                                 	 ClientSecret: CLIENT_SECRET,
                                                                 	 RedirectUri: REDIRECT_URI,
                                                                 	 Scope: SCOPE)
			```
			
		* subscribe your class for this protocol
			```
			SQAuthorizationProtocolDelegate
			```
		
		* subscribe your class as delegate for such protocol
			```
			SQOAuth.instance.authorizationDelegate = self
			```
		
		* add methods for SQAuthorizationProtocolDelegate
			```
			func userIsSuccessfullyAuthorized(token: SQToken) -> Void {
        		dispatch_async(dispatch_get_main_queue(), { () -> Void in
        			// your code is here for successful user authorization
        		})	
        	}
    
			func userIsNotAuthorized() -> Void {
				dispatch_async(dispatch_get_main_queue()) {
					// your code is here for unsuccessful user authorization
				}
			}

			func userDidCancelAuthorization() -> Void {
				dispatch_async(dispatch_get_main_queue()) {
					// your code is here for abandoned user authorization
				}
			}
			
			```
		
		* you can authorize your user now (e.g. via "login" button). For authorization you can use ```authorizeUser``` method. You can get access via shared instance of SQOAuth class)
			```
			SQOAuth.instance.authorizeUser()
			```
			
			Related method from SQAuthorizationProtocolDelegate will be called as a result
		
		* example of Login button (you can use ```@"button_signin_black"``` image that is included into the Pod within ```AuthImages.xcassets```)
			```
			
    		let loginButton = UIButton(type: UIButtonType.Custom)
	        loginButton.setImage(UIImage(named: "button_signin_white_gradation"), forState: UIControlState.Normal)
    	    loginButton.addTarget(self, action: #selector(self.loginButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
	        loginButton.sizeToFit()
	        loginButton.translatesAutoresizingMaskIntoConstraints = false
	        self.view.addSubview(loginButton)
	        self.view.bringSubviewToFront(loginButton)
        
	        // adding constraints for loginButton
	        let xCenter = NSLayoutConstraint.init(item: loginButton,
	                                              attribute: NSLayoutAttribute.CenterX,
	                                              relatedBy: NSLayoutRelation.Equal,
	                                              toItem: self.view,
	                                              attribute: NSLayoutAttribute.CenterX,
	                                              multiplier: 1,
	                                              constant: 0)
	        let yCenter = NSLayoutConstraint.init(item: loginButton,
	                                              attribute: NSLayoutAttribute.CenterY,
	                                              relatedBy: NSLayoutRelation.Equal,
	                                              toItem: self.view,
	                                              attribute: NSLayoutAttribute.CenterY,
	                                              multiplier: 1,
	                                              constant: 0)
	        self.view.addConstraint(xCenter)
	        self.view.addConstraint(yCenter)
    		```
    	
    	* example of ```loginButtonPressed``` method 
    		```
    		func loginButtonPressed() {
    			self.view.userInteractionEnabled = false
    			SQOAuth.instance.authorizeUser()
    		}
    		```
    		
    	* if you want to use original sequencing icon for login button add ```Assets.xcassets``` into ```Copy Bundle Resources``` in project settings
    		* select project name
    		* select project target
    		* open ```Build Phases``` tab
    		* expand ```Copy Bundle Resources``` phase
    		* click ```Add Items``` button (plus icon)
    		* click ```Add Other``` button
    		* open your project folder
    		* open ```Pods``` subfolder
    		* open ```sequencing-oauth-api-swift``` subfolder
    		* open ```Resources``` subfolder
    		* select ```Assets.xcassets``` file
		
		* add segue in Storyboard from LoginViewController to MainViewController with identifier ```SELECT_FILES```
		
		* add constant for segue id
			```let SELECT_FILES_CONTROLLER_SEGUE_ID = "SELECT_FILES"```
		
		* example of navigation methods when user is authorized (token object will be passed on to the SelectFileViewController)
			```
			func userIsSuccessfullyAuthorized(token: SQToken) -> Void {
				dispatch_async(self.kMainQueue, { () -> Void in
					print("user Is Successfully Authorized")
					self.view.userInteractionEnabled = true
					self.performSegueWithIdentifier(self.SELECT_FILES_CONTROLLER_SEGUE_ID, sender: token)
				})
			}
			
			override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
				if segue.destinationViewController.isKindOfClass(SelectFileViewController) {
					if sender != nil {
						let destinationVC = segue.destinationViewController as! SelectFileViewController
						destinationVC.token = sender as! SQToken?
					}
				}
			}
			```

	* **in your SelectFileViewController class:**
		
		* add imports
			```
			import sequencing_oauth_api_swift
			```
				
		* subscribe your class for these protocols
			```
			SQTokenRefreshProtocolDelegate
			```
			
		* add property for handling Token object
			```
			var token: SQToken?
			```
		
		* subscribe your class as delegate for such protocols
			```
			SQOAuth.instance.refreshTokenDelegate = self
			```
		
		* add method for SQTokenRefreshProtocol - it is called when token is refreshed
			```
			func tokenIsRefreshed(updatedToken: SQToken) -> Void {
				// your code is here to handle refreshed token
			}
			```
		
		* in method ```userIsSuccessfullyAuthorized``` and in method ```tokenIsRefreshed``` you'll receive the same SQToken object, that contains following 5 properties with clear titles for usage:
			```	
			accessToken:	String
			expirationDate:	NSDate
			tokenType:		String
			scope:			String
			refreshToken:	String
			```
		
			(!) DO NOT OVERRIDE ```refresh_token``` property for ```token``` object - it comes as ```nil``` after refresh token request.
	
		* for your extra needs you can always get access directly to the up-to-day token object which is stored in ```SQAuthResult``` class via ```token``` property
			```
			SQAuthResult.instance.token
			```
			
			
File Selector CocoaPods Plugin integration
======================================
* **Set up File Selector UI**

	* add "Storyboard Reference" in your Main.storyboard
		* open your main storyboard
		* add "Storyboard Reference" object
		* select added "Storyboard Reference"
		* open Utilities > Atributes inspector
		* select ```TabbarFileSelector``` in Storyboard dropdown
		
	* add segue from your ViewController to created Storyboard Reference
		* open Utilities > Atributes inspector
		* name this segue as ```GET_FILES``` in Identifier field
		* set Kind as ```Present Modally```
		
	* add all resources of ```File Selector``` plugin into your project Bundle Resources:
		* select project name
		* select project target
		* open ```Build Phases``` tab
		* expand ```Copy Bundle Resources``` phase
		* click ```Add Items``` button ("+" icon)
		* click ```Add Other``` button
		* open your project folder
		* open ```Pods``` subfolder
		* open ```sequencing-oauth-api-swift``` subfolder
		* open ```Resources``` subfolder 
	
		* add ```TabbarFileSelector.storyboard``` storyboard
		* add ```SQFilesPopoverInfoViewController.xib``` popover nib
		* add ```SQFilesPopoverMyFilesViewController.xib``` popover nib
		* add ```Images.xcassets``` xcassets
	
	
* **Set up file selector plugin in code**
		
	* add import: 
		```
		import sequencing_file_selector_api_swift
		```

	* subscribe your class to file selector protocol: 
		```
		SQFileSelectorProtocolDelegate
		```
		
	* subscribe your class as handler/delegate for selected file in file selector: 
		```
		SQFilesAPI.instance.selectedFileDelegate = self
		```
		
	* implement "handleFileSelected" method from ```SQFileSelectorProtocolDelegate``` protocol
		```
		func handleFileSelected(file: NSDictionary) -> Void {
			// your code here
	    }
		```

	* implement optional "closeButtonPressed" method from protocol if needed
		```
		func closeButtonPressed() -> Void {
    	    // your code here
	    }
		```
	
	
* **Use File Selector** 

	* set up some button for getting/viewing files for logged in user, and specify delegate method for this button
	
	* specify segue ID constant for file selector UI
		```
		let FILES_CONTROLLER_SEGUE_ID = "GET_FILES"
		```	
		
	* you can load/get files, list of my files and list of sample files, via ```withToken: loadFiles:``` method (via ```SQFilesAPI``` class with shared instance init access).
	
		pay attention, you need to pass on the String value of ```token.accessToken``` object as a parameter for this method:
		```
		SQFilesAPI.instance.loadFilesWithToken(self.token!.accessToken, success: { (success) in
			dispatch_async(dispatch_get_main_queue()) {
				// your code here
			}
	    })
		```
		
		```loadFilesWithToken``` method will return a Bool value with ```true` if files were successfully loaded or ```false``` if there were any problem. You need to manage this in your code
		
	* if files were loaded successfully you can now open/show File Selector in UI. You can do it by calling File Selector view via ```performSegueWithIdentifier``` method:
		```
		self.performSegueWithIdentifier(self.FILES_CONTROLLER_SEGUE_ID, sender: nil)
		```
	
		while opening File Selector in UI you can set `Close` button to be present if you need
		```
		SQFilesAPI.instance.closeButton = true
		```
	
	* when user selects any file and clicks on "Continue" button in File Selector UI - ```handleFileSelected``` method from ```SQFileSelectorProtocolDelegate``` protocol will be called then. Selected file will be passed on as a parameter. In this method you can handle this selected file
	
	* each file is a NSDictionary object with following keys and values format:
	
		key name | type | description
		------------- | ------------- | ------------- 
		DateAdded | String | date file was added
		Ext | String | file extension
		FileCategory | String | file category: Community, Uploaded, FromApps, Altruist
		FileSubType | String | file subtype
		FileType | String | file type
		FriendlyDesc1 | String | person name for sample files
		FriendlyDesc2 | String | person description for sample files
		Id | String | file ID
		Name | String | file name
		Population | String | 
		Sex | String |	the sex


* **Examples**

	* example of ```File Selector - Intro page```

		![intro page](https://github.com/SequencingDOTcom/CocoaPod-iOS-File-Selector-ObjectiveC/blob/master/Screenshots/fileSelector_introPage.png)


	* example of ```File Selector - My Files```

		![my files](https://github.com/SequencingDOTcom/CocoaPod-iOS-File-Selector-ObjectiveC/blob/master/Screenshots/fileSelector_myFiles2.png)


	* example of ```Sample Files```

		![sample files](https://github.com/SequencingDOTcom/CocoaPod-iOS-File-Selector-ObjectiveC/blob/master/Screenshots/fileSelector_sampleFiles2.png)

	
	* example of selected file

		![selected file](https://github.com/SequencingDOTcom/CocoaPod-iOS-File-Selector-ObjectiveC/blob/master/Screenshots/fileSelector_sampleFiles2selected.png)

	
	* example of ```Select File``` button - you can add simple button via storyboard
	
	
	* example of delegate method for select file button
		```
		@IBAction func loadFilesButtonPressed(sender: AnyObject) {
        	self.view.userInteractionEnabled = false
	        self.startActivityIndicatorWithTitle("Loading Files")
    	    if self.token != nil {
        	    SQFilesAPI.instance.loadFilesWithToken(self.token!.accessToken, success: { (success) in
            	    dispatch_async(self.kMainQueue) {
                	    if success {
                    	    self.stopActivityIndicator()
                        	self.view.userInteractionEnabled = true
	                        self.performSegueWithIdentifier(self.FILES_CONTROLLER_SEGUE_ID, sender: nil)
                        
    	                } else {
        	                self.stopActivityIndicator()
            	            self.view.userInteractionEnabled = true
                	        self.showAlertWithMessage("Sorry, can't load genetic files")
                    	}
	                }
    	        })
        	} else {
        		self.stopActivityIndicator()
	            self.showAlertWithMessage("Sorry, can't load genetic files > token is empty")
    	    }
	    }
		```	


	* example of ```handleFileSelected``` method
		```
		func handleFileSelected(file: NSDictionary) -> Void {
    	    self.dismissViewControllerAnimated(true, completion: nil)
        	print(file)
	        if file.allKeys.count > 0 {
    	        dispatch_async(self.kMainQueue) {
        	        self.stopActivityIndicator()
            	    self.view.userInteractionEnabled = true
                	self.selectedFile = file
	            }
    	    } else {
        	    dispatch_async(kMainQueue, {
            	    self.stopActivityIndicator()
                	self.view.userInteractionEnabled = true
	                self.showAlertWithMessage("Sorry, can't load genetic files")
    	        })
        	}
	    }
		```

	* example of ```closeButtonPressed``` method
		```
		func closeButtonPressed() -> Void {
			self.stopActivityIndicator()
        	self.dismissViewControllerAnimated(true, completion: nil)
	    }
		```



AppChains CocoaPod Plugin integration
======================================
* configuration for App-Chains: code snippets below contain the following three placeholders. Please make sure to replace each of the placeholders with real values:
* ```<your token>``` 
 * replace with the oAuth2 access token value obtained from OAuth plugin
  * the code snippet for enabling Sequencing.com's oAuth2 authentication for your app can be found in the [oAuth2 code and demo repo](https://github.com/SequencingDOTcom/oAuth2-code-and-demo)
  * [OAuth plugin Swift (CocoaPods plugin)](https://github.com/SequencingDOTcom/CocoaPod-iOS-OAuth-Swift)

* ```<chain id>``` 
 * replace with the App Chain ID obtained from the list of [App Chains](https://sequencing.com/app-chains)

* ```<file id>``` 
 * replace with the file ID selected by the user while using your app
  * the code snippet for enabling Sequencing.com's File Selector for your app can be found in the [File Selector code repo](https://github.com/SequencingDOTcom/File-Selector-code)
  * [File Selector plugin Swift (CocoaPods plugin)](https://github.com/SequencingDOTcom/CocoaPod-iOS-File-Selector-Swift)


AppChains Swift API overview

AppChain module contains framework with encapsulated logic inside (build on Objective-C language).
AppChains Swift API overview

Method  | Purpose | Arguments | Description
------------- | ------------- | ------------- | -------------
`init(token: String, withHostName: String)`  | Constructor | **token** - security token provided by sequencing.com <br> **Hostname** - API server hostname. api.sequencing.com by default | Constructor used for creating AppChains class instance in case reporting API is needed and where security token is required
`func getReportWithApplicationMethodName(applicationMethodName: String!, withDatasourceId: String!, withSuccessBlock: ((Report!) -> Void)!, withFailureBlock: ((NSError!) -> Void)!)`   | Reporting API | **applicationMethodName** - name of data processing routine<br><br>**datasourceId** - input data identifier<br><br>**success** - callback executed on success operation, results with `Report` object<br><br>**failure** - callback executed on operation failure
`func getBatchReportWithApplicationMethodName(appChainsParams: [AnyObject]!, withSuccessBlock: ReportsArray!, withFailureBlock: ((NSError!) -> Void)!)`   | Reporting API with batch request | **appChainsParams** - array of params for batch request.<br>Each param should be an array with 2 items:<br>first object - `applicationMethodName`<br>last object - `datasourceId`<br><br>**success** - callback executed on success operation, results with ReportsArray as array of dictionaries.<br>Each dictionary has following keys and objects:<br>`appChainID` - appChain ID string<br>`report` - Report object<br><br>**failure** - callback executed on operation failure


Adding code to the project:

* first of all you need to create bridging header file.
	Select File > New > File > Header File > name it as

	```
	project-name-Bridging-Header.h
	```

* add AppChains class import in the bridging header file

	```
	#import <AppChainsLibrary/AppChains.h>
	```

* register your bridging header file in the project settings.
	Select your project > project target > Build Settings > Objective-C Bridging Header
	specify path for bridging header file

	```
	$(PROJECT_DIR)/project-name-Bridging-Header.h
	```

After that you can start utilizing Reporting API for single chain request, example:

```
let appChainsManager = AppChains.init(token: accessToken as String, withHostName: "api.sequencing.com")

appChainsManager.getReportWithApplicationMethodName("Chain88", withDatasourceId: fileID, withSuccessBlock: { (result) in
            let resultReport: Report = result as Report!
            
            if resultReport.isSucceeded() {    
                if resultReport.getResults() != nil {
                    for item: AnyObject in resultReport.getResults() {
                        
                        let resultObj = item as! Result
                        let resultValue: ResultValue = resultObj.getValue()
                        
                        if resultValue.getType() == ResultType.Text {
                            print(resultObj.getName() + " = " + (resultValue as! TextResultValue).getData())
                        }
                    }
                }   
            } else {
                print("Error occured while getting genetic information")
            }
            
            

            
            }) { (error) in
            	print("Error occured while getting genetic information. " + error.localizedDescription)
        }
        
```


Example of using batch request API for several chains:

```
let appChainsManager = AppChains.init(token: accessToken as String, withHostName: "api.sequencing.com")

let appChainsForRequest: NSArray = [["Chain88", fileID],
									["Chain9", fileID]]

appChainsManager.getBatchReportWithApplicationMethodName(appChainsForRequest as [AnyObject], withSuccessBlock: { (resultsArray) in
            let reportResultsArray = resultsArray as NSArray
            
            for appChainReport in reportResultsArray {
                let appChainReportDict = appChainReport as! NSDictionary
                let resultReport: Report = appChainReportDict.objectForKey("report") as! Report;
                let appChainID: NSString = appChainReportDict.objectForKey("appChainID") as! NSString;
                
                if appChainID.isEqualToString("Chain88") {
                    appChainValue = self.parseReportForChain88(resultReport) // your own method to parse report object
                    print(appChainValue)
                    
                } else if appChainID.isEqualToString("Chain9") {
                    appChainValue = self.parseReportForChain9(resultReport) // your own method to parse report object
                    print(appChainValue)
                }   
            }
            
        }) { (error) in
            print("batch request error. " + error.localizedDescription)
            completion(appchainsResults: nil)
        }
```



Resources
======================================
* [App chains](https://sequencing.com/app-chains)
* [File selector code](https://github.com/SequencingDOTcom/File-Selector-code)
* [Generate OAuth2 secret](https://sequencing.com/developer-center/new-app-oauth-secret)
* [Developer Center](https://sequencing.com/developer-center)
* [Developer Documentation](https://sequencing.com/developer-documentation/)

Maintainers
======================================
This repo is actively maintained by [Sequencing.com](https://sequencing.com/). Email the Sequencing.com bioinformatics team at gittaca@sequencing.com if you require any more information or just to say hola.

Contribute
======================================
We encourage you to passionately fork us. If interested in updating the master branch, please send us a pull request. If the changes contribute positively, we'll let it ride.
