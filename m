Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F7206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgCQLSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:18:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbgCQLGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:06:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 612FFC122464A3917050;
        Tue, 17 Mar 2020 19:06:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Mar 2020 19:06:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/7] perf test pmu-events case
Date:   Tue, 17 Mar 2020 19:02:12 +0800
Message-ID: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a basic pmu-events test case.

The test works in two steps:
- Verifies events in generated pmu-events.c are as expected for some test
  events
- Verifies correctly created aliases for those test events for the HW PMUs
  in the host system

The test events are invented, and are (mostly) arch agnostic (even though
I copied these events from pre-existing x86 and arm64 JSONs).

In the test, core and uncore events are treated slightly differently for
testing aliases. For core test events, all events are matched. However,
for uncore test events, these have "Unit" property, so can only be matched
when the corresponding HW PMU exists in the host sytem.

A test run looks like this on my x86 dev box:

$ tools/perf/perf test -vv 10

10: PMU events                                            :
--- start ---
test child forked, pid 26610
testing event table bp_l1_btb_correct: pass
testing event table bp_l2_btb_correct: pass
testing event table segment_reg_loads.any: pass
testing event table dispatch_blocked.any: pass
testing event table eist_trans: pass
testing event table uncore_hisi_ddrc.flux_wcmd: pass
testing event table unc_cbo_xsnp_response.miss_eviction: pass
Using CPUID GenuineIntel-6-3D-4
intel_pt default config: tsc,pt,branch
skipping testing PMU breakpoint
testing aliases PMU uncore_cbox_1: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_1 aliases: pass
testing aliases PMU cpu: matched event bp_l1_btb_correct
testing aliases PMU cpu: matched event bp_l2_btb_correct
testing aliases PMU cpu: matched event segment_reg_loads.any
testing aliases PMU cpu: matched event dispatch_blocked.any
testing aliases PMU cpu: matched event eist_trans
testing PMU cpu aliases: pass
skipping testing PMU software
skipping testing PMU intel_bts
testing aliases PMU uncore_cbox_0: matched event unc_cbo_xsnp_response.miss_eviction
testing PMU uncore_cbox_0 aliases: pass
skipping testing PMU tracepoint
test child finished with 0
---- end ----
PMU events: Ok


Changes since v1:
- Verify event table in generated pmu-events.c, in addition to verifying
  aliases
- Don't create separate table for test events, but include as a "testcpu"

John Garry (7):
  perf jevents: Add some test events
  perf jevents: Support test events folder
  perf pmu: Refactor pmu_add_cpu_aliases()
  perf test: Add pmu-events test
  perf pmu: Add is_pmu_core()
  perf pmu: Make pmu_uncore_alias_match() public
  perf test: Test pmu-events aliases

 .../perf/pmu-events/arch/test/test_cpu/branch.json |  12 +
 .../perf/pmu-events/arch/test/test_cpu/other.json  |  26 ++
 .../perf/pmu-events/arch/test/test_cpu/uncore.json |  21 ++
 tools/perf/pmu-events/jevents.c                    |  30 ++
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/pmu-events.c                      | 373 +++++++++++++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/util/pmu.c                              |  28 +-
 tools/perf/util/pmu.h                              |   5 +
 10 files changed, 492 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/branch.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/other.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/uncore.json
 create mode 100644 tools/perf/tests/pmu-events.c

-- 
2.12.3

