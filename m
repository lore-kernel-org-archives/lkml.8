Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A07C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D0D2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgCELMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:12:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbgCELMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:12:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8BEFDADE6EC7917DF24A;
        Thu,  5 Mar 2020 19:12:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 19:12:19 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/6] perf test pmu-events case
Date:   Thu, 5 Mar 2020 19:08:00 +0800
Message-ID: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a basic perf test pmu-events test case.

The test works by verifying correctly created aliases for the HW PMUs in
the host system.

The aliases come from a set of invented test events, which are (mostly)
arch agnostic (even though I copied these aliases from pre-existing x86
and arm64 JSONs).

In the test, core and uncore events are treated slightly differently. For
core test events, all events are matched. However, for uncore test events,
these have "Unit" property, so can only be matched when the corresponding
HW PMU exists in the host sytem.

A test run looks like this on my x86 dev box:

kernel-dev$ tools/perf/perf test -vv 10
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
10: PMU event aliases                                     :
--- start ---
test child forked, pid 30869
Using CPUID GenuineIntel-6-9E-9
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
skipping testing PMU software
testing PMU power: skip
testing PMU cpu: matched event segment_reg_loads.any
testing PMU cpu: matched event dispatch_blocked.any
testing PMU cpu: matched event eist_trans
testing PMU cpu: matched event bp_l1_btb_correct
testing PMU cpu: matched event bp_l2_btb_correct
testing PMU cpu: pass
testing PMU cstate_core: skip
testing PMU uncore_cbox_2: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_2: pass
skipping testing PMU breakpoint
testing PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_0: pass
skipping testing PMU tracepoint
testing PMU cstate_pkg: skip
testing PMU uncore_arb: skip
testing PMU msr: skip
testing PMU uncore_cbox_3: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_3: pass
testing PMU intel_pt: skip
testing PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_1: pass
test child finished with 0
---- end ----
PMU event aliases: Ok


Comments welcome.

John Garry (6):
  perf jevents: Fix leak of mapfile memory
  perf jevents: Support test events folder
  perf jevents: Add some test events
  perf pmu: Refactor pmu_add_cpu_aliases()
  perf pmu: Add is_pmu_core()
  perf test: Add pmu-events test

 .../pmu-events/arch/test/test_cpu/branch.json |  12 ++
 .../pmu-events/arch/test/test_cpu/other.json  |  26 +++
 .../pmu-events/arch/test/test_cpu/uncore.json |  21 ++
 tools/perf/pmu-events/jevents.c               |  59 +++++-
 tools/perf/pmu-events/pmu-events.h            |   4 +
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/builtin-test.c               |   4 +
 tools/perf/tests/pmu-events.c                 | 192 ++++++++++++++++++
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/util/pmu.c                         |  26 ++-
 tools/perf/util/pmu.h                         |   4 +
 11 files changed, 336 insertions(+), 14 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/branch.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/other.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/uncore.json
 create mode 100644 tools/perf/tests/pmu-events.c

-- 
2.17.1

