{-# LANGUAGE TemplateHaskell #-}

module CheckProp where

import Language.Haskell.TH
  ( Exp,
    Name,
    Q,
    nameBase,
    stringE,
    varE,
  )
import Test.QuickCheck

checkProp :: Name -> Q Exp -> Q Exp
checkProp prop cont =
  [|
    quickCheckWithResult args $(varE prop)
      >>= ( \x ->
              handleResult x $(stringE (nameBase prop))
          )
      >> $(cont)
    |]

args =
  Args
    { replay = Nothing,
      maxSuccess = 100,
      maxDiscardRatio = 100,
      maxSize = 100,
      chatty = False,
      maxShrinks = maxBound
    }

handleResult (Failure _ _ _ _ _ _ _ s _ o t l c) prop = do
  putStrLn $ prop ++ " fail, test case is:"
  mapM_ putStrLn t
handleResult Success {} prop = putStrLn $ prop ++ " success"
handleResult _ _ = return ()

checkPropList :: [Name] -> Q Exp
checkPropList =
  foldr checkProp [|return ()|]