Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31055C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074C220716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1LAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55510 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgC1K76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:59:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9Bz-0003ai-TS; Sat, 28 Mar 2020 11:59:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 896A41C0483;
        Sat, 28 Mar 2020 11:59:55 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:55 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: get rid of put_user_try in
 __setup_rt_frame() (both 32bit and 64bit)
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319521.28353.15028720201420918121.tip-bot2@tip-bot2>
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

Commit-ID:     119cd59fcfbe70fb3fcab4e64cd232bcc3807585
Gitweb:        https://git.kernel.org/tip/119cd59fcfbe70fb3fcab4e64cd232bcc3807585
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 19:54:56 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Thu, 26 Mar 2020 14:41:22 -04:00

x86: get rid of put_user_try in __setup_rt_frame() (both 32bit and 64bit)

Straightforward, except for save_altstack_ex() stuck in those.
Replace that thing with an analogue that would use unsafe_put_user()
instead of put_user_ex() (called compat_save_altstack()) and be done
with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 91 ++++++++++++++++++++-------------------
 include/linux/signal.h   |  8 +--
 2 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 29abad2..8b879fd 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -365,38 +365,37 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 
 	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fpstate);
 
-	if (!access_ok(frame, sizeof(*frame)))
+	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	put_user_try {
-		put_user_ex(sig, &frame->sig);
-		put_user_ex(&frame->info, &frame->pinfo);
-		put_user_ex(&frame->uc, &frame->puc);
+	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(&frame->info, &frame->pinfo, Efault);
+	unsafe_put_user(&frame->uc, &frame->puc, Efault);
 
-		/* Create the ucontext.  */
-		if (static_cpu_has(X86_FEATURE_XSAVE))
-			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
-		else
-			put_user_ex(0, &frame->uc.uc_flags);
-		put_user_ex(0, &frame->uc.uc_link);
-		save_altstack_ex(&frame->uc.uc_stack, regs->sp);
+	/* Create the ucontext.  */
+	if (static_cpu_has(X86_FEATURE_XSAVE))
+		unsafe_put_user(UC_FP_XSTATE, &frame->uc.uc_flags, Efault);
+	else
+		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
 
-		/* Set up to return from userspace.  */
-		restorer = current->mm->context.vdso +
-			vdso_image_32.sym___kernel_rt_sigreturn;
-		if (ksig->ka.sa.sa_flags & SA_RESTORER)
-			restorer = ksig->ka.sa.sa_restorer;
-		put_user_ex(restorer, &frame->pretcode);
+	/* Set up to return from userspace.  */
+	restorer = current->mm->context.vdso +
+		vdso_image_32.sym___kernel_rt_sigreturn;
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
+	unsafe_put_user(restorer, &frame->pretcode, Efault);
 
-		/*
-		 * This is movl $__NR_rt_sigreturn, %ax ; int $0x80
-		 *
-		 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-		 * reasons and because gdb uses it as a signature to notice
-		 * signal handler stack frames.
-		 */
-		put_user_ex(*((u64 *)&rt_retcode), (u64 *)frame->retcode);
-	} put_user_catch(err);
+	/*
+	 * This is movl $__NR_rt_sigreturn, %ax ; int $0x80
+	 *
+	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
+	 * reasons and because gdb uses it as a signature to notice
+	 * signal handler stack frames.
+	 */
+	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
+	user_access_end();
 	
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
@@ -419,6 +418,9 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	regs->cs = __USER_CS;
 
 	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 #else /* !CONFIG_X86_32 */
 static unsigned long frame_uc_flags(struct pt_regs *regs)
@@ -444,6 +446,10 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	unsigned long uc_flags;
 	int err = 0;
 
+	/* x86-64 should always use SA_RESTORER. */
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
 	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
 
 	if (!access_ok(frame, sizeof(*frame)))
@@ -455,23 +461,18 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	}
 
 	uc_flags = frame_uc_flags(regs);
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
 
-	put_user_try {
-		/* Create the ucontext.  */
-		put_user_ex(uc_flags, &frame->uc.uc_flags);
-		put_user_ex(0, &frame->uc.uc_link);
-		save_altstack_ex(&frame->uc.uc_stack, regs->sp);
-
-		/* Set up to return from userspace.  If provided, use a stub
-		   already in userspace.  */
-		/* x86-64 should always use SA_RESTORER. */
-		if (ksig->ka.sa.sa_flags & SA_RESTORER) {
-			put_user_ex(ksig->ka.sa.sa_restorer, &frame->pretcode);
-		} else {
-			/* could use a vstub here */
-			err |= -EFAULT;
-		}
-	} put_user_catch(err);
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+
+	/* Set up to return from userspace.  If provided, use a stub
+	   already in userspace.  */
+	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
+	user_access_end();
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
 	err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
@@ -515,6 +516,10 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 		force_valid_ss(regs);
 
 	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 #endif /* CONFIG_X86_32 */
 
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 1a5f883..05bacd2 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -444,12 +444,12 @@ void signals_init(void);
 int restore_altstack(const stack_t __user *);
 int __save_altstack(stack_t __user *, unsigned long);
 
-#define save_altstack_ex(uss, sp) do { \
+#define unsafe_save_altstack(uss, sp, label) do { \
 	stack_t __user *__uss = uss; \
 	struct task_struct *t = current; \
-	put_user_ex((void __user *)t->sas_ss_sp, &__uss->ss_sp); \
-	put_user_ex(t->sas_ss_flags, &__uss->ss_flags); \
-	put_user_ex(t->sas_ss_size, &__uss->ss_size); \
+	unsafe_put_user((void __user *)t->sas_ss_sp, &__uss->ss_sp, label); \
+	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
+	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
 	if (t->sas_ss_flags & SS_AUTODISARM) \
 		sas_ss_reset(t); \
 } while (0);
