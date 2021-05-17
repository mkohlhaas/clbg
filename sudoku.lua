#!/usr/bin/env luajit

local ffi = require("ffi")

local board = ffi.new("uint8_t[9][9]", {{0,0,0,0,0,0,0,1,0},
                                        {4,0,0,0,0,0,0,0,0},
                                        {0,2,0,0,0,0,0,0,0},
                                        {0,0,0,0,5,0,4,0,7},
                                        {0,0,8,0,0,0,3,0,0},
                                        {0,0,1,0,9,0,0,0,0},
                                        {3,0,0,4,0,0,2,0,0},
                                        {0,5,0,1,0,0,0,0,0},
                                        {0,0,0,8,0,6,0,0,0}})

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
        for n = 1,9 do
          if is_valid_move(grid, x, y, n) then
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

solve(board)
