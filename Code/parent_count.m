function [ number ] = parent_count( A, parent_index )
%Return the number of children of node 'parent_index', the index starts from 1
global par;
number = length(find(A(:,par)==parent_index));

end

