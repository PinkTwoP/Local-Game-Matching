function [ parent_index, number ] = Min_Parent( A, child_index )
%Find all the parents of node 'child_index', and return the ones with least children
global par chi;
parents = find(A(:,chi)==child_index);%Find the position of all the parents
if length(parents)==0 %if node 'child_index' has no parent, return NULL
    parent_index = [];
    number =0;
else
    N = length(parents); %N is the total number of its parents
    child_number = zeros(N,1);%Store the children number of all the parents
    %Count the parent number of all the children
    for i=1:N
        child_number(i) = parent_count(A,A(parents(i),par));
    end
    min_order = find(child_number == min(child_number));%Find the ones with least children
    parent_index = A(parents(min_order),par);
    number = length(parent_index);
end

end

