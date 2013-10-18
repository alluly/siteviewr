#siteviewr
    
siteviewr uses the [Dropbox Core API](https://www.dropbox.com/developers/core) to pull a website from your Dropbox account and display it in the app. In the normal Dropbox app html and other files are not parsed as they would in a browser. This shows your website as it would look on the iPhone. Rather than making a subdomain [test.yourwebsite.com](test.yourwebsite.com) or [yourwebsite.com/test](yourwebsite.com/test) 

I basically made it because it became annoying to test whether or not the site I was building looked good on retina devices. 

###Usage

Drop website contents into a folder called siteviewr

![image](http://differentialapps.com/images/siteviewr.jpg)

Open app, link with Dropbox account

Website will pop up in webview

![image](http://differentialapps.com/images/example.png)

###Uses

I built this because I really wanted to test my websites on the iPhone without throwing them on a server. Just drag your website into a folder called siteviewr in your Dropbox and check out how it looks. 

###Limitations

The app obviously does not support CGI scripts. 

Ideally it would be nice for the user to select from a number of websites he/she may have uploaded, not just the one website in the folder. 

###Future Improvements

The user should definitely be able to choose any folder from his/her Dropbox. 

Instead of loading all the resources again each time the resources should be cached. Only new resources should be changed. 

Instead of reloading the webview each time a resource is added the webview should load at the end when all resources have been added.

###Other Info

You have to use your own API key and secret from Dropbox. I could put this on the App Store, but I would like to improve it more. 

If you have any suggestions or comments, please let me know!