@MainActor does not guarantee main thread

[see article](https://blog.hobbyistsoftware.com/2022/01/mainactor-not-guaranteed/)

The head of master shows code which looks sensible (to me!), uses vanilla async code - but where functions and properties marked as @MainActor run off the main thread

Commit b79b4a28939aca72998572a85db524b24fc89d9a turns on the warnings suggested by OleBergman [here](https://twitter.com/olebegemann/status/1421144304127463427)

Branch 'warnings' shows the code moved into a separate Model class.
This initially generates errors (e937684807f1d9cf0c838fb6682764c14581f582) which are then fixed in (f948aab79a6c8052c771bd7c2c3f93e5fe7bf625)