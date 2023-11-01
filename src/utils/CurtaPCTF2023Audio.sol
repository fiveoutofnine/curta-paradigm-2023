// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// @title Curta ^ Paradigm CTF 2023 commemorative NFT auditory art
/// @notice A library for generating onchain audio for {CurtaPCTF2023}.
/// @dev The metadata returned by {CurtaPCTF2023} doesn't use this library for
/// practical reasons. However, the same result can be yielded by calling
/// {getSoundValueAtSample} for each sample in the range `[0, 1572863]` and
/// concatenating the result, prefixed with the header returned by
/// {getAudioWavFileHeader}.
library CurtaPCTF2023Audio {
    /// @notice Returns the WAV file header for the audio file for 1 full cycle
    /// of the token's sound with the parameters the token's sound was generated
    /// with:
    ///     * Size: 196.61735kB (1572910 bytes) = 98.304s (1572864/8000/2)
    ///     * Number of channels: 1
    ///     * Sample rate: 8000Hz
    ///     * Bits/sample: 16 bits/sample
    function getAudioWavFileHeader() internal pure returns (bytes memory) {
        // Note: base-64 encoding the following hex string yields:
        // "UklGRi4AGABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQAAGACA".
        return
        // "RIFF" chunk descriptor
        hex"52" hex"49" hex"46" hex"46" // "RIFF" in ASCII
        hex"2e" hex"00" hex"18" hex"00" // Size of the file (length of data chunk + 46 for the header) = 1572864 + 46 = 1572910
        hex"57" hex"41" hex"56" hex"45" // "WAVE" in ASCII
        // "fmt " sub-chunk
        hex"66" hex"6d" hex"74" hex"20" // "fmt " in ASCII
        hex"10" hex"00" hex"00" hex"00" // Length of sub-chunk 1 = 16
        hex"01" hex"00" hex"01" hex"00" // Audio format = 1 (PCM), Number of channels = 1
        hex"40" hex"1f" hex"00" hex"00" // Sample rate = 8000Hz
        hex"40" hex"1f" hex"00" hex"00" // Byte rate (sample rate * bits/sample * channels) = 8000 * 1 * 1 = 8000 bytes/sec
        hex"01" hex"00" hex"10" hex"00" // Block align = 1, bits/sample = 16
        // "data" sub-chunk
        hex"64" hex"61" hex"74" hex"61" // "data" in ASCII
        hex"00" hex"00" hex"18" hex"00" // Length of data chunk = (3 * 2 ** 18 * 16 / 8) = 1572864 bytes
        hex"80"; // Sample 1
    }

    /// @notice Returns the sound value at a given time tick in the audio.
    /// @dev {CurtaPCTF2023}'s audio was generated at a sample rate of 8000Hz,
    /// which means that `_tick` increments by 1 every 1/8000 seconds.
    /// @param _tick The number of samples since the beginning of the audio at
    /// a frequency of 8000Hz to get the sound value at.
    /// @return The sound value at the given time tick, a value in the range
    /// `[0, 255]` (higher means louder).
    function getSoundValueAtSample(uint256 _tick) internal pure returns (bytes2) {
        return hex"80"; // TODO
    }
}
