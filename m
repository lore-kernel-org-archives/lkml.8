Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B14DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A992078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961895;
	bh=n4BmXd8N8vutOAdpVhWLKUoBRF2Vet4WcaVXRIJWT+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n13/Yw8am9YivnMPYPkDoKYRbaPCHFH+Gv1FH5zaJIrOf5z53VHxF7rhCLAb1ajyf
	 S5EilLUfa1fZg4hNAu86p0u41nLlKjtSe01aMq1f2OnPEkC7Zx96/lNTJYFdiKy0C9
	 DlBiK9hmlOg00XeVmFdaAwCJFMn9Km9fjhVn6Wr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370911AbgDOOov (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392132AbgDOOcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:32:52 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08D32076D;
        Wed, 15 Apr 2020 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961170;
        bh=n4BmXd8N8vutOAdpVhWLKUoBRF2Vet4WcaVXRIJWT+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMLJPImWSOOgoIAAXR2PGXYTpW6V3S2ROiKLK86ST/VJKQtUXRgNa8JqL4uSOl13L
         qcc2/X8nXjQY5o9C5PrL+pAjxUmSZ6kmwJ0RxX+d6Ffe0bd6Fx32pyUfVsoqe1kNPX
         MEW/sGi0ZHuY/AVmYAZH4qbQYNwnUKqScQ4rExN0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOj5s-006kNp-Uh; Wed, 15 Apr 2020 16:32:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Subject: [PATCH 02/34] docs: filesystems: convert caching/object.txt to ReST
Date:   Wed, 15 Apr 2020 16:32:15 +0200
Message-Id: <65a83e92dcf7461361052ca2d2cfb8c3f27f7fd6.1586960617.git.mchehab+huawei@kernel.org>
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
- Comment out text ToC for html/pdf output;
- Some whitespace fixes and new line breaks;
- Adjust the events list to make them look better for html output;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/caching/fscache.txt |  2 +-
 Documentation/filesystems/caching/index.rst   |  9 ++++
 .../caching/{object.txt => object.rst}        | 43 ++++++++-----------
 Documentation/filesystems/index.rst           |  2 +
 fs/fscache/object.c                           |  2 +-
 5 files changed, 31 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/filesystems/caching/index.rst
 rename Documentation/filesystems/caching/{object.txt => object.rst} (95%)

diff --git a/Documentation/filesystems/caching/fscache.txt b/Documentation/filesystems/caching/fscache.txt
index 50f0a5757f48..071ff50a774d 100644
--- a/Documentation/filesystems/caching/fscache.txt
+++ b/Documentation/filesystems/caching/fscache.txt
@@ -191,7 +191,7 @@ The cache backend API to FS-Cache can be found in:
 A description of the internal representations and object state machine can be
 found in:
 
-	Documentation/filesystems/caching/object.txt
+	Documentation/filesystems/caching/object.rst
 
 
 =======================
diff --git a/Documentation/filesystems/caching/index.rst b/Documentation/filesystems/caching/index.rst
new file mode 100644
index 000000000000..e5ec95ff0be2
--- /dev/null
+++ b/Documentation/filesystems/caching/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Filesystem Caching
+==================
+
+.. toctree::
+   :maxdepth: 2
+
+   object
diff --git a/Documentation/filesystems/caching/object.txt b/Documentation/filesystems/caching/object.rst
similarity index 95%
rename from Documentation/filesystems/caching/object.txt
rename to Documentation/filesystems/caching/object.rst
index 100ff41127e4..ce0e043ccd33 100644
--- a/Documentation/filesystems/caching/object.txt
+++ b/Documentation/filesystems/caching/object.rst
@@ -1,10 +1,12 @@
-	     ====================================================
-	     IN-KERNEL CACHE OBJECT REPRESENTATION AND MANAGEMENT
-	     ====================================================
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================================
+In-Kernel Cache Object Representation and Management
+====================================================
 
 By: David Howells <dhowells@redhat.com>
 
-Contents:
+.. Contents:
 
  (*) Representation
 
@@ -18,8 +20,7 @@ Contents:
  (*) The set of events.
 
 
-==============
-REPRESENTATION
+Representation
 ==============
 
 FS-Cache maintains an in-kernel representation of each object that a netfs is
@@ -38,7 +39,7 @@ or even by no objects (it may not be cached).
 
 Furthermore, both cookies and objects are hierarchical.  The two hierarchies
 correspond, but the cookies tree is a superset of the union of the object trees
-of multiple caches:
+of multiple caches::
 
 	    NETFS INDEX TREE               :      CACHE 1     :      CACHE 2
 	                                   :                  :
@@ -89,8 +90,7 @@ pointers to the cookies.  The cookies themselves and any objects attached to
 those cookies are hidden from it.
 
 
-===============================
-OBJECT MANAGEMENT STATE MACHINE
+Object Management State Machine
 ===============================
 
 Within FS-Cache, each active object is managed by its own individual state
@@ -124,7 +124,7 @@ is not masked, the object will be queued for processing (by calling
 fscache_enqueue_object()).
 
 
-PROVISION OF CPU TIME
+Provision of CPU Time
 ---------------------
 
 The work to be done by the various states was given CPU time by the threads of
@@ -141,7 +141,7 @@ because:
      workqueues don't necessarily have the right numbers of threads.
 
 
-LOCKING SIMPLIFICATION
+Locking Simplification
 ----------------------
 
 Because only one worker thread may be operating on any particular object's
@@ -151,8 +151,7 @@ from the cache backend's representation (fscache_object) - which may be
 requested from either end.
 
 
-=================
-THE SET OF STATES
+The Set of States
 =================
 
 The object state machine has a set of states that it can be in.  There are
@@ -275,19 +274,17 @@ memory and potentially deletes stuff from disk:
      this state.
 
 
-THE SET OF EVENTS
+The Set of Events
 -----------------
 
 There are a number of events that can be raised to an object state machine:
 
- (*) FSCACHE_OBJECT_EV_UPDATE
-
+ FSCACHE_OBJECT_EV_UPDATE
      The netfs requested that an object be updated.  The state machine will ask
      the cache backend to update the object, and the cache backend will ask the
      netfs for details of the change through its cookie definition ops.
 
- (*) FSCACHE_OBJECT_EV_CLEARED
-
+ FSCACHE_OBJECT_EV_CLEARED
      This is signalled in two circumstances:
 
      (a) when an object's last child object is dropped and
@@ -296,20 +293,16 @@ There are a number of events that can be raised to an object state machine:
 
      This is used to proceed from the dying state.
 
- (*) FSCACHE_OBJECT_EV_ERROR
-
+ FSCACHE_OBJECT_EV_ERROR
      This is signalled when an I/O error occurs during the processing of some
      object.
 
- (*) FSCACHE_OBJECT_EV_RELEASE
- (*) FSCACHE_OBJECT_EV_RETIRE
-
+ FSCACHE_OBJECT_EV_RELEASE, FSCACHE_OBJECT_EV_RETIRE
      These are signalled when the netfs relinquishes a cookie it was using.
      The event selected depends on whether the netfs asks for the backing
      object to be retired (deleted) or retained.
 
- (*) FSCACHE_OBJECT_EV_WITHDRAW
-
+ FSCACHE_OBJECT_EV_WITHDRAW
      This is signalled when the cache backend wants to withdraw an object.
      This means that the object will have to be detached from the netfs's
      cookie.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index e7b46dac7079..773af390c5e5 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -25,6 +25,8 @@ algorithms work.
    locking
    directory-locking
 
+   caching/index
+
    porting
 
 Filesystem support layers
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index cfeba839a0f2..efaa003b8323 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
- * See Documentation/filesystems/caching/object.txt for a description of the
+ * See Documentation/filesystems/caching/object.rst for a description of the
  * object state machine and the in-kernel representations.
  */
 
-- 
2.25.2

