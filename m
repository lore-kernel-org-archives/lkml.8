Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCBAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E128E20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lcb6W8aE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DOxAawU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgGHJv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgGHJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:52 -0400
Date:   Wed, 08 Jul 2020 09:51:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U1smPrYcLaJ21/bghacBWCafj5RQ2MCr4tZnzqVD7OM=;
        b=Lcb6W8aEu2CgMuNEwq/TMvPbNVs4mkVea0CjhMtrz5S3+lOXvq7+GqX7jdhKlMUMe4RaQR
        waTp7jZ3TiEUm2PYaOGPHrFrEEw4Nkya+CCdsj2pR1Nljc80z6GiEyTfqsVU5ZzOputCWG
        JxKdQdASexM+tppbkSwz4DYZtBtwBi6Z90e82+kf/F1JHCmRFz7UtVCKrKQzI9dvVI6L0S
        vExC5A9bXz4TkmEGQhNyTeVH3xaUMz9d4ZKht5LbWhHxrxrwidWq2ZVcKQac/O3Eca9Iov
        yOLBvKMN1g6fAVJy1+6eLgtvcdeHSRUDSmMB2p4Rr+FjJ8g5Z8pbTP0+rflpuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U1smPrYcLaJ21/bghacBWCafj5RQ2MCr4tZnzqVD7OM=;
        b=DOxAawU9diZXUDd2tYcQaG7SFLMJUZN+KdbWHt2/ce29l7aCwzc8xK8MWiyyL5LhelGzzW
        A7l8OOK5TH+NT5CQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Support Architectural LBR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-15-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-15-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190824.4006.11131735439641561253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     47125db27e47e9d44c878bf8925aa057824bb0d5
Gitweb:        https://git.kernel.org/tip/47125db27e47e9d44c878bf8925aa057824bb0d5
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:20 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:54 +02:00

perf/x86/intel/lbr: Support Architectural LBR

Last Branch Records (LBR) enables recording of software path history by
logging taken branches and other control flows within architectural
registers now. Intel CPUs have had model-specific LBR for quite some
time, but this evolves them into an architectural feature now.

The main improvements of Architectural LBR implemented includes:
- Linux kernel can support the LBR features without knowing the model
  number of the current CPU.
- Architectural LBR capabilities can be enumerated by CPUID. The
  lbr_ctl_map is based on the CPUID Enumeration.
- The possible LBR depth can be retrieved from CPUID enumeration. The
  max value is written to the new MSR_ARCH_LBR_DEPTH as the number of
  LBR entries.
- A new IA32_LBR_CTL MSR is introduced to enable and configure LBRs,
  which replaces the IA32_DEBUGCTL[bit 0] and the LBR_SELECT MSR.
- Each LBR record or entry is still comprised of three MSRs,
  IA32_LBR_x_FROM_IP, IA32_LBR_x_TO_IP and IA32_LBR_x_TO_IP.
  But they become the architectural MSRs.
- Architectural LBR is stack-like now. Entry 0 is always the youngest
  branch, entry 1 the next youngest... The TOS MSR has been removed.

The way to enable/disable Architectural LBR is similar to the previous
model-specific LBR. __intel_pmu_lbr_enable/disable() can be reused, but
some modifications are required, which include:
- MSR_ARCH_LBR_CTL is used to enable and configure the Architectural
  LBR.
- When checking the value of the IA32_DEBUGCTL MSR, ignoring the
  DEBUGCTLMSR_LBR (bit 0) for Architectural LBR, which has no meaning
  and always return 0.
- The FREEZE_LBRS_ON_PMI has to be explicitly set/clear, because
  MSR_IA32_DEBUGCTLMSR is not touched in __intel_pmu_lbr_disable() for
  Architectural LBR.
- Only MSR_ARCH_LBR_CTL is cleared in __intel_pmu_lbr_disable() for
  Architectural LBR.

