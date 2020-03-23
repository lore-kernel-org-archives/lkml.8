Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC5CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741652072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgCWSjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:39:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46724 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgCWSiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:24 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGRxt-001364-Oa; Mon, 23 Mar 2020 18:38:21 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 12/22] x86: get rid of put_user_try in {ia32,x32}_setup_rt_frame()
Date:   Mon, 23 Mar 2020 18:38:09 +0000
Message-Id: <20200323183819.250124-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Straightforward, except for compat_save_altstack_ex() stuck in those.
Replace that thing with an analogue that would use unsafe_put_user()
instead of put_user_ex() (called unsafe_compat_save_altstack()) and
be done with that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 50 +++++++++++++++++++++++----------------------
 arch/x86/kernel/signal.c    | 33 ++++++++++++++++--------------
 include/linux/compat.h      |  9 ++++----
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index af673ec23a2d..a96995aa23da 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -326,35 +326,34 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 
 	frame = get_sigframe(ksig, regs, sizeof(*frame), &fpstate);
 
-	if (!access_ok(frame, sizeof(*frame)))
+	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	put_user_try {
-		put_user_ex(sig, &frame->sig);
-		put_user_ex(ptr_to_compat(&frame->info), &frame->pinfo);
-		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
+	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ptr_to_compat(&frame->info), &frame->pinfo, Efault);
+	unsafe_put_user(ptr_to_compat(&frame->uc), &frame->puc, Efault);
 
-		/* Create the ucontext.  */
-		if (static_cpu_has(X86_FEATURE_XSAVE))
-			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
-		else
-			put_user_ex(0, &frame->uc.uc_flags);
-		put_user_ex(0, &frame->uc.uc_link);
-		compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
+	/* Create the ucontext.  */
+	if (static_cpu_has(X86_FEATURE_XSAVE))
+		unsafe_put_user(UC_FP_XSTATE, &frame->uc.uc_flags, Efault);
+	else
+		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
 
-		if (ksig->ka.sa.sa_flags & SA_RESTORER)
-			restorer = ksig->ka.sa.sa_restorer;
-		else
-			restorer = current->mm->context.vdso +
-				vdso_image_32.sym___kernel_rt_sigreturn;
-		put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
+	else
+		restorer = current->mm->context.vdso +
+			vdso_image_32.sym___kernel_rt_sigreturn;
+	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
 
-		/*
-		 * Not actually used anymore, but left because some gdb
-		 * versions need it.
-		 */
-		put_user_ex(*((u64 *)&code), (u64 __user *)frame->retcode);
-	} put_user_catch(err);
+	/*
+	 * Not actually used anymore, but left because some gdb
+	 * versions need it.
+	 */
+	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
+	user_access_end();
 
 	err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
 	err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
@@ -380,4 +379,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	regs->ss = __USER32_DS;
 
 	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 3b4ca484cfc2..29abad29aaa1 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -529,6 +529,9 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 	int err = 0;
 	void __user *fpstate = NULL;
 
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
 	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
 
 	if (!access_ok(frame, sizeof(*frame)))
@@ -541,22 +544,17 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 
 	uc_flags = frame_uc_flags(regs);
 
-	put_user_try {
-		/* Create the ucontext.  */
-		put_user_ex(uc_flags, &frame->uc.uc_flags);
-		put_user_ex(0, &frame->uc.uc_link);
-		compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
-		put_user_ex(0, &frame->uc.uc__pad0);
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
 
-		if (ksig->ka.sa.sa_flags & SA_RESTORER) {
-			restorer = ksig->ka.sa.sa_restorer;
-		} else {
-			/* could use a vstub here */
-			restorer = NULL;
-			err |= -EFAULT;
-		}
-		put_user_ex(restorer, (unsigned long __user *)&frame->pretcode);
-	} put_user_catch(err);
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
+	restorer = ksig->ka.sa.sa_restorer;
+	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
+	user_access_end();
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
 				regs, set->sig[0]);
@@ -582,6 +580,11 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 #endif	/* CONFIG_X86_X32_ABI */
 
 	return 0;
+#ifdef CONFIG_X86_X32_ABI
+Efault:
+	user_access_end();
+	return -EFAULT;
+#endif
 }
 
 /*
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 11083d84eb23..224ecb4fffd4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -483,12 +483,13 @@ extern void __user *compat_alloc_user_space(unsigned long len);
 
 int compat_restore_altstack(const compat_stack_t __user *uss);
 int __compat_save_altstack(compat_stack_t __user *, unsigned long);
-#define compat_save_altstack_ex(uss, sp) do { \
+#define unsafe_compat_save_altstack(uss, sp, label) do { \
 	compat_stack_t __user *__uss = uss; \
 	struct task_struct *t = current; \
-	put_user_ex(ptr_to_compat((void __user *)t->sas_ss_sp), &__uss->ss_sp); \
-	put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
-	put_user_ex(t->sas_ss_size, &__uss->ss_size); \
+	unsafe_put_user(ptr_to_compat((void __user *)t->sas_ss_sp), \
+			&__uss->ss_sp, label); \
+	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
+	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
 	if (t->sas_ss_flags & SS_AUTODISARM) \
 		sas_ss_reset(t); \
 } while (0);
-- 
2.11.0

