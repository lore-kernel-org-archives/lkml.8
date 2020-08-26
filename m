Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2836EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2D420707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgHZNEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:04:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbgHZNED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:04:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F01631045;
        Wed, 26 Aug 2020 06:04:02 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 836553F68F;
        Wed, 26 Aug 2020 06:04:01 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: wrap and generalise counter read functions
Date:   Wed, 26 Aug 2020 14:03:07 +0100
Message-Id: <20200826130309.28027-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826130309.28027-1-ionela.voinescu@arm.com>
References: <20200826130309.28027-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for other uses of Activity Monitors (AMU) cycle counters,
place counter read functionality in generic functions that can reused:
read_corecnt() and read_constcnt().

As a result, implement update_freq_counters_refs() to replace
init_cpu_freq_invariance_counters() and both initialise and update
the per-cpu reference variables.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c |  4 ++--
 arch/arm64/kernel/topology.c   | 36 ++++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 15a376689b2f..40d7a4c52558 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1522,7 +1522,7 @@ const struct cpumask *cpus_with_amu_counters(void)
 }
 
 /* Initialize the use of AMU counters for frequency invariance */
-extern void init_cpu_freq_invariance_counters(void);
+extern void update_freq_counters_refs(void);
 
 static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 {
@@ -1530,7 +1530,7 @@ static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
 		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
 			smp_processor_id());
 		cpumask_set_cpu(smp_processor_id(), &amu_cpus);
-		init_cpu_freq_invariance_counters();
+		update_freq_counters_refs();
 	}
 }
 
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 2ef440938282..1241087e92c8 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -121,23 +121,33 @@ int __init parse_acpi_topology(void)
 }
 #endif
 
-#ifdef CONFIG_ARM64_AMU_EXTN
+#define COUNTER_READ_STORE(NAME, VAL) \
+static inline u64 read_##NAME(void) \
+{ \
+	return VAL; \
+} \
+static inline void store_##NAME(void *val) \
+{ \
+	*(u64 *)val = read_##NAME(); \
+}
 
-#undef pr_fmt
-#define pr_fmt(fmt) "AMU: " fmt
+#ifdef CONFIG_ARM64_AMU_EXTN
+COUNTER_READ_STORE(corecnt, read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0));
+COUNTER_READ_STORE(constcnt, read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0));
+#else
+COUNTER_READ_STORE(corecnt, 0);
+COUNTER_READ_STORE(constcnt, 0);
+#endif
 
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
 static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
 static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
 static cpumask_var_t amu_fie_cpus;
 
-/* Initialize counter reference per-cpu variables for the current CPU */
-void init_cpu_freq_invariance_counters(void)
+void update_freq_counters_refs(void)
 {
-	this_cpu_write(arch_core_cycles_prev,
-		       read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0));
-	this_cpu_write(arch_const_cycles_prev,
-		       read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0));
+	this_cpu_write(arch_core_cycles_prev, read_corecnt());
+	this_cpu_write(arch_const_cycles_prev, read_constcnt());
 }
 
 static int validate_cpu_freq_invariance_counters(int cpu)
@@ -272,11 +282,14 @@ void topology_scale_freq_tick(void)
 	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
 		return;
 
-	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
-	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
 	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
 	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
 
+	update_freq_counters_refs();
+
+	const_cnt = this_cpu_read(arch_const_cycles_prev);
+	core_cnt = this_cpu_read(arch_core_cycles_prev);
+
 	if (unlikely(core_cnt <= prev_core_cnt ||
 		     const_cnt <= prev_const_cnt))
 		goto store_and_exit;
@@ -301,4 +314,3 @@ void topology_scale_freq_tick(void)
 	this_cpu_write(arch_core_cycles_prev, core_cnt);
 	this_cpu_write(arch_const_cycles_prev, const_cnt);
 }
-#endif /* CONFIG_ARM64_AMU_EXTN */
-- 
2.17.1

