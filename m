Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A458BC38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D522221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgDQKpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:45:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729905AbgDQKpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C35CE454E8585F57A342;
        Fri, 17 Apr 2020 18:45:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 18:45:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>
CC:     <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <irogers@google.com>, <robin.murphy@arm.com>,
        <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH v2 00/13] perf pmu-events: Support event aliasing for system PMUs
Date:   Fri, 17 Apr 2020 18:41:11 +0800
Message-ID: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently event aliasing for only CPU and uncore PMUs is supported. In
fact, only uncore PMUs aliasing is supported for when the uncore PMUs are
fixed for a CPU, which may not always be the case for certain
architectures.

This series adds support for PMU event aliasing for system and other
uncore PMUs which are not tied to a specific CPU. Or, more specifically,
CPUs which not tied to those PMUs.

For this, we introduce system event tables in generated pmu-events.c,
which contain a per-SoC table of events of all its system PMUs. Each
per-PMU event is matched by a "COMPAT" property.

When creating aliases for PMUs, we treat core/uncore* and system PMUs
differently:

- For CPU PMU, we always match for the event mapfile based on the CPUID.
   This has not changed.

- For an uncore or system PMU, we iterate through all the events in all
   the system PMU tables.

   Matches are based on the "COMPAT" property matching the PMU sysfs
   identifier contents, in /sys/bus/event_source/devices/<PMU>/identifier

* uncore PMUs may also be matched by system PMUs event support.

Initial reference support is also added for ARM SMMUv3 PMCG (Performance
Monitor Event Group) PMU for HiSilicon hip08 platform with only a single
event so far - see driver in drivers/perf/arm_smmuv3_pmu.c for that driver.

Here is a sample output with this series on Huawei D06CS board:

root@ubuntu:/# ./perf list
   [...]

smmu v3 pmcg:
   smmuv3_pmcg.config_cache_miss
        [Configuration cache miss caused by transaction or(ATS or
        non-ATS)translation request. Unit: smmuv3_pmcg]
   smmuv3_pmcg.config_struct_access
        [Configuration structure access. Unit: smmuv3_pmcg]
   smmuv3_pmcg.cycles
        [Clock cycles. Unit: smmuv3_pmcg]
   smmuv3_pmcg.l1_tlb
        [SMMUv3 PMCG L1 TABLE transation. Unit: smmuv3_pmcg]
   smmuv3_pmcg.pcie_ats_trans_passed
        [PCIe ATS Translated Transaction passed through SMMU. Unit: 
smmuv3_pmcg]
   smmuv3_pmcg.pcie_ats_trans_rq
        [PCIe ATS Translation Request received. Unit: smmuv3_pmcg]
   smmuv3_pmcg.tlb_miss
        [TLB miss caused by incomingtransaction or (ATS or non-ATS) 
translation
         request. Unit: smmuv3_pmcg]
   smmuv3_pmcg.trans_table_walk_access
        [Translation table walk access. Unit: smmuv3_pmcg]
   smmuv3_pmcg.transaction
        [Transaction. Unit: smmuv3_pmcg]


root@ubuntu:/# ./perf stat -v -e smmuv3_pmcg.l1_tlb sleep 1
Using CPUID 0x00000000480fd010
Using SYSID HIP08
-> smmuv3_pmcg_200100020/event=0x8a/
-> smmuv3_pmcg_200140020/event=0x8a/
-> smmuv3_pmcg_100020/event=0x8a/
-> smmuv3_pmcg_140020/event=0x8a/
-> smmuv3_pmcg_200148020/event=0x8a/
-> smmuv3_pmcg_148020/event=0x8a/
smmuv3_pmcg.l1_tlb: 0 1001221690 1001221690
smmuv3_pmcg.l1_tlb: 0 1001220090 1001220090
smmuv3_pmcg.l1_tlb: 101 1001219660 1001219660
smmuv3_pmcg.l1_tlb: 0 1001219010 1001219010
smmuv3_pmcg.l1_tlb: 0 1001218360 1001218360
smmuv3_pmcg.l1_tlb: 134 1001217850 1001217850

Performance counter stats for 'system wide':

                235      smmuv3_pmcg.l1_tlb 


        1.001263128 seconds time elapsed

root@ubuntu:/#

Support is also added for imx8mm DDR PMU.

Series is here:
https://github.com/hisilicon/kernel-dev/commits/private-topic-perf-5.6-sys-pmu-events-v2-upstream

Differences to v1:
- Stop using SoC id and use a per-PMU identifier instead
- Add metric group sys events support
   - This is a bit hacky
- Add imx8mm DDR Perf support
- Add fix for parse events sel
	- without it, I get this spewed for metric event:

	assertion failed at util/parse-events.c:1637

Patches still need to be sent to support per-PMU identifer sysfs file
in the kernel.

Thanks,
John

Joakim Zhang (1):
  perf vendor events: Add JSON metrics for imx8mm DDR Perf

John Garry (12):
  perf parse-events: Fix comparison of evsel and leader pmu name
  perf jevents: Add support for an extra directory level
  perf jevents: Add support for system events tables
  perf vendor events arm64: Relocate hip08 events
  perf vendor events arm64: Add Architected events smmuv3-pmcg.json
  perf vendor events arm64: Add hip08 SMMUv3 PMCG events
  perf pmu: Add pmu_id()
  perf pmu: Add pmu_add_sys_aliases()
  perf metricgroup: Split up metricgroup__add_metric()
  perf metricgroup: Split up metricgroup__print()
  perf metricgroup: Support printing metric groups for system PMUs
  perf metricgroup: Support adding metrics for system PMUs

 .../arch/arm64/freescale/imx8mm/sys/ddrc.json      |  39 +++
 .../arch/arm64/freescale/imx8mm/sys/metrics.json   |  18 ++
 .../hisilicon/hip08/{ => cpu}/core-imp-def.json    |   0
 .../hisilicon/hip08/{ => cpu}/uncore-ddrc.json     |   0
 .../hisilicon/hip08/{ => cpu}/uncore-hha.json      |   0
 .../hisilicon/hip08/{ => cpu}/uncore-l3c.json      |   0
 .../arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json    |  42 +++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   2 +-
 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json  |  58 ++++
 tools/perf/pmu-events/jevents.c                    | 152 ++++++++---
 tools/perf/pmu-events/jevents.h                    |  11 +-
 tools/perf/pmu-events/pmu-events.h                 |   6 +
 tools/perf/util/metricgroup.c                      | 291 ++++++++++++++-------
 tools/perf/util/parse-events.c                     |   2 +-
 tools/perf/util/pmu.c                              | 115 ++++++++
 tools/perf/util/pmu.h                              |   6 +
 16 files changed, 612 insertions(+), 130 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/core-imp-def.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-ddrc.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-hha.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/uncore-l3c.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json

-- 
2.16.4

