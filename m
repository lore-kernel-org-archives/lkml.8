Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E1DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B03420663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuPYL7m8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGIKON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGIKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:14:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D172C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:14:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k5so640127plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WERQI4vx6F5VSTK4bYtw80Xem66EpKMMios6baMMwa0=;
        b=KuPYL7m8Uh7NSA/5J+KV4azQCkpwPrcOWfCvWD6oaM9p1gssUwN3jQWCSWbRErgIPG
         Z3F31SQcxapgS+qZr0wEIXthq6Unt9YOjhuFbFD61QC2v1DlNWOuljjD21uCVdXMATFh
         n0Dh4kzp/lCCbUqIeCEbVewIcHhPa4opRZnK5uoKTaMtV5PxjZ6RwpsH++pGmNM8Eu6x
         STN7i5l1Fqnwj6VWxCubDmbvzh0RXeWMpubaPUJApbvWpVXT0RLZB0fxw7ioJDTB4cKq
         I3SPXOvm2q7aZd5nM1BkG+jeiE5crgU9HDswSmnrPoKIBdq4/lEwSUsZrs+lIWOXkZ5K
         fq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WERQI4vx6F5VSTK4bYtw80Xem66EpKMMios6baMMwa0=;
        b=huqzNhx6LBJaaDekkXe2axFfmGVeYFOFIT9gsCXsJmFMYt/tv+7afiZDyWoNOdlZju
         KuVSAIsVguD2xRbRZhQInscQoMpcMSAhdPx0lDshAldaZd8mus6iX72DwxhF41t4XzrE
         1THGR1eBSZesQdk5oK3xMnSrabmSwbz+nVrh3GaW5CdPvJmBmJXZ0XSrbQlLU5s5MSp6
         51ImuzjVGuY4NmABuRj6jBwWHe5nZ+QIFrS20xLQomQ0kntOn+V9KO1I3ubiFSolI5gJ
         yCPV+c4XquEJGQFf4PAHsLc4XxdWqnOWd+CnKgRQotKH7stRJQZ9MSfDFe1o5Pj09Sdd
         pITg==
X-Gm-Message-State: AOAM530isbtDDeK6m0I+tYpfzSh+VHcfUEtduc5HSuPFcv/25nH73miN
        oqN7e6Q0+pRADp8CJ7p3GCaDGw==
X-Google-Smtp-Source: ABdhPJyD5D4wQ3AEbgkO7obMmfy/iLRvycFB4eWrx780dkivmT+OKlyJ7b2yYKFm2jxkqaitum0vKg==
X-Received: by 2002:a17:90b:1c12:: with SMTP id oc18mr14114371pjb.160.1594289647985;
        Thu, 09 Jul 2020 03:14:07 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id 15sm2157222pjs.8.2020.07.09.03.14.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:14:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Puhov <peter.puhov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/3] arm64: topology: Add amu_counters_supported() helper
Date:   Thu,  9 Jul 2020 15:43:33 +0530
Message-Id: <f4b69674ee35cbec102857218d8409249c8f26c7.1594289009.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1594289009.git.viresh.kumar@linaro.org>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would need to know earlier during the boot cycle if AMUs are
supported or not for all the CPUs, export a routine for that and move
code around to make it more readable.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c | 108 ++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b7da372819fc..74fde35b56ef 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -130,6 +130,9 @@ static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
 static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
 static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
 static cpumask_var_t amu_fie_cpus;
+static cpumask_var_t valid_cpus;
+static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
+#define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
 
 /* Initialize counter reference per-cpu variables for the current CPU */
 void init_cpu_freq_invariance_counters(void)
@@ -140,26 +143,14 @@ void init_cpu_freq_invariance_counters(void)
 		       read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0));
 }
 
-static int validate_cpu_freq_invariance_counters(int cpu)
+static void setup_freq_invariance(int cpu)
 {
-	u64 max_freq_hz, ratio;
-
-	if (!cpu_has_amu_feat(cpu)) {
-		pr_debug("CPU%d: counters are not supported.\n", cpu);
-		return -EINVAL;
-	}
-
-	if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
-		     !per_cpu(arch_core_cycles_prev, cpu))) {
-		pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
-		return -EINVAL;
-	}
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	u64 ratio;
 
