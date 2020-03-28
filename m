Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3AEC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45DB2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgC1LAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55527 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC1LAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C2-0003cB-Jr; Sat, 28 Mar 2020 11:59:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 30CD31C0483;
        Sat, 28 Mar 2020 11:59:58 +0100 (CET)
Date:   Sat, 28 Mar 2020 10:59:57 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: switch setup_sigcontext() to unsafe_put_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539319784.28353.4499541834093794408.tip-bot2@tip-bot2>
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

Commit-ID:     9f855c085fb150ccc208497b39b5d3542bac5322
Gitweb:        https://git.kernel.org/tip/9f855c085fb150ccc208497b39b5d3542bac5322
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 17:25:27 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Wed, 18 Mar 2020 20:39:02 -04:00

x86: switch setup_sigcontext() to unsafe_put_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/sighandling.h |  3 +-
 arch/x86/kernel/signal.c           | 88 ++++++++++++++---------------
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index 2fcbd6f..35e0b57 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -14,9 +14,6 @@
 			 X86_EFLAGS_CF | X86_EFLAGS_RF)
 
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
-int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
-		     struct pt_regs *regs, unsigned long mask);
-
 
 #ifdef CONFIG_X86_X32_ABI
 asmlinkage long sys32_x32_rt_sigreturn(void);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 83563e9..3b4ca48 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -140,63 +140,65 @@ static int restore_sigcontext(struct pt_regs *regs,
 			       IS_ENABLED(CONFIG_X86_32));
 }
 
-int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+static int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
 {
-	int err = 0;
-
-	put_user_try {
+	if (!user_access_begin(sc, sizeof(struct sigcontext)))
+		return -EFAULT;
 
 #ifdef CONFIG_X86_32
-		put_user_ex(get_user_gs(regs), (unsigned int __user *)&sc->gs);
-		put_user_ex(regs->fs, (unsigned int __user *)&sc->fs);
-		put_user_ex(regs->es, (unsigned int __user *)&sc->es);
-		put_user_ex(regs->ds, (unsigned int __user *)&sc->ds);
+	unsafe_put_user(get_user_gs(regs),
+				  (unsigned int __user *)&sc->gs, Efault);
+	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
+	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
+	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(regs->di, &sc->di);
-		put_user_ex(regs->si, &sc->si);
-		put_user_ex(regs->bp, &sc->bp);
-		put_user_ex(regs->sp, &sc->sp);
-		put_user_ex(regs->bx, &sc->bx);
-		put_user_ex(regs->dx, &sc->dx);
-		put_user_ex(regs->cx, &sc->cx);
-		put_user_ex(regs->ax, &sc->ax);
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
 #ifdef CONFIG_X86_64
-		put_user_ex(regs->r8, &sc->r8);
-		put_user_ex(regs->r9, &sc->r9);
-		put_user_ex(regs->r10, &sc->r10);
-		put_user_ex(regs->r11, &sc->r11);
-		put_user_ex(regs->r12, &sc->r12);
-		put_user_ex(regs->r13, &sc->r13);
-		put_user_ex(regs->r14, &sc->r14);
-		put_user_ex(regs->r15, &sc->r15);
+	unsafe_put_user(regs->r8, &sc->r8, Efault);
+	unsafe_put_user(regs->r9, &sc->r9, Efault);
+	unsafe_put_user(regs->r10, &sc->r10, Efault);
+	unsafe_put_user(regs->r11, &sc->r11, Efault);
+	unsafe_put_user(regs->r12, &sc->r12, Efault);
+	unsafe_put_user(regs->r13, &sc->r13, Efault);
+	unsafe_put_user(regs->r14, &sc->r14, Efault);
+	unsafe_put_user(regs->r15, &sc->r15, Efault);
 #endif /* CONFIG_X86_64 */
 
-		put_user_ex(current->thread.trap_nr, &sc->trapno);
-		put_user_ex(current->thread.error_code, &sc->err);
-		put_user_ex(regs->ip, &sc->ip);
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
 #ifdef CONFIG_X86_32
-		put_user_ex(regs->cs, (unsigned int __user *)&sc->cs);
-		put_user_ex(regs->flags, &sc->flags);
-		put_user_ex(regs->sp, &sc->sp_at_signal);
-		put_user_ex(regs->ss, (unsigned int __user *)&sc->ss);
+	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
+	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
 #else /* !CONFIG_X86_32 */
-		put_user_ex(regs->flags, &sc->flags);
-		put_user_ex(regs->cs, &sc->cs);
-		put_user_ex(0, &sc->gs);
-		put_user_ex(0, &sc->fs);
-		put_user_ex(regs->ss, &sc->ss);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->cs, &sc->cs, Efault);
+	unsafe_put_user(0, &sc->gs, Efault);
+	unsafe_put_user(0, &sc->fs, Efault);
+	unsafe_put_user(regs->ss, &sc->ss, Efault);
 #endif /* CONFIG_X86_32 */
 
-		put_user_ex(fpstate, (unsigned long __user *)&sc->fpstate);
+	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
 
-		/* non-iBCS2 extensions.. */
-		put_user_ex(mask, &sc->oldmask);
-		put_user_ex(current->thread.cr2, &sc->cr2);
-	} put_user_catch(err);
-
-	return err;
+	/* non-iBCS2 extensions.. */
+	unsafe_put_user(mask, &sc->oldmask, Efault);
+	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
+	user_access_end();
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
 }
 
 /*
