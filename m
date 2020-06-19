Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B03C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138CC21532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbgFSOJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:09:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:54754 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733089AbgFSOIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:19 -0400
IronPort-SDR: iM51rDaIraxKi5y8sWr08ayP5b4wshFhvd5Py+UEKSbYghO6OK/9QCsokPhp3QFjxxkFDxNTr/
 V6X0UdH2jYGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452883"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:08:07 -0700
IronPort-SDR: XtsrgF1ylcpCu2Bqy9GVlPFO1Lkb794c3NIkdunTQQxsY0TNkpMplma+zNBGi06XnYVs7DHO3v
 l9bilweV3Auw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837532"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:08:06 -0700
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
Subject: [PATCH 20/21] perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR context switch
Date:   Fri, 19 Jun 2020 07:04:08 -0700
Message-Id: <1592575449-64278-21-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In the LBR call stack mode, LBR information is used to reconstruct a
call stack. To get the complete call stack, perf has to save/restore
all LBR registers during a context switch. Due to a large number of the
LBR registers, this process causes a high CPU overhead. To reduce the
CPU overhead during a context switch, use the XSAVES/XRSTORS
instructions.

Every XSAVE area must follow a canonical format: the legacy region, an
XSAVE header and the extended region. Although the LBR information is
only kept in the extended region, a space for the legacy region and
XSAVE header is still required. Add a new dedicated structure for LBR
XSAVES support.

Before enabling XSAVES support, the size of the LBR state has to be
sanity checked, because:
- the size of the software structure is calculated from the max number
of the LBR depth, which is enumerated by the CPUID leaf for Arch LBR.
The size of the LBR state is enumerated by the CPUID leaf for XSAVE
support of Arch LBR. If the values from the two CPUID leaves are not
consistent, it may trigger a buffer overflow. For example, a hypervisor
may unconsciously set inconsistent values for the two emulated CPUID.
- unlike other state components, the size of an LBR state depends on the
max number of LBRs, which may vary from generation to generation.

Expose the function xfeature_size() for the sanity check.
The LBR XSAVES support will be disabled if the size of the LBR state
enumerated by CPUID doesn't match with the size of the software
structure.

The XSAVE instruction requires 64-byte alignment for state buffers. A
64-byte aligned kmem_cache is created for architecture LBR.

Add dedicated lbr_save/lbr_restore functions for LBR XSAVES support,
which invokes the corresponding xstate helpers to XSAVES/XRSTORS LBR
information at the context switch when the call stack mode is enabled.
Since the XSAVES/XRSTORS instructions will be eventually invoked, the
dedicated functions is named with '_xsaves'/'_xrstors' postfix.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c       | 78 ++++++++++++++++++++++++++++++++++++---
 arch/x86/events/perf_event.h      | 18 +++++++++
 arch/x86/include/asm/fpu/xstate.h |  1 +
 arch/x86/kernel/fpu/xstate.c      |  2 +-
 4 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4060d3a..dc40a76 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -446,6 +446,17 @@ static void intel_pmu_arch_lbr_restore(void *ctx)
 	}
 }
 
+/*
+ * Restore the Architecture LBR state from the xsave area in the perf
+ * context data for the task via the XRSTORS instruction.
+ */
+static void intel_pmu_arch_lbr_xrstors(void *ctx)
+{
+	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
+
+	copy_kernel_to_dynamic_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+}
+
 static bool lbr_is_reset_in_cstate(void *ctx)
 {
 	if (x86_pmu.arch_lbr)
@@ -523,6 +534,17 @@ static void intel_pmu_arch_lbr_save(void *ctx)
 		entries[x86_pmu.lbr_nr - 1].lbr_from = 0;
 }
 
