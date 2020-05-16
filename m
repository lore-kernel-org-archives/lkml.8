Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A90C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0807206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgEPPK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEPPK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EFDC05BD0A;
        Sat, 16 May 2020 08:10:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZyS9-0000rM-VK; Sat, 16 May 2020 17:10:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 03F091C01BB;
        Sat, 16 May 2020 17:10:16 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:15 -0000
From:   "tip-bot2 for Yu-cheng Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Restore supervisor states for signal return
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-11-yu-cheng.yu@intel.com>
References: <20200512145444.15483-11-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181586.17951.14503333423157907999.tip-bot2@tip-bot2>
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

Commit-ID:     55e00fb66fd5048f4a3ee357018fd26fc527abca
Gitweb:        https://git.kernel.org/tip/55e00fb66fd5048f4a3ee357018fd26fc527abca
Author:        Yu-cheng Yu <yu-cheng.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:44 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 16 May 2020 12:20:50 +02:00

x86/fpu/xstate: Restore supervisor states for signal return

The signal return fast path directly restores user states from the user
buffer. Once that succeeds, restore supervisor states (but only when
they are not yet restored).

For the slow path, save supervisor states to preserve them across context
switches, and restore after the user states are restored.

The previous version has the overhead of an XSAVES in both the fast and the
slow paths.  It is addressed as the following:

- In the fast path, only do an XRSTORS.
- In the slow path, do a supervisor-state-only XSAVES, and relocate the
  buffer contents.

Some thoughts in the implementation:

- In the slow path, can any supervisor state become stale between
  save/restore?

  Answer: set_thread_flag(TIF_NEED_FPU_LOAD) protects the xstate buffer.

- In the slow path, can any code reference a stale supervisor state
  register between save/restore?

  Answer: In the current lazy-restore scheme, any reference to xstate
  registers needs fpregs_lock()/fpregs_unlock() and __fpregs_load_activate().

- Are there other options?

  One other option is eagerly restoring all supervisor states.

  Currently, CET user-mode states and ENQCMD's PASID do not need to be
  eagerly restored.  The upcoming CET kernel-mode states (24 bytes) need
  to be eagerly restored.  To me, eagerly restoring all supervisor states
  adds more overhead then benefit at this point.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20200512145444.15483-11-yu-cheng.yu@intel.com
---
 arch/x86/kernel/fpu/signal.c | 44 +++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 6184fe7..9393a44 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -347,6 +347,23 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
 		if (!ret) {
+
+			/*
+			 * Restore supervisor states: previous context switch
+			 * etc has done XSAVES and saved the supervisor states
+			 * in the kernel buffer from which they can be restored
+			 * now.
+			 *
+			 * We cannot do a single XRSTORS here - which would
+			 * be nice - because the rest of the FPU registers are
+			 * being restored from a user buffer directly. The
+			 * single XRSTORS happens below, when the user buffer
+			 * has been copied to the kernel one.
+			 */
+			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
+			    xfeatures_mask_supervisor())
+				copy_kernel_to_xregs(&fpu->state.xsave,
+						     xfeatures_mask_supervisor());
 			fpregs_mark_activate();
 			fpregs_unlock();
 			return 0;
@@ -364,14 +381,25 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	}
 
 	/*
-	 * The current state of the FPU registers does not matter. By setting
-	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
-	 * is not modified on context switch and that the xstate is considered
+	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
+	 * not modified on context switch and that the xstate is considered
 	 * to be loaded again on return to userland (overriding last_cpu avoids
 	 * the optimisation).
 	 */
-	set_thread_flag(TIF_NEED_FPU_LOAD);
+	fpregs_lock();
+
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+
+		/*
+		 * Supervisor states are not modified by user space input.  Save
+		 * current supervisor states first and invalidate the FPU regs.
+		 */
+		if (xfeatures_mask_supervisor())
+			copy_supervisor_to_kernel(&fpu->state.xsave);
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+	}
 	__fpu_invalidate_fpregs_state(fpu);
+	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
@@ -393,7 +421,13 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, user_xfeatures);
+
+		/*
+		 * Restore previously saved supervisor xstates along with
+		 * copied-in user xstates.
+		 */
+		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
+					       user_xfeatures | xfeatures_mask_supervisor());
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
