Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86199C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6B8206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J2rOFAA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgGGOut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:50:49 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:29202 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgGGOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594133447; x=1625669447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPPawWKOCJ+KeiYfy+BMQZKBX+GVe2sPytsHFts75C8=;
  b=J2rOFAA7VAFe6AXzylTBqMaK9p6IDKpfvb9qVV7zNKPPhddT0OjWWJ5P
   Ujmjb1oV18idQPUZoSMSVJ2R8yWwpocNyMvVDob7/fNIivuH1iIJZyZbc
   cw0d0SiZ9nmjzetyAbn9hK9ZWrZnD0O6HdCtdQhIBmqrxU5EaCg0lmDND
   c=;
IronPort-SDR: PSfc9SmJSsmmnz3c++8acCuxf9WSMe1W5waLdPvWIMD5zF2pvqDqvqSWi+tSHglAE/VSSm3SsN
 QuSLTxmIohrA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589241600"; 
   d="scan'208";a="49757050"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jul 2020 14:50:47 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id E34E6A1E3F;
        Tue,  7 Jul 2020 14:50:43 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:50:43 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:50:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v5 11/11] Docs/damon: Document physical memory monitoring support
Date:   Tue, 7 Jul 2020 16:45:40 +0200
Message-ID: <20200707144540.21216-12-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707144540.21216-1-sjpark@amazon.com>
References: <20200707144540.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds description for the physical memory monitoring usage in
the DAMON document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/faq.rst    |  7 ++-
 Documentation/admin-guide/mm/damon/index.rst  |  1 -
 .../admin-guide/mm/damon/mechanisms.rst       | 29 +++++-----
 Documentation/admin-guide/mm/damon/plans.rst  |  7 ---
 Documentation/admin-guide/mm/damon/usage.rst  | 53 ++++++++++++++-----
 5 files changed, 60 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/admin-guide/mm/damon/plans.rst

diff --git a/Documentation/admin-guide/mm/damon/faq.rst b/Documentation/admin-guide/mm/damon/faq.rst
index f55d1d719999..ff630cf5fce1 100644
--- a/Documentation/admin-guide/mm/damon/faq.rst
+++ b/Documentation/admin-guide/mm/damon/faq.rst
@@ -44,10 +44,9 @@ constructions and actual access checks can be implemented and configured on the
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
index c6e657f8e90c..6e36149053fa 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -32,4 +32,3 @@ workloads and systems.
    faq
    mechanisms
    eval
-   plans
diff --git a/Documentation/admin-guide/mm/damon/mechanisms.rst b/Documentation/admin-guide/mm/damon/mechanisms.rst
index 16066477bb2c..fb33d8d8a09c 100644
--- a/Documentation/admin-guide/mm/damon/mechanisms.rst
+++ b/Documentation/admin-guide/mm/damon/mechanisms.rst
@@ -25,9 +25,11 @@ files, and backing devices would be supportable.  Also, if some architectures
 or kernel module support special access check primitives for specific address
 space, those will be easily configurable.
 
-DAMON currently provides an implementation of the primitives for the virtual
-address space.  It uses VMA for the target address range identification and PTE
-Accessed bit for the access check.
+DAMON currently provides an implementation of the primitives for the physical
+and virtual address spaces.  The implementation for the physical address space
+ask users to manually set the monitoring target address ranges while the
+implementation for the virtual address space uses VMA for the target address
+range identification.  Both uses PTE Accessed bit for the access check.
 
 Below four sections describe the address independent core mechanisms and the
 five knobs for tuning, that is, ``sampling interval``, ``aggregation
@@ -113,26 +115,29 @@ memory mapping changes and applies it to the abstracted target area only for
 each of a user-specified time interval (``regions update interval``).
 
 
-Virtual Address Space Specific Low Primitives
-=============================================
+Address Space Specific Low Primitives
+=====================================
 
-This is for the DAMON's reference implementation of the virtual memory address
-specific low level primitive only.
+This is for the DAMON's reference implementation of the address space specific
+low level primitive only.
 
 
 PTE Accessed-bit Based Access Check
 -----------------------------------
 