+/*
+ * Save the Architecture LBR state to the xsave area in the perf
+ * context data for the task via the XSAVES instruction.
+ */
+static void intel_pmu_arch_lbr_xsaves(void *ctx)
+{
+	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
+
+	copy_dynamic_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+}
+
 static void __intel_pmu_lbr_save(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1640,9 +1662,37 @@ void intel_pmu_lbr_init_knl(void)
 		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
 
+/*
+ * LBR state size is variable based on the max number of registers.
+ * This calculates the expected state size, which should match
+ * what the hardware enumerates for the size of XFEATURE_LBR.
+ */
+static inline unsigned int get_lbr_state_size(void)
+{
+	return sizeof(struct arch_lbr_state) +
+	       x86_pmu.lbr_nr * sizeof(struct arch_lbr_entry);
+}
+
+static bool is_arch_lbr_xsave_available(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_XSAVES))
+		return false;
+
+	/*
+	 * Check the LBR state with the corresponding software structure.
+	 * Disable LBR XSAVES support if the size doesn't match.
+	 */
+	if (WARN_ON(xfeature_size(XFEATURE_LBR) != get_lbr_state_size()))
+		return false;
+
+	return true;
+}
+
 void __init intel_pmu_arch_lbr_init(void)
 {
+	struct pmu *pmu = x86_get_pmu();
 	unsigned int unused_edx;
+	bool arch_lbr_xsave;
 	size_t size;
 	u64 lbr_nr;
 
@@ -1660,9 +1710,21 @@ void __init intel_pmu_arch_lbr_init(void)
 
 	x86_pmu.lbr_nr = lbr_nr;
 
-	size = sizeof(struct x86_perf_task_context_arch_lbr) +
-	       lbr_nr * sizeof(struct x86_perf_arch_lbr_entry);
-	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+	arch_lbr_xsave = is_arch_lbr_xsave_available();
+	if (arch_lbr_xsave) {
+		size = sizeof(struct x86_perf_task_context_arch_lbr_xsave) +
+		       get_lbr_state_size();
+		pmu->task_ctx_cache = create_lbr_kmem_cache(size,
+							    XSAVE_ALIGNMENT);
+	}
+
+	if (!pmu->task_ctx_cache) {
+		arch_lbr_xsave = false;
+
+		size = sizeof(struct x86_perf_task_context_arch_lbr) +
+		       lbr_nr * sizeof(struct x86_perf_arch_lbr_entry);
+		pmu->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+	}
 
 	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
 	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
@@ -1696,8 +1758,14 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_disable = intel_pmu_arch_lbr_disable;
 	x86_pmu.lbr_reset = intel_pmu_arch_lbr_reset;
 	x86_pmu.lbr_read = intel_pmu_arch_lbr_read;
-	x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
-	x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
+	if (arch_lbr_xsave) {
+		x86_pmu.lbr_save = intel_pmu_arch_lbr_xsaves;
+		x86_pmu.lbr_restore = intel_pmu_arch_lbr_xrstors;
+		pr_cont("XSAVE ");
+	} else {
+		x86_pmu.lbr_save = intel_pmu_arch_lbr_save;
+		x86_pmu.lbr_restore = intel_pmu_arch_lbr_restore;
+	}
 
 	x86_pmu.arch_lbr = true;
 	pr_cont("Architectural LBR, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5cebc75..812980e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -812,6 +812,24 @@ struct x86_perf_task_context_arch_lbr {
 	struct x86_perf_arch_lbr_entry  entries[0];
 };
 
+/*
+ * The structure is dynamically allocated. The size of the LBR state may vary
+ * based on the number of LBR registers.
+ *
+ * Do not put anything after the LBR state.
+ */
+struct x86_perf_task_context_arch_lbr_xsave {
+	struct x86_perf_task_context_opt	opt;
+	union {
+		struct xregs_state		xsave;
+		struct {
+			struct fxregs_state	i387;
+			struct xstate_header	header;
+			struct arch_lbr_state	lbr;
+		};
+	};
+};
+
 #define x86_add_quirk(func_)						\
 do {									\
 	static struct x86_pmu_quirk __quirk __initdata = {		\
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 636c3ef..1559554 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -103,6 +103,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
+int xfeature_size(int xfeature_nr);
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
 int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 49e0347..9c0541d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -489,7 +489,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	return ebx;
 }
 
-static int xfeature_size(int xfeature_nr)
+int xfeature_size(int xfeature_nr)
 {
 	u32 eax, ebx, ecx, edx;
 
-- 
2.7.4

