Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B596C35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C290620714
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SZlc3F0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgBYKXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:23:52 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:6971 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgBYKXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582626230; x=1614162230;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=YmPVNep/wLBAHHrQegv1RjXniqoUkgYuMlxY6Vjh9q4=;
  b=SZlc3F0mFjSf1o+UzfhN01+K3yvvzrEpi60qQVkCsfoIDxEwXaCuiRT6
   i/Ae5wr/hjI4+l6n8mxx6OWlTjO9hJKEDPBMUgdW6NnJLkPCyt3WZbF3L
   Y9ybhpHjs9REmGGtjLyFOcLT0Q2wJkX80aoM2PSruHXzuhCc8rj5sAaWb
   o=;
IronPort-SDR: AQzBpez4q3BtyIMo1o7o4TQiKVBLqnMgs5LrpgJCWsnwKsAnWFqm+SjgN3IjopRHMaLwKbkTIt
 vco4sYYaQifA==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="18459783"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Feb 2020 10:23:38 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 93A75A2B34;
        Tue, 25 Feb 2020 10:23:28 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 10:23:27 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 10:23:15 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v3 0/7] Implement Data Access Monitoring-based Memory Operation Schemes
Date:   Tue, 25 Feb 2020 11:22:53 +0100
Message-ID: <20200225102300.23895-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON[1] can be used as a primitive for data access awared memory management
optimizations.  That said, users who want such optimizations should run DAMON,
read the monitoring results, analyze it, plan a new memory management scheme,
and apply the new scheme by themselves.  Such efforts will be inevitable for
some complicated optimizations.

However, in many other cases, the users could simply want the system to apply a
memory management action to a memory region of a specific size having a
specific access frequency for a specific time.  For example, "page out a memory
region larger than 100 MiB keeping only rare accesses more than 10 minutes", or
"Use THP for a memory region larger than 2 MiB continuously accessed for more
than 1 seconds".

This RFC patchset makes DAMON to handle such data access monitoring-based
operation schemes.  With this change, users can do the data access awared
optimizations by simply specifying their schemes to DAMON.


Evaluations
===========

Transparent Huge Pages (THP) subsystem could waste memory space in some cases
because it aggressively promotes regular pages to huge pages.  For the reason,
use of THP is prohivited by a number of memory intensive programs such as
Redis[1] and MongoDB[2].

Below two simple data access monitoring-based operation schemes might be
helpful for the problem:

    # format: <min/max size> <min/max frequency (0-100)> <min/max age> <action>

    # If a memory region larger than 2 MiB is showing access rate higher than
    # 5% for more than 1 second, apply MADV_HUGEPAGE to the region.
    2M	null	5	null	1s	null	hugepage

    # If a memory region larger than 2 MiB is showing access rate lower than 5%
    # for more than 1 second, apply MADV_NOHUGEPAGE to the region.
    2M	null	null	5	1s	null	nohugepage

We can expect the schmes might reduce the memory space overhead but preserve
some amount of the THP's performance benefit.

Please note that I made these schemes with only my straightforward instinction.
Therefore, these might not be optimized schemes.


Setup
-----

On a QEMU/KVM based virtual machine on an Intel i7 host machine running Ubuntu
18.04, I measure runtime and memory usage of various realistic workloads with
several configurations.  I use 14 and 13 workloads in PARSEC3[3] and
SPLASH-2X[4] benchmark suites, respectively.  I personally use another wrapper
scripts[5] for setup and run of the workloads.

For the measurement of memory usage, we drop caches
before starting each of the workloads and monitor 'MemFree' in the
'/proc/meminfo' file.

The configurations are as below:

orig: Linux v5.5 with 'madvise' THP policy
thp: Linux v5.5 with 'always' THP policy
ethp: Linux v5.5 applying the above schemes


[1] "Redis latency problems troubleshooting", https://redis.io/topics/latency
[2] "Disable Transparent Huge Pages (THP)",
    https://docs.mongodb.com/manual/tutorial/transparent-huge-pages/