-	/* Convert maximum frequency from KHz to Hz and validate */
-	max_freq_hz = cpufreq_get_hw_max_freq(cpu) * 1000;
-	if (unlikely(!max_freq_hz)) {
-		pr_debug("CPU%d: invalid maximum frequency.\n", cpu);
-		return -EINVAL;
+	if (!policy) {
+		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
+		return;
 	}
 
 	/*
@@ -176,69 +167,75 @@ static int validate_cpu_freq_invariance_counters(int cpu)
 	 * be unlikely).
 	 */
 	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
-	ratio = div64_u64(ratio, max_freq_hz);
+	ratio = div64_u64(ratio, policy->cpuinfo.max_freq * 1000);
 	if (!ratio) {
 		WARN_ONCE(1, "System timer frequency too low.\n");
-		return -EINVAL;
+		goto out;
 	}
 
 	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
 
-	return 0;
-}
-
-static inline void update_amu_fie_cpus(int cpu, cpumask_var_t valid_cpus)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-
-	if (!policy) {
-		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
-		return;
-	}
-
 	if (cpumask_subset(policy->related_cpus, valid_cpus))
-		cpumask_or(amu_fie_cpus, policy->related_cpus,
-			   amu_fie_cpus);
+		cpumask_or(amu_fie_cpus, policy->related_cpus, amu_fie_cpus);
 
+out:
 	cpufreq_cpu_put(policy);
 }
 
-static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
-#define amu_freq_invariant() static_branch_unlikely(&amu_fie_key)
+bool amu_counters_supported(void)
+{
+	return likely(cpumask_available(valid_cpus)) &&
+		cpumask_equal(valid_cpus, cpu_present_mask);
+}
 
-static int __init init_amu_fie(void)
+static int __init early_init_amu_fie(void)
 {
-	cpumask_var_t valid_cpus;
-	int ret = 0;
 	int cpu;
 
 	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL))
 		return -ENOMEM;
 
-	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto free_valid_mask;
-	}
-
 	for_each_present_cpu(cpu) {
-		if (validate_cpu_freq_invariance_counters(cpu))
+		if (!cpu_has_amu_feat(cpu)) {
+			pr_debug("CPU%d: counters are not supported.\n", cpu);
+			continue;
+		}
+
+		if (unlikely(!per_cpu(arch_const_cycles_prev, cpu) ||
+			     !per_cpu(arch_core_cycles_prev, cpu))) {
+			pr_debug("CPU%d: cycle counters are not enabled.\n", cpu);
 			continue;
+		}
+
 		cpumask_set_cpu(cpu, valid_cpus);
-		update_amu_fie_cpus(cpu, valid_cpus);
 	}
 
+	return 0;
+}
+core_initcall_sync(early_init_amu_fie);
+
+static int __init late_init_amu_fie(void)
+{
+	int cpu;
+
+	if (!cpumask_available(valid_cpus))
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	for_each_present_cpu(cpu)
+		setup_freq_invariance(cpu);
+
 	if (!cpumask_empty(amu_fie_cpus)) {
 		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
 			cpumask_pr_args(amu_fie_cpus));
 		static_branch_enable(&amu_fie_key);
 	}
 
-free_valid_mask:
-	free_cpumask_var(valid_cpus);
-
-	return ret;
+	return 0;
 }
-late_initcall_sync(init_amu_fie);
+late_initcall_sync(late_init_amu_fie);
 
 bool arch_freq_counters_available(struct cpumask *cpus)
 {
@@ -272,7 +269,7 @@ void topology_scale_freq_tick(void)
 	 * scale =  ------- * --------------------
 	 *	    /\const   SCHED_CAPACITY_SCALE
 	 *
-	 * See validate_cpu_freq_invariance_counters() for details on
+	 * See setup_freq_invariance() for details on
 	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
 	 */
 	scale = core_cnt - prev_core_cnt;
@@ -287,4 +284,11 @@ void topology_scale_freq_tick(void)
 	this_cpu_write(arch_core_cycles_prev, core_cnt);
 	this_cpu_write(arch_const_cycles_prev, const_cnt);
 }
+#else
+bool amu_counters_supported(void)
+{
+	return false;
+}
 #endif /* CONFIG_ARM64_AMU_EXTN */
+
+EXPORT_SYMBOL_GPL(amu_counters_supported);
-- 
2.25.0.rc1.19.g042ed3e048af

