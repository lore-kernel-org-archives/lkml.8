Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53558C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5220838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbgAXOjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:39:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388927AbgAXOjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:39:00 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 388E5CE5092B4A3F2C15;
        Fri, 24 Jan 2020 22:38:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 Jan 2020 22:38:50 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <ak@linux.intel.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for system PMUs
Date:   Fri, 24 Jan 2020 22:34:58 +0800
Message-ID: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
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
fact, only uncore PMUs aliasing for when the uncore PMUs are fixed for a
CPU is supported, which may not always be the case for certain
architectures.

This series adds support for PMU event aliasing for system and other
uncore PMUs which are not fixed to a specific CPU.

For this, we introduce support for another per-arch mapfile, which maps a
particular system identifier to a set of system PMU events for that
system. This is much the same as what we do for CPU event aliasing.

To support this, we need to change how we match a PMU to a mapfile,
whether it should use a CPU or system mapfile. For this we do the
following:

- For CPU PMU, we always match for the event mapfile based on the CPUID.
  This has not changed.

- For an uncore or system PMU, we match first based on the SYSID (if set).
  If this fails, then we match on the CPUID.

  This works for x86, as x86 would not have any system mapfiles for uncore
  PMUs (and match on the CPUID).

Initial reference support is also added for ARM SMMUv3 PMCG (Performance
Monitor Event Group) PMU for HiSilicon hip08 platform with only a single
event so far - see driver in drivers/perf/arm_smmuv3_pmu.c for that driver.

Here is a sample output with this series:

root@ubuntu:/# ./perf list
  [...]

  smmuv3_pmcg_100020/config_cache_miss/              [Kernel PMU event]
  smmuv3_pmcg_100020/config_struct_access/           [Kernel PMU event]
  smmuv3_pmcg_100020/cycles/                         [Kernel PMU event]
  smmuv3_pmcg_100020/pcie_ats_trans_passed/          [Kernel PMU event]
  smmuv3_pmcg_100020/pcie_ats_trans_rq/              [Kernel PMU event]
  smmuv3_pmcg_100020/tlb_miss/                       [Kernel PMU event]
  smmuv3_pmcg_100020/trans_table_walk_access/        [Kernel PMU event]
  smmuv3_pmcg_100020/transaction/                    [Kernel PMU event]

  [...]

smmu v3 pmcg:
  smmuv3_pmcg.l1_tlb                                
       [SMMUv3 PMCG l1_tlb. Unit: smmuv3_pmcg]

  [...]

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

Issues with this series which need to be addressed (aware to me):

- It would be good to have a universal method to identify the system from
  sysfs. Nothing exists which I know about. There is DMI, but this is not
  always available (or has correct info). Maybe systems which want to
  support this feature will need a "soc" driver, and a
  /sys/devices/socX/machine file (which I used for testing this series -
  this driver is out of tree currently).

- Maybe it is ok, but for systems which match on the system identifier,
  uncore PMUs should be in the system mapfile, and, as such, match on the
  system identifier and not CPU identifier.

- We need a better way in jevents.c to give a direct mapping of PMU name
  aliases, i.e. for any PMU name not prefixed with "uncore_", we need to
  add this to table unit_to_pmu[]. Not scalable.

  Having said that, maybe the kernel can introduce some future PMU naming
  convention in future.

John Garry (7):
  perf jevents: Add support for an extra directory level
  perf vendor events arm64: Relocate hip08 core events
  perf jevents: Add support for a system events PMU
  perf pmu: Rename uncore symbols to include system pmus
  perf pmu: Support matching by sysid
  perf vendor events arm64: Relocate uncore events for hip08
  perf vendor events arm64: Add hip08 SMMUv3 PMCG IMP DEF events

 tools/perf/arch/arm64/util/arm-spe.c          |   2 +-
 tools/perf/pmu-events/README                  |  47 ++++++--
 .../hip08/{ => cpu}/core-imp-def.json         |   0
 .../hisilicon/hip08/sys/smmu-v3-pmcg.json     |   9 ++
 .../hip08/{ => sys}/uncore-ddrc.json          |   0
 .../hisilicon/hip08/{ => sys}/uncore-hha.json |   0
 .../hisilicon/hip08/{ => sys}/uncore-l3c.json |   0
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +-
 .../pmu-events/arch/arm64/mapfile_sys.csv     |  14 +++
 tools/perf/pmu-events/jevents.c               |  65 ++++++++--
 tools/perf/pmu-events/pmu-events.h            |   1 +
 tools/perf/util/evsel.h                       |   2 +-
 tools/perf/util/parse-events.c                |  12 +-
 tools/perf/util/pmu.c                         | 111 +++++++++++++++---
 tools/perf/util/pmu.h                         |   2 +-
 15 files changed, 221 insertions(+), 46 deletions(-)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => cpu}/core-imp-def.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/smmu-v3-pmcg.json
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => sys}/uncore-ddrc.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => sys}/uncore-hha.json (100%)
 rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ => sys}/uncore-l3c.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile_sys.csv

-- 
2.17.1

