Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01230C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD31720836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFZSYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:24:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:59785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgFZSXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:38 -0400
IronPort-SDR: x6jDTVeYKz3JfJTpXGbwQ8Wt+Rb5jNWAjZGt6p3Z00pvJsTHZ3eWPOHZGk+tsmAgpXARxfpqOB
 YP86hfaant3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512911"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512911"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:36 -0700
IronPort-SDR: Ljja82t7t8R0aiZswrcvK09w6YPU5It19/IdCmFO2excZCiaN/UQEYjAvpMam+ZkfK4Be8sbuk
 omQRq5I/zoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153861"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:36 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 09/23] perf/x86/intel: Check Arch LBR MSRs
Date:   Fri, 26 Jun 2020 11:20:06 -0700
Message-Id: <1593195620-116988-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The KVM may not support the MSRs of Architecture LBR. Accessing the
MSRs may cause #GP and crash the guest.

The MSRs have to be checked at guest boot time.

Only using the max number of Architecture LBR depth to check the
MSR_ARCH_LBR_DEPTH should be good enough. The max number can be
calculated by 8 * the position of the last set bit of LBR_DEPTH value
in CPUID enumeration.

Co-developed-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 24 ++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  5 +++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 117307a..eb17068 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4141,6 +4141,8 @@ static bool check_msr(unsigned long msr, u64 mask)
 
 	if (is_lbr_from(msr))
 		val_tmp = lbr_from_signext_quirk_wr(val_tmp);
+	else if (msr == MSR_ARCH_LBR_DEPTH)
+		val_tmp = x86_pmu_get_max_arch_lbr_nr();
 
 	if (wrmsrl_safe(msr, val_tmp) ||
 	    rdmsrl_safe(msr, &val_new))
@@ -5184,8 +5186,23 @@ __init int intel_pmu_init(void)
 	 * Check all LBT MSR here.
 	 * Disable LBR access if any LBR MSRs can not be accessed.
 	 */
-	if (x86_pmu.lbr_nr && !check_msr(x86_pmu.lbr_tos, 0x3UL))
-		x86_pmu.lbr_nr = 0;
+	if (x86_pmu.lbr_nr) {
+		if (x86_pmu.arch_lbr) {
+			u64 mask = 1;
+
+			if (x86_pmu.lbr_ebx.split.lbr_cpl)
+				mask |= ARCH_LBR_CTL_CPL;
+			if (x86_pmu.lbr_ebx.split.lbr_filter)
+				mask |= ARCH_LBR_CTL_FILTER;
+			if (x86_pmu.lbr_ebx.split.lbr_call_stack)
+				mask |= ARCH_LBR_CTL_STACK;
+			if (!check_msr(MSR_ARCH_LBR_CTL, mask))
+				x86_pmu.lbr_nr = 0;
+			if (!check_msr(MSR_ARCH_LBR_DEPTH, 0))
+				x86_pmu.lbr_nr = 0;
+		} else if (!check_msr(x86_pmu.lbr_tos, 0x3UL))
+			x86_pmu.lbr_nr = 0;
+	}
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
 		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
@@ -5202,6 +5219,9 @@ __init int intel_pmu_init(void)
 	 */
 	if (x86_pmu.extra_regs) {
 		for (er = x86_pmu.extra_regs; er->msr; er++) {
+			/* Skip Arch LBR which is already verified */
+			if (x86_pmu.arch_lbr && (er->idx == EXTRA_REG_LBR))
+				continue;
 			er->extra_msr_access = check_msr(er->msr, 0x11UL);
 			/* Disable LBR select mapping */
 			if ((er->idx == EXTRA_REG_LBR) && !er->extra_msr_access)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9b0e533..f333c83 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -813,6 +813,11 @@ static inline bool x86_pmu_has_lbr_callstack(void)
 		x86_pmu.lbr_sel_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] > 0;
 }
 
+static inline int x86_pmu_get_max_arch_lbr_nr(void)
+{
+	return fls(x86_pmu.lbr_eax.split.lbr_depth_mask) * 8;
+}
+
 DECLARE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
 int x86_perf_event_set_period(struct perf_event *event);
-- 
2.7.4

