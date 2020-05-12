Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A0C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D436B20730
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgELO5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:57:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:29538 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgELO5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:57:10 -0400
IronPort-SDR: WmsWh8AFPmJDKA4Ad5ldEfPMINEG+d78Yj8+Zywp0E4ECASjGpcizeZ2DW0X8Xum4KeyBjDygr
 uZsRj31cwjpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:55:08 -0700
IronPort-SDR: LyNbA3Z7F7reJm6OO5SEVYP9TBiBk5IELcQlq0KtRKX7DHUfvhlFZ6jSPu9tV44VKaP+9xHXlM
 mRLbMV9KLl4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371587808"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 07:55:08 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 03/10] x86/fpu/xstate: Separate user and supervisor xfeatures mask
Date:   Tue, 12 May 2020 07:54:37 -0700
Message-Id: <20200512145444.15483-4-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200512145444.15483-1-yu-cheng.yu@intel.com>
References: <20200512145444.15483-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the introduction of XSAVES supervisor states, 'xfeatures_mask' is
used at various places to determine XSAVE buffer components and XCR0 bits.
It contains only user xstates.  To support supervisor xstates, it is
necessary to separate user and supervisor xstates:

- First, change 'xfeatures_mask' to 'xfeatures_mask_all', which represents
  the full set of bits that should ever be set in a kernel XSAVE buffer.
- Introduce xfeatures_mask_supervisor() and xfeatures_mask_user() to
  extract relevant xfeatures from xfeatures_mask_all.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v3:
- Change xfeature_enabled() type from static int to static bool while at
  it.

v2:
- Fix typo in commit log.
- Move xfeatures_mask_supervisor() from xstate.c to xstate.h.
- Remove printing of user xstates from fpu__init_system_xstate().

 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/include/asm/fpu/xstate.h   | 13 ++++-
 arch/x86/kernel/fpu/signal.c        | 16 +++++--
 arch/x86/kernel/fpu/xstate.c        | 73 +++++++++++++++++------------
 4 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 44c48e34d799..ccb1bb32ad7d 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -92,7 +92,7 @@ static inline void fpstate_init_xstate(struct xregs_state *xsave)
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
 	 * trigger #GP:
 	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask;
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
 }
 
 static inline void fpstate_init_fxstate(struct fxregs_state *fx)
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index b08fa823425f..92104b298d77 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -51,7 +51,18 @@
 #define REX_PREFIX
 #endif
 