[3] "The PARSEC Becnhmark Suite", https://parsec.cs.princeton.edu/index.htm
[4] "SPLASH-2x", https://parsec.cs.princeton.edu/parsec3-doc.htm#splash2x
[5] "parsec3_on_ubuntu", https://github.com/sjp38/parsec3_on_ubuntu


Results
-------

Following sections show the results of the measurements.  For brevity, I show
only memory space and runtime overheads of thp and ethp in percentage.  For
instance, memory space overhead 76.94 of 'thp' for 'splash2x/ocean_ncp' means
the memory usage of 'splash2x/ocean_ncp' measured under 'thp' configuration was
176.94% of that measured under 'orig' configuration.

Note that the numbers are collected from only one measurement.  Thus, below
numbers might contain some measurement errors.  I will repeat the evaluations
several times and update the numbers with averages and stdevs, as soon as
prepared.


Memory Space Overheads
~~~~~~~~~~~~~~~~~~~~~~

Below shows measured memory space overheads (%) of 'thp' and 'ethp' compared to
'orig'.

workload		thp	ethp
parsec3	blackscholes	0.41	0.23
	bodytrack	-0.11	0.12
	canneal		-0.73	0.01
	dedup		5.41	5.80
	facesim		0.76	0.33
	ferret		-1.42	-0.24
	fluidanimate	-0.17	0.82
	freqmine	0.03	0.17
	raytrace	0.19	-0.55
	streamcluster	1.16	1.65
	swaptions	6.14	21.84
	vips		1.63	1.65
	x264		3.21	1.86
	PARSEC3/AVG	1.63	1.48
splash2	barnes		0.18	1.82
	fft		0.06	1.43
	lu_cb		0.94	0.09
	lu_ncb		1.09	0.43
	ocean_cp	1.11	0.23
	ocean_ncp	76.94	-0.08
	radiosity	0.62	-0.05
	radix		-18.37	0.28
	raytrace	14.52	3.64
	volrend		-0.69	1.48
	water_nsquared	-0.68	4.26
	water_spatial	0.11	0.68
	SPLASH2X/AVG	12.72	0.72

Averaged memory space overhead
PARSEC3: 1.62% (thp), 1.47% (ethp). ethp shows 1.10x lower overhead.
SPLASH2X: 12.717% (thp), 0.71% (ethp): ethp shows 18x lower overhead.

Best case: splash2x/ocean_ncp
Overheads: 76.94% (thp), -0.07% (ethp): ethp shows about -1099x lower overhead.
Apparently memory intensive workload, as it uses about 3.9 GiB memory in
'orig'.

Worst case: parsec3/swaptions
Overheads: 6.14% (thp), 21.84% (ethp): ethp shows 3.55x higher overhead.
Not memory-intensive workload, as it uses only 19 MiB memory in 'orig', though.


Runtime Overheads
~~~~~~~~~~~~~~~~~

Below shows measured runtime overheads (%) of 'thp' and 'ethp' compared to
'orig'.

workload		thp	ethp
parsec3	blackscholes	-0.29	0.60
	bodytrack	-0.25	0.61
	canneal		-18.93	-15.60
	dedup		-1.79	-0.84
	facesim		-1.69	3.36
	ferret		-0.28	1.18
	fluidanimate	-1.08	2.89
	freqmine	0.06	2.13
	raytrace	-1.35	0.79
	streamcluster	-13.69	-0.62
	swaptions	-1.83	-1.72
	vips		-2.05	-0.65
	x264		14.96	-3.11
	PARSEC3/AVG	-3.82	-0.33
splash2	barnes		-2.31	-0.95
	fft		-1.21	0.04
	lu_cb		-1.12	-0.14
	lu_ncb		-1.19	-0.24
	ocean_cp	-1.19	-0.48
	ocean_ncp	-1.29	-0.68
	radiosity	-1.29	-0.80
	radix		-0.33	-0.81
	raytrace	-0.22	-0.74
	volrend		-0.08	-0.75
	water_nsquared	-1.23	-0.57
	water_spatial	-1.16	-0.54
	SPLASH2X/AVG	-1.07	-0.51

