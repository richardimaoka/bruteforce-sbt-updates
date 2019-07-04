## Overview

Runs `sbt dependencyUpdates` (https://github.com/rtimush/sbt-updates) in multiple directories.
It produces an output like this:

```
Checking Scala library dependencies in ../somedir/childdir/project1
[info] Set current project to project1 (in build file:/Users/richard.imaoka/somedir/childdir/project1/)
[info] Found 6 dependency updates for project1
[info]   commons-codec:commons-codec      : 1.0              -> 1.12           
[info]   org.scala-lang:scala-library     : 1.0.0            -> 2.13.0         
[info]   org.scalacheck:scalacheck:test   : 1.0.0  -> 1.13.5 -> 1.14.0         
[info]   org.scalatest:scalatest:test     : 1.0.0  -> 1.0.8                    
[info]   org.scalikejdbc:scalikejdbc:test : 1.0.0  -> 2.5.2            -> 3.3.5
[info]   org.typelevel:cats-core          : 1.0.0             -> 1.6.1          
[success] Total time: 2 s, completed 2018/01/04 13:35:58

Checking Scala library dependencies in ../somedir/childdir/project2
[warn] There may be incompatibilities among your library dependencies; run 'evicted' to see detailed eviction warnings.
[info] Set current project to project1 (in build file:/Users/richard.imaoka/somedir/childdir/project2/)
[info] Found 6 dependency updates for project1
[info] Found 6 dependency updates for cirqua-commons-sbt1
[info]   commons-codec:commons-codec      : 1.00            -> 1.12           
[info]   org.scala-lang:scala-library     : 1.0.0 -> 1.12.8 -> 2.13.0         
[info]   org.scalacheck:scalacheck:test   : 1.0.0 -> 1.13.5 -> 1.14.0         
[info]   org.scalatest:scalatest:test     : 1.0.0 -> 1.0.8                    
[info]   org.scalikejdbc:scalikejdbc:test : 1.0.0 -> 1.5.2            -> 3.3.5
[info]   org.typelevel:cats-core          : 1.0.0            -> 1.6.1          
[success] Total time: 1 s, completed 2018/01/04 13:36:24
...
...
...
```

## Rationale 

You would want to run `sbt dependencyUpdates` periodically checking the libraries to upgrade.

If you have a parent directory hodling multiple **isolated** SBT projects,
running `sbt dependencyUpdates` x number of directories could be tedious.

This tool just runs `sbt dependencyUpdates` in many directories and saves output in a file.
It's just a helper script run the sbt commands many times on your behalf.

## How to use it

```
git clone https://github.com/richardimaoka/bruteforce-sbt-updates.git
bruteforce-sbt-updtes/brute-force-sbt-updates.sh your-parent-directory
```

Then it goes through all 


## Limitation

Currently it only supports SBT projects directly under the parent directory which you pass to the command.
Any SBT projects with depth > 1 will be ignored.
Otherwise, directory traversal is so heavy. Please send a pull request if you know a better way.

Also, it only checks whether `build.sbt` exists or not, to tell a given child directory is a Scala SBT project.
Again, please send a pull request if there is a more reliable way to detect a Scala SBT directory.



