Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2DEC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E102073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgC1Qo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:39979 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgC1QoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:44:00 -0400
IronPort-SDR: iXoGO/acT6T13GlqdleofNGkz5GiazcGLP7j+UXVKjUdddMvo9Gh+dRqIwpmnv3OjVtpAY6cs8
 IJ8m3vVnY3xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 09:43:58 -0700
IronPort-SDR: 8maBhhk/FYHHZQppkm8zX1JOKaTxlPLCUAOgw8N/G6IlZxPFb1yEorhZ7vCKWJFG9eg2PpBQZc
 dU0hgqKpa0iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447771173"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 09:43:58 -0700
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
Subject: [PATCH v3 06/10] x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor xstates
Date:   Sat, 28 Mar 2020 09:43:03 -0700
Message-Id: <20200328164307.17497-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200328164307.17497-1-yu-cheng.yu@intel.com>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sanitize_restored_xstate() sanitizes user xstates of an XSAVE
buffer by setting the buffer's header->xfeatures to the input 'xfeatures',
effectively resetting features not in 'xfeatures' back to the init state.

When supervisor xstates are introduced, it is necessary to make sure only
user xstates are sanitized.  Ensure supervisor bits in header->xfeatures
stay set and supervisor states are not modified.

To make names clear, also:

- Rename the function to sanitize_restored_user_xstate().
- Rename input parameter 'xfeatures' to 'xfeatures_from_user'.
- In __fpu__restore_sig(), rename 'xfeatures' to 'user_xfeatures'.

v3:
- Change xfeatures_user to user_xfeatures.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/fpu/signal.c | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index cd6eafba12da..d09d72334a12 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -211,9 +211,9 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 }
 
 static inline void
-sanitize_restored_xstate(union fpregs_state *state,
-			 struct user_i387_ia32_struct *ia32_env,
-			 u64 xfeatures, int fx_only)
+sanitize_restored_user_xstate(union fpregs_state *state,
+			      struct user_i387_ia32_struct *ia32_env,
+			      u64 xfeatures_from_user, int fx_only)
 {
 	struct xregs_state *xsave = &state->xsave;
 	struct xstate_header *header = &xsave->header;
@@ -226,13 +226,22 @@ sanitize_restored_xstate(union fpregs_state *state,
 		 */
 
 		/*
-		 * Init the state that is not present in the memory
-		 * layout and not enabled by the OS.
+		 * 'xfeatures_from_user' might have bits clear which are
+		 * set in header->xfeatures. This represents features that
+		 * were in init state prior to a signal delivery, and need
+		 * to be reset back to the init state.  Clear any user
+		 * feature bits which are set in the kernel buffer to get
+		 * them back to the init state.
+		 *
+		 * Supervisor state is unchanged by input from userspace.
+		 * Ensure supervisor state bits stay set and supervisor
+		 * state is not modified.
 		 */
 		if (fx_only)
 			header->xfeatures = XFEATURE_MASK_FPSSE;
 		else
-			header->xfeatures &= xfeatures;
+			header->xfeatures &= xfeatures_from_user |
+					     xfeatures_mask_supervisor();
 	}
 
 	if (use_fxsr()) {
@@ -281,7 +290,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	struct task_struct *tsk = current;
 	struct fpu *fpu = &tsk->thread.fpu;
 	struct user_i387_ia32_struct env;
-	u64 xfeatures = 0;
+	u64 user_xfeatures = 0;
 	int fx_only = 0;
 	int ret = 0;
 
@@ -314,7 +323,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			trace_x86_fpu_xstate_check_failed(fpu);
 		} else {
 			state_size = fx_sw_user.xstate_size;
-			xfeatures = fx_sw_user.xfeatures;
+			user_xfeatures = fx_sw_user.xfeatures;
 		}
 	}
 
@@ -349,7 +358,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 */
 		fpregs_lock();
 		pagefault_disable();
-		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
+		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
 		if (!ret) {
 			fpregs_mark_activate();
@@ -362,7 +371,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 
 	if (use_xsave() && !fx_only) {
-		u64 init_bv = xfeatures_mask_user() & ~xfeatures;
+		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
 		if (using_compacted_format()) {
 			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
@@ -375,12 +384,13 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		if (ret)
 			goto err_out;
 
-		sanitize_restored_xstate(&fpu->state, envp, xfeatures, fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
+					      fx_only);
 
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, xfeatures);
+		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, user_xfeatures);
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
@@ -389,7 +399,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			goto err_out;
 		}
 
-		sanitize_restored_xstate(&fpu->state, envp, xfeatures, fx_only);
+		sanitize_restored_user_xstate(&fpu->state, envp,
+					      user_xfeatures, fx_only);
 
 		fpregs_lock();
 		if (use_xsave()) {
-- 
2.21.0

