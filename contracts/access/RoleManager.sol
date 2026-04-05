// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title Aenzbi RoleManager
/// @notice Bitmask-based access control. Supports up to 256 roles per address.
abstract contract RoleManager {
    error Unauthorized();
        error RoleAlreadyGranted();
            error RoleNotGranted();

                // mapping(address => bitmask of roles)
                    mapping(address => uint256) private _roles;

                        event RoleGranted(address indexed account, uint8 indexed role);
                            event RoleRevoked(address indexed account, uint8 indexed role);

                                /// @notice Checks if an account has a specific role (0-255)
                                    function hasRole(address account, uint8 role) public view returns (bool) {
                                            return (_roles[account] & (1 << role)) != 0;
                                                }

                                                    /// @notice Modifier to restrict access to a specific role
                                                        modifier onlyRole(uint8 role) {
                                                                if (!hasRole(msg.sender, role)) revert Unauthorized();
                                                                        _;
                                                                            }

                                                                                /// @dev Internal function to grant a role
                                                                                    function _grantRole(address account, uint8 role) internal virtual {
                                                                                            if (hasRole(account, role)) revert RoleAlreadyGranted();
                                                                                                    _roles[account] |= (1 << role);
                                                                                                            emit RoleGranted(account, role);
                                                                                                                }

                                                                                                                    /// @dev Internal function to revoke a role
                                                                                                                        function _revokeRole(address account, uint8 role) internal virtual {
                                                                                                                                if (!hasRole(account, role)) revert RoleNotGranted();
                                                                                                                                        _roles[account] &= ~(1 << role);
                                                                                                                                                emit RoleRevoked(account, role);
                                                                                                                                                    }
                                                                                                                                                    }
                                                                                                                                                    