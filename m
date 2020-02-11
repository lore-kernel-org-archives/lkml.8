Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B94C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D692246A7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgBKMrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:47:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgBKMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux7-0007Yg-K0; Tue, 11 Feb 2020 13:47:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3B8F61C2018;
        Tue, 11 Feb 2020 13:47:45 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:44 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Avoid unnecessary PEBS_ENABLE MSR
 access in PMI
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200121181338.3234-1-kan.liang@linux.intel.com>
References: <20200121181338.3234-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158142526498.411.9050167977316432936.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6c1c07b33eb093e5a2a313ece89baa596ba6135e
Gitweb:        https://git.kernel.org/tip/6c1c07b33eb093e5a2a313ece89baa596ba6135e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 21 Jan 2020 10:13:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:23:48 +01:00

perf/x86/intel: Avoid unnecessary PEBS_ENABLE MSR access in PMI

The perf PMI handler, intel_pmu_handle_irq(), currently does
unnecessary MSR accesses for PEBS_ENABLE MSR in
__intel_pmu_enable/disable_all() when PEBS is enabled.

When entering the handler, global ctrl is explicitly disabled. All
counters do not count anymore. It doesn't matter if PEBS is enabled
or not in a PMI handler.
Furthermore, for most cases, the cpuc->pebs_enabled is not changed in
PMI. The PEBS status doesn't change. The PEBS_ENABLE MSR doesn't need to
be changed either when exiting the handler.

PMI throttle may change the PEBS status during PMI handler. The
x86_pmu_stop() ends up in intel_pmu_pebs_disable() which can update
cpuc->pebs_enabled. But the MSR_IA32_PEBS_ENABLE is not updated
at the same time. Because the cpuc->enabled has been forced to 0.
The patch explicitly update the MSR_IA32_PEBS_ENABLE for this case.

Use ftrace to measure the duration of intel_pmu_handle_irq() on BDX.
   #perf record -e cycles:P -- ./tchain_edit

The average duration of intel_pmu_handle_irq():

  Without the patch       1.144 us
  With the patch          1.025 us

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200121181338.3234-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dff6623..332954c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1945,6 +1945,14 @@ static __initconst const u64 knl_hw_cache_extra_regs
  * intel_bts events don't coexist with intel PMU's BTS events because of
  * x86_add_exclusive(x86_lbr_exclusive_lbr); there's no need to keep them
  * disabled around intel PMU's event batching etc, only inside the PMI handler.
+ *
+ * Avoid PEBS_ENABLE MSR access in PMIs.
+ * The GLOBAL_CTRL has been disabled. All the counters do not count anymore.
+ * It doesn't matter if the PEBS is enabled or not.
+ * Usually, the PEBS status are not changed in PMIs. It's unnecessary to
+ * access PEBS_ENABLE MSR in disable_all()/enable_all().
+ * However, there are some cases which may change PEBS status, e.g. PMI
+ * throttle. The PEBS_ENABLE should be updated where the status changes.
  */
 static void __intel_pmu_disable_all(void)
 {
@@ -1954,13 +1962,12 @@ static void __intel_pmu_disable_all(void)
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask))
 		intel_pmu_disable_bts();
-
-	intel_pmu_pebs_disable_all();
 }
 
 static void intel_pmu_disable_all(void)
 {
 	__intel_pmu_disable_all();
+	intel_pmu_pebs_disable_all();
 	intel_pmu_lbr_disable_all();
 }
 
@@ -1968,7 +1975,6 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	intel_pmu_pebs_enable_all();
 	intel_pmu_lbr_enable_all(pmi);
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
 			x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
@@ -1986,6 +1992,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 
 static void intel_pmu_enable_all(int added)
 {
+	intel_pmu_pebs_enable_all();
 	__intel_pmu_enable_all(added, false);
 }
 
@@ -2374,9 +2381,21 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 * PEBS overflow sets bit 62 in the global status register
 	 */
 	if (__test_and_clear_bit(62, (unsigned long *)&status)) {
+		u64 pebs_enabled = cpuc->pebs_enabled;
+
 		handled++;
 		x86_pmu.drain_pebs(regs);
 		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
+
+		/*
+		 * PMI throttle may be triggered, which stops the PEBS event.
+		 * Although cpuc->pebs_enabled is updated accordingly, the
+		 * MSR_IA32_PEBS_ENABLE is not updated. Because the
+		 * cpuc->enabled has been forced to 0 in PMI.
+		 * Update the MSR if pebs_enabled is changed.
+		 */
+		if (pebs_enabled != cpuc->pebs_enabled)
+			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 	}
 
 	/*
