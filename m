Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635BB20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mLPjmFkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgGFLyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:54:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:23866 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGFLyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594036444; x=1625572444;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7CCCJI5bWc3IFULK9x+lPB+/AvJyV7/EwD9FEoTKo9g=;
  b=mLPjmFkE9gshqhCY/Joi/NQdk6MqUtRSJ3ebARvsyKWnamlcKI9BbUMk
   jj60Q8F59oNWy+Jetebp9hYY6RxR6rCkbIXCAlFX2DE2X6MnaHC1BNHX2
   6yK2IZop4FfAPYaOhksWf5hyP9BEOqDJhorQ92sArw+Ft8mipSUckpJni
   s=;
IronPort-SDR: Cp6DN1gM2aP1d3sUkvM+Kpqo8jDu3ZZXEgxFDbiSkMKTWEpuHfCRSTjmpk3aUAUM4V1mDewS7Y
 V3ZDJDl9dITw==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="57623402"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Jul 2020 11:53:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id E4F94A185D;
        Mon,  6 Jul 2020 11:53:56 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:53:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:53:40 +0000
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
Subject: [PATCH v17 00/15] Introduce Data Access MONitor (DAMON)
Date:   Mon, 6 Jul 2020 13:53:07 +0200
Message-ID: <20200706115322.29598-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D21UWA003.ant.amazon.com (10.43.160.184) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Changes from Previous Version
=============================

- Wordsmith/cleanup the documentations and the code
- user space tool: Cleanup and add an option for reuse histogram (patch 11)
- recording: Check disablement condition properly
- recording: Force minimal recording buffer size (1KB)

Introduction
============

DAMON is a data access monitoring framework subsystem for the Linux kernel.
The core mechanisms of DAMON called 'region based sampling' and 'adaptive
regions adjustment' (refer to 'mechanisms.rst' in the 11th patch of this
patchset for the detail) make it

 - accurate (The monitored information is useful for DRAM level memory
   management. It might not appropriate for Cache-level accuracy, though.),
 - light-weight (The monitoring overhead is low enough to be applied online
   while making no impact on the performance of the target workloads.), and
 - scalable (the upper-bound of the instrumentation overhead is controllable
   regardless of the size of target workloads.).

Using this framework, therefore, the kernel's core memory management mechanisms
such as reclamation and THP can be optimized for better memory management.  The
experimental memory management optimization works that incurring high
instrumentation overhead will be able to have another try.  In user space,
meanwhile, users who have some special workloads will be able to write
personalized tools or applications for deeper understanding and specialized
optimizations of their systems.

Evaluations
===========

We evaluated DAMON's overhead, monitoring quality and usefulness using 25
realistic workloads on my QEMU/KVM based virtual machine running a kernel that
v16 DAMON patchset is applied.

DAMON is lightweight. It increases system memory usage by only -0.25% and
consumes less than 1% CPU time in most case. It slows target workloads down by
only 0.94%.

DAMON is accurate and useful for memory management optimizations. An
experimental DAMON-based operation scheme for THP, 'ethp', removes 31.29% of
THP memory overheads while preserving 60.64% of THP speedup. Another
experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
reduces 87.95% of residential sets and 29.52% of system memory footprint while
incurring only 2.15% runtime overhead in the best case (parsec3/freqmine).

NOTE that the experimentail THP optimization and proactive reclamation are not
for production, just only for proof of concepts.

Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
a document for DAMON" patch in this patchset for detailed evaluation setup and
results.

[1] https://damonitor.github.io/doc/html/latest-damon/admin-guide/mm/damon/eval.html

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
[2] https://damonitor.github.io/doc/html/latest-damon
[3] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.0.png.html
[4] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.png.html
[5] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.2.png.html
[6] https://damonitor.github.io/test/result/visual/latest/rec.wss_sz.png.html
[7] https://damonitor.github.io/test/result/visual/latest/rec.wss_time.png.html
[8] https://damonitor.github.io/test/result/perf/latest/html/index.html

Baseline and Complete Git Trees
===============================

The patches are based on the v5.7.  You can also clone the complete git
tree:

    $ git clone git://github.com/sjp38/linux -b damon/patches/v17

The web is also available:
https://github.com/sjp38/linux/releases/tag/damon/patches/v17

There are a couple of trees for entire DAMON patchset series.  It includes
future features.  The first one[1] contains the changes for latest release,
while the other one[2] contains the changes for next release.

[1] https://github.com/sjp38/linux/tree/damon/master
[2] https://github.com/sjp38/linux/tree/damon/next

Sequence Of Patches
===================

The 1st patch exports 'lookup_page_ext()' to GPL modules so that it can be used
by DAMON even though it is built as a loadable module.

Next four patches implement the target address space independent core logics of
DAMON and it's programming interface.  The 2nd patch introduces DAMON module,
it's data structures, and data structure related common functions.  Following
three patches (3rd to 5th) implements the core mechanisms of DAMON, namely
regions based sampling (patch 3), adaptive regions adjustment (patch 4), and
dynamic memory mapping chage adoption (patch 5).

