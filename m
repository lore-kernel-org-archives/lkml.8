Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B720707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgHZNEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:04:05 -0400
Received: from foss.arm.com ([217.140.110.172]:45936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbgHZNEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:04:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A051101E;
        Wed, 26 Aug 2020 06:04:00 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CEA03F68F;
        Wed, 26 Aug 2020 06:03:59 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, valentin.schneider@arm.com,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: cpufeature: restructure AMU feedback function
Date:   Wed, 26 Aug 2020 14:03:06 +0100
Message-Id: <20200826130309.28027-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826130309.28027-1-ionela.voinescu@arm.com>
References: <20200826130309.28027-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current cpu_has_amu_feat() function only returns whether a single
provided CPU has support for Activity Monitors (AMUs).

Replace that function by cpus_with_amu_counters() that returns a pointer
to a cpumask with all CPUs that support AMUs. This way the user has more
freedom in regards to either checking many CPUs at once or selecting any
supporting CPU, through the use of cpumask operations.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++----
 arch/arm64/kernel/cpufeature.c      | 11 ++++++++---
 arch/arm64/kernel/topology.c        |  3 ++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 89b4f0142c28..387b28ab270c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -758,10 +758,8 @@ static inline bool cpu_has_hw_af(void)
 						ID_AA64MMFR1_HADBS_SHIFT);
 }
 
-#ifdef CONFIG_ARM64_AMU_EXTN
-/* Check whether the cpu supports the Activity Monitors Unit (AMU) */
-extern bool cpu_has_amu_feat(int cpu);
-#endif
+/* Return cpumask with CPUs that support the Activity Monitors Unit (AMU) */
+extern const struct cpumask *cpus_with_amu_counters(void);
 
 static inline unsigned int get_vmid_bits(u64 mmfr1)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6424584be01e..15a376689b2f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1516,9 +1516,9 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
  */
 static struct cpumask amu_cpus __read_mostly;
 
-bool cpu_has_amu_feat(int cpu)
+const struct cpumask *cpus_with_amu_counters(void)
 {
-	return cpumask_test_cpu(cpu, &amu_cpus);
+	return (const struct cpumask *)&amu_cpus;
 }
 
 /* Initialize the use of AMU counters for frequency invariance */
@@ -1552,7 +1552,12 @@ static bool has_amu(const struct arm64_cpu_capabilities *cap,
 
 	return true;
 }
-#endif
+#else
+const struct cpumask *cpus_with_amu_counters(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_ARM64_AMU_EXTN */
 
 #ifdef CONFIG_ARM64_VHE
 static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0801a0f3c156..2ef440938282 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -142,9 +142,10 @@ void init_cpu_freq_invariance_counters(void)
 
 static int validate_cpu_freq_invariance_counters(int cpu)
 {
+	const struct cpumask *cnt_cpu_mask = cpus_with_amu_counters();
 	u64 max_freq_hz, ratio;
 
-	if (!cpu_has_amu_feat(cpu)) {
+	if (!cnt_cpu_mask || !cpumask_test_cpu(cpu, cnt_cpu_mask)) {
 		pr_debug("CPU%d: counters are not supported.\n", cpu);
 		return -EINVAL;
 	}
-- 
2.17.1

