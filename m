Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B3BC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F302063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGXJSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:18:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbgGXJSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:18:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EDEC42EFE7D1DFEE1689;
        Fri, 24 Jul 2020 17:18:02 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 17:17:52 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, <zhangshaokun@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <guohanjun@huawei.com>
Subject: [PATCH 1/4] drivers/perf: Add support for ARMv8.3-SPE
Date:   Fri, 24 Jul 2020 17:16:04 +0800
Message-ID: <20200724091607.41903-2-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724091607.41903-1-liwei391@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armv8.3 extends the SPE by adding:
- Alignment field in the Events packet, and filtering on this event
  using PMSEVFR_EL1.
- Support for the Scalable Vector Extension (SVE).

The main additions for SVE are:
- Recording the vector length for SVE operations in the Operation Type
  packet. It is not possible to filter on vector length.
- Incomplete predicate and empty predicate fields in the Events packet,
  and filtering on these events using PMSEVFR_EL1.

Update the check of pmsevfr for empty/partial predicated SVE and
alignment event in kernel driver.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/include/asm/sysreg.h |  4 +++-
 drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 463175f80341..be4c44ccdb56 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -281,7 +281,6 @@
 #define SYS_PMSFCR_EL1_ST_SHIFT		18
 
 #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
-#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
 
 #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
 #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
@@ -769,6 +768,9 @@
 #define ID_AA64DFR0_PMUVER_8_5		0x6
 #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
 
+#define ID_AA64DFR0_PMSVER_8_2		0x1
+#define ID_AA64DFR0_PMSVER_8_3		0x2
+
 #define ID_DFR0_PERFMON_SHIFT		24
 
 #define ID_DFR0_PERFMON_8_1		0x4
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index e51ddb6d63ed..5ec7ee0c8fa1 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -54,7 +54,7 @@ struct arm_spe_pmu {
 	struct hlist_node			hotplug_node;
 
 	int					irq; /* PPI */
-
+	int					pmuver;
 	u16					min_period;
 	u16					counter_sz;
 
@@ -80,6 +80,15 @@ struct arm_spe_pmu {
 /* Keep track of our dynamic hotplug state */
 static enum cpuhp_state arm_spe_pmu_online;
 
+static u64 sys_pmsevfr_el1_mask[] = {
+	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
+		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
+		BIT_ULL(1),
+	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
+		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
+		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
+};
+
 enum arm_spe_pmu_buf_fault_action {
 	SPE_PMU_BUF_FAULT_ACT_SPURIOUS,
 	SPE_PMU_BUF_FAULT_ACT_FATAL,
@@ -670,7 +679,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
 		return -ENOENT;
 
-	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
+	if (arm_spe_event_to_pmsevfr(event) & ~sys_pmsevfr_el1_mask[spe_pmu->pmuver])
 		return -EOPNOTSUPP;
 
 	if (attr->exclude_idle)
@@ -937,6 +946,7 @@ static void __arm_spe_pmu_dev_probe(void *info)
 			fld, smp_processor_id());
 		return;
 	}
+	spe_pmu->pmuver = fld;
 
 	/* Read PMBIDR first to determine whether or not we have access */
 	reg = read_sysreg_s(SYS_PMBIDR_EL1);
@@ -1027,8 +1037,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	}
 
 	dev_info(dev,
-		 "probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
-		 cpumask_pr_args(&spe_pmu->supported_cpus),
+		 "v%d probed for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
+		 spe_pmu->pmuver, cpumask_pr_args(&spe_pmu->supported_cpus),
 		 spe_pmu->max_record_sz, spe_pmu->align, spe_pmu->features);
 
 	spe_pmu->features |= SPE_PMU_FEAT_DEV_PROBED;
-- 
2.17.1

