{-# LANGUAGE OverloadedStrings, CPP #-}

-- | Add acronyms to your documents using this module.
--
--   Define and render acronyms in a document, where the first occurrance is the
--   long variant, and the next ones are the shorter variant.
module Text.LaTeX.Packages.Acronym
 ( -- * Acronym package
   pacronym
   -- * Package options
 , footnote, nohyperlinks, printonlyused, withpage, smaller, dua, nolist
 -- * Types
 , Acronym(..)
 -- functions
 , ac, acf, acs, acl, acp, acfp, acsp, aclp, acfi, acsu, aclu, iac, iac2
 , ac', acf', acs', acl', acp', acfp', acsp', aclp', acfi', acsu', aclu', iac', iac2'
 , acresetall, acused, 
   ) where

import Data.String(IsString(fromString))

import Text.LaTeX.Base.Class(LaTeXC, comm0, comm1)
import Text.LaTeX.Base.Types(PackageName)

-- | The 'pacronym' package.
--
-- > usepackage [] pacronym
pacronym :: PackageName
pacronym = "acronym"

-- | Redefines the `\acf` and `\acfp` commands making the full
--   name appear as a footnote
footnote :: LaTeXC l => l
footnote = "footnote"

-- | If hyperref is loaded, all acronyms will link to their glossary entry. With
--   the `nohyperlinks` option, these links are suppressed.
nohyperlinks :: LaTeXC l => l
nohyperlinks = "nohyperlinks"

-- | We need a marker which is set if the option `printonlyused` was used.
printonlyused :: LaTeXC l => l
printonlyused = "printonlyused"

-- | A marker which tells us to print page numbers.
withpage :: LaTeXC l => l
withpage = "withpage"

-- | The option `smaller` leads to a redefinition of `\acsfont`. We want to make
--   the acronym appear smaller. Since this should be done in a
--   context-sensitive way, we rely on the macro \textsmaller provided by the
--   `relsize` package. As `\RequiredPackage` cannot be used inside
--   `\DeclareOption`, we need a boolean variable.
smaller :: LaTeXC l => l
smaller = "smaller"

-- | The option `dua` stands for "don't use acronyms". It leads to a
--   redefinition of `\ac` and `\acp` making the full name appear all the time
--   and suppressing all acronyms but the explicitly requested by `\acf` and
--   `\acfp`.
dua :: LaTeXC l => l
dua = "dua"

-- | The option `nolist` stands for "don't write the list of acronyms".
nolist :: LaTeXC l => l
nolist = "nolist"

-- | An acronym type with a label, this is used to generate commands linked to
--   this acronym.
newtype Acronym = Acronym { acronymLabel :: String }

_acronymLabel :: IsString s => Acronym -> s
_acronymLabel = fromString . acronymLabel

_acronymC1 :: LaTeXC l => String -> Acronym -> l
_acronymC1 = (. _acronymLabel) . comm1

-- | Enter an acronym inside the text. The first time the acronym is used, it
--   will specify the full name, and between parenthesis, the short name. If you
--   specified the `footnote` option, it will print the short name, and add a
--   footnote with the long name. The next time, only the short time is printed.
ac :: LaTeXC l => Acronym -> l
ac = _acronymC1 "ac"

-- | You can use this command to later in the text again print the full name of
--   the acronym, this stands for "full acronym", it always prints the full
--   name, and the acronym between parenthesis.
acf :: LaTeXC l => Acronym -> l
acf = _acronymC1 "acf"

-- | This will enter the short version of the acronym inside the text.
acs :: LaTeXC l => Acronym -> l
acs = _acronymC1 "acs"

-- | This will enter the expanded version of the acronym in the text, without
--   mentioning the acronym between parenthesis.
acl :: LaTeXC l => Acronym -> l
acl = _acronymC1 "acl"

-- | This works the same way as `ac`, except that it will make the short and the
--   long forms into plurals.
acp :: LaTeXC l => Acronym -> l
acp = _acronymC1 "acp"

-- | This works the same way as `acf`, except tah it will make the short and
--   long forms into plurals.
acfp :: LaTeXC l => Acronym -> l
acfp = _acronymC1 "acfp"

acsp :: LaTeXC l => Acronym -> l
acsp = _acronymC1 "acsp"

aclp :: LaTeXC l => Acronym -> l
aclp = _acronymC1 "aclp"

acfi :: LaTeXC l => Acronym -> l
acfi = _acronymC1 "acfi"

acsu :: LaTeXC l => Acronym -> l
acsu = _acronymC1 "acsu"

aclu :: LaTeXC l => Acronym -> l
aclu = _acronymC1 "aclu"

iac :: LaTeXC l => Acronym -> l
iac = _acronymC1 "iac"

iac2 :: LaTeXC l => Acronym -> l
iac2 = _acronymC1 "Iac"

ac' :: LaTeXC l => Acronym -> l
ac' = _acronymC1 "ac*"

acf' :: LaTeXC l => Acronym -> l
acf' = _acronymC1 "acf*"

acs' :: LaTeXC l => Acronym -> l
acs' = _acronymC1 "acs*"

acl' :: LaTeXC l => Acronym -> l
acl' = _acronymC1 "acl*"

acp' :: LaTeXC l => Acronym -> l
acp' = _acronymC1 "acp*"

acfp' :: LaTeXC l => Acronym -> l
acfp' = _acronymC1 "acfp*"

acsp' :: LaTeXC l => Acronym -> l
acsp' = _acronymC1 "acsp*"

aclp' :: LaTeXC l => Acronym -> l
aclp' = _acronymC1 "aclp*"

acfi' :: LaTeXC l => Acronym -> l
acfi' = _acronymC1 "acfi*"

acsu' :: LaTeXC l => Acronym -> l
acsu' = _acronymC1 "acsu*"

aclu' :: LaTeXC l => Acronym -> l
aclu' = _acronymC1 "aclu*"

iac' :: LaTeXC l => Acronym -> l
iac' = _acronymC1 "iac*"

iac2' :: LaTeXC l => Acronym -> l
iac2' = _acronymC1 "Iac*"

-- | The memory of the marco `ac` is flushed, afterwards, `ac` will print the
--   full name of any acronym, and the acronym within parenthesis.
acresetall :: LaTeXC l => l
acresetall = comm0 "acresetall"

-- | Marks an acronym as useed, as if it has been called with `ac`, but without
--   printing anything. In the future, only the short form of the acronym will
--   be printed. `acresetall` undoes this.
acused :: LaTeXC l => Acronym -> l
acused = _acronymC1 "acused"
