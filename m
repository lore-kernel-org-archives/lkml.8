Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA36EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6182076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961640;
	bh=QGVn4IRf8anQWWnfQmgTWJmXE6uS1MaTIhGEQA/UNy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qdUlVrHkWaHZ8LinvPDkwNCBB9msIFMz9s4J1brHQdgKu4iWvLzr9Jt3cN7yXxYS
	 DRgW6hj3mWoX5KieDgWczPjy9Q2oKLlxeaVBtofAsOptc38+e2wq7JusIvKGiTfGSJ
	 LtazOasy1MF4dHMRlr6b3g0Ar/6uaBjwOT0natfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370831AbgDOOkg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394051AbgDOOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:33:01 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA3521927;
        Wed, 15 Apr 2020 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961171;
        bh=QGVn4IRf8anQWWnfQmgTWJmXE6uS1MaTIhGEQA/UNy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFapklMoqt1yOQfpNxcKqAvNl4M0MMa86S5lgtEBnlQtfoIRuEntQc5CYOGBA9o+h
         0bVrHODX3rFYWZuzu/eBzZsFcxmvWE6tNZqQYDb0ioXd752gZfn4Oa5OWQeuZmAbg4
         /WFaZWMnd9Sl2nmnUAXpBTxuC70Kmq/Pf+swGRE0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5t-006kP7-Kn; Wed, 15 Apr 2020 16:32:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 18/34] docs: filesystems: convert gfs2-glocks.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:31 +0200
Message-Id: <e146506222bf13e8ef7008ac8b4547172c2faad8.1586960617.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586960617.git.mchehab+huawei@kernel.org>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Add table markups;
- Use notes markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{gfs2-glocks.txt => gfs2-glocks.rst}      | 147 ++++++++++--------
 Documentation/filesystems/index.rst           |   1 +
 MAINTAINERS                                   |   2 +-
 3 files changed, 86 insertions(+), 64 deletions(-)
 rename Documentation/filesystems/{gfs2-glocks.txt => gfs2-glocks.rst} (63%)

diff --git a/Documentation/filesystems/gfs2-glocks.txt b/Documentation/filesystems/gfs2-glocks.rst
similarity index 63%
rename from Documentation/filesystems/gfs2-glocks.txt
rename to Documentation/filesystems/gfs2-glocks.rst
index 7059623635b2..d14f230f0b12 100644
--- a/Documentation/filesystems/gfs2-glocks.txt
+++ b/Documentation/filesystems/gfs2-glocks.rst
@@ -1,5 +1,8 @@
-                   Glock internal locking rules
-                  ------------------------------
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Glock internal locking rules
+============================
 
 This documents the basic principles of the glock state machine
 internals. Each glock (struct gfs2_glock in fs/gfs2/incore.h)
@@ -24,24 +27,28 @@ There are three lock states that users of the glock layer can request,
 namely shared (SH), deferred (DF) and exclusive (EX). Those translate
 to the following DLM lock modes:
 
-Glock mode    | DLM lock mode
-------------------------------
-    UN        |    IV/NL  Unlocked (no DLM lock associated with glock) or NL
-    SH        |    PR     (Protected read)
-    DF        |    CW     (Concurrent write)
-    EX        |    EX     (Exclusive)
+==========	====== =====================================================
+Glock mode      DLM    lock mode
+==========	====== =====================================================
+    UN          IV/NL  Unlocked (no DLM lock associated with glock) or NL
+    SH          PR     (Protected read)
+    DF          CW     (Concurrent write)
+    EX          EX     (Exclusive)
+==========	====== =====================================================
 
 Thus DF is basically a shared mode which is incompatible with the "normal"
 shared lock mode, SH. In GFS2 the DF mode is used exclusively for direct I/O
 operations. The glocks are basically a lock plus some routines which deal
 with cache management. The following rules apply for the cache:
 
