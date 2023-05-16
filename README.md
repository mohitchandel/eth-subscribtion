# eth-subscription

eth-subscription is a smart contract implementation of a subscription service on the Ethereum blockchain. It allows users to subscribe to a service by paying a subscription fee and provides functionalities for managing subscriptions.

## Smart Contract

The main smart contract, `Subscription.sol`, is implemented based on the `ISubscription` interface. It provides the following functions:

### `getSubscription()`

This function allows a user to subscribe to the service by sending a payment of 0.01 ether. It verifies if the subscription already exists, if the previous subscription has expired, and if the amount sent is correct.

### `renewSubscription(uint256 subscriptionId)`

Users can use this function to renew their subscription by providing the subscription ID. It verifies if the caller is an existing subscriber, if the subscription has expired, if the amount sent is correct, and if the provided subscription ID is valid.

### `calcleSubscription(uint256 subscriptionId)`

Subscribers can cancel their subscription using this function by providing the subscription ID. It verifies if the caller is an existing subscriber and if the provided subscription ID is valid. Upon successful cancellation, the subscriber's details are removed from the `_subscribers` mapping.

### `subscriptionData(address subscriber)`

This function allows fetching the subscription details of a subscriber by providing the subscriber's address. It verifies if the provided subscriber address is valid and returns the corresponding subscription data.

### `isSubscribed(address subscriber)`

This function checks if a subscriber's subscription is active by providing the subscriber's address. It verifies if the provided subscriber address is valid and checks if the subscription has not expired.

## Development

To develop and test the smart contract, follow these steps:

1. Install the required dependencies:

```shell
   forge install
```

2. Compile the smart contract:

```shell
   forge build
```

3. Run the tests:

```shell
   forge test
```


