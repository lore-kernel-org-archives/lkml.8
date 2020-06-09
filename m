Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E40C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE432078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fVr48oYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgFIOX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:23:56 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:8246 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591712633; x=1623248633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lkv2Bo/3IctZrTSbBNlygdbTcIm2Ki8g0wDs1n3f3dA=;
  b=fVr48oYRUR9adz9nOhqEvhHSKXL6RhxTM0EkXMSK/WwSz5Qv2FIJmSWF
   EgJ2Fm3OrfB5B+cOvdIWOvrsd5Luabls41QhJZsmN9cIFZkxZoj59HPKv
   SSId8p3YvqZIgk2Dctk7ZspX1YjYxdSYH7yts3iUBaQJ1AzKP257TBJDD
   M=;
IronPort-SDR: IB/F3te4GXNvy+j70MRkn080NGUmhRMc/djYPyReE4xxnzLFX3xRgopWCk5dRynwpdPzUePJjg
 tsJlLYjU0ivg==
X-IronPort-AV: E=Sophos;i="5.73,492,1583193600"; 
   d="scan'208";a="35297925"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 09 Jun 2020 14:23:52 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 3CCF6A07FF;
        Tue,  9 Jun 2020 14:23:40 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:23:40 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:23:24 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v3 10/10] Docs/damon: Document physical memory monitoring support
Date:   Tue, 9 Jun 2020 16:19:41 +0200
Message-ID: <20200609141941.19184-11-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609141941.19184-1-sjpark@amazon.com>
References: <20200609141941.19184-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds description for the physical memory monitoring usage in
the DAMON document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/faq.rst    | 16 +++--
 Documentation/admin-guide/mm/damon/index.rst  |  1 -
 .../admin-guide/mm/damon/mechanisms.rst       |  4 +-
 Documentation/admin-guide/mm/damon/plans.rst  | 29 ---------
 Documentation/admin-guide/mm/damon/usage.rst  | 59 ++++++++++++++-----
 5 files changed, 54 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/admin-guide/mm/damon/plans.rst

diff --git a/Documentation/admin-guide/mm/damon/faq.rst b/Documentation/admin-guide/mm/damon/faq.rst
index 02f7581b05f6..e9b69d1bf975 100644
--- a/Documentation/admin-guide/mm/damon/faq.rst
+++ b/Documentation/admin-guide/mm/damon/faq.rst
@@ -38,9 +38,13 @@ separate document, :doc:`guide`.  Please refer to that.
 Does DAMON support virtual memory only?
 ========================================
 
-For now, yes.  But, DAMON will be able to support various address spaces
-including physical memory in near future.  An RFC patchset [1]_ for this
-extension is already available.  Please refer :doc:`plans` for detailed plan
-for this.
-
-.. [1] https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/
+No.  DAMON supports the virtual memory address spaces and the physical memory
+address space for now.  However, it can be extended to support any address
+space, because the core logic of the DAMON can be configured with the low level
+primitives for each address space.
+
+In other words, DAMON provides the reference implementations of the low level
+primitives for the virtual memory address spaces and the physical memory
+address spaces.  The programming interface users can further implement their
+own low level primitives for their special use cases and configure those in
+DAMON if they need.
diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 4d128e4fd9c8..7b2939d50408 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -33,4 +33,3 @@ optimizations of their systems.
    faq
    mechanisms
    eval
-   plans
diff --git a/Documentation/admin-guide/mm/damon/mechanisms.rst b/Documentation/admin-guide/mm/damon/mechanisms.rst
index f0bc52c698a6..8a93a945cacf 100644
--- a/Documentation/admin-guide/mm/damon/mechanisms.rst
+++ b/Documentation/admin-guide/mm/damon/mechanisms.rst
@@ -76,9 +76,7 @@ keeping the bounds users set for their trade-off.
 Handling Virtual Memory Mappings
 ================================
 
-This is for monitoring of virtual memory address space only.  It is the only
-one address space that supported by DAMON as of now, but other address spaces
-will be supported in the future.
+This is for monitoring of virtual memory address space only.
 
 Only small parts in the super-huge virtual address space of the processes are
 mapped to physical memory and accessed.  Thus, tracking the unmapped address