Some Architectural LBR dedicated functions are implemented to
reset/read/save/restore LBR.
- For reset, writing to the ARCH_LBR_DEPTH MSR clears all Arch LBR
  entries, which is a lot faster and can improve the context switch
  latency.
- For read, the branch type information can be retrieved from
  the MSR_ARCH_LBR_INFO_*. But it's not fully compatible due to
  OTHER_BRANCH type. The software decoding is still required for the
  OTHER_BRANCH case.
  LBR records are stored in the age order as well. Reuse
  intel_pmu_store_lbr(). Check the CPUID enumeration before accessing
  the corresponding bits in LBR_INFO.
- For save/restore, applying the fast reset (writing ARCH_LBR_DEPTH).
  Reading 'lbr_from' of entry 0 instead of the TOS MSR to check if the
  LBR registers are reset in the deep C-state. If 'the deep C-state
  reset' bit is not set in CPUID enumeration, ignoring the check.
  XSAVE support for Architectural LBR will be implemented later.

The number of LBR entries cannot be hardcoded anymore, which should be
retrieved from CPUID enumeration. A new structure
x86_perf_task_context_arch_lbr is introduced for Architectural LBR.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-15-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |   3 +-
 arch/x86/events/intel/lbr.c  | 251 ++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  10 +-
 3 files changed, 253 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 50cb3c6..5096347 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4664,6 +4664,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
+		intel_pmu_arch_lbr_init();
+
 	intel_ds_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0d7a859..e4e249a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -172,6 +172,14 @@ enum {
 
 static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
 
+static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
+{
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return !!(config & ARCH_LBR_CALL_STACK);
+
+	return !!(config & LBR_CALL_STACK);
+}
+
 /*
  * We only support LBR implementations that have FREEZE_LBRS_ON_PMI
  * otherwise it becomes near impossible to get a reliable stack.
@@ -195,27 +203,40 @@ static void __intel_pmu_lbr_enable(bool pmi)
 	 */
 	if (cpuc->lbr_sel)
 		lbr_select = cpuc->lbr_sel->config & x86_pmu.lbr_sel_mask;
-	if (!pmi && cpuc->lbr_sel)
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && !pmi && cpuc->lbr_sel)
 		wrmsrl(MSR_LBR_SELECT, lbr_select);
 
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	orig_debugctl = debugctl;
-	debugctl |= DEBUGCTLMSR_LBR;
+
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
+		debugctl |= DEBUGCTLMSR_LBR;
 	/*
 	 * LBR callstack does not work well with FREEZE_LBRS_ON_PMI.
 	 * If FREEZE_LBRS_ON_PMI is set, PMI near call/return instructions
 	 * may cause superfluous increase/decrease of LBR_TOS.
 	 */
-	if (!(lbr_select & LBR_CALL_STACK))
+	if (is_lbr_call_stack_bit_set(lbr_select))
+		debugctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+	else
 		debugctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+
 	if (orig_debugctl != debugctl)
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
+		wrmsrl(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
 }
 
 static void __intel_pmu_lbr_disable(void)
 {
 	u64 debugctl;
 
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
+		wrmsrl(MSR_ARCH_LBR_CTL, 0);
+		return;
+	}
+
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
@@ -241,6 +262,12 @@ void intel_pmu_lbr_reset_64(void)
 	}
 }
 
+static void intel_pmu_arch_lbr_reset(void)
+{
+	/* Write to ARCH_LBR_DEPTH MSR, all LBR entries are reset to 0 */
+	wrmsrl(MSR_ARCH_LBR_DEPTH, x86_pmu.lbr_nr);
+}
+
 void intel_pmu_lbr_reset(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -439,8 +466,28 @@ void intel_pmu_lbr_restore(void *ctx)
 		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
+static void intel_pmu_arch_lbr_restore(void *ctx)
+{
+	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
+	struct lbr_entry *entries = task_ctx->entries;
+	int i;
+
+	/* Fast reset the LBRs before restore if the call stack is not full. */
+	if (!entries[x86_pmu.lbr_nr - 1].from)
+		intel_pmu_arch_lbr_reset();
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		if (!entries[i].from)
+			break;
+		wrlbr_all(&entries[i], i, true);
+	}
+}
+
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
 {
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return x86_pmu.lbr_deep_c_reset && !rdlbr_from(0, NULL);
+
 	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos, NULL);
 }
 
