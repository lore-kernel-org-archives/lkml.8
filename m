Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09612C33CA6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6D820842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v/+fcVi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgAJNQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:16:18 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46508 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgAJNQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578662175; x=1610198175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WerMUO/qpSqjTgSXC4CARN0MxavhaBRm9YNNK0ZfhrM=;
  b=v/+fcVi+Ke8kU9jc7Ev/ZqKpKbusQ9btH1EXrT5dpwwPraLvL+ESItuc
   bzR81hN7BXBaiqtB2MhadK8JL3URjioDv6//9XdI6dV/prQm124wMUebt
   FCnHfzJb7feT7rzyATshQcqjsCg4+qHIkxujbO43abMDBMN2CPKSiYEmN
   E=;
IronPort-SDR: 3RVzEwdQvjmq7wiM5YWZTP89FsDgphbyHOKX/HZgyySmxvue4fF4tk7eqap/VYYW4sSxkwb7/O
 6vr7iY/aTaMw==
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="17962751"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 Jan 2020 13:16:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 122FDA230F;
        Fri, 10 Jan 2020 13:16:09 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Fri, 10 Jan 2020 13:16:09 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.115) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 10 Jan 2020 13:16:05 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>, <mgorman@suse.de>,
        <brendanhiggins@google.com>, <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: [RFC PATCH 4/5] Documentation/admin-guide/mm: Add a document for DAMON
Date:   Fri, 10 Jan 2020 14:15:21 +0100
Message-ID: <20200110131522.29964-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110131522.29964-1-sjpark@amazon.com>
References: <20200110131522.29964-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.115]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a simple document for DAMON under
'Documentation/admin-guide/mm/'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../admin-guide/mm/data_access_monitor.rst    | 235 ++++++++++++++++++
 Documentation/admin-guide/mm/index.rst        |   1 +
 2 files changed, 236 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/data_access_monitor.rst

