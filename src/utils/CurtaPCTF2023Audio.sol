// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {FixedPointMathLib as Math} from "solady/utils/FixedPointMathLib.sol";

/// @title Curta ^ Paradigm CTF 2023 commemorative NFT auditory art
/// @notice A library for generating onchain audio for {CurtaPCTF2023}, which is
/// a 1:38 minute long audio arrangement of "In the Hall of the Mountain King"
/// by Edvard Grieg with layered melody lines and a bass line at 117.1875 BPM.
/// @dev The metadata returned by {CurtaPCTF2023} doesn't use this library for
/// practical reasons. However, the same result can be yielded by calling
/// {getSoundValueAtSample} for each sample in the range `[0, 786432]` and
/// concatenating the result, prefixed with the header returned by
/// {getAudioWavFileHeader}.
library CurtaPCTF2023Audio {
    using Math for int256;
    using Math for uint256;

    // -------------------------------------------------------------------------
    // Constants
    // -------------------------------------------------------------------------

    /// @notice A bitpacked `uint256` of 8 bitpacked segments of 8-bit words
    /// representing quarter note pitch values for the bass line, where the note
    /// C3 has avalue of 62, and 1 is a semitone.
    uint256 constant BASS_NOTES = 0x332C3028332C332C2F282F282C252C252C252C252C252C25;

    /// @notice A bitpacked `uint256` of 8-bit words representing eigth note
    /// pitch values, for the melody line, where the note C3 has a value of 50,
    /// and 1 is a semitone.
    uint256 constant MELODY_NOTES = 0x2F2F2F2F2C282C2F312C282C2A2827252A2A262A2B2B272B2C2C282C2A282725;

    /// @notice A bitpacked `uint256` of 8-bit words representing tranpositions,
    /// to perform on the melody line every 2**16 samples, where 1 is a
    /// semitone.
    uint256 constant MELODY_TRANSPOSITIONS = 0x13070C00;

    // -------------------------------------------------------------------------
    // Functions
    // -------------------------------------------------------------------------

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
    /// which means that `_tick` increments by 1 every 1/8000 seconds. A full
    /// cycle of the audio is 3*2**18 = 786432 samples long, so `_tick` wraps
    /// around every 786432 samples (i.e. same values for equivalent
    /// `_tick % 786432`).
    /// @param _tick The number of samples since the beginning of the audio at
    /// a frequency of 8000Hz to get the sound value at.
    /// @return The sound value at the given time tick, a value in the range
    /// `[0, 255]` (higher means louder).
    function getSoundValueAtSample(uint256 _tick) internal pure returns (uint8) {
        // This function is equivalent to the following JavaScript code:
        // ```js
        // const getSoundValueAtSample = (tick) => {
        //   const transformValue = (v) => v & 256 ? v & 255 : 256 - (v & 255);
        //   const iteration = (tick >> 18) % 3;
        //   const melodyLine1 = 30 * tick * 2 ** (
        //     (
        //       "%'(*,(,,+'++*&**%'(*,(,1/,(,////".charCodeAt(tick >> 11 & 31) // Theme
        //         + [0, 12, 7, 19][tick >> 16 & 3]) / 12 - 6 // Adjustment
        //   );
        //   const bassLine = 30 * tick * 2 ** (
        //     ("%,%,%,%,%,%,(/(/,3,3(0,3".charCodeAt(
        //       8 * (tick >> 17 & 1 ? 2 : tick >> 15 & 1) + (tick >> 12 & 7)
        //     )) / 12 - 7
        //   );
        //   const melodyLine2 = melodyLine1 * 2;
        //   const melodyLine3 = melodyLine2 * 2;
        //   return transformValue(melodyLine1) / (5 - (iteration > 1))
        //     + (iteration > 0) / 5 * transformValue(melodyLine2)
        //     + (iteration > 1) * (transformValue(melodyLine3) / 5
        //     + transformValue(bassLine) / 4);
        // }
        // ```

        // Calculate the pitch of the value of the melody line at `_tick` as an
        // 18 decimal fixed point value in the range `[0, 255e18]`.
        int256 melody1 = int256(30 * _tick) * int256(2e18).powWad(
            (1e18 * int256(
                // Each note is 2**11 samples long (an eighth note at 117.1875
                // BPM), so `_tick >> 11`. Then, we take `% 32` because the
                // melody line is 32 notes long.
                ((MELODY_NOTES >> (((_tick >> 11) & 31) << 3)) & 0xFF)
                    // We adjust the melody's theme by transposing the theme
                    // by the corresponding amount every 2**16 samples. By
                    // adding to the pitch fetched for the melody line, we
                    // effectively repeat the theme 4 times with different
                    // transpositions.
                    + ((MELODY_TRANSPOSITIONS >> (((_tick >> 16) & 3) << 3)) & 0xFF)
            )) / 12 - int256(6e18)
        );
        // Calculate the pitch of the value of the bass line at `_tick` as an 18
        // decimal fixed point value in the range `[0, 255e18]`.
        int256 bass = int256(30 * _tick) * int256(2e18).powWad(
            (1e18 * int256(
                (BASS_NOTES >> (
                    // Calculate the starting offset of the bass line segment to
                    // read from. We want to read the segments in the following
                    // order: 0, 1, 0, 1, 2, 2, 2, 2. Each segment is 8 quarter
                    // notes long, or 2**15 samples long, so we can achieve this
                    // sequence by returning 2 if `(_tick >> 17) & 1` is 1, or
                    // taking the last bit of `_tick >> 15` otherwise.
                    ((((_tick >> 17) & 1 == 1) ? 2 : (_tick >> 15) & 1) << 3)
                        // Each note is 2**12 samples long (a quarter note at
                        // 117.1875 BPM), so `_tick >> 12`. Then, we take
                        // `% 8` because each segment of the bass line we read
                        // from is 8 notes long.
                        + ((_tick >> 12) & 7)
                )) & 0xFF
            )) / 12 - int256(7e18)
        );
        // Same as the first melody line, except 1 octave higher.
        int256 melody2 = melody1 * 2;
        // Same as the first melody line, except 2 octaves higher.
        int256 melody3 = melody2 * 2;

        // Truncate and transform pitch values to integer triangle wave values
        // in the range `[0, 255]` for a more pleasant sound.
        uint256 transformedMelody1 = _toTruncatedTriangleWaveValue(melody1);
        uint256 transformedBass = _toTruncatedTriangleWaveValue(bass);
        uint256 transformedMelody2 = _toTruncatedTriangleWaveValue(melody2);
        uint256 transformedMelody3 = _toTruncatedTriangleWaveValue(melody3);

        // We want to vary the loudness of each line every 2**18 samples in the
        // following volume (loudness) progressions, where 0 is the quietest
        // and 1 is the loudest:
        //                .-------------------------------------.
        //                | Line     | Rep. 0 | Rep. 1 | Rep. 2 |
        //                |----------|--------|--------|--------|
        //                | Melody 1 | 0.20   | 0.20   | 0.25   |
        //                | Melody 2 | 0.00   | 0.20   | 0.20   |
        //                | Melody 3 | 0.00   | 0.00   | 0.20   |
        //                | Bass     | 0.00   | 0.00   | 0.25   |
        //                |----------|--------|--------|--------|
        //                | TOTAL    | 0.20   | 0.40   | 0.90   |
        //                '-------------------------------------'
        // We achieve this with the following expression, which the `assembly`
        // block below is equivalent to:
        /// ```solidity
        // (
        //     (4 + iteration > 1) * transformedMelody1           
        //         + 4 * (iteration > 0) * transformedMelody2
        //         + 4 * (iteration > 1) * transformedMelody3
        //         + 5 * (iteration > 1) * transformedBass
        // ) / 20
        // ```
        uint256 iteration = (_tick >> 18) % 3;
        uint8 soundValue;
        assembly {
            soundValue := and(
                div(
                    add(
                        add(
                            mul(add(4, gt(iteration, 1)), transformedMelody1),
                            mul(mul(4, gt(iteration, 0)), transformedMelody2)
                        ),
                        add(
                            mul(mul(4, gt(iteration, 1)), transformedMelody3),
                            mul(mul(5, gt(iteration, 1)), transformedBass)
                        )
                    ),
                    20
                ),
                0xFF
            )
        }

        return soundValue;
    }

    /// @notice Truncate an 18 decimal fixed point value `_value`'s decimal
    /// component, and transform it to be on a triangle wave in the range
    /// `[0, 255]`.
    /// @param _value The 18 decimal fixed point value to transform.
    /// @return The truncated and transformed value in the range `[0, 255]`.
    function _toTruncatedTriangleWaveValue(int256 _value) internal pure returns (uint256) {
        uint256 truncatedValue;
        assembly {
            // `_value` can never be negative, so we can safely assign it
            // to a `uint256` value.
            truncatedValue := div(_value, 1000000000000000000) // 1e18
        }

        unchecked {
            return truncatedValue & 0x100 > 0
                ? truncatedValue & 0xFF
                : 256 - (truncatedValue & 0xFF); // Will never underflow.
        }
    }
}
