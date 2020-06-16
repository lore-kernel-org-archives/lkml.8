Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51824C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF9D20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b5JLPgOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgFPONH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:13:07 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43570 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592316785; x=1623852785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Ca8DlQAlerKhHdi7ITKEKAXpP8xJZRRbzDPmzlgJzIw=;
  b=b5JLPgOhievFcyaP20syy/j4pbfnpboXC7OwfDmqXizdOxBtukpV48ri
   UNcXaEQ/hNG76cDaM6gHS+a+TGG+nelQ3EAjjFrB76SedmHT/9+ARPiqq
   VadgQmnXjz18j6nHWuPuB7nYqumaLhvVeLbkQpWR2E2VH5m5XvKfndvWs
   s=;
IronPort-SDR: mKStTPImit/pCNcb2IDZHuCxECcH8x0uzJXcu1UblBWEBSVsl0/0LPfh5vydNSndJGIEofM1tr
 2HMzmozVAw0A==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="51357153"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 16 Jun 2020 14:13:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id CD30CA22AC;
        Tue, 16 Jun 2020 14:13:01 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:13:01 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:12:33 +0000
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
Subject: [RFC v4 8/8] Docs/damon: Document physical memory monitoring support
Date:   Tue, 16 Jun 2020 16:08:13 +0200
Message-ID: <20200616140813.17863-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616140813.17863-1-sjpark@amazon.com>
References: <20200616140813.17863-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D01UWB004.ant.amazon.com (10.43.161.157) To
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
 Documentation/admin-guide/mm/damon/faq.rst   |  7 +--
 Documentation/admin-guide/mm/damon/index.rst |  1 -
 Documentation/admin-guide/mm/damon/plans.rst |  7 ---
 Documentation/admin-guide/mm/damon/usage.rst | 59 ++++++++++++++------
 4 files changed, 46 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/admin-guide/mm/damon/plans.rst

diff --git a/Documentation/admin-guide/mm/damon/faq.rst b/Documentation/admin-guide/mm/damon/faq.rst
index b1f108009115..d72d6182d7ea 100644
--- a/Documentation/admin-guide/mm/damon/faq.rst
+++ b/Documentation/admin-guide/mm/damon/faq.rst
@@ -45,10 +45,9 @@ constructions and actual access checks can be implemented and configured on the
 DAMON core by the users.  In this way, DAMON users can monitor any address
 space with any access check technique.
 
-Nonetheless, DAMON provides a vma tracking and PTE Accessed bit check based
-implementation of the address space dependent functions for the virtual memory
-by default, for a reference and convenient use.  In near future, we will also
-provide that for physical memory address space.
+Nonetheless, DAMON provides vma/rmap tracking and PTE Accessed bit check based
+implementations of the address space dependent functions for the virtual memory
+and the physical memory by default, for a reference and convenient use.
 
 
 Can I simply monitor page granularity?
diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 4d128e4fd9c8..7b2939d50408 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -33,4 +33,3 @@ optimizations of their systems.
    faq
    mechanisms
    eval
-   plans
diff --git a/Documentation/admin-guide/mm/damon/plans.rst b/Documentation/admin-guide/mm/damon/plans.rst
deleted file mode 100644
index 765344f02eb3..000000000000
--- a/Documentation/admin-guide/mm/damon/plans.rst
+++ /dev/null
@@ -1,7 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-============
-Future Plans
-============
-
-TBD.
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 24f1b05a859a..b2bcbd6ebe9d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -61,9 +61,11 @@ Recording Data Access Pattern
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
@@ -74,6 +76,15 @@ of the process.  Below example shows a pid target usage::
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
@@ -317,27 +328,42 @@ check it again::
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
@@ -357,10 +383,11 @@ region of process 42, and another couple of address ranges, ``20-40`` and
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

