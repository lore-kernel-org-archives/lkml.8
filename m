Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB4CC54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C7F206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EI0gZjxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgELL6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:58:08 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:20647 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgELL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589284687; x=1620820687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fVTDlJRsj7WFzWh2TofOuuLmKGmvfqIkitYBNw6RneU=;
  b=EI0gZjxKQWRi6qi03nYy3Gfbjtf6YzQUFz2EEFpvBaNEsLZCAgaQG1v7
   QsuyeBzCZvTdp2wh8qMQJfVhxOKWkYpjGKewmBzjwHigSqP/5IA/lTAbF
   A83aeXPUbjFJHGK9Lmas/mosgmJoB0HAaTFWnA9ws02mPSz6L9+5RKH+A
   M=;
IronPort-SDR: +rFfzpSQ9silIKThJIsIokiEyFGt29J10p61d5JbNIi06DGUbgqZXFZ1kzDEtQlrcBNxSv6nzx
 2A3YzyMaD50A==
X-IronPort-AV: E=Sophos;i="5.73,383,1583193600"; 
   d="scan'208";a="34490141"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 12 May 2020 11:58:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id E87EBA1C12;
        Tue, 12 May 2020 11:58:03 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 11:58:03 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 11:57:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v8 8/8] Documentation/admin-guide/mm: Document DAMON-based operation schemes
Date:   Tue, 12 May 2020 13:53:43 +0200
Message-ID: <20200512115343.27699-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512115343.27699-1-sjpark@amazon.com>
References: <20200512115343.27699-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D17UWB003.ant.amazon.com (10.43.161.42) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit documents DAMON-based operation schemes in the DAMON
document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../admin-guide/mm/data_access_monitor.rst    | 100 +++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/data_access_monitor.rst b/Documentation/admin-guide/mm/data_access_monitor.rst
index 915956aa1065..d4a48bc63400 100644
--- a/Documentation/admin-guide/mm/data_access_monitor.rst
+++ b/Documentation/admin-guide/mm/data_access_monitor.rst
@@ -182,8 +182,8 @@ only for each of a user-specified time interval (``regions update interval``).
 ``debugfs`` Interface
 =====================
 
-DAMON exports four files, ``attrs``, ``pids``, ``record``, and ``monitor_on``
-under its debugfs directory, ``<debugfs>/damon/``.
+DAMON exports five files, ``attrs``, ``pids``, ``record``, ``schemes`` and
+``monitor_on`` under its debugfs directory, ``<debugfs>/damon/``.
 
 Attributes
 ----------
@@ -227,6 +227,46 @@ be 4 KiB and the result to be saved in ``/damon.data``::
     # cat record
     4096 /damon.data
 
+Schemes
+-------
+
+For usual DAMON-based data access awared memory management optimizations, users
+would simply want the system to apply a memory management action to a memory
+region of a specific size having a specific access frequency for a specific
+time.  DAMON receives such formalized operation schemes from user and applies
+those to the target processes.
+
+Users can get and set the schemes by reading from and writing to ``schemes``
+debugfs file.  To the file, each of the schemes should represented in each line
+in below form:
+
+    min-size max-size min-acc max-acc min-age max-age action
+
+Bytes for size of regions (``min-size`` and ``max-size``), number of monitored
+accesses per aggregate interval for access frequency (``min-acc`` and
+``max-acc``), number of aggregate intervals for age of regions (``min-age`` and
+``max-age``), and predefined integer for memory management actions should be
+used.  ``madvise()`` system call with specific hint are currently available.
+The numbers and their representing memory hint are as below::
+
+    0   MADV_WILLNEED
+    1   MADV_COLD
+    2   MADV_PAGEOUT
+    3   MADV_HUGEPAGE
+    4   MADV_NOHUGEPAGE
+
+You can disable schemes by simply writing empty string to the file.  For
+example, below commands applies a scheme saying “If a memory region larger than
+4 KiB (4096 0) is showing less than 5 accesses per aggregate interval (0 5) for
+more than 5 aggregate interval (5 0), page out the region (2)”, check the
+entered scheme again, and finally remove the scheme.::
+
+    # cd <debugfs>/damon
+    # echo "4096 0 0 5 5 0 2" > schemes
+    # cat schemes
+    4096 0 0 5 5 0 2
+    # echo > schemes
+
 Turning On/Off
 --------------
 
@@ -426,3 +466,59 @@ made.
 
 Users can specify the resolution of the distribution (``--range``).  It also
 supports 'gnuplot' based simple visualization (``--plot``) of the distribution.
+
+
+DAMON-based Operation Schemes
+-----------------------------
+
+The ``schemes`` subcommand applies given data access pattern based operation
+schemes to the given target processes.  The target processes are described
+using the command to spawn the processes or pid of running processes, as
+similar to that of ``record`` subcommand.  Meanwhile, the operation schemes
+should be saved in a text file using below format and passed to ``schemes``
+subcommand via ``--schemes`` option.
+
+    min-size max-size min-acc max-acc min-age max-age action
+
+The format also supports comments, several units for size and age of regions,
+and human readable action names.  Currently supported operation actions are
+WILLNEED, COLD, PAGEOUT, HUGEPAGE, and NOHUGEPAGE.  Each of the actions works
+as same to that of madvise() system call.  Below is an example schemes file.
+Please also note that 0 for max values means infinite.::
+
+    # format is:
+    # <min/max size> <min/max frequency (0-99)> <min/max age> <action>
+    #
+    # B/K/M/G/T for Bytes/KiB/MiB/GiB/TiB
+    # us/ms/s/m/h/d for micro-seconds/milli-seconds/seconds/minutes/hours/days
+    # 'null' means zero for size and age.
+
+    # if a region keeps a high access frequency for more than 100ms, put the
+    # region on the head of the LRU list (call madvise() with MADV_WILLNEED).
+    null    null    80      null    100ms   0s      willneed
+
+    # if a region keeps a low access frequency for more than 200ms and less
+    # than one hour, put the # region on the tail of the LRU list (call
+    # madvise() with MADV_COLD).
+    0B      0B      10      20      200ms   1h cold
+
+    # if a region keeps a very low access frequency for more than 1 minute,
+    # swap out the region immediately (call madvise() with MADV_PAGEOUT).
+    0B      null    0       10      60s     0s pageout
+
+    # if a region of a size bigger than 2MiB keeps a very high access frequency
+    # for more than 100ms, let the region to use huge pages (call madvise()
+    # with MADV_HUGEPAGE).
+    2M      null    90      99      100ms   0s hugepage
+
+    # If a regions of a size bigger than 2MiB keeps small access frequency for
+    # more than 100ms, avoid the region using huge pages (call madvise() with
+    # MADV_NOHUGEPAGE).
+    2M      null    0       25      100ms   0s nohugepage
+
+For example, you can make a running process named 'foo' to use THP for memory
+regions keeping 2MB or larger size and having very high access frequency for
+more than 100 milliseconds using below commands::
+
+    $ echo "2M null 90 99 100ms 0s hugepage" > my_thp_scheme
+    $ ./damo schemes --schemes my_thp_scheme `pidof foo`
-- 
2.17.1

