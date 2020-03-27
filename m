Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E19C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5642082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgC0Ccf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:32:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48042 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgC0CcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:32:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHen1-003hSH-3o; Fri, 27 Mar 2020 02:32:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 16/22] x86: get rid of put_user_try in __setup_rt_frame() (both 32bit and 64bit)
Date:   Fri, 27 Mar 2020 02:31:59 +0000
Message-Id: <20200327023205.881896-16-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
References: <20200327023007.GS23230@ZenIV.linux.org.uk>
 <20200327023205.881896-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Straightforward, except for save_altstack_ex() stuck in those.
Replace that thing with an analogue that would use unsafe_put_user()
instead of put_user_ex() (called compat_save_altstack()) and be done
with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kernel/signal.c | 91 +++++++++++++++++++++++++-----------------------
 include/linux/signal.h   |  8 ++---
 2 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 29abad29aaa1..8b879fdc214c 100644
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
index 1a5f88316b08..05bacd2ab135 100644
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
-- 
2.11.0

