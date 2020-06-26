Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E22CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE9A2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFZSXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:59785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgFZSXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:42 -0400
IronPort-SDR: NCIV0WRAJPEXbq6E0oo1sEZrzYubezkFnymT/V1u5lPQ7z/FDp3A8IKssxFr73IYChs8GHKcdv
 fxofDchkMONA==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512928"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512928"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:39 -0700
IronPort-SDR: e2fMA846pPF0QECIEqeZ3H2ywoK+fi3phXTnxhbq2ERW4FWpoX5xaDumBafCR6tr+LpV7SPjlp
 8DsKMhok2sCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153913"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:39 -0700
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
Subject: [PATCH V2 14/23] perf/x86/intel/lbr: Support Architectural LBR
Date:   Fri, 26 Jun 2020 11:20:11 -0700
Message-Id: <1593195620-116988-15-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
---
 arch/x86/events/intel/core.c |   3 +
 arch/x86/events/intel/lbr.c  | 233 +++++++++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |  10 ++
 3 files changed, 235 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index eb17068..8d2f416 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4639,6 +4639,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
+		intel_pmu_arch_lbr_init();
+
 	intel_ds_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bac18c4..c426cf7 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -172,6 +172,14 @@ enum {
 
 static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
 
+static inline bool is_lbr_call_stack_bit_set(u64 config)
+{
+	if (x86_pmu.arch_lbr)
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
+	if (!x86_pmu.arch_lbr && !pmi && cpuc->lbr_sel)
 		wrmsrl(MSR_LBR_SELECT, lbr_select);
 
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	orig_debugctl = debugctl;
-	debugctl |= DEBUGCTLMSR_LBR;
+
+	if (!x86_pmu.arch_lbr)
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
+	if (x86_pmu.arch_lbr)
+		wrmsrl(MSR_ARCH_LBR_CTL, lbr_select | ARCH_LBR_CTL_LBREN);
 }
 
 static void __intel_pmu_lbr_disable(void)
 {
 	u64 debugctl;
 
+	if (x86_pmu.arch_lbr) {
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
@@ -435,8 +462,28 @@ void intel_pmu_lbr_restore(void *ctx)
 	wrmsrl(x86_pmu.lbr_tos, tos);
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
 static bool lbr_is_reset_in_cstate(void *ctx)
 {
+	if (x86_pmu.arch_lbr)
+		return x86_pmu.lbr_eax.split.lbr_deep_c_reset && !rdlbr_from(0, NULL);
+
 	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos, NULL);
 }
 
@@ -486,6 +533,22 @@ void intel_pmu_lbr_save(void *ctx)
 	task_ctx->tos = tos;
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
@@ -764,6 +827,39 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
 }
 
+static inline int get_lbr_br_type(u64 info)
+{
+	if (!x86_pmu.arch_lbr || !x86_pmu.lbr_ecx.split.lbr_br_type)
+		return 0;
+
+	return (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
+}
+
+static inline bool get_lbr_mispred(u64 info)
+{
+	if (x86_pmu.arch_lbr && !x86_pmu.lbr_ecx.split.lbr_mispred)
+		return 0;
+
+	return !!(info & LBR_INFO_MISPRED);
+}
+
+static inline bool get_lbr_predicted(u64 info)
+{
+	if (x86_pmu.arch_lbr && !x86_pmu.lbr_ecx.split.lbr_mispred)
+		return 0;
+
+	return !(info & LBR_INFO_MISPRED);
+}
+
+static inline bool get_lbr_cycles(u64 info)
+{
+	if (x86_pmu.arch_lbr &&
+	    !(x86_pmu.lbr_ecx.split.lbr_timed_lbr && info & LBR_INFO_CYC_CNT_VALID))
+		return 0;
+
+	return info & LBR_INFO_CYCLES;
+}
+
 static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 				struct lbr_entry *entries)
 {
@@ -788,18 +884,23 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 
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
@@ -1174,6 +1275,27 @@ common_branch_type(int type)
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
@@ -1186,7 +1308,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 {
 	u64 from, to;
 	int br_sel = cpuc->br_sel;
-	int i, j, type;
+	int i, j, type, to_plm;
 	bool compress = false;
 
 	/* if sampling all branches, then nothing to filter */
@@ -1198,8 +1320,18 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 
 		from = cpuc->lbr_entries[i].from;
 		to = cpuc->lbr_entries[i].to;
+		type = cpuc->lbr_entries[i].type;
 
-		type = branch_type(from, to, cpuc->lbr_entries[i].abort);
+		/*
+		 * Parse the branch type recorded in LBR_x_INFO MSR.
+		 * Doesn't support OTHER_BRANCH decoding for now.
+		 * OTHER_BRANCH branch type still rely on software decoding.
+		 */
+		if (x86_pmu.arch_lbr && type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
+			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
+			type = arch_lbr_br_type_map[type] | to_plm;
+		} else
+			type = branch_type(from, to, cpuc->lbr_entries[i].abort);
 		if (type != X86_BR_NONE && (br_sel & X86_BR_ANYTX)) {
 			if (cpuc->lbr_entries[i].in_tx)
 				type |= X86_BR_IN_TX;
@@ -1238,8 +1370,8 @@ void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	/* Cannot get TOS for large PEBS */
-	if (cpuc->n_pebs == cpuc->n_large_pebs)
+	/* Cannot get TOS for large PEBS and Arch LBR */
+	if (x86_pmu.arch_lbr || (cpuc->n_pebs == cpuc->n_large_pebs))
 		cpuc->lbr_stack.hw_idx = -1ULL;
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
@@ -1302,6 +1434,26 @@ static const int hsw_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
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
@@ -1448,3 +1600,62 @@ void intel_pmu_lbr_init_knl(void)
 	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
 		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
+
+void __init intel_pmu_arch_lbr_init(void)
+{
+	unsigned int unused_edx;
+	u64 lbr_nr;
+
+	/* Arch LBR Capabilities */
+	cpuid(28, &x86_pmu.lbr_eax.full, &x86_pmu.lbr_ebx.full,
+		  &x86_pmu.lbr_ecx.full, &unused_edx);
+
+	lbr_nr = x86_pmu_get_max_arch_lbr_nr();
+	if (!lbr_nr)
+		return;
+
+	/* Apply the max depth of Arch LBR */
+	if (wrmsrl_safe(MSR_ARCH_LBR_DEPTH, lbr_nr))
+		return;
+
+	x86_pmu.lbr_nr = lbr_nr;
+	x86_get_pmu()->task_ctx_size = sizeof(struct x86_perf_task_context_arch_lbr) +
+				       lbr_nr * sizeof(struct lbr_entry);
+
+	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
+	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
+	x86_pmu.lbr_info = MSR_ARCH_LBR_INFO_0;
+
+	/* LBR callstack requires both CPL and Branch Filtering support */
+	if (!x86_pmu.lbr_ebx.split.lbr_cpl ||
+	    !x86_pmu.lbr_ebx.split.lbr_filter ||
+	    !x86_pmu.lbr_ebx.split.lbr_call_stack)
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] = LBR_NOT_SUPP;
+
+	if (!x86_pmu.lbr_ebx.split.lbr_cpl) {
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_USER_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_KERNEL_SHIFT] = LBR_NOT_SUPP;
+	} else if (!x86_pmu.lbr_ebx.split.lbr_filter) {
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
+	if (!x86_pmu.lbr_ebx.split.lbr_cpl && !x86_pmu.lbr_ebx.split.lbr_filter)
+		x86_pmu.lbr_ctl_map = NULL;
+
+	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
+	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
+	x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
+	x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
+
+	x86_pmu.arch_lbr = true;
+	pr_cont("Architectural LBR, ");
+}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5649838..a35c51b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -762,6 +762,11 @@ struct x86_perf_task_context {
 	struct lbr_entry lbr[MAX_LBR_ENTRIES];
 };
 
+struct x86_perf_task_context_arch_lbr {
+	struct x86_perf_task_context_opt opt;
+	struct lbr_entry  entries[0];
+};
+
 #define x86_add_quirk(func_)						\
 do {									\
 	static struct x86_pmu_quirk __quirk __initdata = {		\
@@ -812,6 +817,9 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 static inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
+	if (x86_pmu.arch_lbr)
+		return &((struct x86_perf_task_context_arch_lbr *)ctx)->opt;
+
 	return &((struct x86_perf_task_context *)ctx)->opt;
 }
 
@@ -1135,6 +1143,8 @@ void intel_pmu_lbr_init_skl(void);
 
 void intel_pmu_lbr_init_knl(void);
 
+void intel_pmu_arch_lbr_init(void);
+
 void intel_pmu_pebs_data_source_nhm(void);
 
 void intel_pmu_pebs_data_source_skl(bool pmem);
-- 
2.7.4

