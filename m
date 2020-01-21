Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E306C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E028124656
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgAUUUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:20:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:7229 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgAUUUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:20:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 12:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="307313121"
Received: from yyu32-desk.sc.intel.com ([143.183.136.51])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2020 12:20:04 -0800
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
Subject: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for __fpu__restore_sig()
Date:   Tue, 21 Jan 2020 12:18:43 -0800
Message-Id: <20200121201843.12047-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200121201843.12047-1-yu-cheng.yu@intel.com>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When returning from a signal, there is user state in a userspace memory
buffer and supervisor state in registers.  The in-kernel buffer has neither
valid user or supervisor state.  To restore both, save supervisor fpregs
first (and protect them across context switches), then restore it along
with user state.

This patch introduces saving and restoring of supervisor xstates for a
sigreturn in the following steps:

- Preserve supervisor register values by saving the whole fpu xstates.
  Saving the whole is necessary because doing XSAVES with a partial
  requested-feature bitmap (RFBM) changes xcomp_bv.  Since user xstates are
  to be restored from a user buffer, saved user xstates are discarded.

- Set TIF_NEED_FPU_LOAD, and do __fpu_invalidate_fpregs_state().
  This prevents a context switch from corrupting the saved xstates,
  and xstate is considered to be loaded again on return to userland.

- Under fpregs_lock(), restore user xstates (from the user buffer), and
  then supervisor xstates (from previously saved content).

- When both parts of the restoration succeed, mark fpregs as valid.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/fpu/signal.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index e3781a4a52a8..0d3e06a772b0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -327,14 +327,22 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	}
 
 	/*
-	 * The current state of the FPU registers does not matter. By setting
-	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
-	 * is not modified on context switch and that the xstate is considered
+	 * Supervisor xstates are not modified by user space input, and
+	 * need to be saved and restored.  Save the whole because doing
+	 * partial XSAVES changes xcomp_bv.
+	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
+	 * not modified on context switch and that the xstate is considered
 	 * to be loaded again on return to userland (overriding last_cpu avoids
 	 * the optimisation).
 	 */
-	set_thread_flag(TIF_NEED_FPU_LOAD);
+	fpregs_lock();
+	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		if (xfeatures_mask_supervisor())
+			copy_xregs_to_kernel(&fpu->state.xsave);
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+	}
 	__fpu_invalidate_fpregs_state(fpu);
+	fpregs_unlock();
 
 	if ((unsigned long)buf_fx % 64)
 		fx_only = 1;
@@ -360,6 +368,9 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures_user, fx_only);
 		pagefault_enable();
 		if (!ret) {
+			if (xfeatures_mask_supervisor())
+				copy_kernel_to_xregs(&fpu->state.xsave,
+						     xfeatures_mask_supervisor());
 			fpregs_mark_activate();
 			fpregs_unlock();
 			return 0;
@@ -389,7 +400,12 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		fpregs_lock();
 		if (unlikely(init_bv))
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, xfeatures_user);
+		/*
+		 * Restore previously saved supervisor xstates along with
+		 * copied-in user xstates.
+		 */
+		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
+					       xfeatures_user | xfeatures_mask_supervisor());
 
 	} else if (use_fxsr()) {
 		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
-- 
2.21.0

