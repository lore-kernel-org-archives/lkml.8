Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B39C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B201206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgFQJGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:06:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbgFQJGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:06:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 16EB71A64CE3E46FD16E;
        Wed, 17 Jun 2020 17:06:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 17:06:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linuxarm@huawei.com>, <irogers@google.com>, <ak@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/2] perf pmu: Improve CPU core PMU HW event list ordering
Date:   Wed, 17 Jun 2020 17:01:54 +0800
Message-ID: <1592384514-119954-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
References: <1592384514-119954-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For perf list, the CPU core PMU HW event ordering is such that not all
events may will be listed adjacent - consider this example:

$ tools/perf/perf list

List of pre-defined events (to be used in -e):

  duration_time                                      [Tool event]

  branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
  branch-misses OR cpu/branch-misses/                [Kernel PMU event]
  bus-cycles OR cpu/bus-cycles/                      [Kernel PMU event]
  cache-misses OR cpu/cache-misses/                  [Kernel PMU event]
  cache-references OR cpu/cache-references/          [Kernel PMU event]
  cpu-cycles OR cpu/cpu-cycles/                      [Kernel PMU event]
  cstate_core/c3-residency/                          [Kernel PMU event]
  cstate_core/c6-residency/                          [Kernel PMU event]
  cstate_core/c7-residency/                          [Kernel PMU event]
  cstate_pkg/c2-residency/                           [Kernel PMU event]
  cstate_pkg/c3-residency/                           [Kernel PMU event]
  cstate_pkg/c6-residency/                           [Kernel PMU event]
  cstate_pkg/c7-residency/                           [Kernel PMU event]
  cycles-ct OR cpu/cycles-ct/                        [Kernel PMU event]
  cycles-t OR cpu/cycles-t/                          [Kernel PMU event]
  el-abort OR cpu/el-abort/                          [Kernel PMU event]
  el-capacity OR cpu/el-capacity/                    [Kernel PMU event]

Notice in the above example how the cstate_core PMU events are mixed in
the middle of the CPU core events.

