Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE21206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgEPPKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgEPPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A3DC05BD0B;
        Sat, 16 May 2020 08:10:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZySB-0000rf-BC; Sat, 16 May 2020 17:10:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB2B51C0440;
        Sat, 16 May 2020 17:10:18 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:18 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Separate user and supervisor xfeatures mask
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-4-yu-cheng.yu@intel.com>
References: <20200512145444.15483-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181873.17951.4665885919598599780.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     524bb73bc15c56f5587e33c817e103a259b019d2
Gitweb:        https://git.kernel.org/tip/524bb73bc15c56f5587e33c817e103a259b019d2
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:37 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 May 2020 10:31:07 +02:00

x86/fpu/xstate: Separate user and supervisor xfeatures mask

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200512145444.15483-4-yu-cheng.yu@intel.com
---
 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/include/asm/fpu/xstate.h   | 13 ++++-
 arch/x86/kernel/fpu/signal.c        | 16 ++++--
 arch/x86/kernel/fpu/xstate.c        | 73 ++++++++++++++++------------
 4 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 44c48e3..ccb1bb3 100644
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
index b08fa82..92104b2 100644
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
index 585e365..3df0cfa 100644
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
index 9997df7..fa71af6 100644
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
