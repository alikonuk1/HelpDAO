// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/HelpDaoNft.sol";

contract HelpDaoNftTest is Test {
    HelpDaoNft public nft;

    address internal contractOwner;
    address internal multiSig;
    address internal minter;
    address internal attacker;

    function setUp() public {
        contractOwner = address(0xa11c3);
        multiSig = address(0x24f3);
        minter = address(0xb0b);
        attacker = address(0x54c32);

        vm.startPrank(contractOwner);
        nft = new HelpDaoNft("HelpDAO", "HELP", "minthelp.xyz", address(contractOwner));
        vm.stopPrank();

        // top up the minter wallet with eth
        minter.call{value: 90 ether}("");
    }

    function testMintPricePaid() public {
        vm.startPrank(minter);
        nft.mint{value: 0.01 ether}();
        vm.stopPrank();
    }

    function testFailMintPriceNotPaid() public {
        vm.startPrank(minter);
        nft.mint();
        vm.stopPrank();
    }

    function testOwnerWithdraw() public {
        vm.startPrank(minter);
        nft.mint{value: 0.01 ether}();
        vm.stopPrank();
/*
        vm.startPrank(contractOwner);
        nft.withdrawPayments(multiSig);
        vm.stopPrank();
*/        
    }
}
