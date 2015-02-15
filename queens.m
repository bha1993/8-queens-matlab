function logMatrix = queens
%Hello and thank you for reading!
%My name is Brian Ha and I am an EECS and MechE dual major at UC
%Berkeley! MATLAB was difficult for me to pick up again, but let me now
%explain my code: 
%
%I had lots of trouble understanding the textbook
%pseudocode, so I took lots of liberties in my own solution. I first
%created a solution matrix to store the 8x8 logical matrices. Then I
%created two 8x8 matrices to represent the current queens' positions and
%the current availability of the board. The reference suggested using only
%one board but I didn't understand how to possibly do that.
%
%Then I followed the given psuedocode which basically consists of iterating 
%through all the possible spots in the row corresponding to the given
%rowNum argument, checking if that spot/position is available, and if so
%placing a queen there - upon which I would snapshot the current board layout, change
%avail_board to reflect the availability after placing the queen, do the 8
%queen check, and ultimately remove the queen and revert avail_board to its
%original state. Every time the condition of 8 queens was reached, I could
%add the current snapshot of queen_board to my soln_mat. I created a
%setRowColAndDiagonals function to take care of changing avail_board to
%reflect the addition of a new queen.

    n = 1;
    soln_mat = [];

    queen_board = zeros(8, 8);
    avail_board = ones(8, 8);
    
    %first call to putQueen with initial rowNum value of 1
    putQueen(1);
    
    %change the output type to logical to satisfy requirements
    logMatrix = logical(soln_mat);

    function putQueen(rowNum)
        colNum = 0;
        
        %iterate through the current row indicated by rowNum
        for colElem = avail_board(rowNum,:)
            %I was too lazy to write another loop so I use a variable to
            %keep track of the column number
            colNum = colNum + 1;
            %if the current position is available
            if colElem == 1
                queen_board(rowNum, colNum) = 1;
                %take a snapshot of the board that we will revert to after
                %removing the most recently added queen
                temp_board = avail_board;
                % set avail_board's queen pos, row, col, diags to 0 since
                % now all of those are unavailable on the board
                setRowColAndDiagonals(rowNum, colNum, 0)
                if rowNum < 8
                    putQueen(rowNum + 1);
                else
                    soln_mat(:,:,n) = queen_board;
                    n = n + 1;
                end
                %remove the queen and revert to snapshot
                queen_board(rowNum, colNum) = 0;
                avail_board = temp_board;
            end
        end
    end

    %manually set the availability according to queen added at (rn, cn)
    %I included setOption though in this case it is always called with a
    %value of 0
    function setRowColAndDiagonals(rn, cn, setOption)
        avail_board(rn, :) = setOption;
        avail_board(:, cn) = setOption;
        
        %set upper left diagonal values
        ulrn = rn;
        ulcn = cn;
        while ulrn > 1 && ulcn > 1
            ulrn = ulrn - 1;
            ulcn = ulcn - 1;
            avail_board(ulrn, ulcn) = setOption;
        end
        
        %set upper right diagonal values
        urrn = rn;
        urcn = cn;
        while urrn > 1 && urcn < 8
            urrn = urrn - 1;
            urcn = urcn + 1;
            avail_board(urrn, urcn) = setOption;
        end
        
        %set lower left diagonal values
        llrn = rn;
        llcn = cn;
        while llrn < 8 && llcn > 1
            llrn = llrn + 1;
            llcn = llcn - 1;
            avail_board(llrn, llcn) = setOption;
        end
        
        %set lower right diagonal values
        lrrn = rn;
        lrcn = cn;
        while lrrn < 8 && lrcn < 8
            lrrn = lrrn + 1;
            lrcn = lrcn + 1;
            avail_board(lrrn, lrcn) = setOption;
        end
        
    end

end
