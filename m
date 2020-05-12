Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A29C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68FA206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgELOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:55:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:29538 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgELOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:55:10 -0400
IronPort-SDR: irdUGMSg1wCWkrNpILLMfIXQLzaqQtmeS5Q9xxRflgyW53QufH1Vm5b6tuI5hZ4/PowrFPKuhN
 nsPHMxE2uwZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:55:08 -0700
IronPort-SDR: yz6+Y/azMzkeEK1dNt8OSDFG7bqgE/MryKUfcN7gUu5F6ZlEe6D9sGfLolS3RYmWDvrB7SVkj6
 9FN+TIAWjSOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371587800"
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
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v4 01/10] x86/fpu/xstate: Rename validate_xstate_header() to validate_user_xstate_header()
Date:   Tue, 12 May 2020 07:54:35 -0700
Message-Id: <20200512145444.15483-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200512145444.15483-1-yu-cheng.yu@intel.com>
References: <20200512145444.15483-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

The function validate_xstate_header() validates an xstate header coming
from userspace (PTRACE or sigreturn).  To make it clear, rename it to
validate_user_xstate_header().

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
v3:
- Change validate_xstate_header_from_user() to validate_user_xstate_header().

 arch/x86/include/asm/fpu/xstate.h | 2 +-
 arch/x86/kernel/fpu/regset.c      | 2 +-
 arch/x86/kernel/fpu/signal.c      | 2 +-
 arch/x86/kernel/fpu/xstate.c      | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index c6136d79f8c0..fc4db51f3b53 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -56,6 +56,6 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-extern int validate_xstate_header(const struct xstate_header *hdr);
+int validate_user_xstate_header(const struct xstate_header *hdr);
 
 #endif
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index d652b939ccfb..bd1d0649f8ce 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -139,7 +139,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	} else {
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, xsave, 0, -1);
 		if (!ret)
-			ret = validate_xstate_header(&xsave->header);
+			ret = validate_user_xstate_header(&xsave->header);
 	}
 
 	/*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 400a05e1c1c5..585e3651b98f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -366,7 +366,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
 
 			if (!ret && state_size > offsetof(struct xregs_state, header))
-				ret = validate_xstate_header(&fpu->state.xsave.header);
+				ret = validate_user_xstate_header(&fpu->state.xsave.header);
 		}
 		if (ret)
 			goto err_out;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 32b153d38748..8ed64397c78b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -472,7 +472,7 @@ int using_compacted_format(void)
 }
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
-int validate_xstate_header(const struct xstate_header *hdr)
+int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
 	if (hdr->xfeatures & (~xfeatures_mask | XFEATURE_MASK_SUPERVISOR))
@@ -1147,7 +1147,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 
 	memcpy(&hdr, kbuf + offset, size);
 
-	if (validate_xstate_header(&hdr))
+	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
@@ -1201,7 +1201,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	if (__copy_from_user(&hdr, ubuf + offset, size))
 		return -EFAULT;
 
-	if (validate_xstate_header(&hdr))
+	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
-- 
2.21.0

