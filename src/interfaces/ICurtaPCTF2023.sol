// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title The interface for {CurtaPCTF2023}
interface ICurtaPCTF2023 {
    // -------------------------------------------------------------------------
    // Errors
    // -------------------------------------------------------------------------

    /// @notice Emitted when a token hasn't been minted.
    error TokenUnminted();

    // -------------------------------------------------------------------------
    // Events
    // -------------------------------------------------------------------------

    /// @notice Emitted when the base URI is set.
    /// @param baseURI The new base URI.
    event SetBaseURI(string baseURI);

    // -------------------------------------------------------------------------
    // Storage
    // -------------------------------------------------------------------------

    /// @dev If `baseURI` is unset, `tokenURI` will directly return the URI
    /// generated onchain via {CurtaPCTF2023._tokenURI(uint256)}. Otherwise, it
    /// will return `baseURI + tokenId`.
    /// @return The base URI for the token collection.
    function baseURI() external view returns (string memory);

    // -------------------------------------------------------------------------
    // Functions
    // -------------------------------------------------------------------------

    /// @notice Mints a token to the sender.
    /// @dev The sender must have been a player on the Curta ^ Paradigm CTF 2023
    /// team (it will revert otherwise).
    function mint() external;

    /// @notice Sets the base URI for the token collection.
    /// @dev This function can only be called by the contract owner.
    /// @param _baseURI The new base URI for the token collection.
    function setBaseURI(string calldata _baseURI) external;

    // TODO: get sound value at
    // TODO: get wav file header at

    // -------------------------------------------------------------------------
    // Metadata
    // -------------------------------------------------------------------------

    /// @notice Returns the contract URI for this contract.
    /// @return The contract URI for this contract.
    function contractURI() external view returns (string memory);
}
