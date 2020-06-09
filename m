Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B233C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1292074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lr+cN9Bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgFIGyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:54:14 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15744 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgFIGyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591685648; x=1623221648;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=s+lAt2ovjJo4KeksjaOBsCKoxhOAqoXG5nSOSsxO0FE=;
  b=lr+cN9BktAIcj+Rx9NhBb9Xq632vapOYvAUGSJIxUvDD9wv0uE0Y/SZV
   kQmzOzwdoR1fZn1l3jfid6amPTAqGDhG0AyXmgGO2kdxE8AZPHUWNC7/F
   YuZC1sY8mP15YMMl1lFVuz3OEL+9MCpLirUEzw0yDE2107r50O4GIV7zn
   8=;
IronPort-SDR: M324Bj4pr4+IwN65o90dgSjczH3RssoQjlvoeYmd5OEKUawrPo7cZ1vps+tDFaDIcJdYUr9EsP
 4YlamzAcOJOw==
X-IronPort-AV: E=Sophos;i="5.73,490,1583193600"; 
   d="scan'208";a="35222063"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Jun 2020 06:54:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id D8018A18CC;
        Tue,  9 Jun 2020 06:53:54 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 06:53:53 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 06:53:38 +0000
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
Subject: [RFC v11 0/8] Implement Data Access Monitoring-based Memory Operation Schemes
Date:   Tue, 9 Jun 2020 08:53:12 +0200
Message-ID: <20200609065320.12941-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D31UWA004.ant.amazon.com (10.43.160.217) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON[1] can be used as a primitive for data access awared memory management
optimizations.  For that, users who want such optimizations should run DAMON,
read the monitoring results, analyze it, plan a new memory management scheme,
and apply the new scheme by themselves.  Such efforts will be inevitable for
some complicated optimizations.

However, in many other cases, the users would simply want the system to apply a
memory management action to a memory region of a specific size having a
specific access frequency for a specific time.  For example, "page out a memory
region larger than 100 MiB keeping only rare accesses more than 2 minutes", or
"Do not use THP for a memory region larger than 2 MiB rarely accessed for more
than 1 seconds".

This RFC patchset makes DAMON to handle such data access monitoring-based
operation schemes.  With this change, users can do the data access aware
optimizations by simply specifying their schemes to DAMON.

[1] https://lore.kernel.org/linux-mm/20200608114047.26589-1-sjpark@amazon.com/


Evaluations
===========

We evaluated DAMON's overhead, monitoring quality and usefulness using 25
realistic workloads on my QEMU/KVM based virtual machine running a kernel that
RFC v9 of this patchset is applied.

DAMON is lightweight.  It increases system memory usage by only -0.39% and
consumes less than 1% CPU time in most case.  It slows target workloads down by
only 0.63%.

DAMON is accurate and useful for memory management optimizations.  An
experimental DAMON-based operation scheme for THP, 'ethp', removes 69.43% of
THP memory overheads while preserving 37.11% of THP speedup.  Another
experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
reduces 89.30% of residential sets and 22.40% of system memory footprint while
incurring only 1.98% runtime overhead in the best case (parsec3/freqmine).

NOTE that the experimentail THP optimization and proactive reclamation are not
for production, just only for proof of concepts.

Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
a document for DAMON" patch in the latest DAMON patchset for detailed
evaluation setup and results.

[1] https://damonitor.github.io/doc/html/latest-damos


More Information
================

We prepared a showcase web site[1] that you can get more information.  There
are

- the official documentations[2],
- the heatmap format dynamic access pattern of various realistic workloads for
  heap area[3], mmap()-ed area[4], and stack[5] area,
- the dynamic working set size distribution[6] and chronological working set
  size changes[7], and
- the latest performance test results[8].

[1] https://damonitor.github.io/_index
[2] https://damonitor.github.io/doc/html/latest-damos
[3] https://damonitor.github.io/test/result/visual/latest/heatmap.0.html
[4] https://damonitor.github.io/test/result/visual/latest/heatmap.1.html
[5] https://damonitor.github.io/test/result/visual/latest/heatmap.2.html
[6] https://damonitor.github.io/test/result/visual/latest/wss_sz.html
[7] https://damonitor.github.io/test/result/visual/latest/wss_time.html
[8] https://damonitor.github.io/test/result/perf/latest/html/index.html


Baseline and Complete Git Tree
==============================


The patches are based on the v5.7 plus v15 DAMON patchset[1] and Minchan's
``do_madvise()`` patch[2], which retrieved from linux-next/master and slightly
modified for backporting on v5.7.  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b damos/rfc/v11

The web is also available:
https://github.com/sjp38/linux/releases/tag/damos/rfc/v11

There are a couple of trees for entire DAMON patchset series that future
features are included.  The first one[3] contains the changes for latest
release, while the other one[4] contains the changes for next release.

[1] TODO: Add DAMON v15 patchset link
[2] https://lore.kernel.org/linux-mm/20200302193630.68771-2-minchan@kernel.org/
[3] https://github.com/sjp38/linux/tree/damon/master
[4] https://github.com/sjp38/linux/tree/damon/next


