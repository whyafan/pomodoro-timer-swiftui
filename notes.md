# Notes & Understanding of the entire project

Pomodoro Timer Learnings

The ViewModel conforms to the observableObject. The observableObject is used whenever there is a dynamic application that requires the application to listen for events and trigger specific actions using the @Published keyword.

The @Published keyword represents those values that will get changed whenever the observableObject will get an event trigger. 

It allows us to create observable objects that announce or trigger whenever an event happens. Since our application is dynamic, and we want the timer to update whenever the slider gets changes, this behaviour is required.

When using @Published inside the observableObject, SwiftUI listens for events and focuses on changing the data and values that rely on the @Published marked variables. SwiftUI monitors the changes. It re-invokes any body property of various Views that uses those @Published variables.

If we don’t use @Published, the views of the SwiftUI will not change and the dynamic content will remain static.

SwiftUI also has property observers. We are using the didSet feature, which allows us to execute a set of code statements whenever the selected property experiences a change or a new set of value through the events triggered in observable objects.

Since the user will modify the float timer property and set their timer, we used didSet there for the string-based property to get modified when the float based property changes.

We are using float values because the slider component requires float values. We need the current Date() as the end date because we are going to add the timer to it, and using it to end the timer.

The “!” Symbol represents a variable that cannot be empty, nil, or null. We will calculate the timer by subtracting the initial endDate with the modified endDate.

The guard keyword transfer the control of the execution out of the current block whenever the condition doesn’t return true. In our case, if the timer isn’t active, we cannot update anything, and thus, it exists the block.

@StateObject initialises an observable object to listen for events. The Timer.publish feature allows you to trigger a specific event based on a timer interval.

The core system library of apple is called Foundation. We imported it in ViewModel. In our model, we used Date() instead of Timer() because the Timer() class isn’t consistent and can run at different intervals even around the specified time. 

The .onReceive ensures that the UI updates for the specified time period by the timer, which is every second. 

I faced a bug while completing the application wherein the timer would random add 30 minutes to itself. This would occur when I was converting my local date to a string using an older format() approach.

However, I used the dateFormatter() class, which is known to handle such operations from a solution on the Internet, and that fixed the bug.
