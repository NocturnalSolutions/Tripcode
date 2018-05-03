# Tripcode

A Swift tripcode parser and hasher.

Uses the standard tripcode algorithm only, currently, though some scaffolding for secure tripcodes are in place.

## Simple Usage

Call the `appliedTripcode()` method on a string which contains a tripcode to get a string with the tripcode hashed and applied.

```swift
let username = "Noct#{\\oc0xWGNQ".appliedTripcode() // "Noct!urnalhjR/k"
```

## Slightly More Advanced Usage

Call the `tripcode()` method on a string to get a `Tripcode` struct which contains `name`, `hash`, and `secureHash` properties (the latter of which will currently always be nil). This allows you to do some formatting on the name if you wish.

```swift
if let tc = "Noct#{\\oc0xWGNQ".tripcode() {
    var username = ""
    if let name = tc.name {
        username.append("<span class=\"name\">\(name)</span>")
    }
    if let hash = tc.hash {
        username.append("<span class=\"triphash\">!\(hash)</span>")
    }
}
else {
    var username = "<span class="\name anonymous\">Anonymous</span>"
}
```