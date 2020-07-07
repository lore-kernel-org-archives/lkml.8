Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB827C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCD12065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k1IYBEs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGGJlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:41:55 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:9917 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgGGJly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594114911; x=1625650911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=i0l61VSi/Iy+2IM/91sEvKdZCdRGUmm7EDVXtSwQRuU=;
  b=k1IYBEs3E/J7WqRj7cdSno+BjPP+G34GGLNuNGY7rAKun09O3xu8Hcts
   z4SKeKIyr2seeGOvar/fAIgio5K+F3V+KuVBhuEBqrbZ24bEpVfBJWtYt
   eMZW4evnyACDV+mNboceqVTIkAX1x0Y1Nsxya+b2D9dGz8lfGR/SJpfQL
   I=;
IronPort-SDR: +oyVR9xMejH+31zqXTzpEGy4Db1zGeCEKY1ocRxK/HIWv8bRuR6YdDOzEvN443dUOxFYclqRGM
 7uFcD6ih6d7g==
X-IronPort-AV: E=Sophos;i="5.75,323,1589241600"; 
   d="scan'208";a="40572825"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Jul 2020 09:41:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 9267EA1EB2;
        Tue,  7 Jul 2020 09:41:31 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 09:41:30 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 09:41:14 +0000
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
Subject: [RFC v13 8/8] Documentation/admin-guide/mm: Document DAMON-based operation schemes
Date:   Tue, 7 Jul 2020 11:38:05 +0200
Message-ID: <20200707093805.4775-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707093805.4775-1-sjpark@amazon.com>
References: <20200707093805.4775-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D36UWA002.ant.amazon.com (10.43.160.24) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit documents DAMON-based operation schemes in the DAMON
document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/guide.rst |  41 +++++-
 Documentation/admin-guide/mm/damon/plans.rst |  24 +---
 Documentation/admin-guide/mm/damon/start.rst |  11 ++
 Documentation/admin-guide/mm/damon/usage.rst | 124 +++++++++++++++++--
 4 files changed, 165 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/guide.rst b/Documentation/admin-guide/mm/damon/guide.rst
index 77775b73f015..783fef558f3b 100644
--- a/Documentation/admin-guide/mm/damon/guide.rst
+++ b/Documentation/admin-guide/mm/damon/guide.rst
@@ -53,6 +53,11 @@ heats``.  If it shows a simple pattern consists of a small number of memory
 regions having high contrast of access temperature, you could consider manual
 `Program Modification`_.
 
+If the access pattern is very frequently changing so that you cannot figure out
+what is the performance important region using your human eye, `Automated
+DAMON-based Memory Operations`_ might help the case owing to its machine-level
+microscope view.
+
 If you still want to absorb more benefits, you should develop `Personalized
 DAMON Application`_ for your special case.
 
@@ -158,6 +163,36 @@ hot object.
           The chronological changes of working set size.
 
 
+Automated DAMON-based Memory Operations
+---------------------------------------
+
+Though `Manual Program Optimization` works well in many cases and DAMON can
+help it, modifying the source code is not a good option in many cases.  First
+of all, the source code could be too old or unavailable.  And, many workloads
+will have complex data access patterns that even hard to distinguish hot memory
+objects and cold memory objects with the human eye.  Finding the mapping from
+the visualized access pattern to the source code and injecting the hinting
+system calls inside the code will also be quite challenging.
+
+By using DAMON-based operation schemes (DAMOS) via ``damo schemes``, you will
+be able to easily optimize your workload in such a case.  Our example schemes
+called 'efficient THP' and 'proactive reclamation' achieved significant speedup
+and memory space saves against 25 realistic workloads [2]_.
+
+That said, note that you need careful tune of the schemes (e.g., target region
+size and age) and monitoring attributes for the successful use of this
+approach.  Because the optimal values of the parameters will be dependent on
+each system and workload, misconfiguring the parameters could result in worse
+memory management.
+
+For the tuning, you could measure the performance metrics such as IPC, TLB
+misses, and swap in/out events and adjusts the parameters based on their
+changes.  The total number and the total size of the regions that each scheme
+is applied, which are provided via the debugfs interface and the programming
+interface can also be useful.  Writing a program automating this optimal
+parameter could be an option.
+
+
 Personalized DAMON Application
 ------------------------------
 
@@ -183,9 +218,9 @@ Referencing previously done successful practices could help you getting the
 sense for this kind of optimizations.  There is an academic paper [1]_
 reporting the visualized access pattern and manual `Program
 Modification`_ results for a number of realistic workloads.  You can also get
