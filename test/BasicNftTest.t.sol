// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        DeployBasicNft deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assertEq(expectedName, actualName);
    }

    function testSymbolIsCorrect() public {
        string memory expectedSymbol = "DOG";
        string memory actualSymbol = basicNft.symbol();
        assertEq(expectedSymbol, actualSymbol);
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        uint256 endingUserBalance = basicNft.balanceOf(USER);
        assertEq(endingUserBalance, 1);
        assertEq(PUG, basicNft.tokenURI(0));
    }
}