-Glock mode   |  Cache data | Cache Metadata | Dirty Data | Dirty Metadata
---------------------------------------------------------------------------
-    UN       |     No      |       No       |     No     |      No
-    SH       |     Yes     |       Yes      |     No     |      No
-    DF       |     No      |       Yes      |     No     |      No
-    EX       |     Yes     |       Yes      |     Yes    |      Yes
+==========      ==========   ==============   ==========   ==============
+Glock mode      Cache data   Cache Metadata   Dirty Data   Dirty Metadata
+==========      ==========   ==============   ==========   ==============
+    UN             No              No             No            No
+    SH             Yes             Yes            No            No
+    DF             No              Yes            No            No
+    EX             Yes             Yes            Yes           Yes
+==========      ==========   ==============   ==========   ==============
 
 These rules are implemented using the various glock operations which
 are defined for each type of glock. Not all types of glocks use
@@ -49,21 +56,23 @@ all the modes. Only inode glocks use the DF mode for example.
 
 Table of glock operations and per type constants:
 
-Field            | Purpose
-----------------------------------------------------------------------------
-go_xmote_th      | Called before remote state change (e.g. to sync dirty data)
-go_xmote_bh      | Called after remote state change (e.g. to refill cache)
-go_inval         | Called if remote state change requires invalidating the cache
-go_demote_ok     | Returns boolean value of whether its ok to demote a glock
-                 | (e.g. checks timeout, and that there is no cached data)
-go_lock          | Called for the first local holder of a lock
-go_unlock        | Called on the final local unlock of a lock
-go_dump          | Called to print content of object for debugfs file, or on
-                 | error to dump glock to the log.
-go_type          | The type of the glock, LM_TYPE_.....
-go_callback	 | Called if the DLM sends a callback to drop this lock
-go_flags	 | GLOF_ASPACE is set, if the glock has an address space
-                 | associated with it
+=============      =============================================================
+Field              Purpose
+=============      =============================================================
+go_xmote_th        Called before remote state change (e.g. to sync dirty data)
+go_xmote_bh        Called after remote state change (e.g. to refill cache)
+go_inval           Called if remote state change requires invalidating the cache
+go_demote_ok       Returns boolean value of whether its ok to demote a glock
+                   (e.g. checks timeout, and that there is no cached data)
+go_lock            Called for the first local holder of a lock
+go_unlock          Called on the final local unlock of a lock
+go_dump            Called to print content of object for debugfs file, or on
+                   error to dump glock to the log.
+go_type            The type of the glock, ``LM_TYPE_*``
+go_callback	   Called if the DLM sends a callback to drop this lock
+go_flags	   GLOF_ASPACE is set, if the glock has an address space
+                   associated with it
+=============      =============================================================
 
 The minimum hold time for each lock is the time after a remote lock
 grant for which we ignore remote demote requests. This is in order to
@@ -82,21 +91,25 @@ rather than via the glock.
 
 Locking rules for glock operations:
 
-Operation     |  GLF_LOCK bit lock held |  gl_lockref.lock spinlock held
--------------------------------------------------------------------------
-go_xmote_th   |       Yes               |       No
-go_xmote_bh   |       Yes               |       No
-go_inval      |       Yes               |       No
-go_demote_ok  |       Sometimes         |       Yes
-go_lock       |       Yes               |       No
-go_unlock     |       Yes               |       No
-go_dump       |       Sometimes         |       Yes
-go_callback   |       Sometimes (N/A)   |       Yes
+=============    ======================    =============================
+Operation        GLF_LOCK bit lock held    gl_lockref.lock spinlock held
+=============    ======================    =============================
+go_xmote_th           Yes                       No
+go_xmote_bh           Yes                       No
+go_inval              Yes                       No
+go_demote_ok          Sometimes                 Yes
+go_lock               Yes                       No
+go_unlock             Yes                       No
+go_dump               Sometimes                 Yes
+go_callback           Sometimes (N/A)           Yes
+=============    ======================    =============================
 
-N.B. Operations must not drop either the bit lock or the spinlock
-if its held on entry. go_dump and do_demote_ok must never block.
-Note that go_dump will only be called if the glock's state
-indicates that it is caching uptodate data.
+.. Note::
+
+   Operations must not drop either the bit lock or the spinlock
+   if its held on entry. go_dump and do_demote_ok must never block.
+   Note that go_dump will only be called if the glock's state
+   indicates that it is caching uptodate data.
 
 Glock locking order within GFS2:
 
