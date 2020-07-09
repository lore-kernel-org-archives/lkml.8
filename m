Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6D520663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmDlpJ0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgGIKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgGIKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:14:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD836C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:14:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so654801pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaA0NjXT9ejZD1re0oAP+uDPoFeFqxhvljIg3jQh5Fg=;
        b=OmDlpJ0f/w2TVYbbJkMRYc+V1bqmuarLLa/EookrkuDVPdoxPOaoTwW2FdIo6o18Qq
         Y+f7Ph0V8W36eKNfyxE7Un2XDMm3T84cN37TqFgz7ABiKCscy8ezDUBDx4fQupfS91nf
         Y3q6n/AVJfmt1rtTTKaHkRVv0fpTAeqPdSwvSaMxnvC4ei7816Eobex9wc6X9aqOjHH6
         rc1avRejayCXlWqTvHDnp0tg6NUjMBqXqbAvvUhLapddHReM7Q53MLxnz+9iqJQSItsQ
         5EohM8Mt8Pof2Qtt4SNLRxX4EFpkKCHnlxYifo5cuHuohDjqF+frQPpsGDDJh5htpIhv
         RZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaA0NjXT9ejZD1re0oAP+uDPoFeFqxhvljIg3jQh5Fg=;
        b=tC3s2/W52mDZqjKX/ZcWXkWIKfFEt4zoNA+YjpP5p18Kr6sD8GFnXP6fbl3w9XEkwl
         5APpJx94g1459aIqPD7Ndo0eCMO0qr19K8BVFFgl7fDnqizD6c0hx328FJoyaUgG/mmo
         T1oR8fFzEjaqTbyt3M9UzHz7jwn9pVY4ZtbWzc4mjkzoe2B8pIdJR6uWj/yNUxQuVNDb
         qF36cH9Z15/CKz+0a6BqiDxkiJql4uR5PVnT0Ux09gSsed78U7BQ9zpIkVQ9rUhdbgts
         X+Q/CQkBByGIeyxJFhiVjwTI3klU38e6oCOjkXcZlUnZyL+9BXlSTAN/unm3eDK9TJcc
         TzLQ==
X-Gm-Message-State: AOAM533+a1/QWV6kPuKaR01MJaoxJpycS0vJC3sKcSXKVXGuK5e5sFIB
        tx/bcmvTH/GXuOo7vtB3nhy3Vg==
X-Google-Smtp-Source: ABdhPJy8HyrcoQ6VzKHy2wCN8zHGO7OHZaG7NF7HUVcRbgP1JwrDTgqUnW0Scs6eadbC6ftvWS1FLQ==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12mr43077013plq.51.1594289651367;
        Thu, 09 Jul 2020 03:14:11 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id w1sm2135716pfq.53.2020.07.09.03.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:14:10 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Puhov <peter.puhov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/3] topology: Provide generic implementation of arch_freq_counters_available()
Date:   Thu,  9 Jul 2020 15:43:34 +0530
Message-Id: <ba962379ae3cbde9fa29eaf149176138bd3656de.1594289009.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1594289009.git.viresh.kumar@linaro.org>
References: <cover.1594289009.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_freq_counters_available() is implemented only for ARM AMU hardware
right now and this patch attempts to make it generic enough so other
parts of the kernel can also register their own implementation of
topology_scale_freq_tick() routine.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/include/asm/topology.h |  7 ---
 arch/arm64/kernel/topology.c      | 81 +++++++++++++++----------------
 drivers/base/arch_topology.c      | 43 ++++++++++++++--
 include/linux/arch_topology.h     |  5 +-
 4 files changed, 81 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 0cc835ddfcd1..93cca6a8cde3 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -16,14 +16,7 @@ int pcibus_to_node(struct pci_bus *bus);
 
 #include <linux/arch_topology.h>
 
-#ifdef CONFIG_ARM64_AMU_EXTN
-/*
- * Replace task scheduler's default counter-based
- * frequency-invariance scale factor setting.
- */
-void topology_scale_freq_tick(void);
 #define arch_scale_freq_tick topology_scale_freq_tick
-#endif /* CONFIG_ARM64_AMU_EXTN */
 
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_capacity topology_get_freq_scale
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 74fde35b56ef..97741da31b6d 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -188,6 +188,41 @@ bool amu_counters_supported(void)
 		cpumask_equal(valid_cpus, cpu_present_mask);
 }
 
