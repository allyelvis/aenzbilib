// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Aenzbi Math
/// @notice Yul-optimized mathematical operations.
library Math {
    /// @notice Returns the largest of two numbers
        function max(uint256 a, uint256 b) internal pure returns (uint256 result) {
                assembly {
                            result := sub(a, and(sub(a, b), lt(a, b)))
                                    }
                                        }

                                            /// @notice Returns the smallest of two numbers
                                                function min(uint256 a, uint256 b) internal pure returns (uint256 result) {
                                                        assembly {
                                                                    result := sub(a, and(sub(a, b), gt(a, b)))
                                                                            }
                                                                                }

                                                                                    /// @notice Calculates the square root of a number using the Babylonian method
                                                                                        function sqrt(uint256 a) internal pure returns (uint256 result) {
                                                                                                if (a == 0) return 0;
                                                                                                        
                                                                                                                assembly {
                                                                                                                            result := 1
                                                                                                                                        let x := a
                                                                                                                                                    
                                                                                                                                                                // Initial guess based on bit length
                                                                                                                                                                            if iszero(lt(x, 0x100000000000000000000000000000000)) { x := shr(128, x) result := shl(64, result) }
                                                                                                                                                                                        if iszero(lt(x, 0x10000000000000000)) { x := shr(64, x) result := shl(32, result) }
                                                                                                                                                                                                    if iszero(lt(x, 0x100000000)) { x := shr(32, x) result := shl(16, result) }
                                                                                                                                                                                                                if iszero(lt(x, 0x10000)) { x := shr(16, x) result := shl(8, result) }
                                                                                                                                                                                                                            if iszero(lt(x, 0x100)) { x := shr(8, x) result := shl(4, result) }
                                                                                                                                                                                                                                        if iszero(lt(x, 0x10)) { x := shr(4, x) result := shl(2, result) }
                                                                                                                                                                                                                                                    if iszero(lt(x, 0x8)) { result := shl(1, result) }

                                                                                                                                                                                                                                                                // Newton-Raphson iterations
                                                                                                                                                                                                                                                                            result := shr(1, add(result, div(a, result)))
                                                                                                                                                                                                                                                                                        result := shr(1, add(result, div(a, result)))
                                                                                                                                                                                                                                                                                                    result := shr(1, add(result, div(a, result)))
                                                                                                                                                                                                                                                                                                                result := shr(1, add(result, div(a, result)))
                                                                                                                                                                                                                                                                                                                            result := shr(1, add(result, div(a, result)))
                                                                                                                                                                                                                                                                                                                                        result := shr(1, add(result, div(a, result)))
                                                                                                                                                                                                                                                                                                                                                    result := shr(1, add(result, div(a, result)))

                                                                                                                                                                                                                                                                                                                                                                // Ensure rounding down
                                                                                                                                                                                                                                                                                                                                                                            let roundedDown := div(a, result)
                                                                                                                                                                                                                                                                                                                                                                                        if lt(roundedDown, result) {
                                                                                                                                                                                                                                                                                                                                                                                                        result := roundedDown
                                                                                                                                                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                                                                                                                                                