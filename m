Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FF4120720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KR6HYwqr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fKRaoMNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgGHJxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgGHJvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65265C08C5DC;
        Wed,  8 Jul 2020 02:51:47 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:51:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8clFBUT48Zg4Jbc2veI/f5Sqo7XOO1HQtb3xkQSOIs=;
        b=KR6HYwqrPgY7cejgJQjzfl1ZzasTHmxM8tYJF2Pozz/CvMP+1WQoK0v9wXjgvlD/tr2h1C
        1kHMxaO5V4jTh74kDG0uP4lsC73wtNwQLgpH8Q7NKQrACYxGVXyngQUIlR/8fezkXZhMKa
        jWnqJy1Jqo0d3ZCSPdyAn3gX73HuhEQ/kFcrPzKF2yAjjVBKQsyQFdWW9ILqhuibBMMu5H
        SXDkDuhX6etuzWF03UDqom4S8eQXGIB9eMBASZWYpnlU6slj811H8pNjsxv9tFOnwJ6bNl
        rhvYv/AJthOQfQExAKl378C+b2pIMSxykzLuZFtFR+TtpQvHNK5/KZAJL1HD1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8clFBUT48Zg4Jbc2veI/f5Sqo7XOO1HQtb3xkQSOIs=;
        b=fKRaoMNy2AC9K5o846cbq8gsE1V8VIZ2fID4bkOXOaMBQRO8cnnEPaC1RqCiImKnT6ZfFu
        IFZBvIs40YjtZvBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/fpu: Use proper mask to replace full instruction mask
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-20-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-20-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190524.4006.281131920134798684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a063bf249b9f8d8004f282031781322c1b527d13
Gitweb:        https://git.kernel.org/tip/a063bf249b9f8d8004f282031781322c1b527d13
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:25 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:56 +02:00

x86/fpu: Use proper mask to replace full instruction mask

When saving xstate to a kernel/user XSAVE area with the XSAVE family of
instructions, the current code applies the 'full' instruction mask (-1),
which tries to XSAVE all possible features. This method relies on
hardware to trim 'all possible' down to what is enabled in the
hardware. The code works well for now. However, there will be a
problem, if some features are enabled in hardware, but are not suitable
to be saved into all kernel XSAVE buffers, like task->fpu, due to
performance consideration.

One such example is the Last Branch Records (LBR) state. The LBR state
only contains valuable information when LBR is explicitly enabled by
the perf subsystem, and the size of an LBR state is large (808 bytes
for now). To avoid both CPU overhead and space overhead at each context
switch, the LBR state should not be saved into task->fpu like other
state components. It should be saved/restored on demand when LBR is
enabled in the perf subsystem. Current copy_xregs_to_* will trigger a
buffer overflow for such cases.

Three sites use the '-1' instruction mask which must be updated.

Two are saving/restoring the xstate to/from a kernel-allocated XSAVE
buffer and can use 'xfeatures_mask_all', which will save/restore all of
the features present in a normal task FPU buffer.

The last one saves the register state directly to a user buffer. It
could
also use 'xfeatures_mask_all'. Just as it was with the '-1' argument,
any supervisor states in the mask will be filtered out by the hardware
and not saved to the buffer.  But, to be more explicit about what is
expected to be saved, use xfeatures_mask_user() for the instruction
mask.

KVM includes the header file fpu/internal.h. To avoid 'undefined
xfeatures_mask_all' compiling issue, move copy_fpregs_to_fpstate() to
fpu/core.c and export it, because:
- The xfeatures_mask_all is indirectly used via copy_fpregs_to_fpstate()
  by KVM. The function which is directly used by other modules should be
  exported.
- The copy_fpregs_to_fpstate() is a function, while xfeatures_mask_all
  is a variable for the "internal" FPU state. It's safer to export a
  function than a variable, which may be implicitly changed by others.
- The copy_fpregs_to_fpstate() is a big function with many checks. The
  removal of the inline keyword should not impact the performance.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/1593780569-62993-20-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/include/asm/fpu/internal.h | 47 ++++------------------------
 arch/x86/kernel/fpu/core.c          | 39 +++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f4..d3724dc 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -274,7 +274,7 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
  */
 static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -320,7 +320,7 @@ static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
  */
 static inline void copy_xregs_to_kernel(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_all;
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -356,6 +356,9 @@ static inline void copy_kernel_to_xregs(struct xregs_state *xstate, u64 mask)
  */
 static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 {
+	u64 mask = xfeatures_mask_user();
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
 	int err;
 
 	/*
@@ -367,7 +370,7 @@ static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 		return -EFAULT;
 
 	stac();
-	XSTATE_OP(XSAVE, buf, -1, -1, err);
+	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
 
 	return err;
@@ -408,43 +411,7 @@ static inline int copy_kernel_to_xregs_err(struct xregs_state *xstate, u64 mask)
 	return err;
 }
 
-/*
- * These must be called with preempt disabled. Returns
- * 'true' if the FPU state is still intact and we can
- * keep registers active.
- *
- * The legacy FNSAVE instruction cleared all FPU state
- * unconditionally, so registers are essentially destroyed.
- * Modern FPU state can be kept in registers, if there are
- * no pending FP exceptions.
- */
-static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
-{
-	if (likely(use_xsave())) {
-		copy_xregs_to_kernel(&fpu->state.xsave);
-
-		/*
-		 * AVX512 state is tracked here because its use is
-		 * known to slow the max clock speed of the core.
-		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
-			fpu->avx512_timestamp = jiffies;
-		return 1;
-	}
-
-	if (likely(use_fxsr())) {
-		copy_fxregs_to_kernel(fpu);
-		return 1;
-	}
-
-	/*
-	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
-	 * so we have to mark them inactive:
-	 */
-	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
-
-	return 0;
-}
+extern int copy_fpregs_to_fpstate(struct fpu *fpu);
 
 static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 06c8189..1bb7532 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -82,6 +82,45 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
+/*
+ * These must be called with preempt disabled. Returns
+ * 'true' if the FPU state is still intact and we can
+ * keep registers active.
+ *
+ * The legacy FNSAVE instruction cleared all FPU state
+ * unconditionally, so registers are essentially destroyed.
+ * Modern FPU state can be kept in registers, if there are
+ * no pending FP exceptions.
+ */
+int copy_fpregs_to_fpstate(struct fpu *fpu)
+{
+	if (likely(use_xsave())) {
+		copy_xregs_to_kernel(&fpu->state.xsave);
+
+		/*
+		 * AVX512 state is tracked here because its use is
+		 * known to slow the max clock speed of the core.
+		 */
+		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+			fpu->avx512_timestamp = jiffies;
+		return 1;
+	}
+
+	if (likely(use_fxsr())) {
+		copy_fxregs_to_kernel(fpu);
+		return 1;
+	}
+
+	/*
+	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
+	 * so we have to mark them inactive:
+	 */
+	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
+
+	return 0;
+}
+EXPORT_SYMBOL(copy_fpregs_to_fpstate);
+
 void kernel_fpu_begin(void)
 {
 	preempt_disable();
