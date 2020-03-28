Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4414DC2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CE42073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgC1Qog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:39985 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgC1QoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:44:00 -0400
IronPort-SDR: Cn4ZBHMxixinauIH5Qp41bndEX7a5rXEu6pzqgsoUCZuogRVoEIeRUQGEtLpiZYp4ngh2+Datd
 tv8AqlnrUHoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 09:43:58 -0700
IronPort-SDR: ssYiABuChWxonrxpoGpKETuUufZccGyrFbUSa23iSRE1tf3rNRQuN34m++KEv/l8YroiCTyDR1
 XopJLlf1FACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447771171"
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
Subject: [PATCH v3 05/10] x86/fpu/xstate: Define new functions for clearing fpregs and xstates
Date:   Sat, 28 Mar 2020 09:43:02 -0700
Message-Id: <20200328164307.17497-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200328164307.17497-1-yu-cheng.yu@intel.com>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
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

v3:
- Put common code into a static function fpu__clear(), with a parameter
  clear_user_only.

v2:
- Fixed an issue where fpu__clear_user_states() drops supervisor xstates.
- Revise commit log.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
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
index 12c70840980e..6ba3a8b78bf9 100644
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
+static void fpu__clear(struct fpu *fpu, int clear_user_only)
 {
-	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
+	if (static_cpu_has(X86_FEATURE_FPU)) {
+		fpregs_lock();
+
+		if (clear_user_only) {
+			if (!fpregs_state_valid(fpu, smp_processor_id()) &&
+			    xfeatures_mask_supervisor())
+				copy_kernel_to_xregs(&fpu->state.xsave,
+						     xfeatures_mask_supervisor());
+			copy_init_fpstate_to_fpregs(xfeatures_mask_user());
+		} else {
+			copy_init_fpstate_to_fpregs(xfeatures_mask_all);
+		}
+
+		fpregs_mark_activate();
+		fpregs_unlock();
+		return;
+	} else {
+		fpu__drop(fpu);
+		fpu__initialize(fpu);
+	}
+}
 
-	fpu__drop(fpu);
+void fpu__clear_user_states(struct fpu *fpu)
+{
+	WARN_ON_FPU(fpu != &current->thread.fpu);
+	fpu__clear(fpu, 1);
+}
 
-	/*
-	 * Make sure fpstate is cleared and initialized.
-	 */
-	fpu__initialize(fpu);
-	if (static_cpu_has(X86_FEATURE_FPU))
-		copy_init_fpstate_to_fpregs();
+void fpu__clear_all(struct fpu *fpu)
+{
+	WARN_ON_FPU(fpu != &current->thread.fpu);
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
index 3053c85e0e42..87de18c64cf5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -192,7 +192,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear(&tsk->thread.fpu);
+	fpu__clear_all(&tsk->thread.fpu);
 }
 
 void disable_TSC(void)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8a29573851a3..35f878e9f91d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -761,7 +761,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
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

