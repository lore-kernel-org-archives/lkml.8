Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F3C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEB9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgD2TKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:10:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:38220 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2TKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:10:40 -0400
IronPort-SDR: itTu7O2UbNKhqeLZjZEtp8dy35ePhY0MGsexvZ6UIs+Oce1o9qxn5RJc4PGviTfzoY2q090vBx
 sjyKZ9FsnLng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 12:10:40 -0700
IronPort-SDR: 8kITfram0gBDZT4mH/oCcj6diWpMSlMW+ywI/MNXXCBR9szUKoXiwQ4E1WvT0jBBENQXXkd+JF
 R5ux37E/z0sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="294268300"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2020 12:10:39 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 05/10] x86/fpu/xstate: Define new functions for clearing fpregs and xstates
Date:   Wed, 29 Apr 2020 12:10:03 -0700
Message-Id: <20200429191003.30036-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200328164307.17497-6-yu-cheng.yu@intel.com>
References: <20200328164307.17497-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Currently, fpu__clear() clears all fpregs and xstates.  Once XSAVES
supervisor states are introduced, supervisor settings (e.g. CET xstates)
must remain active for signals; It is necessary to have separate functions:

- Create fpu__clear_user_states(): clear only user settings for signals;
- Create fpu__clear_all(): clear both user and supervisor settings in
   flush_thread().

Also modify copy_init_fpstate_to_fpregs() to take a mask from above two
functions.

Remove obvious side-comment in fpu__clear(), while at it.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v3:
- Put common code into a static function fpu__clear(), with a parameter
  user_only.

v2:
- Fixed an issue where fpu__clear_user_states() drops supervisor xstates.
- Revise commit log.

 arch/x86/include/asm/fpu/internal.h |  3 +-
 arch/x86/kernel/fpu/core.c          | 49 +++++++++++++++++++----------
 arch/x86/kernel/fpu/signal.c        |  4 +--
 arch/x86/kernel/process.c           |  2 +-
 arch/x86/kernel/signal.c            |  2 +-
 5 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index ccb1bb32ad7d..a42fcb4b690d 100644
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
index 12c70840980e..7fddd5d60443 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -294,12 +294,10 @@ void fpu__drop(struct fpu *fpu)
  * Clear FPU registers by setting them up from
  * the init fpstate:
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
+static void fpu__clear(struct fpu *fpu, int user_only)
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
+	fpu__clear(fpu, 1);
+}
+
+void fpu__clear_all(struct fpu *fpu)
+{
+	fpu__clear(fpu, 0);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 3df0cfae535f..cd6eafba12da 100644
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
index 9da70b279dad..de182b84723a 100644
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
index 83b74fb38c8f..0052bbe5dfd4 100644
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
-- 
2.21.0

