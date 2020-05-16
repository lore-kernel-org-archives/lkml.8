Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280BCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDBE207D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgEPPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgEPPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA89C061A0C;
        Sat, 16 May 2020 08:10:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZySA-0000rO-23; Sat, 16 May 2020 17:10:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CAA201C0475;
        Sat, 16 May 2020 17:10:16 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:16 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Introduce copy_supervisor_to_kernel()
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-9-yu-cheng.yu@intel.com>
References: <20200512145444.15483-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181672.17951.9851247776841845334.tip-bot2@tip-bot2>
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

Commit-ID:     eeedf1533687b8e81865fdbde79eddf7c4b76c9a
Gitweb:        https://git.kernel.org/tip/eeedf1533687b8e81865fdbde79eddf7c4b76c9a
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:42 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 16 May 2020 11:24:14 +02:00

x86/fpu: Introduce copy_supervisor_to_kernel()

The XSAVES instruction takes a mask and saves only the features specified
in that mask.  The kernel normally specifies that all features be saved.

XSAVES also unconditionally uses the "compacted format" which means that
all specified features are saved next to each other in memory.  If a
feature is removed from the mask, all the features after it will "move
up" into earlier locations in the buffer.

Introduce copy_supervisor_to_kernel(), which saves only supervisor states
and then moves those states into the standard location where they are
normally found.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200512145444.15483-9-yu-cheng.yu@intel.com
---
 arch/x86/include/asm/fpu/xstate.h |  1 +-
 arch/x86/kernel/fpu/xstate.c      | 84 ++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 92104b2..422d836 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -75,6 +75,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
+void copy_supervisor_to_kernel(struct xregs_state *xsave);
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 int validate_user_xstate_header(const struct xstate_header *hdr);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a68213e..587e03f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -62,6 +62,7 @@ u64 xfeatures_mask_all __read_mostly;
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -393,6 +394,33 @@ static void __init setup_xstate_comp_offsets(void)
 }
 
 /*
+ * Setup offsets of a supervisor-state-only XSAVES buffer:
+ *
+ * The offsets stored in xstate_comp_offsets[] only work for one specific
+ * value of the Requested Feature BitMap (RFBM).  In cases where a different
+ * RFBM value is used, a different set of offsets is required.  This set of
+ * offsets is for when RFBM=xfeatures_mask_supervisor().
+ */
+static void __init setup_supervisor_only_offsets(void)
+{
+	unsigned int next_offset;
+	int i;
+
+	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		if (!xfeature_enabled(i) || !xfeature_is_supervisor(i))
+			continue;
+
+		if (xfeature_is_aligned(i))
+			next_offset = ALIGN(next_offset, 64);
+
+		xstate_supervisor_only_offsets[i] = next_offset;
+		next_offset += xstate_sizes[i];
+	}
+}
+
+/*
  * Print out xstate component offsets and sizes
  */
 static void __init print_xstate_offset_size(void)
@@ -790,6 +818,7 @@ void __init fpu__init_system_xstate(void)
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
+	setup_supervisor_only_offsets();
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
@@ -1262,6 +1291,61 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	return 0;
 }
 
+/*
+ * Save only supervisor states to the kernel buffer.  This blows away all
+ * old states, and is intended to be used only in __fpu__restore_sig(), where
+ * user states are restored from the user buffer.
+ */
+void copy_supervisor_to_kernel(struct xregs_state *xstate)
+{
+	struct xstate_header *header;
+	u64 max_bit, min_bit;
+	u32 lmask, hmask;
+	int err, i;
+
+	if (WARN_ON(!boot_cpu_has(X86_FEATURE_XSAVES)))
+		return;
+
+	if (!xfeatures_mask_supervisor())
+		return;
+
+	max_bit = __fls(xfeatures_mask_supervisor());
+	min_bit = __ffs(xfeatures_mask_supervisor());
+
+	lmask = xfeatures_mask_supervisor();
+	hmask = xfeatures_mask_supervisor() >> 32;
+	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
+
+	/* We should never fault when copying to a kernel buffer: */
+	if (WARN_ON_FPU(err))
+		return;
+
+	/*
+	 * At this point, the buffer has only supervisor states and must be
+	 * converted back to normal kernel format.
+	 */
+	header = &xstate->header;
+	header->xcomp_bv |= xfeatures_mask_all;
+
+	/*
+	 * This only moves states up in the buffer.  Start with
+	 * the last state and move backwards so that states are
+	 * not overwritten until after they are moved.  Note:
+	 * memmove() allows overlapping src/dst buffers.
+	 */
+	for (i = max_bit; i >= min_bit; i--) {
+		u8 *xbuf = (u8 *)xstate;
+
+		if (!((header->xfeatures >> i) & 1))
+			continue;
+
+		/* Move xfeature 'i' into its normal location */
+		memmove(xbuf + xstate_comp_offsets[i],
+			xbuf + xstate_supervisor_only_offsets[i],
+			xstate_sizes[i]);
+	}
+}
+
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