@@ -494,6 +541,22 @@ void intel_pmu_lbr_save(void *ctx)
 		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
+static void intel_pmu_arch_lbr_save(void *ctx)
+{
+	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
+	struct lbr_entry *entries = task_ctx->entries;
+	int i;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		if (!rdlbr_all(&entries[i], i, true))
+			break;
+	}
+
+	/* LBR call stack is not full. Reset is required in restore. */
+	if (i < x86_pmu.lbr_nr)
+		entries[x86_pmu.lbr_nr - 1].from = 0;
+}
+
 static void __intel_pmu_lbr_save(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -786,6 +849,39 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
 }
 
+static __always_inline int get_lbr_br_type(u64 info)
+{
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) || !x86_pmu.lbr_br_type)
+		return 0;
+
+	return (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
+}
+
+static __always_inline bool get_lbr_mispred(u64 info)
+{
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
+		return 0;
+
+	return !!(info & LBR_INFO_MISPRED);
+}
+
+static __always_inline bool get_lbr_predicted(u64 info)
+{
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR) && !x86_pmu.lbr_mispred)
+		return 0;
+
+	return !(info & LBR_INFO_MISPRED);
+}
+
+static __always_inline bool get_lbr_cycles(u64 info)
+{
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+	    !(x86_pmu.lbr_timed_lbr && info & LBR_INFO_CYC_CNT_VALID))
+		return 0;
+
+	return info & LBR_INFO_CYCLES;
+}
+
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 				struct lbr_entry *entries)
 {
@@ -810,18 +906,23 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
 		e->from		= from;
 		e->to		= to;
-		e->mispred	= !!(info & LBR_INFO_MISPRED);
-		e->predicted	= !(info & LBR_INFO_MISPRED);
+		e->mispred	= get_lbr_mispred(info);
+		e->predicted	= get_lbr_predicted(info);
 		e->in_tx	= !!(info & LBR_INFO_IN_TX);
 		e->abort	= !!(info & LBR_INFO_ABORT);
-		e->cycles	= info & LBR_INFO_CYCLES;
-		e->type		= 0;
+		e->cycles	= get_lbr_cycles(info);
+		e->type		= get_lbr_br_type(info);
 		e->reserved	= 0;
 	}
 
 	cpuc->lbr_stack.nr = i;
 }
 
+static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
+{
+	intel_pmu_store_lbr(cpuc, NULL);
+}
+
 void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1197,6 +1298,27 @@ common_branch_type(int type)
 	return PERF_BR_UNKNOWN;
 }
 
+enum {
+	ARCH_LBR_BR_TYPE_JCC			= 0,
+	ARCH_LBR_BR_TYPE_NEAR_IND_JMP		= 1,
+	ARCH_LBR_BR_TYPE_NEAR_REL_JMP		= 2,
+	ARCH_LBR_BR_TYPE_NEAR_IND_CALL		= 3,
+	ARCH_LBR_BR_TYPE_NEAR_REL_CALL		= 4,
+	ARCH_LBR_BR_TYPE_NEAR_RET		= 5,
+	ARCH_LBR_BR_TYPE_KNOWN_MAX		= ARCH_LBR_BR_TYPE_NEAR_RET,
+
+	ARCH_LBR_BR_TYPE_MAP_MAX		= 16,
+};
+
+static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
+	[ARCH_LBR_BR_TYPE_JCC]			= X86_BR_JCC,
+	[ARCH_LBR_BR_TYPE_NEAR_IND_JMP]		= X86_BR_IND_JMP,
+	[ARCH_LBR_BR_TYPE_NEAR_REL_JMP]		= X86_BR_JMP,
+	[ARCH_LBR_BR_TYPE_NEAR_IND_CALL]	= X86_BR_IND_CALL,
+	[ARCH_LBR_BR_TYPE_NEAR_REL_CALL]	= X86_BR_CALL,
+	[ARCH_LBR_BR_TYPE_NEAR_RET]		= X86_BR_RET,
+};
+
 /*
  * implement actual branch filter based on user demand.
  * Hardware may not exactly satisfy that request, thus
@@ -1209,7 +1331,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 {
 	u64 from, to;
 	int br_sel = cpuc->br_sel;
-	int i, j, type;
+	int i, j, type, to_plm;
 	bool compress = false;
 
 	/* if sampling all branches, then nothing to filter */
