Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B0DC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBAD20784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503039AbgDPI4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:56:03 -0400
Received: from mx139-tc.baidu.com ([61.135.168.139]:37925 "EHLO
        tc-sys-mailedm03.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502931AbgDPIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:51:38 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm03.tc.baidu.com (Postfix) with ESMTP id 3CCB04500032;
        Thu, 16 Apr 2020 16:51:18 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     peterz@infradead.org, frederic@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/isolation: allow isolcpus and nohz_full for different cpus
Date:   Thu, 16 Apr 2020 16:51:18 +0800
Message-Id: <1587027078-16239-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when both isolcpus and nohz_full are set, their cpus must be
same now, in fact isolcpus and nohz_full are not related, and
different cpus are expected for some cases, for example, some
cores for polling threads wants to isolcpus, and some cores for
dedicated threads, only nohz_full is expected

so define two housekeeping mask to save these two configuration
separately and make cpus same only when both nohz_full and
isolcpus with nohz are passed into kernel

fix a build error when CONFIG_CPUMASK_OFFSTACK is not configured
reported by kbuild test robot <lkp@intel.com>

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/isolation.c | 80 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 008d6ac2342b..f2331c443121 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -11,7 +11,8 @@
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
-static cpumask_var_t housekeeping_mask;
+static cpumask_var_t housekeeping_mask_isolcpus;
+static cpumask_var_t housekeeping_mask_nohz_full;
 static unsigned int housekeeping_flags;
 
 bool housekeeping_enabled(enum hk_flags flags)
@@ -20,12 +21,27 @@ bool housekeeping_enabled(enum hk_flags flags)
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
+static struct cpumask *housekeeping_get_mask(enum hk_flags flags)
+{
+	if (flags & (HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ))
+		return housekeeping_mask_isolcpus;
+
+	/* set by isolcpus=nohz only */
+	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_RCU))
+		return housekeeping_mask_isolcpus;
+
+	return housekeeping_mask_nohz_full;
+}
+
 int housekeeping_any_cpu(enum hk_flags flags)
 {
 	int cpu;
 
 	if (static_branch_unlikely(&housekeeping_overridden)) {
 		if (housekeeping_flags & flags) {
+			struct cpumask *housekeeping_mask;
+
+			housekeeping_mask = housekeeping_get_mask(flags);
 			cpu = sched_numa_find_closest(housekeeping_mask, smp_processor_id());
 			if (cpu < nr_cpu_ids)
 				return cpu;
@@ -41,7 +57,7 @@ const struct cpumask *housekeeping_cpumask(enum hk_flags flags)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
 		if (housekeeping_flags & flags)
-			return housekeeping_mask;
+			return housekeeping_get_mask(flags);
 	return cpu_possible_mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
@@ -49,16 +65,24 @@ EXPORT_SYMBOL_GPL(housekeeping_cpumask);
 void housekeeping_affine(struct task_struct *t, enum hk_flags flags)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
+		if (housekeeping_flags & flags) {
+			struct cpumask *housekeeping_mask;
+
+			housekeeping_mask = housekeeping_get_mask(flags);
 			set_cpus_allowed_ptr(t, housekeeping_mask);
+		}
 }
 EXPORT_SYMBOL_GPL(housekeeping_affine);
 
 bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
-		if (housekeeping_flags & flags)
+		if (housekeeping_flags & flags) {
+			struct cpumask *housekeeping_mask;
+
+			housekeeping_mask = housekeeping_get_mask(flags);
 			return cpumask_test_cpu(cpu, housekeeping_mask);
+		}
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
@@ -74,10 +98,14 @@ void __init housekeeping_init(void)
 		sched_tick_offload_init();
 
 	/* We need at least one CPU to handle housekeeping work */
-	WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
+	if (housekeeping_flags & (HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ))
+		WARN_ON_ONCE(cpumask_empty(housekeeping_mask_isolcpus));
+	if (housekeeping_flags & HK_FLAG_TICK)
+		WARN_ON_ONCE(cpumask_empty(housekeeping_mask_nohz_full));
 }
 
-static int __init housekeeping_setup(char *str, enum hk_flags flags)
+static int __init housekeeping_setup(char *str, enum hk_flags flags,
+		cpumask_var_t *housekeeping_mask)
 {
 	cpumask_var_t non_housekeeping_mask;
 	cpumask_var_t tmp;
@@ -92,25 +120,25 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 	}
 
 	alloc_bootmem_cpumask_var(&tmp);
-	if (!housekeeping_flags) {
-		alloc_bootmem_cpumask_var(&housekeeping_mask);
-		cpumask_andnot(housekeeping_mask,
-			       cpu_possible_mask, non_housekeeping_mask);
-
-		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
-		if (cpumask_empty(tmp)) {
-			pr_warn("Housekeeping: must include one present CPU, "
+	alloc_bootmem_cpumask_var(housekeeping_mask);
+	cpumask_andnot(*housekeeping_mask,
+				   cpu_possible_mask, non_housekeeping_mask);
+
+	cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
+	if (cpumask_empty(tmp)) {
+		pr_warn("Housekeeping: must include one present CPU, "
 				"using boot CPU:%d\n", smp_processor_id());
-			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
-			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
-		}
-	} else {
-		cpumask_andnot(tmp, cpu_present_mask, non_housekeeping_mask);
-		if (cpumask_empty(tmp))
-			__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
-		cpumask_andnot(tmp, cpu_possible_mask, non_housekeeping_mask);
-		if (!cpumask_equal(tmp, housekeeping_mask)) {
-			pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
+		__cpumask_set_cpu(smp_processor_id(), *housekeeping_mask);
+		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
+	}
+
+	/* cpus should match when both nohz_full and isolcpus
+	 * with nohz are passed into kernel
+	 */
+	if (housekeeping_flags & flags & HK_FLAG_TICK) {
+		if (!cpumask_equal(housekeeping_mask_nohz_full,
+					housekeeping_mask_isolcpus)) {
+			pr_warn("Housekeeping: nohz_full= must match isolcpus=nohz\n");
 			free_bootmem_cpumask_var(tmp);
 			free_bootmem_cpumask_var(non_housekeeping_mask);
 			return 0;
@@ -142,7 +170,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 
 	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
 
-	return housekeeping_setup(str, flags);
+	return housekeeping_setup(str, flags, &housekeeping_mask_nohz_full);
 }
 __setup("nohz_full=", housekeeping_nohz_full_setup);
 
@@ -177,6 +205,6 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	if (!flags)
 		flags |= HK_FLAG_DOMAIN;
 
-	return housekeeping_setup(str, flags);
+	return housekeeping_setup(str, flags, &housekeeping_mask_isolcpus);
 }
 __setup("isolcpus=", housekeeping_isolcpus_setup);
-- 
2.16.2

