Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6EBC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948320716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgC1LAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55557 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgC1LAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C7-0003ew-SJ; Sat, 28 Mar 2020 12:00:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 61B491C0470;
        Sat, 28 Mar 2020 12:00:01 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:00:00 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: switch sigframe sigset handling to explict
 __get_user()/__put_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539320093.28353.2717834444858954380.tip-bot2@tip-bot2>
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

Commit-ID:     71c3313a38aa09339a2442809e658fd233ab0757
Gitweb:        https://git.kernel.org/tip/71c3313a38aa09339a2442809e658fd233ab0757
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 11:43:18 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 15:29:54 -04:00

x86: switch sigframe sigset handling to explict __get_user()/__put_user()

... and consolidate the definition of sigframe_ia32->extramask - it's
always a 1-element array of 32bit unsigned.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/ia32/ia32_signal.c     | 16 +++++-----------
 arch/x86/include/asm/sigframe.h |  6 +-----
 arch/x86/kernel/signal.c        | 20 ++++++++------------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index a3aefe9..c72025d 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -126,10 +126,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	if (__get_user(set.sig[0], &frame->sc.oldmask)
-	    || (_COMPAT_NSIG_WORDS > 1
-		&& __copy_from_user((((char *) &set.sig) + 4),
-				    &frame->extramask,
-				    sizeof(frame->extramask))))
+	    || __get_user(((__u32 *)&set)[1], &frame->extramask[0]))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -153,7 +150,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -277,11 +274,8 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	if (ia32_setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
 		return -EFAULT;
 
-	if (_COMPAT_NSIG_WORDS > 1) {
-		if (__copy_to_user(frame->extramask, &set->sig[1],
-				   sizeof(frame->extramask)))
-			return -EFAULT;
-	}
+	if (__put_user(set->sig[1], &frame->extramask[0]))
+		return -EFAULT;
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		restorer = ksig->ka.sa.sa_restorer;
@@ -381,7 +375,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	err |= __copy_siginfo_to_user32(&frame->info, &ksig->info, false);
 	err |= ia32_setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
 				     regs, set->sig[0]);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
 	if (err)
 		return -EFAULT;
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index f176114..84eab27 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -33,11 +33,7 @@ struct sigframe_ia32 {
 	 * legacy application accessing/modifying it.
 	 */
 	struct _fpstate_32 fpstate_unused;
-#ifdef CONFIG_IA32_EMULATION
-	unsigned int extramask[_COMPAT_NSIG_WORDS-1];
-#else /* !CONFIG_IA32_EMULATION */
-	unsigned long extramask[_NSIG_WORDS-1];
-#endif /* CONFIG_IA32_EMULATION */
+	unsigned int extramask[1];
 	char retcode[8];
 	/* fp state follows here */
 };
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8a29573..53ac66b 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -326,11 +326,8 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (setup_sigcontext(&frame->sc, fpstate, regs, set->sig[0]))
 		return -EFAULT;
 
-	if (_NSIG_WORDS > 1) {
-		if (__copy_to_user(&frame->extramask, &set->sig[1],
-				   sizeof(frame->extramask)))
-			return -EFAULT;
-	}
+	if (__put_user(set->sig[1], &frame->extramask[0]))
+		return -EFAULT;
 
 	if (current->mm->context.vdso)
 		restorer = current->mm->context.vdso +
@@ -489,7 +486,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	} put_user_catch(err);
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
 
 	if (err)
 		return -EFAULT;
@@ -575,7 +572,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
 
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, fpstate,
 				regs, set->sig[0]);
-	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	err |= __put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask);
 
 	if (err)
 		return -EFAULT;
@@ -613,9 +610,8 @@ SYSCALL_DEFINE0(sigreturn)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(set.sig[0], &frame->sc.oldmask) || (_NSIG_WORDS > 1
-		&& __copy_from_user(&set.sig[1], &frame->extramask,
-				    sizeof(frame->extramask))))
+	if (__get_user(set.sig[0], &frame->sc.oldmask) ||
+	    __get_user(set.sig[1], &frame->extramask[0]))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -645,7 +641,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
 	if (__get_user(uc_flags, &frame->uc.uc_flags))
 		goto badframe;
@@ -870,7 +866,7 @@ asmlinkage long sys32_x32_rt_sigreturn(void)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
 	if (__get_user(uc_flags, &frame->uc.uc_flags))
 		goto badframe;