@@ -1221,8 +1343,19 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 
 		from = cpuc->lbr_entries[i].from;
 		to = cpuc->lbr_entries[i].to;
+		type = cpuc->lbr_entries[i].type;
 
-		type = branch_type(from, to, cpuc->lbr_entries[i].abort);
+		/*
+		 * Parse the branch type recorded in LBR_x_INFO MSR.
+		 * Doesn't support OTHER_BRANCH decoding for now.
+		 * OTHER_BRANCH branch type still rely on software decoding.
+		 */
+		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
+		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
+			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
+			type = arch_lbr_br_type_map[type] | to_plm;
+		} else
+			type = branch_type(from, to, cpuc->lbr_entries[i].abort);
 		if (type != X86_BR_NONE && (br_sel & X86_BR_ANYTX)) {
 			if (cpuc->lbr_entries[i].in_tx)
 				type |= X86_BR_IN_TX;
@@ -1261,8 +1394,9 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	/* Cannot get TOS for large PEBS */
-	if (cpuc->n_pebs == cpuc->n_large_pebs)
+	/* Cannot get TOS for large PEBS and Arch LBR */
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR) ||
+	    (cpuc->n_pebs == cpuc->n_large_pebs))
 		cpuc->lbr_stack.hw_idx = -1ULL;
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
@@ -1324,6 +1458,26 @@ static const int hsw_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
 	[PERF_SAMPLE_BRANCH_CALL_SHIFT]		= LBR_REL_CALL,
 };
 
