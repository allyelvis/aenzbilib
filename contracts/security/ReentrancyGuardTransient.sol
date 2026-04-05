// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title ReentrancyGuardTransient
/// @notice A gas-efficient reentrancy guard using EIP-1153 transient storage.
abstract contract ReentrancyGuardTransient {
    error ReentrancyAttempted();

    bytes32 private constant _REENTRANCY_SLOT = keccak256("aenzbi.security.reentrancy");

    modifier nonReentrant() {
        assembly {
            if tload(_REENTRANCY_SLOT) {
                mstore(0x00, 0x1bfb8b4b)
                revert(0x1c, 0x04)
            }
            tstore(_REENTRANCY_SLOT, 1)
        }
        
        _;
        
        assembly {
            tstore(_REENTRANCY_SLOT, 0)
        }
    }
}