diff --git a/Documentation/admin-guide/mm/data_access_monitor.rst b/Documentation/admin-guide/mm/data_access_monitor.rst
new file mode 100644
index 000000000000..907a7af75f35
--- /dev/null
+++ b/Documentation/admin-guide/mm/data_access_monitor.rst
@@ -0,0 +1,235 @@
+.. _data_access_monitor:
+
+==========================
+DAMON: Data Access MONitor
+==========================
+
+
+Too Long; Don't Read
+====================
+
+DAMON is a kernel module that allows users to monitor the actual memory access
+pattern of specific user-space processes.  It aims to be 1) accurate enough to
+be useful for performance-centric domains, and 2) sufficiently light-weight so
+that it can be applied online.
+
+For the goals, DAMON utilizes its two core mechanisms, called region-based
+sampling and adaptive regions adjustment.  The region-based sampling allows
+users to make their own trade-off between the quality and the overhead of the
+monitoring and set the upperbound of the monitoring overhead.  Further, the
+adaptive regions adjustment mechanism makes DAMON to maximize the quality and
+minimize the overhead with its best efforts while preserving the users
+configured trade-off.
+
+
+Background
+==========
+
+For performance-centric analysis and optimizations of memory management schemes
+(either that of kernel space or user space), the actual data access pattern of
+the workloads is highly useful.  The information need to be only reasonable
+rather than strictly correct, because some level of incorrectness can be
+handled in many performance-centric domains.  It also need to be taken within
+reasonably short time with only light-weight overhead.
+
+Manually extracting such data is not easy and time consuming if the target
+workload is huge and complex, even for the developers of the programs.  There
+are a range of tools and techniques developed for general memory access
+investigations, and some of those could be partially used for this purpose.
+However, most of those are not practical or unscalable, mainly because those
+are designed with no consideration about the trade-off between the accuracy of
+the output and the overhead.
+
+The memory access instrumentation techniques which is applied to many tools
+such as Intel PIN is essential for correctness required cases such as invalid
+memory access bug detections.  However, those usually incur high overhead which
+is unacceptable for many of the performance-centric domains.  Periodic access
+checks based on H/W or S/W access counting features (e.g., the Accessed bits of
+PTEs or the PG_Idle flags of pages) can dramatically decrease the overhead by
+forgiving some of the quality, compared to the instrumentation based
+techniques.  The reduced quality is still reasonable for many of the domains,
+but the overhead can arbitrarily increase as the size of the target workload
+grows.  Miniature-like static region based sampling can set the upperbound of
+the overhead, but it will now decrease the quality of the output as the size of
+the workload grows.
+
+
+Expected Use-cases
+==================
+
+A straightforward usecase of DAMON would be the program behavior analysis.
+With the DAMON output, users can confirm whether the program is running as
+intended or not.  This will be useful for debuggings and tests of design
+points.
+
+The monitored results can also be useful for counting the dynamic working set
+size of workloads.  For the administration of memory overcommitted systems or
+selection of the environments (e.g., containers providing different amount of
+memory) for your workloads, this will be useful.
+
+If you are a programmer, you can optimize your program by managing the memory
+based on the actual data access pattern.  For example, you can identify the
+dynamic hotness of your data using DAMON and call ``mlock()`` to keep your hot
+data in DRAM, or call ``madvise()`` with ``MADV_PAGEOUT`` to proactively
+reclaim cold data.  Even though your program is guaranteed to not encounter
+memory pressure, you can still improve the performance by applying the DAMON
+outputs for call of ``MADV_HUGEPAGE`` and ``MADV_NOHUGEPAGE``.  More creative
+optimizations would be possible.  Our evaluations of DAMON includes a
+straightforward optimization using the ``mlock()``.  Please refer to the below
+Evaluation section for more detail.
+
+As DAMON incurs very low overhead, such optimizations can be applied not only
+offline, but also online.  Also, there is no reason to limit such optimizations
+to the user space.  Several parts of the kernel's memory management mechanisms
+could be also optimized using DAMON. The reclamation, the THP (de)promotion
+decisions, and the compaction would be such a candidates.
+
+
+Mechanisms of DAMON
+===================
+
+
+Basic Access Check
+------------------
+
+DAMON basically reports what pages are how frequently accessed.  The report is
+passed to users in binary format via a ``result file`` which users can set it's
+path.  Note that the frequency is not an absolute number of accesses, but a
+relative frequency among the pages of the target workloads.
+
+Users can also control the resolution of the reports by setting two time
+intervals, ``sampling interval`` and ``aggregation interval``.  In detail,
+DAMON checks access to each page per ``sampling interval``, aggregates the
+results (counts the number of the accesses to each page), and reports the
+aggregated results per ``aggregation interval``.  For the access check of each
+page, DAMON uses the Accessed bits of PTEs.
+
+This is thus similar to the previously mentioned periodic access checks based
+mechanisms, which overhead is increasing as the size of the target process
+grows.
+
+
+Region Based Sampling
+---------------------
+
+To avoid the unbounded increase of the overhead, DAMON groups a number of
+adjacent pages that assumed to have same access frequencies into a region.  As
+long as the assumption (pages in a region have same access frequencies) is
+kept, only one page in the region is required to be checked.  Thus, for each
+``sampling interval``, DAMON randomly picks one page in each region and clears
+its Accessed bit.  After one more ``sampling interval``, DAMON reads the
+Accessed bit of the page and increases the access frequency of the region if
+the bit has set meanwhile.  Therefore, the monitoring overhead is controllable
+by setting the number of regions.  DAMON allows users to set the minimal and
+maximum number of regions for the trade-off.
+
+Except the assumption, this is almost same with the above-mentioned
+miniature-like static region based sampling.  In other words, this scheme
+cannot preserve the quality of the output if the assumption is not guaranteed.
+
+
+Adaptive Regions Adjustment
+---------------------------
+
+At the beginning of the monitoring, DAMON constructs the initial regions by
+evenly splitting the memory mapped address space of the process into the
+user-specified minimal number of regions.  In this initial state, the
+assumption is normally not kept and thus the quality could be low.  To keep the
+assumption as much as possible, DAMON adaptively merges and splits each region.
+For each ``aggregation interval``, it compares the access frequencies of
+adjacent regions and merges those if the frequency difference is small.  Then,
+after it reports and clears the aggregated access frequency of each region, it
+splits each region into two regions if the total number of regions is smaller
+than the half of the user-specified maximum number of regions.
+
+In this way, DAMON provides its best-effort quality and minimal overhead while
+keeping the bounds users set for their trade-off.
+
+
+Applying Dynamic Memory Mappings
+--------------------------------
+
+Only a number of small parts in the super-huge virtual address space of the
+processes is mapped to physical memory and accessed.  Thus, tracking the
+unmapped address regions is just wasteful.  However, tracking every memory
+mapping change might incur an overhead.  For the reason, DAMON applies the
+dynamic memory mapping changes to the tracking regions only for each of an
+user-specified time interval (``regions update interval``).
+
+
+User Interface
+==============
+
+DAMON exports three files, ``attrs``, ``pids``, and ``monitor_on`` under its
+debugfs directory, ``<debugfs>/damon/``.
+
+
+Attributes
+----------
+
+Users can read and write the ``sampling interval``, ``aggregation interval``,
+``regions update interval``, min/max number of regions, and the path to
+``result file`` by reading from and writing to the ``attrs`` file.  For
+example, below commands set those values to 5 ms, 100 ms, 1,000 ms, 10, 1000,
+and ``/damon.data`` and check it again::
+
+    # cd <debugfs>/damon
+    # echo 5000 100000 1000000 10 1000 /damon.data > attrs
+    # cat attrs
+    5000 100000 1000000 10 1000 /damon.data
+
+
+Target PIDs
+-----------
+
+Users can read and write the pids of current monitoring target processes by
+reading from and writing to the `pids` file.  For example, below commands set
+processes having pids 42 and 4242 as the processes to be monitored and check
+it again::
+
+    # cd <debugfs>/damon
+    # echo 42 4242 > pids
+    # cat pids
+    42 4242
+
+Note that setting the pids doesn't starts the monitoring.
+
+
+Turning On/Off
+--------------
+
+You can check current status, start and stop the monitoring by reading from and
+writing to the ``monitor_on`` file.  Writing ``on`` to the file starts DAMON to
+monitor the target processes with the attributes.  Writing ``off`` to the file
+stops DAMON.  DAMON also stops if every target processes is be terminated.
+Below example commands turn on, off, and check status of DAMON::
+
+    # cd <debugfs>/damon
+    # echo on > monitor_on
+    # echo off > monitor_on
+    # cat monitor_on
+    off
+
+Please note that you cannot write to the ``attrs`` and ``pids`` files while the
+monitoring is turned on.  If you write to the files while DAMON is running,
+``-EINVAL`` will be returned.
+
+
+User Space Wrapper
+------------------
+
+DAMON has a shallow wrapper python script, ``/tools/damon/damn`` that provides
+more convenient interface.  Note that it is only aimed to be used for minimal
+reference of the DAMON's raw interfaces and for debugging of the DAMON itself.
+Based on the debugfs interface, you can create another cool and more convenient
+user space tools.
+
+
+Quick Tutorial
+--------------
+
+To test DAMON on your system,
+
+1. Ensure your kernel is built with CONFIG_DAMON turned on, and debugfs is
+   mounted at ``/sys/kernel/debug/``.
+2. ``<your kernel source tree>/tools/damon/damn -h``
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 11db46448354..d3d0ba373eb6 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -27,6 +27,7 @@ the Linux memory management.
 
    concepts
    cma_debugfs
+   data_access_monitor
    hugetlbpage
    idle_page_tracking
    ksm
-- 
2.17.1