+static int arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
+	[PERF_SAMPLE_BRANCH_ANY_SHIFT]		= ARCH_LBR_ANY,
+	[PERF_SAMPLE_BRANCH_USER_SHIFT]		= ARCH_LBR_USER,
+	[PERF_SAMPLE_BRANCH_KERNEL_SHIFT]	= ARCH_LBR_KERNEL,
+	[PERF_SAMPLE_BRANCH_HV_SHIFT]		= LBR_IGN,
+	[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT]	= ARCH_LBR_RETURN |
+						  ARCH_LBR_OTHER_BRANCH,
+	[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT]     = ARCH_LBR_REL_CALL |
+						  ARCH_LBR_IND_CALL |
+						  ARCH_LBR_OTHER_BRANCH,
+	[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT]     = ARCH_LBR_IND_CALL,
+	[PERF_SAMPLE_BRANCH_COND_SHIFT]         = ARCH_LBR_JCC,
+	[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT]   = ARCH_LBR_REL_CALL |
+						  ARCH_LBR_IND_CALL |
+						  ARCH_LBR_RETURN |
+						  ARCH_LBR_CALL_STACK,
+	[PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT]	= ARCH_LBR_IND_JMP,
+	[PERF_SAMPLE_BRANCH_CALL_SHIFT]		= ARCH_LBR_REL_CALL,
+};
+
 /* core */
 void __init intel_pmu_lbr_init_core(void)
 {
@@ -1471,6 +1625,81 @@ void intel_pmu_lbr_init_knl(void)
 		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
 
+void __init intel_pmu_arch_lbr_init(void)
+{
+	union cpuid28_eax eax;
+	union cpuid28_ebx ebx;
+	union cpuid28_ecx ecx;
+	unsigned int unused_edx;
+	u64 lbr_nr;
+
+	/* Arch LBR Capabilities */
+	cpuid(28, &eax.full, &ebx.full, &ecx.full, &unused_edx);
+
+	lbr_nr = fls(eax.split.lbr_depth_mask) * 8;
+	if (!lbr_nr)
+		goto clear_arch_lbr;
+
+	/* Apply the max depth of Arch LBR */
+	if (wrmsrl_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
+		goto clear_arch_lbr;
+
+	x86_pmu.lbr_depth_mask = eax.split.lbr_depth_mask;
+	x86_pmu.lbr_deep_c_reset = eax.split.lbr_deep_c_reset;
+	x86_pmu.lbr_lip = eax.split.lbr_lip;
+	x86_pmu.lbr_cpl = ebx.split.lbr_cpl;
+	x86_pmu.lbr_filter = ebx.split.lbr_filter;
+	x86_pmu.lbr_call_stack = ebx.split.lbr_call_stack;
+	x86_pmu.lbr_mispred = ecx.split.lbr_mispred;
+	x86_pmu.lbr_timed_lbr = ecx.split.lbr_timed_lbr;
+	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
+	x86_pmu.lbr_nr = lbr_nr;
+
+	x86_get_pmu()->task_ctx_size = sizeof(struct x86_perf_task_context_arch_lbr) +
+				       lbr_nr * sizeof(struct lbr_entry);
+
+	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
+	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
+	x86_pmu.lbr_info = MSR_ARCH_LBR_INFO_0;
+
+	/* LBR callstack requires both CPL and Branch Filtering support */
+	if (!x86_pmu.lbr_cpl ||
+	    !x86_pmu.lbr_filter ||
+	    !x86_pmu.lbr_call_stack)
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] = LBR_NOT_SUPP;
+
+	if (!x86_pmu.lbr_cpl) {
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_USER_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_KERNEL_SHIFT] = LBR_NOT_SUPP;
+	} else if (!x86_pmu.lbr_filter) {
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_RETURN_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_ANY_CALL_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_IND_CALL_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_COND_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_IND_JUMP_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_SHIFT] = LBR_NOT_SUPP;
+	}
+
+	x86_pmu.lbr_ctl_mask = ARCH_LBR_CTL_MASK;
+	x86_pmu.lbr_ctl_map  = arch_lbr_ctl_map;
+
+	if (!x86_pmu.lbr_cpl && !x86_pmu.lbr_filter)
+		x86_pmu.lbr_ctl_map = NULL;
+
+	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
+	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
+	x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
+	x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
+
+	pr_cont("Architectural LBR, ");
+
+	return;
+
+clear_arch_lbr:
+	clear_cpu_cap(&boot_cpu_data, X86_FEATURE_ARCH_LBR);
+}
+
 /**
  * x86_perf_get_lbr - get the LBR records information
  *
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 20e35cb..3f7c329 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -772,6 +772,11 @@ struct x86_perf_task_context {
 	struct lbr_entry lbr[MAX_LBR_ENTRIES];
 };
 
+struct x86_perf_task_context_arch_lbr {
+	struct x86_perf_task_context_opt opt;
+	struct lbr_entry entries[];
+};
+
 #define x86_add_quirk(func_)						\
 do {									\
 	static struct x86_pmu_quirk __quirk __initdata = {		\
@@ -822,6 +827,9 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
+	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return &((struct x86_perf_task_context_arch_lbr *)ctx)->opt;
+
 	return &((struct x86_perf_task_context *)ctx)->opt;
 }
 
@@ -1141,6 +1149,8 @@ void intel_pmu_lbr_init_skl(void);
 
 void intel_pmu_lbr_init_knl(void);
 
+void intel_pmu_arch_lbr_init(void);
+
 void intel_pmu_pebs_data_source_nhm(void);
 
 void intel_pmu_pebs_data_source_skl(bool pmem);