@@ -104,7 +117,7 @@ Glock locking order within GFS2:
  2. Rename glock (for rename only)
  3. Inode glock(s)
     (Parents before children, inodes at "same level" with same parent in
-     lock number order)
+    lock number order)
  4. Rgrp glock(s) (for (de)allocation operations)
  5. Transaction glock (via gfs2_trans_begin) for non-read operations
  6. i_rw_mutex (if required)
@@ -117,8 +130,8 @@ determine the lifetime of the inode in question. Locking of inodes
 is on a per-inode basis. Locking of rgrps is on a per rgrp basis.
 In general we prefer to lock local locks prior to cluster locks.
 
-                            Glock Statistics
-                           ------------------
+Glock Statistics
+----------------
 
 The stats are divided into two sets: those relating to the
 super block and those relating to an individual glock. The
@@ -173,8 +186,8 @@ we'd like to get a better idea of these timings:
 1. To be able to better set the glock "min hold time"
 2. To spot performance issues more easily
 3. To improve the algorithm for selecting resource groups for
-allocation (to base it on lock wait time, rather than blindly
-using a "try lock")
+   allocation (to base it on lock wait time, rather than blindly
+   using a "try lock")
 
 Due to the smoothing action of the updates, a step change in
 some input quantity being sampled will only fully be taken
@@ -195,10 +208,13 @@ as possible. There are always inaccuracies in any
 measuring system, but I hope this is as accurate as we
 can reasonably make it.
 
-Per sb stats can be found here:
-/sys/kernel/debug/gfs2/<fsname>/sbstats
-Per glock stats can be found here:
-/sys/kernel/debug/gfs2/<fsname>/glstats
+Per sb stats can be found here::
+
+    /sys/kernel/debug/gfs2/<fsname>/sbstats
+
+Per glock stats can be found here::
+
+    /sys/kernel/debug/gfs2/<fsname>/glstats
 
 Assuming that debugfs is mounted on /sys/kernel/debug and also
 that <fsname> is replaced with the name of the gfs2 filesystem
@@ -206,14 +222,16 @@ in question.
 
 The abbreviations used in the output as are follows:
 
-srtt     - Smoothed round trip time for non-blocking dlm requests
-srttvar  - Variance estimate for srtt
-srttb    - Smoothed round trip time for (potentially) blocking dlm requests
-srttvarb - Variance estimate for srttb
-sirt     - Smoothed inter-request time (for dlm requests)
-sirtvar  - Variance estimate for sirt
-dlm      - Number of dlm requests made (dcnt in glstats file)
-queue    - Number of glock requests queued (qcnt in glstats file)
+=========  ================================================================
+srtt       Smoothed round trip time for non blocking dlm requests
+srttvar    Variance estimate for srtt
+srttb      Smoothed round trip time for (potentially) blocking dlm requests
+srttvarb   Variance estimate for srttb
+sirt       Smoothed inter request time (for dlm requests)
+sirtvar    Variance estimate for sirt
+dlm        Number of dlm requests made (dcnt in glstats file)
+queue      Number of glock requests queued (qcnt in glstats file)
+=========  ================================================================
 
 The sbstats file contains a set of these stats for each glock type (so 8 lines
 for each type) and for each cpu (one column per cpu). The glstats file contains
@@ -224,9 +242,12 @@ The gfs2_glock_lock_time tracepoint prints out the current values of the stats
 for the glock in question, along with some addition information on each dlm
 reply that is received:
 
-status - The status of the dlm request
-flags  - The dlm request flags
-tdiff  - The time taken by this specific request
+======   =======================================
+status   The status of the dlm request
+flags    The dlm request flags
+tdiff    The time taken by this specific request
+======   =======================================
+
 (remaining fields as per above list)
 
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 300e12569f54..6a34d1b578a9 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -81,6 +81,7 @@ Documentation for filesystem implementations.
    f2fs
    gfs2
    gfs2-uevents
+   gfs2-glocks
    hfs
    hfsplus
    hpfs
diff --git a/MAINTAINERS b/MAINTAINERS
index eebb55517709..470389ef0135 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7181,7 +7181,7 @@ L:	cluster-devel@redhat.com
 S:	Supported
 W:	http://sources.redhat.com/cluster/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
-F:	Documentation/filesystems/gfs2*.txt
+F:	Documentation/filesystems/gfs2*
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 
-- 
2.25.2

