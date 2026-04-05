// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title AenzbiERC721
/// @notice Modern, gas-optimized ERC721 implementation.
abstract contract AenzbiERC721 {
    error NotOwnerOrApproved();
        error InvalidRecipient();
            error InvalidTokenId();
                error AlreadyMinted();
                    error UnsafeRecipient();

                        string public name;
                            string public symbol;

                                mapping(uint256 => address) internal _owners;
                                    mapping(address => uint256) internal _balances;
                                        mapping(uint256 => address) internal _tokenApprovals;
                                            mapping(address => mapping(address => bool)) internal _isApprovedForAll;

                                                event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
                                                    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
                                                        event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

                                                            constructor(string memory _name, string memory _symbol) {
                                                                    name = _name;
                                                                            symbol = _symbol;
                                                                                }

                                                                                    function ownerOf(uint256 id) public view virtual returns (address owner) {
                                                                                            owner = _owners[id];
                                                                                                    if (owner == address(0)) revert InvalidTokenId();
                                                                                                        }

                                                                                                            function balanceOf(address owner) public view virtual returns (uint256) {
                                                                                                                    if (owner == address(0)) revert InvalidRecipient();
                                                                                                                            return _balances[owner];
                                                                                                                                }

                                                                                                                                    function approve(address spender, uint256 id) public virtual {
                                                                                                                                            address owner = _owners[id];
                                                                                                                                                    if (msg.sender != owner && !_isApprovedForAll[owner][msg.sender]) {
                                                                                                                                                                revert NotOwnerOrApproved();
                                                                                                                                                                        }
                                                                                                                                                                                _tokenApprovals[id] = spender;
                                                                                                                                                                                        emit Approval(owner, spender, id);
                                                                                                                                                                                            }

                                                                                                                                                                                                function setApprovalForAll(address operator, bool approved) public virtual {
                                                                                                                                                                                                        _isApprovedForAll[msg.sender][operator] = approved;
                                                                                                                                                                                                                emit ApprovalForAll(msg.sender, operator, approved);
                                                                                                                                                                                                                    }

                                                                                                                                                                                                                        function transferFrom(address from, address to, uint256 id) public virtual {
                                                                                                                                                                                                                                if (to == address(0)) revert InvalidRecipient();
                                                                                                                                                                                                                                        address owner = _owners[id];
                                                                                                                                                                                                                                                if (owner != from) revert NotOwnerOrApproved();

                                                                                                                                                                                                                                                        bool isApprovedOrOwner = (msg.sender == owner || 
                                                                                                                                                                                                                                                                                         _tokenApprovals[id] == msg.sender || 
                                                                                                                                                                                                                                                                                                                          _isApprovedForAll[owner][msg.sender]);
                                                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                                                          if (!isApprovedOrOwner) revert NotOwnerOrApproved();

                                                                                                                                                                                                                                                                                                                                                  unchecked {
                                                                                                                                                                                                                                                                                                                                                              _balances[from] -= 1;
                                                                                                                                                                                                                                                                                                                                                                          _balances[to] += 1;
                                                                                                                                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                                                  _owners[id] = to;
                                                                                                                                                                                                                                                                                                                                                                                                          delete _tokenApprovals[id];

                                                                                                                                                                                                                                                                                                                                                                                                                  emit Transfer(from, to, id);
                                                                                                                                                                                                                                                                                                                                                                                                                      }

                                                                                                                                                                                                                                                                                                                                                                                                                          function _mint(address to, uint256 id) internal virtual {
                                                                                                                                                                                                                                                                                                                                                                                                                                  if (to == address(0)) revert InvalidRecipient();
                                                                                                                                                                                                                                                                                                                                                                                                                                          if (_owners[id] != address(0)) revert AlreadyMinted();

                                                                                                                                                                                                                                                                                                                                                                                                                                                  unchecked {
                                                                                                                                                                                                                                                                                                                                                                                                                                                              _balances[to] += 1;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                              _owners[id] = to;

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      emit Transfer(address(0), to, id);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          