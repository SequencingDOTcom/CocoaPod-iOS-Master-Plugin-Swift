# COMING SOON!

# Master CocoPod Plugin for adding Squencing.com's Real-Time Personalization technology to iOS apps coded in Swift
=========================================
This Master CocoPod Plugin can be used to quickly add Real-Time Personalization to your app. This Master Plugin contains a customizable, end-to-end plug-n-play solution that quickly adds all necessary code (OAuth2, File Selector and App Chain coding) to your app.

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

Contents
=========================================
* Implementation
* App chains
* Authentication flow
* Steps
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

App chains
======================================
Search and find app chains -> https://sequencing.com/app-chains/

Each app chain is composed of 
* an **API request** to Sequencing.com
 * this request is secured using oAuth2
* analysis of the app user's genes
 * each app chain analyzes a specific trait or condition
 * there are thousands of app chains to choose from
 * all analysis occurs in real-time at Sequencing.com
* an **API response** to your app
 * the information provided by the response allows your app to tailor itself to the app user based on the user's genes.
 * the documentation for each app chain provides a list of all possible API responses. The response for most app chains are simply 'Yes' or 'No'.

Example
* App Chain: It is very important for this person's health to apply sunscreen with SPF +30 whenever it is sunny or even partly sunny.
* Possible responses: Yes, No, Insufficient Data, Error

While there are already app chains to personalize most apps, if you need something but don't see an app chain for it, tell us! (ie email us: gittaca@sequencing.com).

Authentication flow
======================================
Sequencing.com uses standard OAuth approach which enables applications to obtain limited access to user accounts on an HTTP service from 3rd party applications without exposing the user's password. OAuth acts as an intermediary on behalf of the end user, providing the service with an access token that authorizes specific account information to be shared.

![Authentication sequence diagram]
(https://github.com/SequencingDOTcom/oAuth2-code-and-demo/blob/master/screenshots/oauth_activity.png)


## Steps

### Step 1: Authorization Code Link

First, the user is given an authorization code link that looks like the following:

```
https://sequencing.com/oauth2/authorize?redirect_uri=REDIRECT_URL&response_type=code&state=STATE&client_id=CLIENT_ID&scope=SCOPES
```

Here is an explanation of the link components:

* https://sequencing.com/oauth2/authorize: the API authorization endpoint
* client_id=CLIENT_ID: the application's client ID (how the API identifies the application)
* redirect_uri=REDIRECT_URL: where the service redirects the user-agent after an authorization code is granted
* response_type=code: specifies that your application is requesting an authorization code grant
* scope=CODES: specifies the level of access that the application is requesting

![login dialog](https://github.com/SequencingDOTcom/oAuth2-code-and-demo/blob/master/screenshots/oauth_auth.png)

### Step 2: User Authorizes Application

When the user clicks the link, they must first log in to the service, to authenticate their identity (unless they are already logged in). Then they will be prompted by the service to authorize or deny the application access to their account. Here is an example authorize application prompt

![grant dialog](https://github.com/SequencingDOTcom/oAuth2-code-and-demo/blob/master/screenshots/oauth_grant.png)

### Step 3: Application Receives Authorization Code

If the user clicks "Authorize Application", the service redirects the user-agent to the application redirect URI, which was specified during the client registration, along with an authorization code. The redirect would look something like this (assuming the application is "php-oauth-demo.sequencing.com"):

```
https://php-oauth-demo.sequencing.com/index.php?code=AUTHORIZATION_CODE
```

### Step 4: Application Requests Access Token

The application requests an access token from the API, by passing the authorization code along with authentication details, including the client secret, to the API token endpoint. Here is an example POST request to Sequencing.com token endpoint:

```
https://sequencing.com/oauth2/token
```

Following POST parameters have to be sent

* grant_type='authorization_code'
* code=AUTHORIZATION_CODE (where AUTHORIZATION_CODE is a code acquired in a "code" parameter in the result of redirect from sequencing.com)
* redirect_uri=REDIRECT_URL (where REDIRECT_URL is the same URL as the one used in step 1)

### Step 5: Application Receives Access Token

If the authorization is valid, the API will send a JSON response containing the access token  to the application.

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
