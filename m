Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C292DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A192B207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgEPPKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgEPPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204FAC061A0C;
        Sat, 16 May 2020 08:10:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZySB-0000ri-LK; Sat, 16 May 2020 17:10:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4503E1C01BB;
        Sat, 16 May 2020 17:10:19 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:19 -0000
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Define new macros for supervisor and
 user xstates
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-3-yu-cheng.yu@intel.com>
References: <20200512145444.15483-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181919.17951.3520607466636429869.tip-bot2@tip-bot2>
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

Commit-ID:     8ab22804efefea9ecf3c68aa00f1fa69c70fcfad
Gitweb:        https://git.kernel.org/tip/8ab22804efefea9ecf3c68aa00f1fa69c70fcfad
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:36 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 May 2020 20:34:38 +02:00

x86/fpu/xstate: Define new macros for supervisor and user xstates

XCNTXT_MASK is 'all supported xfeatures' before introducing supervisor
xstates.  Rename it to XFEATURE_MASK_USER_SUPPORTED to make clear that
these are user xstates.

Replace XFEATURE_MASK_SUPERVISOR with the following:
- XFEATURE_MASK_SUPERVISOR_SUPPORTED: Currently nothing.  ENQCMD and
  Control-flow Enforcement Technology (CET) will be introduced in separate
  series.
- XFEATURE_MASK_SUPERVISOR_UNSUPPORTED: Currently only Processor Trace.
- XFEATURE_MASK_SUPERVISOR_ALL: the combination of above.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200512145444.15483-3-yu-cheng.yu@intel.com
---
 arch/x86/include/asm/fpu/xstate.h | 36 +++++++++++++++++++-----------
 arch/x86/kernel/fpu/init.c        |  3 ++-
 arch/x86/kernel/fpu/xstate.c      | 26 +++++++++++-----------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fc4db51..b08fa82 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -21,19 +21,29 @@
 #define XSAVE_YMM_SIZE	    256
 #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
 
-/* Supervisor features */
-#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
-
-/* All currently supported features */
-#define XCNTXT_MASK		(XFEATURE_MASK_FP | \
-				 XFEATURE_MASK_SSE | \
-				 XFEATURE_MASK_YMM | \
-				 XFEATURE_MASK_OPMASK | \
-				 XFEATURE_MASK_ZMM_Hi256 | \
-				 XFEATURE_MASK_Hi16_ZMM	 | \
-				 XFEATURE_MASK_PKRU | \
-				 XFEATURE_MASK_BNDREGS | \
-				 XFEATURE_MASK_BNDCSR)
+/* All currently supported user features */
+#define XFEATURE_MASK_USER_SUPPORTED (XFEATURE_MASK_FP | \
+				      XFEATURE_MASK_SSE | \
+				      XFEATURE_MASK_YMM | \
+				      XFEATURE_MASK_OPMASK | \
+				      XFEATURE_MASK_ZMM_Hi256 | \
+				      XFEATURE_MASK_Hi16_ZMM	 | \
+				      XFEATURE_MASK_PKRU | \
+				      XFEATURE_MASK_BNDREGS | \
+				      XFEATURE_MASK_BNDCSR)
+
+/* All currently supported supervisor features */
+#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (0)
+
+/*
+ * Unsupported supervisor features. When a supervisor feature in this mask is
+ * supported in the future, move it to the supported supervisor feature mask.
+ */
+#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT)
+
+/* All supervisor states including supported and unsupported states. */
+#define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
+				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
 #define REX_PREFIX	"0x48, "
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6ce7e0a..61ddc3a 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -224,7 +224,8 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
-	return XCNTXT_MASK;
+	return XFEATURE_MASK_USER_SUPPORTED |
+	       XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 }
 
 /* Legacy code to initialize eager fpu mode. */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8ed6439..9997df7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -208,14 +208,13 @@ void fpu__init_cpu_xstate(void)
 	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask)
 		return;
 	/*
-	 * Make it clear that XSAVES supervisor states are not yet
-	 * implemented should anyone expect it to work by changing
-	 * bits in XFEATURE_MASK_* macros and XCR0.
+	 * Unsupported supervisor xstates should not be found in
+	 * the xfeatures mask.
 	 */
-	WARN_ONCE((xfeatures_mask & XFEATURE_MASK_SUPERVISOR),
-		"x86/fpu: XSAVES supervisor states are not yet implemented.\n");
+	WARN_ONCE((xfeatures_mask & XFEATURE_MASK_SUPERVISOR_UNSUPPORTED),
+		  "x86/fpu: Found unsupported supervisor xstates.\n");
 
-	xfeatures_mask &= ~XFEATURE_MASK_SUPERVISOR;
+	xfeatures_mask &= ~XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
@@ -438,7 +437,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	 * format. Checking a supervisor state's uncompacted offset is
 	 * an error.
 	 */
-	if (XFEATURE_MASK_SUPERVISOR & BIT_ULL(xfeature_nr)) {
+	if (XFEATURE_MASK_SUPERVISOR_ALL & BIT_ULL(xfeature_nr)) {
 		WARN_ONCE(1, "No fixed offset for xstate %d\n", xfeature_nr);
 		return -1;
 	}
@@ -475,7 +474,7 @@ int using_compacted_format(void)
 int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & (~xfeatures_mask | XFEATURE_MASK_SUPERVISOR))
+	if (hdr->xfeatures & ~(xfeatures_mask & XFEATURE_MASK_USER_SUPPORTED))
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -768,7 +767,8 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size,	xfeatures_mask & ~XFEATURE_MASK_SUPERVISOR);
+	update_regset_xstate_info(fpu_user_xstate_size,
+				  xfeatures_mask & XFEATURE_MASK_USER_SUPPORTED);
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -996,7 +996,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= XFEATURE_MASK_USER_SUPPORTED;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1080,7 +1080,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= XFEATURE_MASK_USER_SUPPORTED;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1173,7 +1173,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
 
 	/*
 	 * Add back in the features that came in from userspace:
@@ -1229,7 +1229,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
 
 	/*
 	 * Add back in the features that came in from userspace:
