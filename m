Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71476C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F0820707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgHZNEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:04:40 -0400
Received: from foss.arm.com ([217.140.110.172]:45960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbgHZNEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:04:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B211063;
        Wed, 26 Aug 2020 06:04:05 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D92613F68F;
        Wed, 26 Aug 2020 06:04:03 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: split counter validation function
Date:   Wed, 26 Aug 2020 14:03:08 +0100
Message-Id: <20200826130309.28027-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826130309.28027-1-ionela.voinescu@arm.com>
References: <20200826130309.28027-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the counter validation function to be reused, split
validate_cpu_freq_invariance_counters() into:
 - freq_counters_valid(cpu) - check cpu for valid cycle counters
 - freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate) -
   generic function that sets the normalization ratio used by
   topology_scale_freq_tick()

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/topology.c | 46 +++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1241087e92c8..edc44b46e34f 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -150,46 +150,51 @@ void update_freq_counters_refs(void)
 	this_cpu_write(arch_const_cycles_prev, read_constcnt());
 }
 
-static int validate_cpu_freq_invariance_counters(int cpu)
+static inline bool freq_counters_valid(int cpu)
 {
 	const struct cpumask *cnt_cpu_mask = cpus_with_amu_counters();
-	u64 max_freq_hz, ratio;
 
 	if (!cnt_cpu_mask || !cpumask_test_cpu(cpu, cnt_cpu_mask)) {
 		pr_debug("CPU%d: counters are not supported.\n", cpu);
-		return -EINVAL;
+		return false;
 	}
 
 	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
 		     !per_cpu(arch_core_cycles_prev, cpu))) {
 		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
-		return -EINVAL;
+		return false;
 	}
 
-	/* Convert maximum frequency from KHz to Hz and validate */
-	max_freq_hz = cpufreq_get_hw_max_freq(cpu) * 1000;
-	if (unlikely(!max_freq_hz)) {
-		pr_debug("CPU%d: invalid maximum frequency.\n", cpu);
+	return true;
+}
+
+static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
+{
+	u64 ratio;
+
+	if (unlikely(!max_rate || !ref_rate)) {
+		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
+			 cpu);
 		return -EINVAL;
 	}
 
 	/*
 	 * Pre-compute the fixed ratio between the frequency of the constant
-	 * counter and the maximum frequency of the CPU.
+	 * reference counter and the maximum frequency of the CPU.
 	 *
-	 *			      const_freq
-	 * arch_max_freq_scale =   ---------------- * SCHED_CAPACITY_SCALE²
-	 *			   cpuinfo_max_freq
+	 *			    ref_rate
+	 * arch_max_freq_scale =   ---------- * SCHED_CAPACITY_SCALE²
+	 *			    max_rate
 	 *
 	 * We use a factor of 2 * SCHED_CAPACITY_SHIFT -> SCHED_CAPACITY_SCALE²
 	 * in order to ensure a good resolution for arch_max_freq_scale for
-	 * very low arch timer frequencies (down to the KHz range which should
+	 * very low reference frequencies (down to the KHz range which should
 	 * be unlikely).
 	 */
-	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
-	ratio = div64_u64(ratio, max_freq_hz);
+	ratio = ref_rate << (2 * SCHED_CAPACITY_SHIFT);
+	ratio = div64_u64(ratio, max_rate);
 	if (!ratio) {
-		WARN_ONCE(1, "System timer frequency too low.\n");
+		WARN_ONCE(1, "Reference frequency too low.\n");
 		return -EINVAL;
 	}
 
@@ -224,6 +229,7 @@ static int __init init_amu_fie(void)
 {
 	cpumask_var_t valid_cpus;
 	bool have_policy = false;
+	u64 max_rate_hz;
 	int ret = 0;
 	int cpu;
 
@@ -236,8 +242,14 @@ static int __init init_amu_fie(void)
 	}
 
 	for_each_present_cpu(cpu) {
-		if (validate_cpu_freq_invariance_counters(cpu))
+		if (!freq_counters_valid(cpu))
 			continue;
+
+		max_rate_hz = cpufreq_get_hw_max_freq(cpu) * 1000;
+		if (freq_inv_set_max_ratio(cpu, max_rate_hz,
+					   arch_timer_get_rate()))
+			continue;
+
 		cpumask_set_cpu(cpu, valid_cpus);
 		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
 	}
-- 
2.17.1

