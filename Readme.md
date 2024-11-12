# Tasks

1. Refactor `MarketsTableViewController` from MVC into MVVM architecture. Any business logic in the View Model should be unit tested.
2. After completing the first task, what would you choose to do next? In this task we would like to see which would be your next priority and why.
3. If you had more time what would you improve?


Tankyou for taking the time to review my tech task.  I have converted the project to MVVM and unit tested the buisness logic as requested.  I also addressed what I believe to be the most important issues within the project.  This was the separation of the network layer from the ViewModel.  The data provider is injected into the constructor to allow for easy mocking.  I also converted the model to be decodable structs rather than classes with the manual decoding.  This is much safer as the app would crash if it failed the manual decoding previously, also it is likely our Market objects would need to be passed between threads as the application expands.

Given more time I would next address the error handling within the application. At the moment if something goes wrong the application cannot recover and will be in an unsuable state.  The way I would achieve this would be first implement a rety for the request if it fails - depending on the error, then surface an alert to the user.  Further more I would implement pull to refresh on the tableView as well as introducing some loading states.  This would lead to a releasable user experience.  Following this I would refactor the networking to decode using generics so that it can be reusable.  This will greatly aid the scalability of the project.