diff --git a/Documentation/admin-guide/mm/damon/plans.rst b/Documentation/admin-guide/mm/damon/plans.rst
deleted file mode 100644
index 8eba8a1dcb98..000000000000
--- a/Documentation/admin-guide/mm/damon/plans.rst
+++ /dev/null
@@ -1,29 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-============
-Future Plans
-============
-
-DAMON is still on its early stage.  Below plans are still under development.
-
-
-Support Various Address Spaces
-==============================
-
-Currently, DAMON supports only virtual memory address spaces because it
-utilizes PTE Accessed bits as its low-level access check primitive and ``struct
-vma`` as a way to address the monitoring target regions.  However, the core
-idea of DAMON is in a separate higher layer.  Therefore, DAMON can support
-other various address spaces by changing the two low primitives to others for
-the address spaces.
-
-In the future, DAMON will make the lower level primitives configurable so that
-it can support various address spaces including physical memory.  The
-configuration will be highly flexible so that users can even implement the
-primitives by themselves for their special use cases.  Monitoring of
-clean/dirty/entire page cache, NUMA nodes, specific files, or block devices
-would be examples of such use cases.
-
-An RFC patchset for this plan is available [1]_.
-
-.. [1] https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index f600366cdd4e..8942d09bfd49 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -58,9 +58,11 @@ Recording Data Access Pattern
 -----------------------------
 
 The ``record`` subcommand records the data access pattern of target processes
-in a file (``./damon.data`` by default).  You can specify the target as either
-pid of running target or a command for execution of the process.  Below example
-shows a command target usage::
+in a file (``./damon.data`` by default).  You can specify the target with 1)
+the command for execution of the monitoring target process, 2) pid of running
+target process, or 3) the special keyword, 'paddr', if you want to monitor the
+system's physical memory address space.  Below example shows a command target
+usage::
 
     # cd <kernel>/tools/damon/
     # damo record "sleep 5"
@@ -71,6 +73,15 @@ of the process.  Below example shows a pid target usage::
     # sleep 5 &
     # damo record `pidof sleep`
 
+Finally, below example shows the use of the special keyword, 'paddr'::
+
+    # damo record paddr
+
+In this case, the monitoring target regions defaults to the largetst 'System
+RAM' region specified in '/proc/iomem' file.  Note that the initial monitoring
+target region is maintained rather than dynamically updated like the virtual
+memory address spaces monitoring mode.
+
 You can tune this by setting the monitoring attributes and path to the record
 file using optional arguments to the subcommand.  To know about the monitoring
 attributes in detail, please refer to :doc:`mechanisms`.
@@ -314,27 +325,42 @@ check it again::
 Target PIDs
 -----------
 
-Users can get and set the pids of monitoring target processes by reading from
-and writing to the ``pids`` file.  For example, below commands set processes
-having pids 42 and 4242 as the processes to be monitored and check it again::
+To monitor the virtual memory address spaces of specific processes, users can
+get and set the pids of monitoring target processes by reading from and writing
+to the ``pids`` file.  For example, below commands set processes having pids 42
+and 4242 as the processes to be monitored and check it again::
 
     # cd <debugfs>/damon
     # echo 42 4242 > pids
     # cat pids
     42 4242
 
+Users can also monitor the physical memory address space of the system by
+writing a special keyword, "``paddr\n``" to the file.  In this case, reading the
+file will show ``-1``, as below::
+
+    # cd <debugfs>/damon
+    # echo paddr > pids
+    # cat pids
+    -1
+
 Note that setting the pids doesn't start the monitoring.
 
 
 Initial Monitoring Target Regions
 ---------------------------------
 
-DAMON automatically sets and updates the monitoring target regions so that
-entire memory mappings of target processes can be covered.  However, users
-might want to limit the monitoring region to specific address ranges, such as
-the heap, the stack, or specific file-mapped area.  Or, some users might know
-the initial access pattern of their workloads and therefore want to set optimal
-initial regions for the 'adaptive regions adjustment'.
+In case of the virtual memory monitoring, DAMON automatically sets and updates
+the monitoring target regions so that entire memory mappings of target
+processes can be covered.  However, users might want to limit the monitoring
+region to specific address ranges, such as the heap, the stack, or specific
+file-mapped area.  Or, some users might know the initial access pattern of
+their workloads and therefore want to set optimal initial regions for the
+'adaptive regions adjustment'.
+
+In contrast, DAMON do not automatically sets and updates the monitoring target
+regions in case of physical memory monitoring.  Therefore, users should set the
+monitoring target regions by themselves.
 
 In such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the ``init_regions`` file.  Each line
@@ -354,10 +380,11 @@ region of process 42, and another couple of address ranges, ``20-40`` and
             4242 20      40
             4242 50      100" > init_regions
 
-Note that this sets the initial monitoring target regions only.  DAMON will
-automatically updates the boundary of the regions after one ``regions update
-interval``.  Therefore, users should set the ``regions update interval`` large
-enough.
+Note that this sets the initial monitoring target regions only.  In case of
+virtual memory monitoring, DAMON will automatically updates the boundary of the
+regions after one ``regions update interval``.  Therefore, users should set the
+``regions update interval`` large enough in this case, if they don't want the
+update.
 
 
 Record
-- 
2.17.1