-the visualized access patterns [3]_ [4]_ [5]_ and automated DAMON-based
-memory operations results for other realistic workloads that collected with
-latest version of DAMON [2]_.
+the visualized access patterns [3]_ [4]_ [5]_ and
+`Automated DAMON-based Memory Operations`_ results for other realistic
+workloads that collected with latest version of DAMON [2]_ .
 
 .. [1] https://dl.acm.org/doi/10.1145/3366626.3368125
 .. [2] https://damonitor.github.io/test/result/perf/latest/html/
diff --git a/Documentation/admin-guide/mm/damon/plans.rst b/Documentation/admin-guide/mm/damon/plans.rst
index e3aa5ab96c29..765344f02eb3 100644
--- a/Documentation/admin-guide/mm/damon/plans.rst
+++ b/Documentation/admin-guide/mm/damon/plans.rst
@@ -4,26 +4,4 @@
 Future Plans
 ============
 
-DAMON is still on its first stage.  Below plans are still under development.
-
-
-Automate Data Access Monitoring-based Memory Operation Schemes Execution
-========================================================================
-
-The ultimate goal of DAMON is to be used as a building block for the data
-access pattern aware kernel memory management optimization.  It will make
-system just works efficiently.  However, some users having very special
-workloads will want to further do their own optimization.  DAMON will automate
-most of the tasks for such manual optimizations in near future.  Users will be
-required to only describe what kind of data access pattern-based operation
-schemes they want in a simple form.
-
-By applying a very simple scheme for THP promotion/demotion with a prototype
-implementation, DAMON reduced 60% of THP memory footprint overhead while
-preserving 50% of the THP performance benefit.  The detailed results can be
-seen on an external web page [1]_.
-
-Several RFC patchsets for this plan are available [2]_.
-
-.. [1] https://damonitor.github.io/test/result/perf/latest/html/
-.. [2] https://lore.kernel.org/linux-mm/20200616073828.16509-1-sjpark@amazon.com/
+TBD.
diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 4b861509565d..ae61ca75dc80 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -112,6 +112,17 @@ workloads at external web pages [1]_ [2]_ [3]_.
 
           The chronological changes of working set size.
 
+
+Data Access Pattern Aware Memory Management
+===========================================
+
+Below three commands make every memory region of size >=4K that doesn't
+accessed for >=60 seconds in your workload to be swapped out. ::
+
+    $ echo "#min-size max-size min-acc max-acc min-age max-age action" > scheme
+    $ echo "4K        max      0       0       60s     max     pageout" >> scheme
+    $ damo schemes -c my_thp_scheme <pid of your workload>
+
 .. [1] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.png.html
 .. [2] https://damonitor.github.io/test/result/visual/latest/rec.wss_sz.png.html
 .. [3] https://damonitor.github.io/test/result/visual/latest/rec.wss_time.png.html
diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9d71f04d12ee..153f07da9368 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -218,11 +218,70 @@ Similar to that of ``heats --heatmap``, it also supports 'gnuplot' based simple
 visualization of the distribution via ``--plot`` option.
 
 
+DAMON-based Operation Schemes
+-----------------------------
+
+The ``schemes`` subcommand allows users to do DAMON-based memory management
+optimizations in a few seconds.  Similar to ``record``, it receives monitoring
+attributes and target.  However, in addition to those, ``schemes`` receives
+data access pattern-based memory operation schemes, which describes what memory
+operation action should be applied to memory regions showing specific data
+access pattern.  Then, it starts the data access monitoring and automatically
+applies the schemes to the targets.
+
+The operation schemes should be saved in a text file in below format and passed
+to ``schemes`` subcommand via ``--schemes`` option. ::
+
+    min-size max-size min-acc max-acc min-age max-age action
+
+The format also supports comments, several units for size and age of regions,
+and human readable action names.  Currently supported operation actions are
+``willneed``, ``cold``, ``pageout``, ``hugepage`` and ``nohugepage``.  Each of
+the actions works same to the madvise() system call hints having the name.
+Please also note that the range is inclusive (closed interval), and ``0`` for
+max values means infinite. Below example schemes are possible. ::
+
+    # format is:
+    # <min/max size> <min/max frequency (0-100)> <min/max age> <action>
+    #
+    # B/K/M/G/T for Bytes/KiB/MiB/GiB/TiB
+    # us/ms/s/m/h/d for micro-seconds/milli-seconds/seconds/minutes/hours/days
+    # 'min/max' for possible min/max value.
+
+    # if a region keeps a high access frequency for >=100ms, put the region on
+    # the head of the LRU list (call madvise() with MADV_WILLNEED).
+    min    max      80      max     100ms   max willneed
+
+    # if a region keeps a low access frequency for >=200ms and <=one hour, put
+    # the region on the tail of the LRU list (call madvise() with MADV_COLD).
+    min     max     10      20      200ms   1h  cold
+
+    # if a region keeps a very low access frequency for >=60 seconds, swap out
+    # the region immediately (call madvise() with MADV_PAGEOUT).
+    min     max     0       10      60s     max pageout
+
+    # if a region of a size >=2MiB keeps a very high access frequency for
+    # >=100ms, let the region to use huge pages (call madvise() with
+    # MADV_HUGEPAGE).
+    2M      max     90      100     100ms   max hugepage
+
+    # If a regions of a size >=2MiB keeps small access frequency for >=100ms,
+    # avoid the region using huge pages (call madvise() with MADV_NOHUGEPAGE).
+    2M      max     0       25      100ms   max nohugepage
+
+For example, you can make a running process named 'foo' to use huge pages for
+memory regions keeping 2MB or larger size and having very high access frequency
+for at least 100 milliseconds using below commands::
+
+    $ echo "2M max    90 max    100ms max    hugepage" > my_thp_scheme
+    $ ./damo schemes --schemes my_thp_scheme `pidof foo`
+
+
 debugfs Interface
 =================
 
