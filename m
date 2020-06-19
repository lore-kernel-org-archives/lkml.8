Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DB720771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbgFSOIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:54764 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733048AbgFSOIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:15 -0400
IronPort-SDR: L1QgRgkEujSF5wn2sJ0gAzRTzWXs/764i+lQFzFuJibdLt03fP8gM64BIBE8rK1U23d/4a8gV9
 ZoZoNDVfOQbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452854"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:57 -0700
IronPort-SDR: 1Cj/LBz/Wdgn29uNoLY+wN96N3S7QuO5az9j7LdO9KSUXqz1YzCPe26CQCksEu7CGRpz+W96TG
 Fh8ACM5iVeHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837476"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:56 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 12/21] perf/x86/intel/lbr: Support Architectural LBR
Date:   Fri, 19 Jun 2020 07:04:00 -0700
Message-Id: <1592575449-64278-13-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
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

Accordingly, Architectural LBR dedicated functions are implemented to
enable/disable/reset/read/save/restore LBR.
- For enable/disable, like in the previous LBR implementation, the LBR
  call stack mode does not work well with the FREEZE_LBRS_ON_PMI.
  The bit DEBUGCTLMSR_FREEZE_LBRS_ON_PMI is still disabled in the LBR
  call stack mode. The IA32_DEBUGCTL[bit 0] has no meaning anymore.
- For reset, writing to the ARCH_LBR_DEPTH MSR clears all Arch LBR
  entries, which is a lot faster and can improve the context switch
  latency.
- For read, the branch type information can be retrieved from
  the MSR_ARCH_LBR_INFO_*. But it's not fully compatible due to
  OTHER_BRANCH type. The software decoding is still required for the
  OTHER_BRANCH case.
  LBR records are stored in the age order.
  Add dedicated read functions for both PEBS and non-PEBS case.
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
 arch/x86/events/intel/lbr.c  | 276 ++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  16 +++
 3 files changed, 294 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6462ef2..768caa9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4643,6 +4643,9 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
+		intel_pmu_arch_lbr_init();
+
 	intel_ds_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index b34beb5..fde23e8 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -212,6 +212,33 @@ void intel_pmu_lbr_enable(bool pmi)
 		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
+static void intel_pmu_arch_lbr_enable(bool pmi)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 debugctl, lbr_ctl = 0, orig_debugctl;
+
+	if (pmi)
+		return;
+
+	if (cpuc->lbr_ctl)
+		lbr_ctl = cpuc->lbr_ctl->config & x86_pmu.lbr_ctl_mask;
+	/*
+	 * LBR callstack does not work well with FREEZE_LBRS_ON_PMI.
+	 * If FREEZE_LBRS_ON_PMI is set, PMI near call/return instructions
+	 * may be missed, that can lead to confusing results.
+	 */
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	orig_debugctl = debugctl;
+	if (lbr_ctl & ARCH_LBR_CALL_STACK)
+		debugctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+	else
+		debugctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
+	if (orig_debugctl != debugctl)
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+
+	wrmsrl(MSR_ARCH_LBR_CTL, lbr_ctl | ARCH_LBR_CTL_LBREN);
+}
+
 void intel_pmu_lbr_disable(void)
 {
 	u64 debugctl;
@@ -221,6 +248,11 @@ void intel_pmu_lbr_disable(void)
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
+static void intel_pmu_arch_lbr_disable(void)
+{
+	wrmsrl(MSR_ARCH_LBR_CTL, 0);
+}
+
 void intel_pmu_lbr_reset_32(void)
 {
 	int i;
@@ -241,6 +273,12 @@ void intel_pmu_lbr_reset_64(void)
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
@@ -389,8 +427,29 @@ void intel_pmu_lbr_restore(void *ctx)
 	wrmsrl(x86_pmu.lbr_tos, tos);
 }
 
+static void intel_pmu_arch_lbr_restore(void *ctx)
+{
+	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
+	struct x86_perf_arch_lbr_entry *entries = task_ctx->entries;
+	int i;
+
+	/* Fast reset the LBRs before restore if the call stack is not full. */
+	if (!entries[x86_pmu.lbr_nr - 1].lbr_from)
+		intel_pmu_arch_lbr_reset();
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		if (!entries[i].lbr_from)
+			break;
+		wrlbr_from(i, entries[i].lbr_from);
+		wrlbr_to(i, entries[i].lbr_to);
+		wrmsrl(MSR_ARCH_LBR_INFO_0 + i, entries[i].lbr_info);
+	}
+}
+
 static bool lbr_is_reset_in_cstate(void *ctx)
 {
+	if (x86_pmu.arch_lbr)
+		return x86_pmu.arch_lbr_deep_c_reset && !rdlbr_from(0);
 	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos);
 }
 
