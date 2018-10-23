


The Local-game Matching Algorithm
===
Description
---
The local matching algorithm aims to find the control paths as to solve the structural controllability problem in complex network.
The detailed information about the LM algorithm is available in the main paper and supplementary information. \
For more detailed information about the LM algorithm, you can refer to \
[Enabling Controlling Complex Networks with Local Topological Information](https://www.nature.com/articles/s41598-018-22655-5)\
\
Here is a brief introduction to the proposed algorithm: \
\
When a node is seeking for a match, we define the number of its unmatched child (parent) nodes, i.e.,
the nodes that have not yet achieved a match with a parent (child), as its u-output (u-input) degree.
Denote  the u-input and u-output degrees of 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_i" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_i" title="x_i" /></a>
as 
<a href="http://www.codecogs.com/eqnedit.php?latex=N^{u-in}(x_i)" target="_blank"><img src="http://latex.codecogs.com/svg.latex?N^{u-in}(x_i)" title="N^{u-in}(x_i)" /></a>
and 
<a href="http://www.codecogs.com/eqnedit.php?latex=N^{u-out}(x_i)" target="_blank"><img src="http://latex.codecogs.com/svg.latex?N^{u-out}(x_i)" title="N^{u-out}(x_i)" /></a>
, respectively. We denote the minimum u-input degree of 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_i" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_i" title="x_i" /></a>
's unmatched child nodes as 
<a href="http://www.codecogs.com/eqnedit.php?latex=\min&space;\{N^{u-in}(x_i)\}" target="_blank"><img src="http://latex.codecogs.com/svg.latex?\min&space;\{N^{u-in}(x_i)\}" title="\min \{N^{u-in}(x_i)\}" /></a>
, and the minimum u-output degree of 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_i" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_i" title="x_i" /></a>
's unmatched parent nodes as 
<a href="http://www.codecogs.com/eqnedit.php?latex=\min&space;\{N^{u-out}(x_i)\}" target="_blank"><img src="http://latex.codecogs.com/svg.latex?\min&space;\{N^{u-out}(x_i)\}" title="\min \{N^{u-out}(x_i)\}" /></a>.\
\
Figure 1 illustrates  the flowchart of the LM algorithm containing the following three components:

1. ***Child locating***: Each node without  a matched child node sends a child request to  its  neighboring child node (including itself if there exists a self-loop link to the
node)  with the minimum u-input degree 
<a href="http://www.codecogs.com/eqnedit.php?latex=\min&space;\{N^{u-in}(x_i)\}" target="_blank"><img src="http://latex.codecogs.com/svg.latex?\min&space;\{N^{u-in}(x_i)\}" title="\min \{N^{u-in}(x_i)\}" /></a>
.  When there is a tie, i.e.,
a node has multiple unmatched child nodes with the same minimum
u-input degree, the node either  holds on at a probability 
<a href="http://www.codecogs.com/eqnedit.php?latex=w" target="_blank"><img src="http://latex.codecogs.com/svg.latex?w" title="w" /></a>
or randomly breaks the tie.

2. ***Parent locating***: Each node without a matched parent node
sends a parent request to the neighboring parent node  (including itself if there exists a self-loop link to the
node)  with the minimum
u-output degree 
<a href="http://www.codecogs.com/eqnedit.php?latex=\min&space;\{N^{u-out}(x_i)\}" target="_blank"><img src="http://latex.codecogs.com/svg.latex?\min&space;\{N^{u-out}(x_i)\}" title="\min \{N^{u-out}(x_i)\}" /></a>
.  When there is a tie, i.e.,
  a node has multiple unmatched parent nodes with the same minimum
u-output degree,   the node either holds on at a probability 
<a href="http://www.codecogs.com/eqnedit.php?latex=w" target="_blank"><img src="http://latex.codecogs.com/svg.latex?w" title="w" /></a>
or randomly breaks the tie.

3. ***Matching***: When there is a match of requests, i.e., two nodes receive each other's parent/child request,  a
parent-child match is achieved and fixed. The child node in this match
removes all its links to other parent nodes, and the u-output degrees of those
parent nodes are reduced by 1. The parent node in this match removes all
of its links to other child nodes, and the u-input degrees of those child nodes
are reduced by 1.

`Figure 1`
<div align=center><img width="500" height="362" src="/Figure/Figure-1.png" alt="Figure 1"/></div>

The iterative request-matching operations in the LM algorithm  continue  until no more child/parent match can be achieved.

Files
---
* ./Code/BA1000u3.mat -----> a 1000-node BA complex network data with 3 mean degree (mat-data)
* ./Code/ER1000u3.mat -----> a 1000-node ER complex network data with 3 mean degree (mat-data)
* ./Code/LM_main.m -----> the main script code of local-game matching algorithm (code)
* ./Code/Min_Child.m	-----> the function code to find all the children of node 'parent_index', and return the ones with least parents (code)
* ./Code/Min_Parent.m -----> the function code to find all the parents of node 'child_index', and return the ones with least children (code)
* ./Code/children_count.m -----> the function code to return the number of parents of node 'child_index' (code)
* ./Code/parent_count.m -----> the function code to return the number of children of node 'parent_index' (code)
* ./Figure/Figure-1.png -----> figure 1 (figure)
* ./Figure/Figure-2.png -----> figure 2 (figure)

Example
---
You can run the local-game matching algorithm by running ***the main script code*** `LM_main.m` and the detailed annotation about the algorithm
is inside the script.

Here is a simple example to help you understand the matching process of local-game matching:

In this example in Figure 2, it is interesting to observe that
LM manages to reach the same final answer with the minimum number of
driver nodes  through a few different paths. Specifically,
for node 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_2" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_2" title="x_2" /></a>
, as 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_5" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_5" title="x_5" /></a>
and 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_7" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_7" title="x_7" /></a>
have the same number of input links, they have the equal chance to
be selected as 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_2" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_2" title="x_2" /></a>
's child node;  and for node 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_6" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_6" title="x_6" /></a>
, as 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_5" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_5" title="x_5" /></a>
 and 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_9" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_9" title="x_9" /></a>
 have the same number of output links, they have the equal chance to
be selected as 
<a href="http://www.codecogs.com/eqnedit.php?latex=x_6" target="_blank"><img src="http://latex.codecogs.com/svg.latex?x_6" title="x_6" /></a>
's  parent node.
In LM,  each node has a waiting probability 
<a href="http://www.codecogs.com/eqnedit.php?latex=w" target="_blank"><img src="http://latex.codecogs.com/svg.latex?w" title="w" /></a>
to hold on when there is a tie. As some edges may be removed in the iteration process, the tie may be broken. As illustrated in Figure 2, there may be 4 different cases with different tie-breaking process, 
which however lead to the same number of driver nodes in this example.

`Figure 2`
<div align=center><img width="600" height="929" src="/Figure/Figure-2.png" alt="Figure 2"/></div>

Contact
---
For any questions regarding Local-game Mathcing algorithm, please email:\
Tang Pei tangp14@mails.tsinghua.edu.cn
