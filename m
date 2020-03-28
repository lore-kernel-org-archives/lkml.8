Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C86C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE88206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgC1Qo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:39985 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgC1QoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:44:01 -0400
IronPort-SDR: WTRNRXFcjJGz1aOQtSMSaoNuoTrtaIWS6dMpRVkNtS2EuunMaOkQMUv15YcqsEy3mDVm/h3ipB
 A+5nX57ZmMxg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 09:43:59 -0700
IronPort-SDR: SdGokYdutrkh7muRZKTD8uLS4BGv9nABmxBsyKvY78eKn5Rw5R9w//vc1XZd7FZMrUJtUW0LgZ
 UGwtIlpexqOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447771185"
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
Subject: [PATCH v3 09/10] x86/fpu/xstate: Preserve supervisor states for slow path of __fpu__restore_sig()
Date:   Sat, 28 Mar 2020 09:43:06 -0700
Message-Id: <20200328164307.17497-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200328164307.17497-1-yu-cheng.yu@intel.com>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signal return code is responsible for taking an XSAVE buffer present
in user memory and loading it into the hardware registers.  This
operation only affects user XSAVE state and never affects supervisor state.

The fast path through this code simply points XRSTOR directly at the
user buffer.  However, due to page faults, this XRSTOR can fail.  If it
fails, the signal return code falls back to a slow path which can
tolerate page faults.

That slow path copies the xfeatures one by one out of the user buffer
into the task's fpu state area.  However, by being in a context where it
can handle page faults, the code can also schedule.  That exposes us to
the whims of the lazy-fpu-load code.  That code currently can not
comprehend valid fpregs (the supervisor state) mixed with the *not*
valid user fpregs.  To do that, we would need to track whether
individual XSAVE components had valid fpregs or fpstate.

If we left the current code in place, the context-switch code would
think it has an up-to-date fpstate and would fail to save the supervisor
state when scheduling the task out.  When scheduling back in, it would
likely restore stale supervisor state.

To fix that, we need to save the supervisor state before the slow path.
That way, the supervisor state is always up-to-date and the task can
survive being scheduled.

Modify copy_user_to_fpregs_zeroing() so that if it fails, fpregs are not
zeroed, and there is no need for fpregs_deactivate() and supervisor states
are preserved.

Move set_thread_flag(TIF_NEED_FPU_LOAD) to the slow path.  Without doing
this, the fast path also needs supervisor states to be saved first.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/fpu/signal.c | 53 +++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d09d72334a12..545ca4314096 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -262,19 +262,23 @@ sanitize_restored_user_xstate(union fpregs_state *state,
 static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 {
 	u64 init_bv;
+	int r;
 
 	if (use_xsave()) {
 		if (fx_only) {
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
 
-			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_fxregs(buf);
+			r = copy_user_to_fxregs(buf);
+			if (!r)
+				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
+			return r;
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
-			if (unlikely(init_bv))
+			r = copy_user_to_xregs(buf, xbv);
+			if (!r && unlikely(init_bv))
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
-			return copy_user_to_xregs(buf, xbv);
+			return r;
 		}
 	} else if (use_fxsr()) {
 		return copy_user_to_fxregs(buf);
@@ -327,28 +331,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		}
 	}
 
-	/*
-	 * The current state of the FPU registers does not matter. By setting
-	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
-	 * is not modified on context switch and that the xstate is considered
-	 * to be loaded again on return to userland (overriding last_cpu avoids
-	 * the optimisation).
-	 */
-	set_thread_flag(TIF_NEED_FPU_LOAD);
-	__fpu_invalidate_fpregs_state(fpu);
-
 	if ((unsigned long)buf_fx % 64)
 		fx_only = 1;
-	/*
-	 * For 32-bit frames with fxstate, copy the fxstate so it can be
-	 * reconstructed later.
-	 */
-	if (ia32_fxstate) {
-		ret = __copy_from_user(&env, buf, sizeof(env));
-		if (ret)
-			goto err_out;
-		envp = &env;
-	} else {
+
+	if (!ia32_fxstate) {
 		/*
 		 * Attempt to restore the FPU registers directly from user
 		 * memory. For that to succeed, the user access cannot cause
@@ -365,10 +351,27 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			fpregs_unlock();
 			return 0;
 		}
-		fpregs_deactivate(fpu);
 		fpregs_unlock();
+	} else {
+		/*
+		 * For 32-bit frames with fxstate, copy the fxstate so it can
+		 * be reconstructed later.
+		 */
+		ret = __copy_from_user(&env, buf, sizeof(env));
+		if (ret)
+			goto err_out;
+		envp = &env;
 	}
 
+	/*
+	 * The current state of the FPU registers does not matter. By setting
+	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
+	 * is not modified on context switch and that the xstate is considered
+	 * to be loaded again on return to userland (overriding last_cpu avoids
+	 * the optimisation).
+	 */
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	__fpu_invalidate_fpregs_state(fpu);
 
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
-- 
2.21.0

