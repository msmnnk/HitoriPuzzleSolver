% Mariia Semenenko
% Student ID: 22100679

% Each cell can either be shaded or unshaded but not both.
% The curly braces indicate a choice between the two possibilities.
% The "== 1" operator specifies that only one of them can be true.
  { shaded(R,C) ; not shaded(R,C) } == 1 :- cell(R,C,_).

% RULE 1. No number appears more than once in a row or column.
% If there exist two cells in the same row or column,
% that are not shaded and have the same number,
% this is a violation of the rule and cannot be the case.
% for the same row (horizontally)
  :- cell(R,C,N), not shaded(R,C), cell(R,C1,N), not shaded(R,C1), C!=C1.
% for the same column (vertically)
  :- cell(R,C,N), not shaded(R,C), cell(R1,C,N), not shaded(R1,C), R!=R1.

% Define a predicate adjacent/4, which specifies the conditions under which
% two cells are considered adjacent (they share the same row or column).
% for the cell above (same column, one row immediately above another)
  adjacent(R,C,R1,C) :- cell(R,C,_), cell(R1,C,_), R1==R+1.
% for the cell below (same column, one row immediately below another)
  adjacent(R,C,R1,C) :- cell(R,C,_), cell(R1,C,_), R1==R-1.
% for the cell on the right (same row, one column immediately right)
  adjacent(R,C,R,C1) :- cell(R,C,_), cell(R,C1,_), C1==C+1.
% for the cell on the left (same row, one column immediately left)
  adjacent(R,C,R,C1) :- cell(R,C,_), cell(R,C1,_), C1==C-1.

% RULE 2. The shaded cells cannot be horizontally or vertically adjacent.
% If there exist two cells that are shaded and adjacent horizontally or vertically,
% this is a violation of the rule and cannot be the case.
  :- cell(R,C,_), shaded(R,C), cell(R1,C1,_), shaded(R1,C1), adjacent(R,C,R1,C1).

% Define a predicate connected/4, which specifies the conditions under which
% two cells are considered connected.
% condition 1: if two cells are adjacent.
  connected(R,C,R1,C1) :- cell(R,C,_), cell(R1,C1,_), adjacent(R,C,R1,C1).
% condition 2: if there is a path from (R, C) to (R2, C2) through other cells,
% such as there exists another cell (R1,C1) connected to both (R,C) and (R2,C2).
  connected(R,C,R2,C2) :- connected(R,C,R1,C1), connected(R1,C1,R2,C2).

% RULE 3. The unshaded cells must be connected to each other, i.e. any unshaded cell
% is reachable from another unshaded cell by vertical or horizontal movements.
% If there exist two cells that are not shaded and not connected,
% this is a violation of the rule and cannot be the case.
  :- cell(R,C,_), not shaded(R,C), cell(R1,C1,_), not shaded(R1,C1),
     not connected(R,C,R1,C1), (R,C) != (R1,C1).

% Define a predicate called cellblack/2, which is used to output the solution and
% specifies a cell is black if and only if the shaded/2 predicate holds for that cell.
  cellblack(R,C) :- cell(R,C,_), shaded(R,C).

% Specify that only one solution should be output,
% and it should be the minimum number of black cells.
  #minimize {1, R, C : cellblack(R, C)}.
  #show cellblack/2.