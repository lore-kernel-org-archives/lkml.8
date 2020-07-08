Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E96C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E0F20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+FCIQK2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tzv0zZpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgGHJvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgGHJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3508CC08C5DC;
        Wed,  8 Jul 2020 02:51:46 -0700 (PDT)
Date:   Wed, 08 Jul 2020 09:51:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuueGIno4nXC2EQ11JEyPJyj5XATISyTSDKr5FASpdw=;
        b=D+FCIQK2GkDjNckrL1XWRBs058x3PlNbqE/fkI5tN6HSMPEAyLATL8c5lW7Fcg4Pzxa0aK
        Nv9FoMDmTMN/AHHdX+qG+YITawR4KjbFKf7RGJ/WaDIfvqy7sEB/YNcW4idlDLG2vm2Q2r
        ZN0fdv6FTeK2VCaJOhNFylZE8fvLZccypFyCqYzEuJP559HNCcsMi9VMLGXDD09HnH6+pt
        Dc8xsPjKqp2Jk7lFqruJaP8if5pDNt1oioIKW1YnZqAml/CvzYcUEFjZMFf8mn/RiJBmGJ
        ZewXCv1oDfKHZTlP25P52IAoF/YuV/t+UoHVfT8f2ywHZ0T/nqQl6878FcC1sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201904;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuueGIno4nXC2EQ11JEyPJyj5XATISyTSDKr5FASpdw=;
        b=Tzv0zZpIlnLfXoqlVa7naITUQSFfJlt+Tm8RbMIXHfpznIt5sYi5Hxh//JaaWB94cQtBlo
        bmUbuf+KMPmbjhBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/fpu/xstate: Add helpers for LBR dynamic
 supervisor feature
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-22-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-22-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420190404.4006.5975896241439512235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     50f408d96d4d1a945d2c50c5fd8ed400883edf0e
Gitweb:        https://git.kernel.org/tip/50f408d96d4d1a945d2c50c5fd8ed400883edf0e
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:56 +02:00

x86/fpu/xstate: Add helpers for LBR dynamic supervisor feature

The perf subsystem will only need to save/restore the LBR state.
However, the existing helpers save all supported supervisor states to a
kernel buffer, which will be unnecessary. Two helpers are introduced to
only save/restore requested dynamic supervisor states. The supervisor
features in XFEATURE_MASK_SUPERVISOR_SUPPORTED and
XFEATURE_MASK_SUPERVISOR_UNSUPPORTED mask cannot be saved/restored using
these helpers.

The helpers will be used in the following patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/1593780569-62993-22-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/include/asm/fpu/xstate.h |  3 +-
 arch/x86/kernel/fpu/xstate.c      | 72 ++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 040c4d4..c029fce 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -106,6 +106,9 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_supervisor_to_kernel(struct xregs_state *xsave);
+void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
+void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
+
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 int validate_user_xstate_header(const struct xstate_header *hdr);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index dcf0624..b0c22b7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1361,6 +1361,78 @@ void copy_supervisor_to_kernel(struct xregs_state *xstate)
 	}
 }
 
+/**
+ * copy_dynamic_supervisor_to_kernel() - Save dynamic supervisor states to
+ *                                       an xsave area
+ * @xstate: A pointer to an xsave area
+ * @mask: Represent the dynamic supervisor features saved into the xsave area
+ *
+ * Only the dynamic supervisor states sets in the mask are saved into the xsave
+ * area (See the comment in XFEATURE_MASK_DYNAMIC for the details of dynamic
+ * supervisor feature). Besides the dynamic supervisor states, the legacy
+ * region and XSAVE header are also saved into the xsave area. The supervisor
+ * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
+ * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
+ *
+ * The xsave area must be 64-bytes aligned.
+ */
+void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+{
+	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u32 lmask, hmask;
+	int err;
+
+	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
+		return;
+
+	if (WARN_ON_FPU(!dynamic_mask))
+		return;
+
+	lmask = dynamic_mask;
+	hmask = dynamic_mask >> 32;
+
+	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
+
+	/* Should never fault when copying to a kernel buffer */
+	WARN_ON_FPU(err);
+}
+
+/**
+ * copy_kernel_to_dynamic_supervisor() - Restore dynamic supervisor states from
+ *                                       an xsave area
+ * @xstate: A pointer to an xsave area
+ * @mask: Represent the dynamic supervisor features restored from the xsave area
+ *
+ * Only the dynamic supervisor states sets in the mask are restored from the
+ * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
+ * dynamic supervisor feature). Besides the dynamic supervisor states, the
+ * legacy region and XSAVE header are also restored from the xsave area. The
+ * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
+ * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
+ *
+ * The xsave area must be 64-bytes aligned.
+ */
+void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
+{
+	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u32 lmask, hmask;
+	int err;
+
+	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
+		return;
+
+	if (WARN_ON_FPU(!dynamic_mask))
+		return;
+
+	lmask = dynamic_mask;
+	hmask = dynamic_mask >> 32;
+
+	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
+
+	/* Should never fault when copying from a kernel buffer */
+	WARN_ON_FPU(err);
+}
+
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