-The implementation uses PTE Accessed-bit for basic access checks.  That is, it
-clears the bit for next sampling target page and checks whether it set again
-after one sampling period.  To avoid disturbing other Accessed bit users such
-as the reclamation logic, this implementation adjusts the ``PG_Idle`` and
-``PG_Young`` appropriately, as same to the 'Idle Page Tracking'.
+Both of the implementations for physical and virtual address spaces use PTE
+Accessed-bit for basic access checks.  That is, those clears the bit for next
+sampling target page and checks whether it set again after one sampling period.
+To avoid disturbing other Accessed bit users such as the reclamation logic, the
+implementations adjust the ``PG_Idle`` and ``PG_Young`` appropriately, as same
+to the 'Idle Page Tracking'.
 
 
 VMA-based Target Address Range Construction
 -------------------------------------------
 
+This is for the virtual address space specific primitives implementation.
+
 Only small parts in the super-huge virtual address space of the processes are
 mapped to the physical memory and accessed.  Thus, tracking the unmapped
 address regions is just wasteful.  However, because DAMON can deal with some
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
index 573fcb4c57a7..356281078d4d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -10,15 +10,16 @@ DAMON provides below three interfaces for different users.
   This is for privileged people such as system administrators who want a
   just-working human-friendly interface.  Using this, users can use the DAMON’s
   major features in a human-friendly way.  It may not be highly tuned for
-  special cases, though.  It supports virtual address space monitoring only.
+  special cases, though.  It supports both virtual and physical address spaces
+  monitoring.
 - *debugfs interface.*
   This is for privileged user space programmers who want more optimized use of
   DAMON.  Using this, users can use DAMON’s major features by reading
   from and writing to special debugfs files.  Therefore, you can write and use
   your personalized DAMON debugfs wrapper programs that reads/writes the
   debugfs files instead of you.  The DAMON user space tool is also a reference
-  implementation of such programs.  It supports virtual address space
-  monitoring only.
+  implementation of such programs.  It supports both virtual and physical
+  address spaces monitoring.
 - *Kernel Space Programming Interface.*
   This is for kernel space programmers.  Using this, users can utilize every
   feature of DAMON most flexibly and efficiently by writing kernel space
@@ -48,9 +49,11 @@ Recording Data Access Pattern
 -----------------------------
 
 The ``record`` subcommand records the data access pattern of target workloads
-in a file (``./damon.data`` by default).  You can specify the target as either
-process id of running target or a command for execution of it.  Below example
-shows a command target usage::
+in a file (``./damon.data`` by default).  You can specify the target with 1)
+the command for execution of the monitoring target process, 2) pid of running
+target process, or 3) the special keyword, 'paddr', if you want to monitor the
+system's physical memory address space.  Below example shows a command target
+usage::
 
     # cd <kernel>/tools/damon/
     # damo record "sleep 5"
@@ -61,6 +64,15 @@ of the process.  Below example shows a pid target usage::
     # sleep 5 &
     # damo record `pidof sleep`
 
+Finally, below example shows the use of the special keyword, 'paddr'::
+
+    # damo record paddr
+
+In this case, the monitoring target regions defaults to the largetst 'System
+RAM' region specified in '/proc/iomem' file.  Note that the initial monitoring
+target region is maintained rather than dynamically updated like the virtual
+memory address spaces monitoring case.
+
 The location of the recorded file can be explicitly set using ``-o`` option.
 You can further tune this by setting the monitoring attributes.  To know about
 the monitoring attributes in detail, please refer to :doc:`mechanisms`.
@@ -303,15 +315,25 @@ check it again::
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
 
 
@@ -326,6 +348,10 @@ file-mapped area. Or, some users might know the initial access pattern of their
 workloads and therefore want to set optimal initial regions for the 'adaptive
 regions adjustment'.
 
+In contrast, DAMON do not automatically sets and updates the monitoring target
+regions in case of physical memory monitoring.  Therefore, users should set the
+monitoring target regions by themselves.
+
 In such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the ``init_regions`` file.  Each line
 of the input should represent one region in below form.::
@@ -344,10 +370,11 @@ region of process 42, and another couple of address ranges, ``20-40`` and
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