Sequence Of Patches
===================

The 1st patch allows DAMON to reuse ``madvise()`` code for the actions.  The
2nd patch accounts age of each region.  The 3rd patch implements the handling
of the schemes in DAMON and exports a kernel space programming interface for
it.  The 4th patch implements a debugfs interface for the privileged people and
user programs.  The 5th patch implements schemes statistics feature for easier
tuning of the schemes and runtime access pattern analysis.  The 6th patche adds
selftests for these changes, and the 7th patch adds human friendly schemes
support to the user space tool for DAMON.  Finally, the 8th patch documents
this new feature in the document.


Patch History
=============

Changes from RFC v10
(https://lore.kernel.org/linux-mm/20200603071138.8152-1-sjpark@amazon.com/)
 - Fix the wrong error handling for schemes debugfs file
 - Handle the schemes stats from the user space tool
 - Remove the schemes implementation plan from the document

Changes from RFC v9
(https://lore.kernel.org/linux-mm/20200526075702.27339-1-sjpark@amazon.com/)
 - Rebase on v5.7
 - Fix wrong comments and documents for schemes apply conditions

Changes from RFC v8
(https://lore.kernel.org/linux-mm/20200512115343.27699-1-sjpark@amazon.com/)
 - Rewrite the document (Stefan Nuernberger)
 - Make 'damon_for_each_*' argument order consistent (Leonard Foerster)
 - Implement statistics for schemes
 - Avoid races between debugfs readers and writers
 - Reset age for only significant access frequency changes
 - Add kernel-doc comments in damon.h

Changes from RFC v7
(https://lore.kernel.org/linux-mm/20200429124540.32232-1-sjpark@amazon.com/)
 - Rebase on DAMON v11 patchset
 - Add documentation

Changes from RFC v6
(https://lore.kernel.org/linux-mm/20200407100007.3894-1-sjpark@amazon.com/)
 - Rebase on DAMON v9 patchset
 - Cleanup code and fix typos (Stefan Nuernberger)

Changes from RFC v5
(https://lore.kernel.org/linux-mm/20200330115042.17431-1-sjpark@amazon.com/)
 - Rebase on DAMON v8 patchset
 - Update test results
 - Fix DAMON userspace tool crash on signal handling
 - Fix checkpatch warnings

Changes from RFC v4
(https://lore.kernel.org/linux-mm/20200303121406.20954-1-sjpark@amazon.com/)
 - Handle CONFIG_ADVISE_SYSCALL
 - Clean up code (Jonathan Cameron)
 - Update test results
 - Rebase on v5.6 + DAMON v7

Changes from RFC v3
(https://lore.kernel.org/linux-mm/20200225102300.23895-1-sjpark@amazon.com/)
 - Add Reviewed-by from Brendan Higgins
 - Code cleanup: Modularize madvise() call
 - Fix a trivial bug in the wrapper python script
 - Add more stable and detailed evaluation results with updated ETHP scheme

Changes from RFC v2
(https://lore.kernel.org/linux-mm/20200218085309.18346-1-sjpark@amazon.com/)
 - Fix aging mechanism for more better 'old region' selection
 - Add more kunittests and kselftests for this patchset
 - Support more human friedly description and application of 'schemes'

Changes from RFC v1
(https://lore.kernel.org/linux-mm/20200210150921.32482-1-sjpark@amazon.com/)
 - Properly adjust age accounting related properties after splitting, merging,
   and action applying

SeongJae Park (8):
  mm/madvise: Export do_madvise() to external GPL modules
  mm/damon: Account age of target regions
  mm/damon: Implement data access monitoring-based operation schemes
  mm/damon/schemes: Implement a debugfs interface
  mm/damon/schemes: Implement statistics feature
  mm/damon/selftests: Add 'schemes' debugfs tests
  damon/tools: Support more human friendly 'schemes' control
  Documentation/admin-guide/mm: Document DAMON-based operation schemes

 Documentation/admin-guide/mm/damon/guide.rst  |  35 ++
 Documentation/admin-guide/mm/damon/plans.rst  |  26 +-
 Documentation/admin-guide/mm/damon/usage.rst  | 127 +++++-
 include/linux/damon.h                         |  66 ++++
 mm/damon.c                                    | 363 +++++++++++++++++-
 mm/madvise.c                                  |   1 +
 tools/damon/_convert_damos.py                 | 128 ++++++
 tools/damon/_damon.py                         | 146 +++++++
 tools/damon/damo                              |   7 +
 tools/damon/record.py                         | 139 +------
 tools/damon/schemes.py                        | 109 ++++++
 .../testing/selftests/damon/debugfs_attrs.sh  |  29 ++
 12 files changed, 1008 insertions(+), 168 deletions(-)
 create mode 100755 tools/damon/_convert_damos.py
 create mode 100644 tools/damon/_damon.py
 create mode 100644 tools/damon/schemes.py

-- 
2.17.1