+void amu_scale_freq_tick(void)
+{
+	u64 prev_core_cnt, prev_const_cnt;
+	u64 core_cnt, const_cnt, scale;
+
+	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
+	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
+	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
+	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
+
+	if (unlikely(core_cnt <= prev_core_cnt ||
+		     const_cnt <= prev_const_cnt))
+		goto store_and_exit;
+
+	/*
+	 *	    /\core    arch_max_freq_scale
+	 * scale =  ------- * --------------------
+	 *	    /\const   SCHED_CAPACITY_SCALE
+	 *
+	 * See setup_freq_invariance() for details on
+	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
+	 */
+	scale = core_cnt - prev_core_cnt;
+	scale *= this_cpu_read(arch_max_freq_scale);
+	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
+			  const_cnt - prev_const_cnt);
+
+	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
+	this_cpu_write(freq_scale, (unsigned long)scale);
+
+store_and_exit:
+	this_cpu_write(arch_core_cycles_prev, core_cnt);
+	this_cpu_write(arch_const_cycles_prev, const_cnt);
+}
+
 static int __init early_init_amu_fie(void)
 {
 	int cpu;
@@ -230,9 +265,11 @@ static int __init late_init_amu_fie(void)
 	if (!cpumask_empty(amu_fie_cpus)) {
 		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
 			cpumask_pr_args(amu_fie_cpus));
-		static_branch_enable(&amu_fie_key);
+		if (!topology_set_scale_freq_tick(amu_scale_freq_tick, amu_fie_cpus))
+			pr_info("Registered amu_scale_freq_tick()\n");
 	}
 
+	free_cpumask_var(amu_fie_cpus);
 	return 0;
 }
 late_initcall_sync(late_init_amu_fie);
@@ -242,48 +279,6 @@ bool arch_freq_counters_available(struct cpumask *cpus)
 	return amu_freq_invariant() &&
 	       cpumask_subset(cpus, amu_fie_cpus);
 }
-
-void topology_scale_freq_tick(void)
-{
-	u64 prev_core_cnt, prev_const_cnt;
-	u64 core_cnt, const_cnt, scale;
-	int cpu = smp_processor_id();
-
-	if (!amu_freq_invariant())
-		return;
-
-	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
-		return;
-
-	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
-	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
-	prev_const_cnt = this_cpu_read(arch_const_cycles_prev);
-	prev_core_cnt = this_cpu_read(arch_core_cycles_prev);
-
-	if (unlikely(core_cnt <= prev_core_cnt ||
-		     const_cnt <= prev_const_cnt))
-		goto store_and_exit;
-
-	/*
-	 *	    /\core    arch_max_freq_scale
-	 * scale =  ------- * --------------------
-	 *	    /\const   SCHED_CAPACITY_SCALE
-	 *
-	 * See setup_freq_invariance() for details on
-	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
-	 */
-	scale = core_cnt - prev_core_cnt;
-	scale *= this_cpu_read(arch_max_freq_scale);
-	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
-			  const_cnt - prev_const_cnt);
-
-	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
-	this_cpu_write(freq_scale, (unsigned long)scale);
-
-store_and_exit:
-	this_cpu_write(arch_core_cycles_prev, core_cnt);
-	this_cpu_write(arch_const_cycles_prev, const_cnt);
-}
 #else
 bool amu_counters_supported(void)
 {
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4d0a0038b476..3820109864c1 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,11 +21,48 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
-__weak bool arch_freq_counters_available(struct cpumask *cpus)
+static void (*scale_freq_tick)(void);
+static cpumask_var_t freq_tick_cpus;
+
+int topology_set_scale_freq_tick(void *ptr, const struct cpumask *cpus)
 {
-	return false;
+	if (scale_freq_tick)
+		return -EBUSY;
+
+	if (!zalloc_cpumask_var(&freq_tick_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(freq_tick_cpus, cpus);
+	scale_freq_tick = ptr;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(topology_set_scale_freq_tick);
+
+void topology_remove_scale_freq_tick(void *ptr)
+{
+	if (scale_freq_tick == ptr) {
+		free_cpumask_var(freq_tick_cpus);
+		scale_freq_tick = NULL;
+	} else {
+		pr_err("%s: Invalid argument\n", __func__);
+	}
+}
+EXPORT_SYMBOL_GPL(topology_remove_scale_freq_tick);
+
+void topology_scale_freq_tick(void)
+{
+	if (scale_freq_tick &&
+	    cpumask_test_cpu(raw_smp_processor_id(), freq_tick_cpus))
+		scale_freq_tick();
+}
+
+static bool support_scale_freq_tick(struct cpumask *cpus)
+{
+	return scale_freq_tick && cpumask_subset(cpus, freq_tick_cpus);
+}
+
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
+EXPORT_SYMBOL_GPL(freq_scale);
 
 void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 			 unsigned long max_freq)
@@ -38,7 +75,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 	 * want to update the scale factor with information from CPUFREQ.
 	 * Instead the scale factor will be updated from arch_scale_freq_tick.
 	 */
-	if (arch_freq_counters_available(cpus))
+	if (support_scale_freq_tick(cpus))
 		return;
 
 	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0566cb3314ef..6305148c8aa0 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -10,6 +10,9 @@
 
 void topology_normalize_cpu_scale(void);
 int topology_update_cpu_topology(void);
+void topology_scale_freq_tick(void);
+int topology_set_scale_freq_tick(void *ptr, const struct cpumask *cpus);
+void topology_remove_scale_freq_tick(void *ptr);
 
 struct device_node;
 bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
@@ -30,8 +33,6 @@ static inline unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
-bool arch_freq_counters_available(struct cpumask *cpus);
-
 DECLARE_PER_CPU(unsigned long, thermal_pressure);
 
 static inline unsigned long topology_get_thermal_pressure(int cpu)
-- 
2.25.0.rc1.19.g042ed3e048af