-extern u64 xfeatures_mask;
+extern u64 xfeatures_mask_all;
+
+static inline u64 xfeatures_mask_supervisor(void)
+{
+	return xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+}
+
+static inline u64 xfeatures_mask_user(void)
+{
+	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
+}
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 585e3651b98f..3df0cfae535f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -252,13 +252,17 @@ sanitize_restored_xstate(union fpregs_state *state,
  */
 static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 {
+	u64 init_bv;
+
 	if (use_xsave()) {
 		if (fx_only) {
-			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_fxregs(buf);
 		} else {
-			u64 init_bv = xfeatures_mask & ~xbv;
+			init_bv = xfeatures_mask_user() & ~xbv;
+
 			if (unlikely(init_bv))
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_xregs(buf, xbv);
@@ -358,7 +362,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask & ~xfeatures;
+		u64 init_bv = xfeatures_mask_user() & ~xfeatures;
 
 		if (using_compacted_format()) {
 			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
@@ -389,7 +393,9 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 		fpregs_lock();
 		if (use_xsave()) {
-			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
+			u64 init_bv;
+
+			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 		}
 
@@ -465,7 +471,7 @@ void fpu__init_prepare_fx_sw_frame(void)
 
 	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
 	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = xfeatures_mask;
+	fx_sw_reserved.xfeatures = xfeatures_mask_user();
 	fx_sw_reserved.xstate_size = fpu_user_xstate_size;
 
 	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9997df717339..fa71af643025 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -54,9 +54,10 @@ static short xsave_cpuid_features[] __initdata = {
 };
 
 /*
- * Mask of xstate features supported by the CPU and the kernel:
+ * This represents the full set of bits that should ever be set in a kernel
+ * XSAVE buffer, both supervisor and user xstates.
  */
-u64 xfeatures_mask __read_mostly;
+u64 xfeatures_mask_all __read_mostly;
 
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
@@ -76,7 +77,7 @@ unsigned int fpu_user_xstate_size;
  */
 int cpu_has_xfeatures(u64 xfeatures_needed, const char **feature_name)
 {
-	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask;
+	u64 xfeatures_missing = xfeatures_needed & ~xfeatures_mask_all;
 
 	if (unlikely(feature_name)) {
 		long xfeature_idx, max_idx;
@@ -150,7 +151,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * None of the feature bits are in init state. So nothing else
 	 * to do for us, as the memory layout is up to date.
 	 */
-	if ((xfeatures & xfeatures_mask) == xfeatures_mask)
+	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
 		return;
 
 	/*
@@ -177,7 +178,7 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 * in a special way already:
 	 */
 	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask & ~xfeatures) >> 2;
+	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
 
 	/*
 	 * Update all the remaining memory layouts according to their
@@ -205,19 +206,28 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
  */
 void fpu__init_cpu_xstate(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask)
+	u64 unsup_bits;
+
+	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
 		return;
 	/*
 	 * Unsupported supervisor xstates should not be found in
 	 * the xfeatures mask.
 	 */
-	WARN_ONCE((xfeatures_mask & XFEATURE_MASK_SUPERVISOR_UNSUPPORTED),
-		  "x86/fpu: Found unsupported supervisor xstates.\n");
+	unsup_bits = xfeatures_mask_all & XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
+	WARN_ONCE(unsup_bits, "x86/fpu: Found unsupported supervisor xstates: 0x%llx\n",
+		  unsup_bits);
 
-	xfeatures_mask &= ~XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
+	xfeatures_mask_all &= ~XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+
+	/*
+	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
+	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
+	 * states can be set here.
+	 */
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
 }
 
 /*
@@ -225,9 +235,9 @@ void fpu__init_cpu_xstate(void)
  * functions here: one for user xstates and the other for
  * system xstates.  For now, they are the same.
  */
-static int xfeature_enabled(enum xfeature xfeature)
+static bool xfeature_enabled(enum xfeature xfeature)
 {
-	return !!(xfeatures_mask & (1UL << xfeature));
+	return xfeatures_mask_all & BIT_ULL(xfeature);
 }
 
 /*
@@ -414,7 +424,7 @@ static void __init setup_init_fpu_buf(void)
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		init_fpstate.xsave.header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
-						     xfeatures_mask;
+						     xfeatures_mask_all;
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -474,7 +484,7 @@ int using_compacted_format(void)
 int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & ~(xfeatures_mask & XFEATURE_MASK_USER_SUPPORTED))
+	if (hdr->xfeatures & ~xfeatures_mask_user())
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -609,7 +619,7 @@ static void do_extra_xstate_size_checks(void)
 
 
 /*
- * Get total size of enabled xstates in XCR0/xfeatures_mask.
+ * Get total size of enabled xstates in XCR0 | IA32_XSS.
  *
  * Note the SDM's wording here.  "sub-function 0" only enumerates
  * the size of the *user* states.  If we use it to size a buffer
@@ -699,7 +709,7 @@ static int __init init_xstate_size(void)
  */
 static void fpu__init_disable_system_xstate(void)
 {
-	xfeatures_mask = 0;
+	xfeatures_mask_all = 0;
 	cr4_clear_bits(X86_CR4_OSXSAVE);
 	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
 }
@@ -734,16 +744,21 @@ void __init fpu__init_system_xstate(void)
 		return;
 	}
 
+	/*
+	 * Find user xstates supported by the processor.
+	 */
 	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
-	xfeatures_mask = eax + ((u64)edx << 32);
+	xfeatures_mask_all = eax + ((u64)edx << 32);
 
-	if ((xfeatures_mask & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
+	/* Place supervisor features in xfeatures_mask_all here */
+	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
 		/*
 		 * This indicates that something really unexpected happened
 		 * with the enumeration.  Disable XSAVE and try to continue
 		 * booting without it.  This is too early to BUG().
 		 */
-		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n", xfeatures_mask);
+		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n",
+		       xfeatures_mask_all);
 		goto out_disable;
 	}
 
@@ -752,10 +767,10 @@ void __init fpu__init_system_xstate(void)
 	 */
 	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
 		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask &= ~BIT(i);
+			xfeatures_mask_all &= ~BIT_ULL(i);
 	}
 
-	xfeatures_mask &= fpu__get_supported_xfeatures_mask();
+	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
@@ -767,8 +782,7 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size,
-				  xfeatures_mask & XFEATURE_MASK_USER_SUPPORTED);
+	update_regset_xstate_info(fpu_user_xstate_size, xfeatures_mask_user());
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -776,7 +790,7 @@ void __init fpu__init_system_xstate(void)
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
-		xfeatures_mask,
+		xfeatures_mask_all,
 		fpu_kernel_xstate_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
@@ -795,7 +809,7 @@ void fpu__resume_cpu(void)
 	 * Restore XCR0 on xsave capable CPUs:
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
+		xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
 }
 
 /*
@@ -840,10 +854,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 
 	/*
 	 * We should not ever be requesting features that we
-	 * have not enabled.  Remember that xfeatures_mask is
-	 * what we write to the XCR0 register.
+	 * have not enabled.
 	 */
-	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
+	WARN_ONCE(!(xfeatures_mask_all & BIT_ULL(xfeature_nr)),
 		  "get of unsupported state");
 	/*
 	 * This assumes the last 'xsave*' instruction to
@@ -996,7 +1009,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= XFEATURE_MASK_USER_SUPPORTED;
+	header.xfeatures &= xfeatures_mask_user();
 
 	/*
 	 * Copy xregs_state->header:
@@ -1080,7 +1093,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= XFEATURE_MASK_USER_SUPPORTED;
+	header.xfeatures &= xfeatures_mask_user();
 
 	/*
 	 * Copy xregs_state->header:
-- 
2.21.0