-DAMON exports four files, ``attrs``, ``pids``, ``record``, and ``monitor_on``
-under its debugfs directory, ``<debugfs>/damon/``.
+DAMON exports five files, ``attrs``, ``pids``, ``record``, ``schemes`` and
+``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
 
 
 Attributes
@@ -274,16 +333,63 @@ saved in ``/damon.data``. ::
 The recording can be disabled by setting the buffer size zero.
 
 
+Schemes
+-------
+
+For usual DAMON-based data access aware memory management optimizations, users
+would simply want the system to apply a memory management action to a memory
+region of a specific size having a specific access frequency for a specific
+time.  DAMON receives such formalized operation schemes from the user and
+applies those to the target processes.  It also counts the total number and
+size of regions that each scheme is applied.  This statistics can be used for
+online analysis or tuning of the schemes.
+
+Users can get and set the schemes by reading from and writing to ``schemes``
+debugfs file.  Reading the file also shows the statistics of each scheme.  To
+the file, each of the schemes should be represented in each line in below form:
+
+    min-size max-size min-acc max-acc min-age max-age action
+
+Note that the ranges are closed interval.  Bytes for the size of regions
+(``min-size`` and ``max-size``), number of monitored accesses per aggregate
+interval for access frequency (``min-acc`` and ``max-acc``), number of
+aggregate intervals for the age of regions (``min-age`` and ``max-age``), and a
+predefined integer for memory management actions should be used.  The supported
+numbers and their meanings are as below.
+
+ - 0: Call ``madvise()`` for the region with ``MADV_WILLNEED``
+ - 1: Call ``madvise()`` for the region with ``MADV_COLD``
+ - 2: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
+ - 3: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
+ - 4: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+ - 5: Do nothing but count the statistics
+
+You can disable schemes by simply writing an empty string to the file.  For
+example, below commands applies a scheme saying "If a memory region of size in
+[4KiB, 8KiB] is showing accesses per aggregate interval in [0, 5] for aggregate
+interval in [10, 20], page out the region", check the entered scheme again, and
+finally remove the scheme. ::
+
+    # cd <debugfs>/damon
+    # echo "4096 8192    0 5    10 20    2" > schemes
+    # cat schemes
+    4096 8192 0 5 10 20 2 0 0
+    # echo > schemes
+
+The last two integers in the 4th line of above example is the total number and
+the total size of the regions that the scheme is applied.
+
 Turning On/Off
 --------------
 
-Setting the files as described above doesn't incur effect unless you
-explicitly start the monitoring.  You can start, stop, and check the current
-status of the monitoring by writing to and reading from the ``monitor_on``
-file.  Writing ``on`` to the file starts the monitoring and recording of the
-targets with the attributes.  Writing ``off`` to the file stops those.  DAMON
-also stops if every target process is terminated.  Below example commands turn
-on, off, and check the status of DAMON::
+Setting the files as described above doesn't incur effect unless you explicitly
+start the monitoring.  You can start, stop, and check the current status of the
+monitoring by writing to and reading from the ``monitor_on`` file.  Writing
+``on`` to the file starts the monitoring of the targets with the attributes.
+Recording and schemes will also start work if requested before.  Writing
+``off`` to the file stops those.  DAMON also stops if every target process is
+terminated.  Below example commands turn on, off, and check the status of
+DAMON::
 
     # cd <debugfs>/damon
     # echo on > monitor_on
-- 
2.17.1

