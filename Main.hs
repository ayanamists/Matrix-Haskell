{-# LANGUAGE TemplateHaskell #-}

module Main where

import CheckProp (checkPropList)
import Props (checkList)

main :: IO ()
main = do
  $(checkPropList checkList)