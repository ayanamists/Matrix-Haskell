{-# LANGUAGE TemplateHaskell #-}
module Props where

import Solution

checkAdd a b = 
  if a == 0 then add a b == b 
  else add a b == (+1) (add (a - 1) b)
  where types = a :: Int
  
checkAdd2 a b =
    add a b == add b a
    where types = a :: Int

checkList = 
  [ 'checkAdd
  , 'checkAdd2
  ]