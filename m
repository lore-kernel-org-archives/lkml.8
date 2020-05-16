Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C40C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4049820709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 15:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEPPKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgEPPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 11:10:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084FC05BD09;
        Sat, 16 May 2020 08:10:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZySA-0000rW-Ih; Sat, 16 May 2020 17:10:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 083291C06E5;
        Sat, 16 May 2020 17:10:18 +0200 (CEST)
Date:   Sat, 16 May 2020 15:10:17 -0000
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512145444.15483-6-yu-cheng.yu@intel.com>
References: <20200512145444.15483-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Message-ID: <158964181793.17951.15480349640697746223.tip-bot2@tip-bot2>
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

Commit-ID:     b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94
Gitweb:        https://git.kernel.org/tip/b860eb8dce5906b14e3a7f3c771e0b3d6ef61b94
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Tue, 12 May 2020 07:54:39 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 May 2020 13:41:50 +02:00

x86/fpu/xstate: Define new functions for clearing fpregs and xstates

Currently, fpu__clear() clears all fpregs and xstates.  Once XSAVES
supervisor states are introduced, supervisor settings (e.g. CET xstates)
must remain active for signals; It is necessary to have separate functions:

- Create fpu__clear_user_states(): clear only user settings for signals;
- Create fpu__clear_all(): clear both user and supervisor settings in
   flush_thread().

Also modify copy_init_fpstate_to_fpregs() to take a mask from above two
functions.

Remove obvious side-comment in fpu__clear(), while at it.

 [ bp: Make the second argument of fpu__clear() bool after requesting it
   a bunch of times during review.
  - Add a comment about copy_init_fpstate_to_fpregs() locking needs. ]

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200512145444.15483-6-yu-cheng.yu@intel.com
---
 arch/x86/include/asm/fpu/internal.h |  3 +-
 arch/x86/kernel/fpu/core.c          | 53 ++++++++++++++++++----------
 arch/x86/kernel/fpu/signal.c        |  4 +-
 arch/x86/kernel/process.c           |  2 +-
 arch/x86/kernel/signal.c            |  2 +-
 5 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index ccb1bb3..a42fcb4 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -31,7 +31,8 @@ extern void fpu__save(struct fpu *fpu);
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
-extern void fpu__clear(struct fpu *fpu);
+extern void fpu__clear_user_states(struct fpu *fpu);
+extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 12c7084..06c8189 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -291,15 +291,13 @@ void fpu__drop(struct fpu *fpu)
 }
 
 /*
- * Clear FPU registers by setting them up from
- * the init fpstate:
+ * Clear FPU registers by setting them up from the init fpstate.
+ * Caller must do fpregs_[un]lock() around it.
  */
-static inline void copy_init_fpstate_to_fpregs(void)
+static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
 {
-	fpregs_lock();
-
 	if (use_xsave())
-		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
+		copy_kernel_to_xregs(&init_fpstate.xsave, features_mask);
 	else if (static_cpu_has(X86_FEATURE_FXSR))
 		copy_kernel_to_fxregs(&init_fpstate.fxsave);
 	else
@@ -307,9 +305,6 @@ static inline void copy_init_fpstate_to_fpregs(void)
 
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
 		copy_init_pkru_to_fpregs();
-
-	fpregs_mark_activate();
-	fpregs_unlock();
 }
 
 /*
@@ -318,18 +313,40 @@ static inline void copy_init_fpstate_to_fpregs(void)
  * Called by sys_execve(), by the signal handler code and by various
  * error paths.
  */
-void fpu__clear(struct fpu *fpu)
+static void fpu__clear(struct fpu *fpu, bool user_only)
 {
-	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
+	WARN_ON_FPU(fpu != &current->thread.fpu);
 
-	fpu__drop(fpu);
+	if (!static_cpu_has(X86_FEATURE_FPU)) {
+		fpu__drop(fpu);
+		fpu__initialize(fpu);
+		return;
+	}
 
-	/*
-	 * Make sure fpstate is cleared and initialized.
-	 */
-	fpu__initialize(fpu);
-	if (static_cpu_has(X86_FEATURE_FPU))
-		copy_init_fpstate_to_fpregs();
+	fpregs_lock();
+
+	if (user_only) {
+		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
+		    xfeatures_mask_supervisor())
+			copy_kernel_to_xregs(&fpu->state.xsave,
+					     xfeatures_mask_supervisor());
+		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
+	} else {
+		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+	}
+
+	fpregs_mark_activate();
+	fpregs_unlock();
+}
+
+void fpu__clear_user_states(struct fpu *fpu)
+{
+	fpu__clear(fpu, true);
+}
+
+void fpu__clear_all(struct fpu *fpu)
+{
+	fpu__clear(fpu, false);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 3df0cfa..cd6eafb 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -289,7 +289,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			 IS_ENABLED(CONFIG_IA32_EMULATION));
 
 	if (!buf) {
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 		return 0;
 	}
 
@@ -416,7 +416,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 
 err_out:
 	if (ret)
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 	return ret;
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9da70b2..de182b8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -191,7 +191,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear(&tsk->thread.fpu);
+	fpu__clear_all(&tsk->thread.fpu);
 }
 
 void disable_TSC(void)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 83b74fb..0052bbe 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -732,7 +732,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		/*
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
-		fpu__clear(fpu);
+		fpu__clear_user_states(fpu);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
