Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C067FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA72420FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFZSYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:24:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:59785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgFZSXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:47 -0400
IronPort-SDR: T/+r4K5apO17olaOHk62wzk6ENxEOkjMunlgCRfyIFlFC06HZTSKaruffepXqZv1WvTYUnzj3D
 5VzSvI+PSooQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512952"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:44 -0700
IronPort-SDR: shSU69E9c8bl//KKBvrESxcWgQpUxTCp2wNB+yNguK3TElSP06sTHeZKH8mnYA0oTIVsBXT/vU
 rxlfBaPqowyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153951"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:44 -0700
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
Subject: [PATCH V2 20/23] x86/fpu/xstate: Support dynamic supervisor feature for LBR
Date:   Fri, 26 Jun 2020 11:20:17 -0700
Message-Id: <1593195620-116988-21-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Last Branch Records (LBR) registers are used to log taken branches and
other control flows. In perf with call stack mode, LBR information is
used to reconstruct a call stack. To get the complete call stack, perf
has to save/restore all LBR registers during a context switch. Due to
the large number of the LBR registers, e.g., the current platform has
96 LBR registers, this process causes a high CPU overhead. To reduce
the CPU overhead during a context switch, an LBR state component that
contains all the LBR related registers is introduced in hardware. All
LBR registers can be saved/restored together using one XSAVES/XRSTORS
instruction.

However, the kernel should not save/restore the LBR state component at
each context switch, like other state components, because of the
following unique features of LBR:
- The LBR state component only contains valuable information when LBR
  is enabled in the perf subsystem, but for most of the time, LBR is
  disabled.
- The size of the LBR state component is huge. For the current
  platform, it's 808 bytes.
If the kernel saves/restores the LBR state at each context switch, for
most of the time, it is just a waste of space and cycles.

To efficiently support the LBR state component, it is desired to have:
- only context-switch the LBR when the LBR feature is enabled in perf.
- only allocate an LBR-specific XSAVE buffer on demand.
  (Besides the LBR state, a legacy region and an XSAVE header have to be
   included in the buffer as well. There is a total of (808+576) byte
   overhead for the LBR-specific XSAVE buffer. The overhead only happens
   when the perf is actively using LBRs. There is still a space-saving,
   on average, when it replaces the constant 808 bytes of overhead for
   every task, all the time on the systems that support architectural
   LBR.)
- be able to use XSAVES/XRSTORS for accessing LBR at run time.
  However, the IA32_XSS should not be adjusted at run time.
  (The XCR0 | IA32_XSS are used to determine the requested-feature
  bitmap (RFBM) of XSAVES.)

A solution, called dynamic supervisor feature, is introduced to address
this issue, which
- does not allocate a buffer in each task->fpu;
- does not save/restore a state component at each context switch;
- sets the bit corresponding to the dynamic supervisor feature in
  IA32_XSS at boot time, and avoids setting it at run time.
- dynamically allocates a specific buffer for a state component
  on demand, e.g. only allocates LBR-specific XSAVE buffer when LBR is
  enabled in perf. (Note: The buffer has to include the LBR state
  component, a legacy region and a XSAVE header space.)
  (Implemented in a later patch)
- saves/restores a state component on demand, e.g. manually invokes
  the XSAVES/XRSTORS instruction to save/restore the LBR state
  to/from the buffer when perf is active and a call stack is required.
  (Implemented in a later patch)

A new mask XFEATURE_MASK_DYNAMIC and a helper xfeatures_mask_dynamic()
are introduced to indicate the dynamic supervisor feature. For the
systems which support the Architecture LBR, LBR is the only dynamic
supervisor feature for now. For the previous systems, there is no
dynamic supervisor feature available.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/fpu/types.h  |  7 +++++++
 arch/x86/include/asm/fpu/xstate.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/fpu/xstate.c      | 15 ++++++++++-----
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f098f6c..132e9cc 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -114,6 +114,12 @@ enum xfeature {
 	XFEATURE_Hi16_ZMM,
 	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
 	XFEATURE_PKRU,
+	XFEATURE_RSRVD_COMP_10,
+	XFEATURE_RSRVD_COMP_11,
+	XFEATURE_RSRVD_COMP_12,
+	XFEATURE_RSRVD_COMP_13,
+	XFEATURE_RSRVD_COMP_14,
+	XFEATURE_LBR,
 
 	XFEATURE_MAX,
 };
@@ -128,6 +134,7 @@ enum xfeature {
 #define XFEATURE_MASK_Hi16_ZMM		(1 << XFEATURE_Hi16_ZMM)
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
+#define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 422d836..040c4d4 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -36,6 +36,27 @@
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (0)
 
 /*
+ * A supervisor state component may not always contain valuable information,
+ * and its size may be huge. Saving/restoring such supervisor state components
+ * at each context switch can cause high CPU and space overhead, which should
+ * be avoided. Such supervisor state components should only be saved/restored
+ * on demand. The on-demand dynamic supervisor features are set in this mask.
+ *
+ * Unlike the existing supported supervisor features, a dynamic supervisor
+ * feature does not allocate a buffer in task->fpu, and the corresponding
+ * supervisor state component cannot be saved/restored at each context switch.
+ *
+ * To support a dynamic supervisor feature, a developer should follow the
+ * dos and don'ts as below:
+ * - Do dynamically allocate a buffer for the supervisor state component.
+ * - Do manually invoke the XSAVES/XRSTORS instruction to save/restore the
+ *   state component to/from the buffer.
+ * - Don't set the bit corresponding to the dynamic supervisor feature in
+ *   IA32_XSS at run time, since it has been set at boot time.
+ */
+#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
+
+/*
  * Unsupported supervisor features. When a supervisor feature in this mask is
  * supported in the future, move it to the supported supervisor feature mask.
  */
@@ -43,6 +64,7 @@
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
+				      XFEATURE_MASK_DYNAMIC | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
@@ -63,6 +85,14 @@ static inline u64 xfeatures_mask_user(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
+static inline u64 xfeatures_mask_dynamic(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
+		return XFEATURE_MASK_DYNAMIC & ~XFEATURE_MASK_LBR;
+
+	return XFEATURE_MASK_DYNAMIC;
+}
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bda2e5e..dcf0624 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -233,8 +233,10 @@ void fpu__init_cpu_xstate(void)
 	/*
 	 * MSR_IA32_XSS sets supervisor states managed by XSAVES.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
+	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
+				     xfeatures_mask_dynamic());
+	}
 }
 
 static bool xfeature_enabled(enum xfeature xfeature)
@@ -598,7 +600,8 @@ static void check_xstate_against_struct(int nr)
 	 */
 	if ((nr < XFEATURE_YMM) ||
 	    (nr >= XFEATURE_MAX) ||
-	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR)) {
+	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
+	    ((nr >= XFEATURE_RSRVD_COMP_10) && (nr <= XFEATURE_LBR))) {
 		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
 		XSTATE_WARN_ON(1);
 	}
@@ -847,8 +850,10 @@ void fpu__resume_cpu(void)
 	 * Restore IA32_XSS. The same CPUID bit enumerates support
 	 * of XSAVES and MSR_IA32_XSS.
 	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
+	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
+		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
+				     xfeatures_mask_dynamic());
+	}
 }
 
 /*
-- 
2.7.4

