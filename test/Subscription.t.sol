// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Subscription.sol";

contract SubscriptionTest is Test {
    Subscription public subscription;

    function setUp() public {
        subscription = new Subscription();
    }

    function testGetSubscription() public {
        subscription.getSubscription{value: 0.01 ether}();
        bool isSubscribed = subscription.isSubscribed(address(this));
        assertEq(isSubscribed, true);
    }

    function testCancleSubscription() public {
        subscription.getSubscription{value: 0.01 ether}();
        bool isSubscribed = subscription.isSubscribed(address(this));
        assertEq(isSubscribed, true);
        uint256 subscriptionId = subscription
            .subscriptionData(address(this))
            .subscribtionId;
        subscription.calcleSubscription(subscriptionId);
        vm.expectRevert(bytes("Subscription: InvalidSubscriber"));
        subscription.subscriptionData(address(this));
    }

    function testRenewSubscription() public {
        subscription.getSubscription{value: 0.01 ether}();
        bool isSubscribed = subscription.isSubscribed(address(this));
        assertEq(isSubscribed, true);
        uint256 subscriptionId = subscription
            .subscriptionData(address(this))
            .subscribtionId;
        uint256 startedAt = subscription
            .subscriptionData(address(this))
            .startedAt;
        vm.warp(startedAt + 31 days);
        subscription.renewSubscription{value: 0.01 ether}(subscriptionId);
        assertEq(isSubscribed, true);
    }
}