@@ -444,6 +503,26 @@ void intel_pmu_lbr_save(void *ctx)
 	task_ctx->tos = tos;
 }
 
+static void intel_pmu_arch_lbr_save(void *ctx)
+{
+	struct x86_perf_task_context_arch_lbr *task_ctx = ctx;
+	struct x86_perf_arch_lbr_entry *entries = task_ctx->entries;
+	int i;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		entries[i].lbr_from = rdlbr_from(i);
+		/* Only save valid branches. */
+		if (!entries[i].lbr_from)
+			break;
+		entries[i].lbr_to = rdlbr_to(i);
+		rdmsrl(MSR_ARCH_LBR_INFO_0 + i, entries[i].lbr_info);
+	}
+
+	/* LBR call stack is not full. Reset is required in restore. */
+	if (i < x86_pmu.lbr_nr)
+		entries[x86_pmu.lbr_nr - 1].lbr_from = 0;
+}
+
 static void __intel_pmu_lbr_save(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -722,6 +801,92 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	cpuc->lbr_stack.hw_idx = tos;
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
+static void __intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc, int index,
+				      u64 from, u64 to, u64 info)
+{
+	u64 mis = 0, pred = 0, in_tx = 0, abort = 0, type = 0;
+	u32 br_type, to_plm;
+	u16 cycles = 0;
+
+	if (x86_pmu.arch_lbr_mispred) {
+		mis = !!(info & ARCH_LBR_INFO_MISPRED);
+		pred = !mis;
+	}
+	in_tx = !!(info & ARCH_LBR_INFO_IN_TSX);
+	abort = !!(info & ARCH_LBR_INFO_TSX_ABORT);
+	if (x86_pmu.arch_lbr_timed_lbr &&
+	    (info & ARCH_LBR_INFO_CYC_CNT_VALID))
+		cycles = (info & ARCH_LBR_INFO_CYC_CNT);
+
+	/*
+	 * Parse the branch type recorded in LBR_x_INFO MSR.
+	 * Doesn't support OTHER_BRANCH decoding for now.
+	 * OTHER_BRANCH branch type still rely on software decoding.
+	 */
+	if (x86_pmu.arch_lbr_br_type) {
+		br_type = (info & ARCH_LBR_INFO_BR_TYPE) >> ARCH_LBR_INFO_BR_TYPE_OFFSET;
+
+		if (br_type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
+			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
+			type = arch_lbr_br_type_map[br_type] | to_plm;
+		}
+	}
+
+	cpuc->lbr_entries[index].from		 = from;
+	cpuc->lbr_entries[index].to		 = to;
+	cpuc->lbr_entries[index].mispred	 = mis;
+	cpuc->lbr_entries[index].predicted	 = pred;
+	cpuc->lbr_entries[index].in_tx		 = in_tx;
+	cpuc->lbr_entries[index].abort		 = abort;
+	cpuc->lbr_entries[index].cycles		 = cycles;
+	cpuc->lbr_entries[index].type		 = type;
+	cpuc->lbr_entries[index].reserved	 = 0;
+}
+
+static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
+{
+	u64 from, to, info;
+	int i;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		from = rdlbr_from(i);
+		to   = rdlbr_to(i);
+
+		/*
+		 * Read LBR entries until invalid entry (0s) is detected.
+		 */
+		if (!from)
+			break;
+
+		rdmsrl(MSR_ARCH_LBR_INFO_0 + i, info);
+
+		__intel_pmu_arch_lbr_read(cpuc, i, from, to, info);
+	}
+
+	cpuc->lbr_stack.nr = i;
+}
+
 void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1149,7 +1314,10 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		from = cpuc->lbr_entries[i].from;
 		to = cpuc->lbr_entries[i].to;
 
