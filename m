Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5342C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC3120709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgEPPKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEPPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A280C061A0C;
        Sat, 16 May 2020 08:10:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZySA-0000rU-Jk; Sat, 16 May 2020 17:10:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9A8DB1C06DA;
        Sat, 16 May 2020 17:10:17 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:17 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Update sanitize_restored_xstate() for
 supervisor xstates
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-7-yu-cheng.yu@intel.com>
References: <20200512145444.15483-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181752.17951.5308875754899881553.tip-bot2@tip-bot2>
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

Commit-ID:     5d6b6a6f9b5ce7ac42273efd75d61ec63b463c18
Gitweb:        https://git.kernel.org/tip/5d6b6a6f9b5ce7ac42273efd75d61ec63b463c18
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:40 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 May 2020 20:11:08 +02:00

x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor xstates

The function sanitize_restored_xstate() sanitizes user xstates of an XSAVE
buffer by clearing bits not in the input 'xfeatures' from the buffer's
header->xfeatures, effectively resetting those features back to the init
state.

When supervisor xstates are introduced, it is necessary to make sure only
user xstates are sanitized.  Ensure supervisor bits in header->xfeatures
stay set and supervisor states are not modified.

To make names clear, also:

- Rename the function to sanitize_restored_user_xstate().
- Rename input parameter 'xfeatures' to 'user_xfeatures'.
- In __fpu__restore_sig(), rename 'xfeatures' to 'user_xfeatures'.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200512145444.15483-7-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/signal.c | 37 ++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index cd6eafb..77e5c2e 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -211,9 +211,9 @@ retry:
 }
 
 static inline void
-sanitize_restored_xstate(union fpregs_state *state,
-			 struct user_i387_ia32_struct *ia32_env,
-			 u64 xfeatures, int fx_only)
+sanitize_restored_user_xstate(union fpregs_state *state,
+			      struct user_i387_ia32_struct *ia32_env,
+			      u64 user_xfeatures, int fx_only)
 {
 	struct xregs_state *xsave = &state->xsave;
 	struct xstate_header *header = &xsave->header;
@@ -226,13 +226,22 @@ sanitize_restored_xstate(union fpregs_state *state,
 		 */
 
 		/*
-		 * Init the state that is not present in the memory
-		 * layout and not enabled by the OS.
+		 * 'user_xfeatures' might have bits clear which are
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
+			header->xfeatures &= user_xfeatures |
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
+		sanitize_restored_user_xstate(&fpu->state, envp, user_xfeatures,
+					      fx_only);
 
 		fpregs_lock();
 		if (use_xsave()) {
