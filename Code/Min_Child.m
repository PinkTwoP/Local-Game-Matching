function [ child_index, number ] = Min_Child( A, parent_index )
%Find all the children of node 'parent_index', and return the ones with least parents
global par chi;
children = find(A(:,par)==parent_index);%Find the position of all the children
if length(children)==0 %if node 'parent_index' has no child, return NULL
    child_index = [];
    number =0;
else
    N = length(children); %N is the total number of its children
    parent_number = zeros(N,1);%Store the parent number of all the children
    %Count the parent number of all the children
    for i=1:N
        parent_number(i) = children_count(A,A(children(i),chi));
    end
    min_order = find(parent_number == min(parent_number));%find the ones with least parents
    child_index = A(children(min_order),chi);
    number = length(child_index);
end

end

