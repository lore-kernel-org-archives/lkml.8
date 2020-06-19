Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862042166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbgFSOIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:54754 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732664AbgFSOIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:08:21 -0400
IronPort-SDR: RSVhp0ciGULioimL4pR9XJ2mscWeRDPjBUSg9IKD8R7N7lhFsppwrFcFXxsl8ckRynxfxx7oSv
 1KdRPcH1Y4hA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452880"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:08:06 -0700
IronPort-SDR: mI46dL1kxtgpYfA1hwaKtplMWkBvdZzsK/ybGUYpD4TA7DJ/S742ckaAh5NWlOITdjG7KYY0ym
 s3BGHTtx8bpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837527"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:08:05 -0700
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
Subject: [PATCH 19/21] x86/fpu/xstate: Add helpers for LBR dynamic supervisor feature
Date:   Fri, 19 Jun 2020 07:04:07 -0700
Message-Id: <1592575449-64278-20-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The LBR dynamic supervisor feature will be enabled in the perf
subsystem later. A new structure, several helpers, and a macro are
added as below to facilitate enabling the feature.
- Currently, the structure for each state component is maintained in
  fpu/types.h. The structure for the new LBR state component should be
  maintained in the same place, which will be used in the following
  patch.
- The perf subsystem will only need to save/restore the LBR state.
  However, the existing helpers save all supported supervisor states to
  a kernel buffer, which will be unnecessary. Two helpers are
  introduced to only save/restore requested dynamic supervisor states.
  The supervisor features in XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  XFEATURE_MASK_SUPERVISOR_UNSUPPORTED mask cannot be saved/restored
  using these helpers.
- The XSAVE buffer must be 64-byte aligned. A new macro is added to
  reflect the alignment requirement.

The structure, the helpers, and the macro will be used in the following
patch.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/fpu/types.h  | 19 +++++++++++
 arch/x86/include/asm/fpu/xstate.h |  5 +++
 arch/x86/kernel/fpu/xstate.c      | 72 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 132e9cc..975f078 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -236,6 +236,25 @@ struct pkru_state {
 	u32				pad;
 } __packed;
 
+/*
+ * State component 15: Architectural LBR configuration state.
+ * The size of Arch LBR state depends on the number of LBRs (lbr_depth).
+ */
+struct arch_lbr_entry {
+	u64 lbr_from;
+	u64 lbr_to;
+	u64 lbr_info;
+};
+
+struct arch_lbr_state {
+	u64 lbr_ctl;
+	u64 lbr_depth;
+	u64 ler_from;
+	u64 ler_to;
+	u64 ler_info;
+	struct arch_lbr_entry		entries[0];
+} __packed;
+
 struct xstate_header {
 	u64				xfeatures;
 	u64				xcomp_bv;
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 040c4d4..636c3ef 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -21,6 +21,8 @@
 #define XSAVE_YMM_SIZE	    256
 #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
 
+#define XSAVE_ALIGNMENT     64
+
 /* All currently supported user features */
 #define XFEATURE_MASK_USER_SUPPORTED (XFEATURE_MASK_FP | \
 				      XFEATURE_MASK_SSE | \
@@ -106,6 +108,9 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_supervisor_to_kernel(struct xregs_state *xsave);
+void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
+void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
+
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 int validate_user_xstate_header(const struct xstate_header *hdr);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 58d79f1..49e0347 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1352,6 +1352,78 @@ void copy_supervisor_to_kernel(struct xregs_state *xstate)
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
-- 
2.7.4

