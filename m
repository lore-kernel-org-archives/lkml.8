Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ACFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882C420B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFZSYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:24:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:59781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgFZSXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:47 -0400
IronPort-SDR: i5WUASH4SacBXLGNmgsTBZMQ+CqaC0eRQJOE4kMvqBQpOpNSC0rIqNK8Dh2mmOac6L7uDFrV+K
 IL5p3UgNH6zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512955"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:45 -0700
IronPort-SDR: /AUJ+xaO4hifyOUI/DFiU0St8Sd4w+cdkYzaOhAO/EX/MAyq1EGDQ7NFmJk94d+knLOfx6LlXK
 kFXpyq8AltHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153962"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:45 -0700
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
Subject: [PATCH V2 21/23] x86/fpu/xstate: Add helpers for LBR dynamic supervisor feature
Date:   Fri, 26 Jun 2020 11:20:18 -0700
Message-Id: <1593195620-116988-22-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf subsystem will only need to save/restore the LBR state.
However, the existing helpers save all supported supervisor states to a
kernel buffer, which will be unnecessary. Two helpers are introduced to
only save/restore requested dynamic supervisor states. The supervisor
features in XFEATURE_MASK_SUPERVISOR_SUPPORTED and
XFEATURE_MASK_SUPERVISOR_UNSUPPORTED mask cannot be saved/restored using
these helpers.

The helpers will be used in the following patch.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/fpu/xstate.h |  3 ++
 arch/x86/kernel/fpu/xstate.c      | 72 +++++++++++++++++++++++++++++++++++++++
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
-- 
2.7.4

