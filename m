Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A3C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1B206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgC1QoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:39985 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgC1QoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:44:01 -0400
IronPort-SDR: JH015GfkQNe7R5i9s5uAt/RmwnNl2JjEiKuPkh2Fww7ql8ukslKD56RrqnD89spYIdG9rX4yko
 lkrotWIxpixQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 09:43:59 -0700
IronPort-SDR: 4kmXup3fXjGiqEGSPQKZgCpaI0HHS7StNFhatMZcE9M35j/rmKBRS9W17eDbYpJ60qPsvG7O96
 KF0TFZVjn3hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447771187"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 09:43:59 -0700
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
Subject: [PATCH v3 10/10] x86/fpu/xstate: Restore supervisor states for signal return
Date:   Sat, 28 Mar 2020 09:43:07 -0700
Message-Id: <20200328164307.17497-11-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200328164307.17497-1-yu-cheng.yu@intel.com>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the previous patch, the signal return fast path directly
restores user states from the user buffer.  Once that succeeds, restore
supervisor states (but only when they are not yet restored).

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

v3:
- Change copy_xregs_to_kernel() to copy_supervisor_to_kernel(), which is
  introduced in a previous patch.
- Update commit log.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/fpu/signal.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 545ca4314096..4dad5afc938d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -347,6 +347,11 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
 		if (!ret) {
+			/* Restore supervisor states */
+			if (test_thread_flag(TIF_NEED_FPU_LOAD) &&
+			    xfeatures_mask_supervisor())
+				copy_kernel_to_xregs(&fpu->state.xsave,
+						     xfeatures_mask_supervisor());
 			fpregs_mark_activate();
 			fpregs_unlock();
 			return 0;
@@ -364,14 +369,21 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	}
 
 	/*
-	 * The current state of the FPU registers does not matter. By setting
-	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
-	 * is not modified on context switch and that the xstate is considered
+	 * Supervisor states are not modified by user space input.  Save
+	 * current supervisor states first.
+	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
+	 * not modified on context switch and that the xstate is considered
 	 * to be loaded again on return to userland (overriding last_cpu avoids
 	 * the optimisation).
 	 */
-	set_thread_flag(TIF_NEED_FPU_LOAD);
+	fpregs_lock();
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		if (xfeatures_mask_supervisor())
+			copy_supervisor_to_kernel(&fpu->state.xsave);
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+	}
 	__fpu_invalidate_fpregs_state(fpu);
+	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
@@ -393,7 +405,12 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, user_xfeatures);
+		/*
+		 * Restore previously saved supervisor xstates along with
+		 * copied-in user xstates.
+		 */
+		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
+					       user_xfeatures | xfeatures_mask_supervisor());
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
-- 
2.21.0

