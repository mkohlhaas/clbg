#!/usr/bin/env luajit

local ffi = require("ffi")

local board = ffi.new("uint8_t[9][9]", {{5,3,0,0,7,0,0,0,0}, 
                                        {6,0,0,1,9,5,0,0,0},
                                        {0,9,8,0,0,0,0,6,0},
                                        {8,0,0,0,6,0,0,0,3},
                                        {4,0,0,8,0,3,0,0,1},
                                        {7,0,0,0,2,0,0,0,6},
                                        {0,6,0,0,0,0,2,8,0},
                                        {0,0,0,4,1,9,0,0,5},
                                        {0,0,0,0,8,0,0,7,9}})

-- local board = ffi.new("uint8_t[9][9]", {{5,3,4,6,7,8,9,1,2}, 
--                                         {6,7,2,1,9,5,3,4,8},
--                                         {1,9,8,3,4,2,5,6,7},
--                                         {8,5,9,7,6,1,4,2,3},
--                                         {4,2,6,8,5,3,7,9,1},
--                                         {7,1,3,9,2,4,8,5,6},
--                                         {9,6,1,5,3,7,2,8,5},
--                                         {0,0,0,4,1,9,0,0,5},
--                                         {0,0,0,0,8,0,0,7,9}})

-- local board = ffi.new("uint8_t[9][9]", {{5,3,4,6,7,8,9,1,2}, 
--                                         {6,7,2,1,9,5,3,4,8},
--                                         {1,9,8,3,4,2,5,6,7},
--                                         {8,5,9,7,6,1,4,2,3},
--                                         {4,2,6,8,5,3,7,9,1},
--                                         {7,1,3,9,2,4,8,5,6},
--                                         {9,6,1,5,3,7,2,8,5},
--                                         {2,8,7,4,1,9,6,3,5},
--                                         {3,4,5,2,8,6,0,7,9}})

local function print_sudoku(grid)
  for i=0,8 do
    for j=0,8 do
      io.write(grid[i][j], " ")
    end
    print()
  end
  print()
end

local function is_valid_move(grid,x,y,n)
  for i=0,8 do
    if grid[i][x] == n or grid[y][i] == n then return false end
  end

  local sq_x = math.floor(x / 3) * 3
  local sq_y = math.floor(y / 3) * 3

  for i=0,2 do
    for j=0,2 do
      if grid[sq_y + i][sq_x + j] == n then return false end
    end
  end
  return true
end

local function solve(grid)
  for y=0,8 do
    for x=0,8 do
      if grid[y][x] == 0 then
        -- print(x,y)
        for n = 1,9 do
          if is_valid_move(grid, x, y, n) then
            -- print(x,y,n)
            grid[y][x] = n
            solve(grid)
            grid[y][x] = 0
          end
        end
        return
      end
    end
  end
  print_sudoku(grid)
end

print_sudoku(board)
solve(board)