The following one (patch 6) implements the virtual memory address space
specific functions.

Following four patches are for more user friendly interfaces.  The 7th patch
implements recording of access patterns in DAMON.  Each of next two patches
(8th and 9th) respectively adds a tracepoint for other tracepoints supporting
tracers such as perf, and a debugfs interface for privileged people and/or
programs in user space.

Three patches for high level users of DAMON follows.  To provide a minimal
reference to the debugfs interface and for high level use/tests of the DAMON,
the next patch (10th) implements an user space tool.  The 11th patch adds one
more option to the tool for reuse histogram plot.  The 12nd patch adds a
document for administrators of DAMON.

Next two patches are for tests.  The 13th patch provides unit tests (based on
the kunit) while the 14th patch adds user space tests (based on the kselftest).

Finally, the last patch (15th) updates the MAINTAINERS file.

Patch History
=============

This version of patchset merges first, second, and sixth patches in the CDAMON
patchset[1] for better readability.  As the changes are not subtle,
'Reviewed-by's I previously received on the changes affected patches are also
dropped.

[1] https://lore.kernel.org/linux-mm/20200609141941.19184-1-sjpark@amazon.com/

Changes from v16
(https://lore.kernel.org/linux-mm/20200615161927.12637-1-sjpark@amazon.com/)
 - Wordsmith/cleanup the documentations and the code
 - user space tool: Simplify the code and add wss option for reuse histogram
 - recording: Check disablement condition properly
 - recording: Force minimal recording buffer size (1KB)

Changes from v15
(https://lore.kernel.org/linux-mm/20200608114047.26589-1-sjpark@amazon.com/)
 - Refine commit messages (David Hildenbrand)
 - Optimizes three vma regions search (Varad Gautam)
 - Support static granularity monitoring (Shakeel Butt)
 - Cleanup code and re-organize the sequence of patches

Changes from v14
(https://lore.kernel.org/linux-mm/20200602130125.20467-1-sjpark@amazon.com/)
 - Directly pass region and task to tracepoint (Steven Rostedt)
 - Refine comments for better read
 - Add more 'Reviewed-by's (Leonard Foerster, Brendan Higgins)

Changes from v13
(https://lore.kernel.org/linux-mm/20200525091512.30391-1-sjpark@amazon.com/)
 - Fix a typo (Leonard Foerster)
 - Fix wring condition of three sub ranges split (Leonard Foerster)
 - Rebase on v5.7

Changes from v12
(https://lore.kernel.org/linux-mm/20200518100018.2293-1-sjpark@amazon.com/)
 - Avoid races between debugfs readers and writers
 - Add kernel-doc comments in damon.h

Changes from v11
(https://lore.kernel.org/linux-mm/20200511123302.12520-1-sjpark@amazon.com/)
 - Rewrite the document (Stefan Nuernberger)
 - Make 'damon_for_each_*' argument order consistent (Leonard Foerster)
 - Fix wrong comment in 'kdamond_merge_regions()' (Leonard Foerster)

Changes from v10
(https://lore.kernel.org/linux-mm/20200505110815.10532-1-sjpark@amazon.com/)
 - Reduce aggressive split overhead by doing it only if required

Changes from v9
(https://lore.kernel.org/linux-mm/20200427120442.24179-1-sjpark@amazon.com/)
 - Split each region into 4 subregions if possible (Jonathan Cameraon)
 - Update kunit test for the split code change

Please refer to the v9 patchset to get older history.

SeongJae Park (15):
  mm/page_ext: Export lookup_page_ext() to GPL modules
  mm: Introduce Data Access MONitor (DAMON)
  mm/damon: Implement region based sampling
  mm/damon: Adaptively adjust regions
  mm/damon: Track dynamic monitoring target regions update
  mm/damon: Implement callbacks for the virtual memory address spaces
  mm/damon: Implement access pattern recording
  mm/damon: Add a tracepoint
  mm/damon: Implement a debugfs interface
  tools: Introduce a minimal user-space tool for DAMON
  tools/damon/wss: Implement '--thres' option
  Documentation/admin-guide/mm: Add a document for DAMON
  mm/damon: Add kunit tests
  mm/damon: Add user space selftests
  MAINTAINERS: Update for DAMON

 Documentation/admin-guide/mm/damon/api.rst    |   20 +
 .../admin-guide/mm/damon/damon_heatmap.png    |  Bin 0 -> 8366 bytes
 .../admin-guide/mm/damon/damon_wss_change.png |  Bin 0 -> 7211 bytes
 .../admin-guide/mm/damon/damon_wss_dist.png   |  Bin 0 -> 6173 bytes
 Documentation/admin-guide/mm/damon/eval.rst   |  222 +++
 Documentation/admin-guide/mm/damon/faq.rst    |   59 +
 .../admin-guide/mm/damon/freqmine_heatmap.png |  Bin 0 -> 9999 bytes
 .../admin-guide/mm/damon/freqmine_wss_sz.png  |  Bin 0 -> 5589 bytes
 .../mm/damon/freqmine_wss_time.png            |  Bin 0 -> 6550 bytes
 Documentation/admin-guide/mm/damon/guide.rst  |  194 ++
 Documentation/admin-guide/mm/damon/index.rst  |   35 +
 .../admin-guide/mm/damon/mechanisms.rst       |  159 ++
 Documentation/admin-guide/mm/damon/plans.rst  |   29 +
 Documentation/admin-guide/mm/damon/start.rst  |  117 ++
 .../mm/damon/streamcluster_heatmap.png        |  Bin 0 -> 42210 bytes
 .../mm/damon/streamcluster_wss_sz.png         |  Bin 0 -> 6327 bytes
 .../mm/damon/streamcluster_wss_time.png       |  Bin 0 -> 8830 bytes
 Documentation/admin-guide/mm/damon/usage.rst  |  296 +++
 Documentation/admin-guide/mm/index.rst        |    1 +
 MAINTAINERS                                   |   12 +
 include/linux/damon.h                         |  175 ++
 include/trace/events/damon.h                  |   43 +
 mm/Kconfig                                    |   23 +
 mm/Makefile                                   |    1 +
 mm/damon-test.h                               |  661 +++++++
 mm/damon.c                                    | 1632 +++++++++++++++++
 mm/page_ext.c                                 |    1 +
 tools/damon/.gitignore                        |    1 +
 tools/damon/_damon.py                         |  129 ++
 tools/damon/_dist.py                          |   36 +
 tools/damon/_recfile.py                       |   23 +
 tools/damon/bin2txt.py                        |   67 +
 tools/damon/damo                              |   37 +
 tools/damon/heats.py                          |  362 ++++
 tools/damon/nr_regions.py                     |   91 +
 tools/damon/record.py                         |  106 ++
 tools/damon/report.py                         |   45 +
 tools/damon/wss.py                            |   99 +
 tools/testing/selftests/damon/Makefile        |    7 +
 .../selftests/damon/_chk_dependency.sh        |   28 +
 tools/testing/selftests/damon/_chk_record.py  |  108 ++
 .../testing/selftests/damon/debugfs_attrs.sh  |  139 ++
 .../testing/selftests/damon/debugfs_record.sh |   50 +
 43 files changed, 5008 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/api.rst
 create mode 100644 Documentation/admin-guide/mm/damon/damon_heatmap.png
 create mode 100644 Documentation/admin-guide/mm/damon/damon_wss_change.png
 create mode 100644 Documentation/admin-guide/mm/damon/damon_wss_dist.png
 create mode 100644 Documentation/admin-guide/mm/damon/eval.rst
 create mode 100644 Documentation/admin-guide/mm/damon/faq.rst
 create mode 100644 Documentation/admin-guide/mm/damon/freqmine_heatmap.png
 create mode 100644 Documentation/admin-guide/mm/damon/freqmine_wss_sz.png
 create mode 100644 Documentation/admin-guide/mm/damon/freqmine_wss_time.png
 create mode 100644 Documentation/admin-guide/mm/damon/guide.rst
 create mode 100644 Documentation/admin-guide/mm/damon/index.rst
 create mode 100644 Documentation/admin-guide/mm/damon/mechanisms.rst
 create mode 100644 Documentation/admin-guide/mm/damon/plans.rst
 create mode 100644 Documentation/admin-guide/mm/damon/start.rst
 create mode 100644 Documentation/admin-guide/mm/damon/streamcluster_heatmap.png
 create mode 100644 Documentation/admin-guide/mm/damon/streamcluster_wss_sz.png
 create mode 100644 Documentation/admin-guide/mm/damon/streamcluster_wss_time.png
 create mode 100644 Documentation/admin-guide/mm/damon/usage.rst
 create mode 100644 include/linux/damon.h
 create mode 100644 include/trace/events/damon.h
 create mode 100644 mm/damon-test.h
 create mode 100644 mm/damon.c
 create mode 100644 tools/damon/.gitignore
 create mode 100644 tools/damon/_damon.py
 create mode 100644 tools/damon/_dist.py
 create mode 100644 tools/damon/_recfile.py
 create mode 100644 tools/damon/bin2txt.py
 create mode 100755 tools/damon/damo
 create mode 100644 tools/damon/heats.py
 create mode 100644 tools/damon/nr_regions.py
 create mode 100644 tools/damon/record.py
 create mode 100644 tools/damon/report.py
 create mode 100644 tools/damon/wss.py
 create mode 100644 tools/testing/selftests/damon/Makefile
 create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
 create mode 100644 tools/testing/selftests/damon/_chk_record.py
 create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 create mode 100755 tools/testing/selftests/damon/debugfs_record.sh

-- 
2.17.1

