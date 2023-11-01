// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Base64} from "src/utils/Base64.sol";
import {CurtaPCTF2023Art} from "src/utils/CurtaPCTF2023Art.sol";

/// @notice A script to print the art generated by `CurtaPCTF2023Art` for
/// testing purposes.
contract PrintCurtaPCTF2023ArtScript is Script {
    /// @notice Prints the generated art metadata for the given token ID.
    /// @dev Set `ID_TO_PRINT` to specify the token ID to print.
    function run() public view {
        uint256 ID_TO_PRINT = 4;
        console.log(
            Base64.encode(
                abi.encodePacked(CurtaPCTF2023Art.render(ID_TO_PRINT))
            )
        );
    }
}