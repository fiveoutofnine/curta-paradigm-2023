// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title The interface for {CurtaPCTF2023}
interface ICurtaPCTF2023 {
    // -------------------------------------------------------------------------
    // Errors
    // -------------------------------------------------------------------------

    /// @notice Emitted when a token hasn't been minted.
    error TokenUnminted();

    /// @notice Emitted when `msg.sender` is not authorized.
    error Unauthorized();

    // -------------------------------------------------------------------------
    // Functions
    // -------------------------------------------------------------------------

    /// @notice Mints a token to the sender.
    function mint() external;

    // TODO: get sound value at
    // TODO: get wav file header at

    // -------------------------------------------------------------------------
    // Metadata
    // -------------------------------------------------------------------------

    /// @notice Returns the contract URI for this contract.
    /// @return The contract URI for this contract.
    function contractURI() external view returns (string memory);

    /// @notice Returns a distinct URI for a given asset.
    /// @param _id The token ID.
    /// @return The URI for the token.
    function tokenURI(
        uint256 _id
    ) public view virtual override returns (string memory);
}