Averaged runtime overhead
PARSEC3: -3.81% (thp), -0.38% (ethp): ethp preserves about 10% of THP speedup.
SPLASH2X: -1.07% (thp), -0.51% (ethp): ethp preserves about 50% of THP speedup.

Best case: parsec3/canneal
The overhead: -18.93% (thp), -15.60% (ethp): ethp preserves about 82% of THP
speedup.
Apparently memory intensive workload, as it uses about 1 GiB memory in average.

Worst case: parsec3/streamcluster
Seems memory-intensive workload, though it uses about 128 MiB memory.
The overheads: -13.69% (thp), -0.62% (ethp): ethp preserves only about 4% of
THP speedup.


In short, the straightforward data access monitoring-based operation scheme,
ethp, reduces memory space waste (1.10x lower for PARSEC3 and 18x lower for
SPLASH-2X) while preserving some amount of the THP's performance benefit (10%
for PARSEC3 and 50% for SPLASH-2X), as expected.


Sequence Of Patches
===================

The patches are based on the v5.5 plus v5 DAMON patchset[1] and Minchan's
``madvise()`` factor-out patch[2].  Minchan's patch was necessary for reuse of
``madvise()`` code in DAMON.  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b damos/rfc/v3

The web is also available:
https://github.com/sjp38/linux/releases/tag/damos/rfc/v3


[1] https://lore.kernel.org/linux-mm/20200217103110.30817-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200128001641.5086-2-minchan@kernel.org/

The first patch allows DAMON to reuse ``madvise()`` code for the actions.  The
second patch accounts age of each region.  The third patch implements the
handling of the schemes in DAMON and exports a kernel space programming
interface for it.  The fourth patch implements a debugfs interface for
privileged people and programs.  The fifth and sixth patches each adds
kunittests and selftests for these changes, and finally the seventhe patch
modifies the user space tool for DAMON to support description and applying of
schemes in human freiendly way.


Patch History
=============

Changes from RFC v2
(https://lore.kernel.org/linux-mm/20200218085309.18346-1-sjpark@amazon.com/)
 - Fix aging mechanism for more better 'old region' selection
 - Add more kunittests and kselftests for this patchset
 - Support more human friedly description and application of 'schemes'

Changes from RFC v1
(https://lore.kernel.org/linux-mm/20200210150921.32482-1-sjpark@amazon.com/)
 - Properly adjust age accounting related properties after splitting, merging,
   and action applying

SeongJae Park (7):
  mm/madvise: Export madvise_common() to mm internal code
  mm/damon: Account age of target regions
  mm/damon: Implement data access monitoring-based operation schemes
  mm/damon/schemes: Implement a debugfs interface
  mm/damon-test: Add kunit test case for regions age accounting
  mm/damon/selftests: Add 'schemes' debugfs tests
  damon/tools: Support more human friendly 'schemes' control

 include/linux/damon.h                         |  29 ++
 mm/damon-test.h                               |   5 +
 mm/damon.c                                    | 414 +++++++++++++++++-
 mm/internal.h                                 |   4 +
 mm/madvise.c                                  |   3 +-
 tools/damon/_convert_damos.py                 | 125 ++++++
 tools/damon/_damon.py                         | 143 ++++++
 tools/damon/damo                              |   7 +
 tools/damon/record.py                         | 133 +-----
 tools/damon/schemes.py                        | 105 +++++
 .../testing/selftests/damon/debugfs_attrs.sh  |  29 ++
 11 files changed, 867 insertions(+), 130 deletions(-)
 create mode 100755 tools/damon/_convert_damos.py
 create mode 100644 tools/damon/_damon.py
 create mode 100644 tools/damon/schemes.py

-- 
2.17.1

