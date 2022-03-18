# A corpus of grammars from Kings College

Michael Sperberg-McQueen [writes](https://lists.w3.org/Archives/Public/public-ixml/2022Mar/0041.html):

Some of you may be interested in a corpus of 20,000 sample grammars
created at Kings College London for an experiment in automatic detection
of ambiguity in context-free grammars.  I stumbled across it this
morning when looking idly around on the network trying to see if there
are any automated ambiguity detection tools we might be able to use on
ixml.ixml.

A paper by Vasudevan and Tratt, presents a 'breadth-first' technique
for seeking ambiguity in a grammar, which contrasts in their account
with the 'depth-first' search of 
[other tools](https://soft-dev.org/pubs/pdf/vasudevan_tratt__detecting_ambiguity_in_programming_language_grammars.pdf). They also describe
the corpus of grammars they built for their experiment using two
different approaches to machine generation of new grammars, and
point to a repository where their code and their test corpus can be
[downloaded](https://figshare.com/articles/dataset/cfg_amb_experiment/774614).

Since many (or all?) of their grammars are machine-generated, their
corpus is likely to illuminate regions of the space of possible grammars
that would be unlikely to be exercised by a corpus purely of grammars
written by people.

## Making Invisible XML versions

Among the grammars in the corpus are 12,800 “boltzcfg” grammars. For example:

```
%token TK_WKLJ, TK_ZT, TK_TCN, TK_WIP, TK_JX, TK_AU, TK_SM;

%nodefault

root: TK_SM NIXU TK_ZT | 'S';

PS: LDOE | TK_WKLJ I DPDY 'P' TK_SM SNSB TK_WIP K TK_WIP | M TK_WIP TK_JX 'S' YRYTE TK_WKLJ;

NIXU: K | 'P' TK_TCN TK_ZT YRYTE | TK_JX YRYTE |  | SNSB K DPDY TK_SM YRYTE SNSB 'Z' TK_AU 'Z' TK_WIP;

SNSB: TK_WKLJ | I TK_TCN | K | 'P' 'S' TK_WKLJ M | TK_WIP SNSB;

YRYTE: NIXU;

I: 'P' TK_ZT | YRYTE TK_TCN | 'P' K SNSB | NIXU YRYTE;

LDOE: TK_SM | DPDY | K | M 'S' 'S' TK_WIP TK_WIP M YRYTE;

K: I | TK_AU 'S' TK_JX;

M: I TK_WKLJ 'S' PS SNSB | TK_SM TK_WKLJ;

DPDY: TK_JX 'Z';
```

These looked to be reasonably amenable to automatic translation to Invisible XML.

The grammar in `bgrammar.ixml` turns them into XML:

```xml
<grammar xmlns:ixml="http://invisiblexml.org/NS" ixml:state="ambiguous">
   <tokens>
      <token>TK_WKLJ</token>
      <token>TK_ZT</token>
      <token>TK_TCN</token>
      <token>TK_WIP</token>
      <token>TK_JX</token>
      <token>TK_AU</token>
      <token>TK_SM</token>
   </tokens>
   <rule>
      <nonterminal>root</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>TK_SM</token> 
               <token>NIXU</token> 
               <token>TK_ZT</token>
            </sequence>
            <sequence>
               <literal>S</literal>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>PS</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>LDOE</token>
            </sequence>
            <sequence>
               <token>TK_WKLJ</token> 
               <token>I</token> 
               <token>DPDY</token> 
               <literal>P</literal> 
               <token>TK_SM</token> 
               <token>SNSB</token> 
               <token>TK_WIP</token> 
               <token>K</token> 
               <token>TK_WIP</token>
            </sequence>
            <sequence>
               <token>M</token> 
               <token>TK_WIP</token> 
               <token>TK_JX</token> 
               <literal>S</literal> 
               <token>YRYTE</token> 
               <token>TK_WKLJ</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>NIXU</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>K</token>
            </sequence>
            <sequence>
               <literal>P</literal> 
               <token>TK_TCN</token> 
               <token>TK_ZT</token> 
               <token>YRYTE</token>
            </sequence>
            <sequence>
               <token>TK_JX</token> 
               <token>YRYTE</token>
            </sequence>
            <sequence>
               <epsilon/>
            </sequence>
            <sequence>
               <token>SNSB</token> 
               <token>K</token> 
               <token>DPDY</token> 
               <token>TK_SM</token> 
               <token>YRYTE</token> 
               <token>SNSB</token> 
               <literal>Z</literal> 
               <token>TK_AU</token> 
               <literal>Z</literal> 
               <token>TK_WIP</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>SNSB</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>TK_WKLJ</token>
            </sequence>
            <sequence>
               <token>I</token> 
               <token>TK_TCN</token>
            </sequence>
            <sequence>
               <token>K</token>
            </sequence>
            <sequence>
               <literal>P</literal> 
               <literal>S</literal> 
               <token>TK_WKLJ</token> 
               <token>M</token>
            </sequence>
            <sequence>
               <token>TK_WIP</token> 
               <token>SNSB</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>YRYTE</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>NIXU</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>I</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <literal>P</literal> 
               <token>TK_ZT</token>
            </sequence>
            <sequence>
               <token>YRYTE</token> 
               <token>TK_TCN</token>
            </sequence>
            <sequence>
               <literal>P</literal> 
               <token>K</token> 
               <token>SNSB</token>
            </sequence>
            <sequence>
               <token>NIXU</token> 
               <token>YRYTE</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>LDOE</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>TK_SM</token>
            </sequence>
            <sequence>
               <token>DPDY</token>
            </sequence>
            <sequence>
               <token>K</token>
            </sequence>
            <sequence>
               <token>M</token> 
               <literal>S</literal> 
               <literal>S</literal> 
               <token>TK_WIP</token> 
               <token>TK_WIP</token> 
               <token>M</token> 
               <token>YRYTE</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>K</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>I</token>
            </sequence>
            <sequence>
               <token>TK_AU</token> 
               <literal>S</literal> 
               <token>TK_JX</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>M</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>I</token> 
               <token>TK_WKLJ</token> 
               <literal>S</literal> 
               <token>PS</token> 
               <token>SNSB</token>
            </sequence>
            <sequence>
               <token>TK_SM</token> 
               <token>TK_WKLJ</token>
            </sequence>
         </choice>
      </rhs>
   </rule>
   <rule>
      <nonterminal>DPDY</nonterminal>
      <rhs>
         <choice>
            <sequence>
               <token>TK_JX</token> 
               <literal>Z</literal>
            </sequence>
         </choice>
      </rhs>
   </rule>
</grammar>
```

If we take the tokens identified by `%token` as intended to be the
ones provided by the lexer, then we can simply replace them with
literals. Then the question becomes, what should the input be?

These grammars aren’t useful except for testing, so it doesn’t really
matter what the input is. A space separated list of token values is
one possibility, but using spaces in that way complicates matters when
a token is replaced by epsilon. If, instead, we choose a different
separator, then the input is easier to represent.

The XSLT in `btoixml.xsl` transforms them into
Invisible XML assuming that “|” will be used as the separator.

```
{ TK_SM||TK_ZT }

root: "TK_SM", s, NIXU, s, "TK_ZT"; 'S' .
PS: LDOE; "TK_WKLJ", s, I, s, DPDY, s, 'P', s, "TK_SM", s, SNSB, s, "TK_WIP", s, K, s, "TK_WIP"; M, s, "TK_WIP", s, "TK_JX", s, 'S', s, YRYTE, s, "TK_WKLJ" .
NIXU: K; 'P', s, "TK_TCN", s, "TK_ZT", s, YRYTE; "TK_JX", s, YRYTE; {}; SNSB, s, K, s, DPDY, s, "TK_SM", s, YRYTE, s, SNSB, s, 'Z', s, "TK_AU", s, 'Z', s, "TK_WIP" .
SNSB: "TK_WKLJ"; I, s, "TK_TCN"; K; 'P', s, 'S', s, "TK_WKLJ", s, M; "TK_WIP", s, SNSB .
YRYTE: NIXU .
I: 'P', s, "TK_ZT"; YRYTE, s, "TK_TCN"; 'P', s, K, s, SNSB; NIXU, s, YRYTE .
LDOE: "TK_SM"; DPDY; K; M, s, 'S', s, 'S', s, "TK_WIP", s, "TK_WIP", s, M, s, YRYTE .
K: I; "TK_AU", s, 'S', s, "TK_JX" .
M: I, s, "TK_WKLJ", s, 'S', s, PS, s, SNSB; "TK_SM", s, "TK_WKLJ" .
DPDY: "TK_JX", s, 'Z' .
-s: -'|' .
```

The comment at the top of the file is one possible input, as derived
by the XSLT. In an effort to limit the size of the input and avoid
loops, if an epsilon transition is possible, the XSLT chooses it.
Otherwise, it chooses the first sequence.

If there are loops, the XSLT will crash.
