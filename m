Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7629C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5072207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbgFSOIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:54759 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733085AbgFSOIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:19 -0400
IronPort-SDR: BgxaaAtUrpHy8sWT2AD/jtJj3yeXauDy9j/y8SR7WqgkV0AzfMxS0xkdlTnyarmlwtENZoJvlL
 l1Yrnfts0XBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452870"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452870"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:08:03 -0700
IronPort-SDR: kvmugd7hIAkJsOBPGBM/btIhJZ1leKxFjmgee67fpUhnAcrIigbdufYHEOZF9nA4sqW8yj3DLp
 6960+FcUZFzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837515"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:08:03 -0700
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
Subject: [PATCH 17/21] x86/fpu: Use proper mask to replace full instruction mask
Date:   Fri, 19 Jun 2020 07:04:05 -0700
Message-Id: <1592575449-64278-18-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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

The last one saves the register state directly to a user buffer. It could
also use 'xfeatures_mask_all'. Just as it was with the '-1' argument,
any supervisor states in the mask will be filtered out by the hardware
and not saved to the buffer.  But, to be more explicit about what is
expected to be saved, use xfeatures_mask_user() for the instruction
mask.

KVM includes the header file fpu/internal.h. To avoid 'undefined
xfeatures_mask_all' compiling issue, xfeatures_mask_all has to be
exported.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/fpu/internal.h | 9 ++++++---
 arch/x86/kernel/fpu/xstate.c        | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 42159f4..0388c792 100644
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
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 587e03f..eb2e44e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -58,6 +58,7 @@ static short xsave_cpuid_features[] __initdata = {
  * XSAVE buffer, both supervisor and user xstates.
  */
 u64 xfeatures_mask_all __read_mostly;
+EXPORT_SYMBOL_GPL(xfeatures_mask_all);
 
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
-- 
2.7.4

