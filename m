Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9D0207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgHTQtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:49:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:14315 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730326AbgHTQsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:48:24 -0400
IronPort-SDR: Vqux16cVLojjtJWsQE8AZvvaa6GeGn9HvK2DrhKHncp41Pb1bgQGwDw+3qHk+paYTrtAv9JMPR
 yKgiHOhWrTYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="155325356"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="155325356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 09:48:22 -0700
IronPort-SDR: uVyirGKdbAoNQhN+hG6zONG5kRddXPnkhe9Ll4CaogB9eP4fksK9nRfro2P9P5vweoeDBX6gdz
 yomBNfKMqAsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="442049131"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2020 09:48:22 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/4] TopDown metrics support for Ice Lake (perf tool)
Date:   Thu, 20 Aug 2020 09:45:28 -0700
Message-Id: <20200820164532.8011-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The kernel patches have been merged into the tip's perf/core branch.
The patch set is on top of commit 2cb5383b30d4 ("perf/x86/intel: Support
per-thread RDPMC TopDown metrics") of the tip's perf/core branch.

The changes for the perf tool include:
- Extend --topdown option to support per thread TopDown metrics
- Support sample-read topdown metric group
- Add a complete document for the TopDown usage.

Ice Lake has support for measuring the level 1 TopDown metrics
directly in hardware. This is implemented by an additional METRICS
register, and a new Fixed Counter 3 that measures pipeline SLOTS.

New in Icelake
- Do not require generic counters. This allows to collect TopDown always
  in addition to other events.
- Measuring TopDown per thread/process instead of only per core

For the Ice Lake implementation of performance metrics, the values in
PERF_METRICS MSR are derived from fixed counter 3. Software should start
both registers, PERF_METRICS and fixed counter 3, from zero.
Additionally, software is recommended to periodically clear both
registers in order to maintain accurate measurements. The latter is
required for certain scenarios that involve sampling metrics at high
rates. Software should always write fixed counter 3 before write to
PERF_METRICS.

IA32_PERF_GLOBAL_STATUS. OVF_PERF_METRICS[48]: If this bit is set,
it indicates that some PERF_METRICS-related counter has overflowed and
a PMI is triggered. Software has to synchronize, e.g. re-start,
PERF_METRICS as well as fixed counter 3. Otherwise, PERF_METRICS may
return invalid values.

Limitation
- To get accurate result and avoid reading the METRICS register multiple
  times, the TopDown metrics events and SLOTS event have to be in the
  same group.
- METRICS and SLOTS registers have to be cleared after each read by SW.
  That is to prevent the lose of precision.
- Cannot do sampling read SLOTS and TopDown metric events

Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
TopDown metrics.

Andi Kleen (2):
  perf stat: Support new per thread TopDown metrics
  perf, tools: Add documentation for topdown metrics

Kan Liang (2):
  perf tools: Rename group to topdown
  perf record: Support sample-read topdown metric group

 tools/perf/Documentation/perf-stat.txt |   7 +-
 tools/perf/Documentation/topdown.txt   | 256 +++++++++++++++++++++++++
 tools/perf/arch/x86/util/Build         |   2 +-
 tools/perf/arch/x86/util/group.c       |  28 ---
 tools/perf/arch/x86/util/topdown.c     |  63 ++++++
 tools/perf/builtin-stat.c              |  81 +++-----
 tools/perf/util/Build                  |   1 +
 tools/perf/util/group.h                |   8 -
 tools/perf/util/record.c               |   3 +-
 tools/perf/util/stat-shadow.c          |  89 +++++++++
 tools/perf/util/stat.c                 |   4 +
 tools/perf/util/stat.h                 |   8 +
 tools/perf/util/topdown.c              |  58 ++++++
 tools/perf/util/topdown.h              |  12 ++
 14 files changed, 528 insertions(+), 92 deletions(-)
 create mode 100644 tools/perf/Documentation/topdown.txt
 delete mode 100644 tools/perf/arch/x86/util/group.c
 create mode 100644 tools/perf/arch/x86/util/topdown.c
 delete mode 100644 tools/perf/util/group.h
 create mode 100644 tools/perf/util/topdown.c
 create mode 100644 tools/perf/util/topdown.h

-- 
2.17.1