-		type = branch_type(from, to, cpuc->lbr_entries[i].abort);
+		if (cpuc->lbr_entries[i].type)
+			type = cpuc->lbr_entries[i].type;
+		else
+			type = branch_type(from, to, cpuc->lbr_entries[i].abort);
 		if (type != X86_BR_NONE && (br_sel & X86_BR_ANYTX)) {
 			if (cpuc->lbr_entries[i].in_tx)
 				type |= X86_BR_IN_TX;
@@ -1184,11 +1352,37 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	}
 }
 
+static void intel_pmu_store_pebs_arch_lbrs(struct pebs_lbr *pebs_lbr,
+					   struct cpu_hw_events *cpuc)
+{
+	struct pebs_lbr_entry *lbr;
+	int i;
+
+	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+		lbr = &pebs_lbr->lbr[i];
+
+		/*
+		 * Read LBR entries until invalid entry (0s) is detected.
+		 */
+		if (!lbr->from)
+			break;
+
+		__intel_pmu_arch_lbr_read(cpuc, i, lbr->from,
+					  lbr->to, lbr->info);
+	}
+
+	cpuc->lbr_stack.nr = i;
+	intel_pmu_lbr_filter(cpuc);
+}
+
 void intel_pmu_store_pebs_lbrs(struct pebs_lbr *lbr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int i;
 
+	if (x86_pmu.arch_lbr)
+		return intel_pmu_store_pebs_arch_lbrs(lbr, cpuc);
+
 	cpuc->lbr_stack.nr = x86_pmu.lbr_nr;
 
 	/* Cannot get TOS for large PEBS */
@@ -1266,6 +1460,26 @@ static const int hsw_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX_SHIFT] = {
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
@@ -1411,3 +1625,63 @@ void intel_pmu_lbr_init_knl(void)
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
+	cpuid(28, &x86_pmu.arch_lbr_eax, &x86_pmu.arch_lbr_ebx,
+		  &x86_pmu.arch_lbr_ecx, &unused_edx);
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
+				       lbr_nr * sizeof(struct x86_perf_arch_lbr_entry);
+
+	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
+	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
+
+	/* LBR callstack requires both CPL and Branch Filtering support */
+	if (!x86_pmu.arch_lbr_cpl ||
+	    !x86_pmu.arch_lbr_filter ||
+	    !x86_pmu.arch_lbr_call_stack)
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_CALL_STACK_SHIFT] = LBR_NOT_SUPP;
+
+	if (!x86_pmu.arch_lbr_cpl) {
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_USER_SHIFT] = LBR_NOT_SUPP;
+		arch_lbr_ctl_map[PERF_SAMPLE_BRANCH_KERNEL_SHIFT] = LBR_NOT_SUPP;
+	} else if (!x86_pmu.arch_lbr_filter) {
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
+	if (!x86_pmu.arch_lbr_cpl && !x86_pmu.arch_lbr_filter)
+		x86_pmu.lbr_ctl_map = NULL;
+
+	x86_pmu.lbr_enable = intel_pmu_arch_lbr_enable;
+	x86_pmu.lbr_disable = intel_pmu_arch_lbr_disable;
+	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
+	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
+	x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
+	x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
+
+	x86_pmu.arch_lbr = true;
+	pr_cont("Architectural LBR, ");
+}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1b91f2b..5cebc75 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -801,6 +801,17 @@ struct x86_perf_task_context {
 	struct x86_perf_task_context_opt opt;
 };
 
+struct x86_perf_arch_lbr_entry {
+	u64 lbr_from;
+	u64 lbr_to;
+	u64 lbr_info;
+};
+
+struct x86_perf_task_context_arch_lbr {
+	struct x86_perf_task_context_opt opt;
+	struct x86_perf_arch_lbr_entry  entries[0];
+};
+
 #define x86_add_quirk(func_)						\
 do {									\
 	static struct x86_pmu_quirk __quirk __initdata = {		\
@@ -851,6 +862,9 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 static inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
+	if (x86_pmu.arch_lbr)
+		return &((struct x86_perf_task_context_arch_lbr *)ctx)->opt;
+
 	return &((struct x86_perf_task_context *)ctx)->opt;
 }
 
@@ -1181,6 +1195,8 @@ void intel_pmu_lbr_init_skl(void);
 
 void intel_pmu_lbr_init_knl(void);
 
+void intel_pmu_arch_lbr_init(void);
+
 void intel_pmu_pebs_data_source_nhm(void);
 
 void intel_pmu_pebs_data_source_skl(bool pmem);
-- 
2.7.4