For my arm64 platform, all the uncore events get mixed in, making the list
very disorganised:
 page-faults OR faults                              [Software event]
  task-clock                                         [Software event]
  duration_time                                      [Tool event]
  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-loads                                         [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]
  iTLB-loads                                         [Hardware cache event]
  br_mis_pred OR armv8_pmuv3_0/br_mis_pred/          [Kernel PMU event]
  br_mis_pred_retired OR armv8_pmuv3_0/br_mis_pred_retired/ [Kernel PMU event]
  br_pred OR armv8_pmuv3_0/br_pred/                  [Kernel PMU event]
  br_retired OR armv8_pmuv3_0/br_retired/            [Kernel PMU event]
  br_return_retired OR armv8_pmuv3_0/br_return_retired/ [Kernel PMU event]
  bus_access OR armv8_pmuv3_0/bus_access/            [Kernel PMU event]
  bus_cycles OR armv8_pmuv3_0/bus_cycles/            [Kernel PMU event]
  cid_write_retired OR armv8_pmuv3_0/cid_write_retired/ [Kernel PMU event]
  cpu_cycles OR armv8_pmuv3_0/cpu_cycles/            [Kernel PMU event]
  dtlb_walk OR armv8_pmuv3_0/dtlb_walk/              [Kernel PMU event]
  exc_return OR armv8_pmuv3_0/exc_return/            [Kernel PMU event]
  exc_taken OR armv8_pmuv3_0/exc_taken/              [Kernel PMU event]
  hisi_sccl1_ddrc0/act_cmd/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_rcmd/                        [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_rd/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_wcmd/                        [Kernel PMU event]
  hisi_sccl1_ddrc0/flux_wr/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/pre_cmd/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/rnk_chg/                          [Kernel PMU event]

...

  hisi_sccl7_l3c21/wr_hit_cpipe/                     [Kernel PMU event]
  hisi_sccl7_l3c21/wr_hit_spipe/                     [Kernel PMU event]
  hisi_sccl7_l3c21/wr_spipe/                         [Kernel PMU event]
  inst_retired OR armv8_pmuv3_0/inst_retired/        [Kernel PMU event]
  inst_spec OR armv8_pmuv3_0/inst_spec/              [Kernel PMU event]
  itlb_walk OR armv8_pmuv3_0/itlb_walk/              [Kernel PMU event]
  l1d_cache OR armv8_pmuv3_0/l1d_cache/              [Kernel PMU event]
  l1d_cache_refill OR armv8_pmuv3_0/l1d_cache_refill/ [Kernel PMU event]
  l1d_cache_wb OR armv8_pmuv3_0/l1d_cache_wb/        [Kernel PMU event]
  l1d_tlb OR armv8_pmuv3_0/l1d_tlb/                  [Kernel PMU event]
  l1d_tlb_refill OR armv8_pmuv3_0/l1d_tlb_refill/    [Kernel PMU event]

So the events are list alphabetically. However, CPU core event listing is
special from commit dc098b35b56f ("perf list: List kernel supplied event
aliases"), in that the alias and full event is shown (in that order).
As such, the core events may become sparse.

Improve this by grouping the CPU core events and ensure that they are
listed first for kernel PMU events. For the first example, above, this
now looks like:

duration_time                                      [Tool event]
  branch-instructions OR cpu/branch-instructions/    [Kernel PMU event]
  branch-misses OR cpu/branch-misses/                [Kernel PMU event]
  bus-cycles OR cpu/bus-cycles/                      [Kernel PMU event]
  cache-misses OR cpu/cache-misses/                  [Kernel PMU event]
  cache-references OR cpu/cache-references/          [Kernel PMU event]
  cpu-cycles OR cpu/cpu-cycles/                      [Kernel PMU event]
  cycles-ct OR cpu/cycles-ct/                        [Kernel PMU event]
  cycles-t OR cpu/cycles-t/                          [Kernel PMU event]
  el-abort OR cpu/el-abort/                          [Kernel PMU event]
  el-capacity OR cpu/el-capacity/                    [Kernel PMU event]
  el-commit OR cpu/el-commit/                        [Kernel PMU event]
  el-conflict OR cpu/el-conflict/                    [Kernel PMU event]
  el-start OR cpu/el-start/                          [Kernel PMU event]
  instructions OR cpu/instructions/                  [Kernel PMU event]
  mem-loads OR cpu/mem-loads/                        [Kernel PMU event]
  mem-stores OR cpu/mem-stores/                      [Kernel PMU event]
  ref-cycles OR cpu/ref-cycles/                      [Kernel PMU event]
  topdown-fetch-bubbles OR cpu/topdown-fetch-bubbles/ [Kernel PMU event]
  topdown-recovery-bubbles OR cpu/topdown-recovery-bubbles/ [Kernel PMU event]
  topdown-slots-issued OR cpu/topdown-slots-issued/  [Kernel PMU event]
  topdown-slots-retired OR cpu/topdown-slots-retired/ [Kernel PMU event]
  topdown-total-slots OR cpu/topdown-total-slots/    [Kernel PMU event]
  tx-abort OR cpu/tx-abort/                          [Kernel PMU event]
  tx-capacity OR cpu/tx-capacity/                    [Kernel PMU event]
  tx-commit OR cpu/tx-commit/                        [Kernel PMU event]
  tx-conflict OR cpu/tx-conflict/                    [Kernel PMU event]
  tx-start OR cpu/tx-start/                          [Kernel PMU event]
  cstate_core/c3-residency/                          [Kernel PMU event]
  cstate_core/c6-residency/                          [Kernel PMU event]
  cstate_core/c7-residency/                          [Kernel PMU event]
  cstate_pkg/c2-residency/                           [Kernel PMU event]
  cstate_pkg/c3-residency/                           [Kernel PMU event]
  cstate_pkg/c6-residency/                           [Kernel PMU event]
  cstate_pkg/c7-residency/                           [Kernel PMU event]

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a375364537cd..faa3e0619740 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1400,6 +1400,7 @@ struct sevent {
 	char *pmu;
 	char *metric_expr;
 	char *metric_name;
+	int is_cpu;
 };
 
 static int cmp_sevent(const void *a, const void *b)
@@ -1416,6 +1417,11 @@ static int cmp_sevent(const void *a, const void *b)
 		if (n)
 			return n;
 	}
+
+	/* Order CPU core events to be first */
+	if (as->is_cpu != bs->is_cpu)
+		return bs->is_cpu - as->is_cpu;
+
 	return strcmp(as->name, bs->name);
 }
 
@@ -1507,6 +1513,7 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
 			aliases[j].pmu = pmu->name;
 			aliases[j].metric_expr = alias->metric_expr;
 			aliases[j].metric_name = alias->metric_name;
+			aliases[j].is_cpu = is_cpu;
 			j++;
 		}
 		if (pmu->selectable &&
-- 
2.26.2

