%LM algorithm

clear all;
clc;
tic; 

global par;
global chi;
par = 1; chi = 2;

load BA1000u3;
dataset_name = 'BA1000u3';
%the dataset should be stored as a list of edges, i.e. a matrix of N*2
%the first column is the node index of parents, and the second one is that
%of children

Lonely_Nodes = unique(A); %initialize the lonely nodes, i.e. nodes with no parents & children
Edges_Total = size(A,1)
Nodes_Total = length(Lonely_Nodes)
Mean_Degree = Edges_Total/Nodes_Total
A_match = []; %initialize the matched edge list
A_unmatch = A; %initialize the unmatched edge list
clear A;
[m n] = size(A_unmatch);
A_Request = zeros(m,n);%Store the matching requests of unmatched nodes
Parents_Available = unique(A_unmatch(:,par));%Available parent nodes
Children_Available = unique(A_unmatch(:,chi));%Available children nodes
w = 0; %waiting probability 

k = 0;
%while until A_unmatch = []
while 1 
    k = k + 1;
    fprintf('No.%d epoch\n',k);
    
    fprintf('No.%d epoch: Child Locating with %d unmatched parents\n',k,length(Parents_Available));
    %STEP 1£ºChild Locating phase
    for i=1:length(Parents_Available)
        [child_index number] = Min_Child(A_unmatch,Parents_Available(i));
        %Return the children of node 'Parents_Available(i)' with least parents
        
        %If the number of desired children is one, send a matching request
        if number==1
            order1 = find(A_unmatch(:,par)==Parents_Available(i));
            order2 = find(A_unmatch(:,chi)==child_index);
            order = intersect(order1,order2);%Find the index of the child
            A_Request(order,chi) = 1;%Send a request to the child
        end
        %If the number of desired children is larger than one, wait or
        %randomly choose one child to send request
        if number>1
            if rand<w
                continue;
            else
                pos = randi([1 number],1,1);
                order1 = find(A_unmatch(:,par)==Parents_Available(i));
                order2 = find(A_unmatch(:,chi)==child_index(pos));
                order = intersect(order1,order2);%%Find the index of the randomly choosed child
                A_Request(order,chi) = 1;%Send a request to the child
            end
        end
    end
    
    fprintf('No.%d epoch: Parent Locating with %d unmatched children\n',k,length(Children_Available));
    %STEP 2£ºParent Locating phase
    for i=1:length(Children_Available)
        [parent_index number] = Min_Parent(A_unmatch,Children_Available(i));
        %Return the parents of node 'Children_Available(i)' with least children
        
        %If the number of desired parents is one, send a matching request
        if number==1
            order1 = find(A_unmatch(:,chi)==Children_Available(i));
            order2 = find(A_unmatch(:,par)==parent_index);
            order = intersect(order1,order2);%Find the index of the parent
            A_Request(order,par) = 1;%Send a request to the parent
        end
        %If the number of desired parents is larger than one, wait or
        %randomly choose one parent to send request
        if number>1
            if rand<w 
                continue;
            else
                pos = randi([1 number],1,1);
                order1 = find(A_unmatch(:,chi)==Children_Available(i));
                order2 = find(A_unmatch(:,par)==parent_index(pos));
                order = intersect(order1,order2);%Find the index of the parent
                A_Request(order,par) = 1;%Send a request to the parent
            end
        end
    end
    
    fprintf('No.%d epoch: Matching with total %d edges\n',k,m);
    %STEP 3£ºMatching phase
    Equal = ones(1,n);%a mask the both the parent and child send a request to each other
    delete_order = [];%record the edges that should be deleted
    for i=1:m
        %Judge whether the edge is matched
        if isequal(A_Request(i,:),Equal)==1%If a parent and child send a request to each other, this edge matches
            A_match = [A_match;A_unmatch(i,:)];
            order1 = find(A_unmatch(:,par)==A_unmatch(i,par));%delete all the edges with the parent node
            order2 = find(A_unmatch(:,chi)==A_unmatch(i,chi));%delete all the edges with the child node 
            
            order = union(order1,order2);
            delete_order = union(delete_order,order);
            
            %If a node has match, it is not a lonely node that should be
            %deleted from the lonely nodes set
            order5 = find(Lonely_Nodes==A_unmatch(i,par));
            order6 = find(Lonely_Nodes==A_unmatch(i,chi));
            order = union(order5,order6);
            Lonely_Nodes(order) = [];
        end
    end
    A_unmatch(delete_order,:) = [];
    A_Request(delete_order,:) = [];
    [m n] = size(A_unmatch);%update the size of unmatched edge list
    
    if m~=0
        A_Request = zeros(m,n);
        Parents_Available = unique(A_unmatch(:,par));%update available parents
        Children_Available = unique(A_unmatch(:,chi));%update available children
    else
        break;
    end
       
end


%driver node has a child but no parent
Driver_Nodes = setdiff(A_match(:,par),A_match(:,chi));
%all the drive nodes and lonely nodes should be controlled
Control_Nodes = union(Lonely_Nodes,Driver_Nodes);

NumberOfLength = length(Control_Nodes)


time = toc;