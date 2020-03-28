Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B5C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3E20723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgC1LAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55535 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgC1LAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C4-0003bt-Pj; Sat, 28 Mar 2020 12:00:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 596451C0470;
        Sat, 28 Mar 2020 11:59:57 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:57 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: get rid of put_user_try in
 {ia32,x32}_setup_rt_frame()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319701.28353.6658289032826087569.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     39f16c1c0f14e9794545dbf6a64c909d5e16a2ea
Gitweb:        https://git.kernel.org/tip/39f16c1c0f14e9794545dbf6a64c909d5e16a2ea
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 18:39:17 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 19 Mar 2020 00:37:49 -04:00

x86: get rid of put_user_try in {ia32,x32}_setup_rt_frame()

Straightforward, except for compat_save_altstack_ex() stuck in those.
Replace that thing with an analogue that would use unsafe_put_user()
instead of put_user_ex() (called unsafe_compat_save_altstack()) and
be done with that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c | 50 ++++++++++++++++++------------------
 arch/x86/kernel/signal.c    | 33 +++++++++++++-----------
 include/linux/compat.h      |  9 +++---
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index af673ec..a96995a 100644
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
index 3b4ca48..29abad2 100644
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
index 11083d8..224ecb4 100644
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
