function [ number ] = children_count( A, child_index )
%Return the number of parents of node 'child_index', the index starts from 1
global chi;
number = length(find(A(:,chi)==child_index));

end

